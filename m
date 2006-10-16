From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 10:56:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
 <87ejt8p5l9.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 19:56:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZWhW-0007SN-BS
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 19:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWJPR4b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 13:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbWJPR4b
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 13:56:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161031AbWJPR4a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 13:56:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9GHuFaX011520
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Oct 2006 10:56:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9GHuEd5021889;
	Mon, 16 Oct 2006 10:56:14 -0700
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <87ejt8p5l9.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-0.472 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28977>



On Mon, 16 Oct 2006, Jim Meyering wrote:
> 
> That helps a little.
> Now, instead of taking 63s, my test takes ~30s.
> (32 for XDL_MAX_EQLIMIT = 16, 30 for XDL_MAX_EQLIMIT = 8)

Btw, what architecture is this on?

I'm testing those two files, and I get much more reasonable numbers with 
both ppc32 and x86. Both 32-bit:

	[torvalds@macmini test-perf]$ time git show | wc -l
	25221

	real    0m1.437s
	user    0m1.436s
	sys     0m0.012s

ie it generated the diff in less than a second and a half. Not wonderful, 
but certainly not your 63s either.

HOWEVER. On x86-64, it takes forever (still not 63 seconds, but it takes 
17 seconds on my 2GHz merom machine).

So I think there's something seriously broken with hashing on 64-bit. 

And I think I know what it is.

Try this patch. And make sure to do a "make clean" first, since I think 
the dependencies on xdiff may be broken.

Davide: there's two things wrong with your old XDL_HASHLONG():

 - the GR_PRIME was just 32-bit, so it wouldn't shift low bits up far 
   enough on a 64-bit architecture, so then shifting things down caused 
   pretty much everything to be very small.

 - The whole idea of shifting up by multiplying and then shifting down to 
   get the high bits is _broken_. Even on 32-bit architectures. Think 
   about what happens when "hashbits" is 16 on a 32-bit architecture: the 
   multiply moves the low bits _up_, but it doesn't move the high bits 
   _down_. And with hashbits being a large fraction of the whole word, you 
   need to shift things down, not up.

So just making GR_PRIME be a bigger value on a 64-bit architecture would 
not have fixed it. The whole hash was simply broken. Do it the sane and 
obvious way instead: always pick the low bits, but mix in upper bits there 
too..

This patch brings the time down from 17 seconds to 0.8 seconds for me.

		Linus

---
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 4c2fde8..bb4830b 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -24,14 +24,27 @@ #if !defined(XMACROS_H)
 #define XMACROS_H
 
 
-#define GR_PRIME 0x9e370001UL
+static inline unsigned long xdl_hashlong(unsigned long val, unsigned int bits)
+{
+	unsigned long shift = val >> bits;
+
+	/* Shift in the upper bits too */
+	val += shift;
+
+	/* Do it twice for small values of bits */
+	if (bits < 4*sizeof(unsigned long))
+		val += shift >> bits;
+
+	/* Return the resulting low bits */
+	return val & ((1ul << bits)-1);
+}
 
 
 #define XDL_MIN(a, b) ((a) < (b) ? (a): (b))
 #define XDL_MAX(a, b) ((a) > (b) ? (a): (b))
 #define XDL_ABS(v) ((v) >= 0 ? (v): -(v))
 #define XDL_ISDIGIT(c) ((c) >= '0' && (c) <= '9')
-#define XDL_HASHLONG(v, b) (((unsigned long)(v) * GR_PRIME) >> ((CHAR_BIT * sizeof(unsigned long)) - (b)))
+#define XDL_HASHLONG(v, b) xdl_hashlong(v,b)
 #define XDL_PTRFREE(p) do { if (p) { xdl_free(p); (p) = NULL; } } while (0)
 #define XDL_LE32_PUT(p, v) \
 do { \
