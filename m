From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 15:25:19 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain> <7vljfrp6g2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain> <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 00:26:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY6Pn-0000Mu-Cw
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 00:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab0AUX0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 18:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294Ab0AUX0L
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 18:26:11 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33877 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755524Ab0AUX0K (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 18:26:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0LNPJdw009830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 15:25:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0LNPJhq003548;
	Thu, 21 Jan 2010 15:25:19 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137699>



On Thu, 21 Jan 2010, Linus Torvalds wrote:
> 
> We could fix it a few ways
> 
>  - ignore it. Most git programs will get the pack handling functions 
>    anyway, since they want to get object reading.

In fact, we should probably remove git-show-index. It may have some 
historical significance as a pack-file index debugger, but it has no 
actual redeeming features now, considering that the binary is a megabyte 
of useless crud with debugging info.

However, we do actually use it in t/t5302-pack-index.sh. So in the 
meantime, how about this hacky patch to simply just avoid xmalloc, and 
separating out the trivial hex functions into "hex.o".

This results in

  [torvalds@nehalem git]$ size git-show-index 
       text    data     bss     dec     hex filename
     222818    2276  112688  337782   52776 git-show-index (before)
       5696     624    1264    7584    1da0 git-show-index (after)

which is a whole lot better, no?

(Or make it a built-in, if we actually think we want to carry it along in 
the long run)

		Linus

---
 Makefile     |    1 +
 sha1_file.c  |   66 ----------------------------------------------------------
 show-index.c |    2 +-
 3 files changed, 2 insertions(+), 67 deletions(-)

diff --git a/Makefile b/Makefile
index ad890ec..a041b69 100644
--- a/Makefile
+++ b/Makefile
@@ -559,6 +559,7 @@ LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hash.o
 LIB_OBJS += help.o
+LIB_OBJS += hex.o
 LIB_OBJS += ident.o
 LIB_OBJS += levenshtein.o
 LIB_OBJS += list-objects.o
diff --git a/sha1_file.c b/sha1_file.c
index 7086760..12478a3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -35,54 +35,6 @@ static size_t sz_fmt(size_t s) { return s; }
 
 const unsigned char null_sha1[20];
 
-const signed char hexval_table[256] = {
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 18-1f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 20-27 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 28-2f */
-	  0,  1,  2,  3,  4,  5,  6,  7,		/* 30-37 */
-	  8,  9, -1, -1, -1, -1, -1, -1,		/* 38-3f */
-	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 40-47 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 48-4f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 50-57 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 58-5f */
-	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 60-67 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 68-67 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 70-77 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 78-7f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 80-87 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 88-8f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 90-97 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 98-9f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a0-a7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a8-af */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b0-b7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b8-bf */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c0-c7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c8-cf */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d0-d7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d8-df */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e0-e7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e8-ef */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f0-f7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
-};
-
-int get_sha1_hex(const char *hex, unsigned char *sha1)
-{
-	int i;
-	for (i = 0; i < 20; i++) {
-		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
-		if (val & ~0xff)
-			return -1;
-		*sha1++ = val;
-		hex += 2;
-	}
-	return 0;
-}
-
 static inline int offset_1st_component(const char *path)
 {
 	if (has_dos_drive_prefix(path))
@@ -133,24 +85,6 @@ int safe_create_leading_directories_const(const char *path)
 	return result;
 }
 
-char *sha1_to_hex(const unsigned char *sha1)
-{
-	static int bufno;
-	static char hexbuffer[4][50];
-	static const char hex[] = "0123456789abcdef";
-	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
-	int i;
-
-	for (i = 0; i < 20; i++) {
-		unsigned int val = *sha1++;
-		*buf++ = hex[val >> 4];
-		*buf++ = hex[val & 0xf];
-	}
-	*buf = '\0';
-
-	return buffer;
-}
-
 static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
 {
 	int i;
diff --git a/show-index.c b/show-index.c
index 63f9da5..4c0ac13 100644
--- a/show-index.c
+++ b/show-index.c
@@ -48,7 +48,7 @@ int main(int argc, char **argv)
 			unsigned char sha1[20];
 			uint32_t crc;
 			uint32_t off;
-		} *entries = xmalloc(nr * sizeof(entries[0]));
+		} *entries = malloc(nr * sizeof(entries[0]));
 		for (i = 0; i < nr; i++)
 			if (fread(entries[i].sha1, 20, 1, stdin) != 1)
 				die("unable to read sha1 %u/%u", i, nr);
