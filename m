From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] strbuf: instate cleanup rule in case of non-memory errors
Date: Tue, 06 Jan 2009 21:41:14 +0100
Message-ID: <4963C1EA.504@lsrfire.ath.cx>
References: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <1230026749-25360-1-git-send-email-madcoder@debian.org> <20081223102127.GA21485@artemis.corp> <alpine.LFD.2.00.0812231009220.3535@localhost.localdomain> <20081224101146.GA10008@artemis.corp> <4952532F.5050704@lsrfire.ath.cx> <7viqp8afap.fsf@gitster.siamese.dyndns.org> <20090104122108.GC29325@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 21:42:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKIlB-0002zP-Da
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 21:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbZAFUlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 15:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbZAFUlR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 15:41:17 -0500
Received: from india601.server4you.de ([85.25.151.105]:41420 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbZAFUlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 15:41:17 -0500
Received: from [10.0.1.101] (p57B7BA44.dip.t-dialin.net [87.183.186.68])
	by india601.server4you.de (Postfix) with ESMTPSA id 33E9E2F8116;
	Tue,  6 Jan 2009 21:41:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090104122108.GC29325@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104724>

Make all strbuf functions that can fail free() their memory on error if
they have allocated it.  They don't shrink buffers that have been grown,
though.

This allows for easier error handling, as callers only need to call
strbuf_release() if A) the command succeeded or B) if they would have had
to do so anyway because they added something to the strbuf themselves.

Bonus hunk: document strbuf_readlink.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/technical/api-strbuf.txt |   11 +++++++++--
 strbuf.c                               |   17 +++++++++++++----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index a8ee2fe..9a4e3ea 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -133,8 +133,10 @@ Functions
 
 * Adding data to the buffer
 
-NOTE: All of these functions in this section will grow the buffer as
-      necessary.
+NOTE: All of the functions in this section will grow the buffer as necessary.
+If they fail for some reason other than memory shortage and the buffer hadn't
+been allocated before (i.e. the `struct strbuf` was set to `STRBUF_INIT`),
+then they will free() it.
 
 `strbuf_addch`::
 
@@ -235,6 +237,11 @@ same behaviour as well.
 	Read the contents of a file, specified by its path. The third argument
 	can be used to give a hint about the file size, to avoid reallocs.
 
+`strbuf_readlink`::
+
+	Read the target of a symbolic link, specified by its path.  The third
+	argument can be used to give a hint about the size, to avoid reallocs.
+
 `strbuf_getline`::
 
 	Read a line from a FILE* pointer. The second argument specifies the line
diff --git a/strbuf.c b/strbuf.c
index bdf4954..6ed0684 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -256,18 +256,21 @@ size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
 size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 {
 	size_t res;
+	size_t oldalloc = sb->alloc;
 
 	strbuf_grow(sb, size);
 	res = fread(sb->buf + sb->len, 1, size, f);
-	if (res > 0) {
+	if (res > 0)
 		strbuf_setlen(sb, sb->len + res);
-	}
+	else if (res < 0 && oldalloc == 0)
+		strbuf_release(sb);
 	return res;
 }
 
 ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 {
 	size_t oldlen = sb->len;
+	size_t oldalloc = sb->alloc;
 
 	strbuf_grow(sb, hint ? hint : 8192);
 	for (;;) {
@@ -275,7 +278,10 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 
 		cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
 		if (cnt < 0) {
-			strbuf_setlen(sb, oldlen);
+			if (oldalloc == 0)
+				strbuf_release(sb);
+			else
+				strbuf_setlen(sb, oldlen);
 			return -1;
 		}
 		if (!cnt)
@@ -292,6 +298,8 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 {
+	size_t oldalloc = sb->alloc;
+
 	if (hint < 32)
 		hint = 32;
 
@@ -311,7 +319,8 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 		/* .. the buffer was too small - try again */
 		hint *= 2;
 	}
-	strbuf_release(sb);
+	if (oldalloc == 0)
+		strbuf_release(sb);
 	return -1;
 }
 
-- 
1.6.1
