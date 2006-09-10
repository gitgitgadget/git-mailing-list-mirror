From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: {RFC/PATCH] micro-optimize get_sha1_hex()
Date: Sat, 9 Sep 2006 17:06:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609091639110.27779@g5.osdl.org>
References: <7vzmd8vh6q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 10 02:06:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMCqY-00068s-Jk
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 02:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWIJAGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 20:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWIJAGr
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 20:06:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60625 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965035AbWIJAGq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 20:06:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8A06gnW022329
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 9 Sep 2006 17:06:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8A06fv1024296;
	Sat, 9 Sep 2006 17:06:41 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmd8vh6q.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.523 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26775>



On Sat, 9 Sep 2006, Junio C Hamano wrote:
>
> I was profiling 'git-rev-list v2.16.12..', because I suspected
> insert_by_date() might be expensive (the function inserts into
> singly-linked ordered list, so the data structure has to become
> array based to allow optimization).

I _suspect_ that you profiled using "gprof" and the "-pg" flag to 
the compiler?

The thing is, that generates almost totally bogus profiles. It makes 
simple function calls look extremely - and unrealistically - expensive, 
because the profiling code itself adds lots of overhead, and it then ends 
up showing on the tick-based profile too in a way that it wouldn't show 
in real life.

It tends to be much better to profile unmodified binaries using 
"oprofile", which doesn't end up giving the exact number of calls, but 
where the time-based profiling is a _lot_ more reliable.

That said, clearly "hexval()" can be optimized, and it's quite possible 
that it would show up even in oprofile data too.

> The attached brings get_sha1_hex() down from 15.19% to 5.41%,
> but I feel we should be able to do better.

I doubt it's 5% in real life, but your optimization looks fine to me.

You can make it even _more_ optimized by not even bothering to test at 
each point, but just inlining hexval(), and making it a single array 
lookup. The point being that if you get -1 for _either_ of the two 
lookups, since we shift them and or them together, the end result will be 
invalid, and you only need to _test_ once.

So this patch should generate much better code, where the inner loop is 
something like

<get_sha1_hex+16>:
	add    $0x1,%esi		# count of result bytes..
	cmp    $0x14,%esi		# did we have 20 already?
	mov    %dl,(%ebx)		# save the "last loop" result
	je     0x807630b <get_sha1_hex+75>	# break out
	add    $0x1,%ebx		# update dest pointer (one byte at a time)
	add    $0x2,%ecx		# update source pointer (two hex chars at a time)
	movsbl (%ecx),%eax		# get first character
	movsbl 0x80989e0(%eax),%edx	# get the hexval for it
	movsbl 0x1(%ecx),%eax		# get the second character
	shl    $0x4,%edx		# shift first character hexval up by 4
	movsbl 0x80989e0(%eax),%eax	# get second character hexval
	or     %eax,%edx		# get the byte value
	test   $0xffffff00,%edx		# was it ok (0x00 - 0xff)?
	je     <get_sha1_hex+16>	# yeah, continue

which should perform very well (just two comparisons - one for the "wrong 
bits set" at the end, and one for the 20-byte-counter test at the 
beginning). Small and sweet.

In fact, I don't see how you can much improve on that code even if you 
were to hand-code it, so gcc actually generates good code once the 
"hexval()" function has been written like this.

Not very much tested, but it looks obvious enough.. And it's actually 
conceptually a smaller diff than yours (ie it doesn't change anything but 
the "hexval()" function, and all the bulk of it is the stupid array 
initializer).

		Linus

---
diff --git a/sha1_file.c b/sha1_file.c
index 428d791..b64b92d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -26,15 +26,43 @@ const unsigned char null_sha1[20];
 
 static unsigned int sha1_file_open_flag = O_NOATIME;
 
-static unsigned hexval(char c)
-{
-	if (c >= '0' && c <= '9')
-		return c - '0';
-	if (c >= 'a' && c <= 'f')
-		return c - 'a' + 10;
-	if (c >= 'A' && c <= 'F')
-		return c - 'A' + 10;
-	return ~0;
+static inline unsigned int hexval(unsigned int c)
+{
+	static signed char val[256] = {
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 18-1f */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 20-27 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 28-2f */
+		  0,  1,  2,  3,  4,  5,  6,  7,		/* 30-37 */
+		  8,  9, -1, -1, -1, -1, -1, -1,		/* 38-3f */
+		 -1, 10, 11, 12, 13, 14, 15, -1,		/* 40-47 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 48-4f */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 50-57 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 58-5f */
+		 -1, 10, 11, 12, 13, 14, 15, -1,		/* 60-67 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 68-67 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 70-77 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 78-7f */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 80-87 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 88-8f */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 90-97 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* 98-9f */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* a0-a7 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* a8-af */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* b0-b7 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* b8-bf */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* c0-c7 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* c8-cf */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* d0-d7 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* d8-df */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* e0-e7 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* e8-ef */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* f0-f7 */
+		 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
+	};
+	return val[c];
 }
 
 int get_sha1_hex(const char *hex, unsigned char *sha1)
