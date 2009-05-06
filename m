From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 1/2] Export crlf conversion function to libgit
Date: Wed, 6 May 2009 17:09:05 +0200
Message-ID: <20090506150854.GA2974@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 17:09:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1ikJ-0004dr-DF
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 17:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522AbZEFPJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 11:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756042AbZEFPJH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 11:09:07 -0400
Received: from darksea.de ([83.133.111.250]:51660 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751604AbZEFPJG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 11:09:06 -0400
Received: (qmail 28796 invoked from network); 6 May 2009 17:08:55 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 May 2009 17:08:55 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118346>

This makes it possible for parsecvs to use the git heuristics to
convert textfiles into a normalized form

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
There is another patch for parsecvs which depends on this change.

I first would like to know how you feel about exporting such a function?

 cache.h   |    1 +
 convert.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index f48e80b..42e9243 100644
--- a/cache.h
+++ b/cache.h
@@ -926,6 +926,7 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern int convert_to_git(const char *path, const char *src, size_t len,
                           struct strbuf *dst, enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
+extern int crlf_to_git_buf(size_t *p_len, char *p_blob);
 
 /* add */
 /*
diff --git a/convert.c b/convert.c
index 1816e97..0ced471 100644
--- a/convert.c
+++ b/convert.c
@@ -179,6 +179,36 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 	return 1;
 }
 
+int crlf_to_git_buf(size_t *p_len, char *p_blob)
+{
+	struct strbuf nbuf;
+	strbuf_init(&nbuf, 0);
+	size_t len = *p_len;
+	char *blob = p_blob;
+
+	/* this is needed otherwise crlf_to_git will skip this file */
+	auto_crlf = 1;
+
+	/* filter blob with len and store in nbuf
+	 * if no conversion happens just return */
+	if (!crlf_to_git(NULL, blob, len, &nbuf, CRLF_GUESS))
+		return 0;
+
+	blob = strbuf_detach(&nbuf, &len);
+	/* crlf conversion should only make our buffer shorter */
+	if (len <= *p_len) {
+		*p_len  = len;
+		memcpy(p_blob, blob, len);
+		free(blob);
+	} else {
+		*p_len  = len;
+		free(blob);
+		return 0;
+	}
+
+	return 1;
+}
+
 static int crlf_to_worktree(const char *path, const char *src, size_t len,
                             struct strbuf *buf, int action)
 {
-- 
1.6.2.1.423.g442d
