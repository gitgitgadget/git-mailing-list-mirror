From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] probe_utf8_pathname_composition: use internal strbuf
Date: Sun, 4 Oct 2015 23:45:26 -0400
Message-ID: <20151005034526.GB25502@sigill.intra.peff.net>
References: <20151005034126.GA5639@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 05:45:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiwiU-0006nd-7X
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 05:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbbJEDp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 23:45:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:39540 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751975AbbJEDp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 23:45:29 -0400
Received: (qmail 30317 invoked by uid 102); 5 Oct 2015 03:45:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Oct 2015 22:45:29 -0500
Received: (qmail 11730 invoked by uid 107); 5 Oct 2015 03:45:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Oct 2015 23:45:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Oct 2015 23:45:26 -0400
Content-Disposition: inline
In-Reply-To: <20151005034126.GA5639@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279032>

When we are initializing a .git directory, we may call
probe_utf8_pathname_composition to detect utf8 mangling. We
pass in a path buffer for it to use, and it blindly
strcpy()s into it, not knowing whether the buffer is large
enough to hold the result or not.

In practice this isn't a big deal, because the buffer we
pass in already contains "$GIT_DIR/config", and we append
only a few extra bytes to it. But we can easily do the right
thing just by calling git_path_buf ourselves. Technically
this results in a different pathname (before we appended our
utf8 characters to the "config" path, and now they get their
own files in $GIT_DIR), but that should not matter for our
purposes.

Signed-off-by: Jeff King <peff@peff.net>
---
I assume that "$GIT_DIR/$auml_nfc" is fine to perform this test based on
Torsten's patch showing the same simplification. If it matters, or if we
simply want to be ultra-conservative, changing the "%s" to "CoNfIg%s"
would yield identical behavior (but if it doesn't matter, I think I
prefer this as a simplification).

 builtin/init-db.c        |  2 +-
 compat/precompose_utf8.c | 18 ++++++++++--------
 compat/precompose_utf8.h |  2 +-
 git-compat-util.h        |  2 +-
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index e7d0e31..89addda 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -312,7 +312,7 @@ static int create_default_files(const char *template_path)
 		strcpy(path + len, "CoNfIg");
 		if (!access(path, F_OK))
 			git_config_set("core.ignorecase", "true");
-		probe_utf8_pathname_composition(path, len);
+		probe_utf8_pathname_composition();
 	}
 
 	return reinit;
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 044c686..079070f 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -36,24 +36,26 @@ static size_t has_non_ascii(const char *s, size_t maxlen, size_t *strlen_c)
 }
 
 
-void probe_utf8_pathname_composition(char *path, int len)
+void probe_utf8_pathname_composition(void)
 {
+	struct strbuf path = STRBUF_INIT;
 	static const char *auml_nfc = "\xc3\xa4";
 	static const char *auml_nfd = "\x61\xcc\x88";
 	int output_fd;
 	if (precomposed_unicode != -1)
 		return; /* We found it defined in the global config, respect it */
-	strcpy(path + len, auml_nfc);
-	output_fd = open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
+	git_path_buf(&path, "%s", auml_nfc);
+	output_fd = open(path.buf, O_CREAT|O_EXCL|O_RDWR, 0600);
 	if (output_fd >= 0) {
 		close(output_fd);
-		strcpy(path + len, auml_nfd);
-		precomposed_unicode = access(path, R_OK) ? 0 : 1;
+		git_path_buf(&path, "%s", auml_nfd);
+		precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
 		git_config_set("core.precomposeunicode", precomposed_unicode ? "true" : "false");
-		strcpy(path + len, auml_nfc);
-		if (unlink(path))
-			die_errno(_("failed to unlink '%s'"), path);
+		git_path_buf(&path, "%s", auml_nfc);
+		if (unlink(path.buf))
+			die_errno(_("failed to unlink '%s'"), path.buf);
 	}
+	strbuf_release(&path);
 }
 
 
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index 3b73585..a94e7c4 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -27,7 +27,7 @@ typedef struct {
 } PREC_DIR;
 
 void precompose_argv(int argc, const char **argv);
-void probe_utf8_pathname_composition(char *, int);
+void probe_utf8_pathname_composition(void);
 
 PREC_DIR *precompose_utf8_opendir(const char *dirname);
 struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *dirp);
diff --git a/git-compat-util.h b/git-compat-util.h
index 348b9dc..9a3e559 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -229,7 +229,7 @@ typedef unsigned long uintptr_t;
 #else
 #define precompose_str(in,i_nfd2nfc)
 #define precompose_argv(c,v)
-#define probe_utf8_pathname_composition(a,b)
+#define probe_utf8_pathname_composition()
 #endif
 
 #ifdef MKDIR_WO_TRAILING_SLASH
-- 
2.6.0.455.ga3f9923
