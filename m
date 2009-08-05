From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/4] strbuf: add new function strbuf_getwholeline()
Date: Tue,  4 Aug 2009 22:31:56 -0500
Message-ID: <r3l_p2g-BpVHWKE-kMWIRydJaW0FHLKBpE497REXzOgqPjLUFjPkJ-YKp1tkrIs3CwcppURiH8o@cipher.nrlssc.navy.mil>
References: <7vmy6fdxst.fsf@alter.siamese.dyndns.org> <r3l_p2g-BpVHWKE-kMWIRzBGUCnzo9_l7hOHzYLG_4X6oEjXrJ4rJdB10yXPT2jmJJ7ppBmr-x8@cipher.nrlssc.navy.mil>
Cc: nanako3@lavabit.com, raa.lkml@gmail.com, hpa@zytor.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 05 05:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYXFc-0001ap-0O
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 05:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933434AbZHEDcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 23:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933421AbZHEDct
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 23:32:49 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59661 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933382AbZHEDct (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 23:32:49 -0400
Received: by mail.nrlssc.navy.mil id n753Wllr015198; Tue, 4 Aug 2009 22:32:47 -0500
In-Reply-To: <r3l_p2g-BpVHWKE-kMWIRzBGUCnzo9_l7hOHzYLG_4X6oEjXrJ4rJdB10yXPT2jmJJ7ppBmr-x8@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Aug 2009 03:32:47.0398 (UTC) FILETIME=[66D79460:01CA157D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124841>

From: Brandon Casey <drafnel@gmail.com>

This function is just like strbuf_getline() except it retains the
line-termination character.  This function will be used by the mailinfo
and mailsplit builtins which require the entire line for parsing.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 strbuf.c |   15 ++++++++++++---
 strbuf.h |    1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index f03d117..a6153dc 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -322,7 +322,7 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 	return -1;
 }
 
-int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
+int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 {
 	int ch;
 
@@ -332,10 +332,10 @@ int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 
 	strbuf_reset(sb);
 	while ((ch = fgetc(fp)) != EOF) {
-		if (ch == term)
-			break;
 		strbuf_grow(sb, 1);
 		sb->buf[sb->len++] = ch;
+		if (ch == term)
+			break;
 	}
 	if (ch == EOF && sb->len == 0)
 		return EOF;
@@ -344,6 +344,15 @@ int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 	return 0;
 }
 
+int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
+{
+	if (strbuf_getwholeline(sb, fp, term))
+		return EOF;
+	if (sb->buf[sb->len-1] == term)
+		strbuf_setlen(sb, sb->len-1);
+	return 0;
+}
+
 int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 {
 	int fd, len;
diff --git a/strbuf.h b/strbuf.h
index eaa8704..d05e056 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -126,6 +126,7 @@ extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
 extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 
+extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
 extern int strbuf_getline(struct strbuf *, FILE *, int);
 
 extern void stripspace(struct strbuf *buf, int skip_comments);
-- 
1.6.4
