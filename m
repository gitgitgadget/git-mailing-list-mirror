From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/8] update-index: use enum for untracked cache options
Date: Tue,  8 Dec 2015 18:15:10 +0100
Message-ID: <1449594916-21167-3-git-send-email-chriscool@tuxfamily.org>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 18:15:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Lrf-00061D-2k
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 18:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbbLHRPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 12:15:43 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33514 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbbLHRPl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 12:15:41 -0500
Received: by wmec201 with SMTP id c201so222257085wme.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 09:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W3OTPiChNuaSQsxBraokLa+J+j3fwuR46il7UF7MkEk=;
        b=NlRWOO7s6pWVtYLlCILAkYClXf+wsUv4GZej5K2pSau0CrKP/2P9RkqjGi3UO0k/4R
         z+usl6XQMn1MkcQO3fZJQ704hO0rrj3BaGa9x0mXLZX18FSSfOkhWE3kuH7f1qk9kPX2
         YQZiUDMTV7r9u/5oEbReiGPk9xxsXQw4oiJxv+5dE+FXXTqjMwKO/ZSN+nel6xB2Mi8/
         vDR8hVyBPbIRDEa7niC3Xf30jwVuKpyUZslAhpqmhs82xRGoPxhC3SVAhcC1IshwHTgu
         XCQg0vCGG6qfSfEG6NuSVOvUaaqqR5iFgrvY09vKqYSOfq4voupv8BoxBdltTrK3hkjJ
         WIKA==
X-Received: by 10.194.21.101 with SMTP id u5mr762199wje.103.1449594940131;
        Tue, 08 Dec 2015 09:15:40 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 200sm4332517wmn.11.2015.12.08.09.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 09:15:39 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.478.g9f95483.dirty
In-Reply-To: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282159>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6f6b289..246b3d3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -35,6 +35,14 @@ static int mark_skip_worktree_only;
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
 
+/* Untracked cache mode */
+enum uc_mode {
+	UNDEF_UC = -1,
+	NO_UC = 0,
+	UC,
+	FORCE_UC
+};
+
 __attribute__((format (printf, 1, 2)))
 static void report(const char *fmt, ...)
 {
@@ -902,7 +910,7 @@ static int reupdate_callback(struct parse_opt_ctx_t *ctx,
 int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
 	int newfd, entries, has_errors = 0, line_termination = '\n';
-	int untracked_cache = -1;
+	enum uc_mode untracked_cache = UNDEF_UC;
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	int preferred_index_format = 0;
@@ -997,7 +1005,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "untracked-cache", &untracked_cache,
 			N_("enable/disable untracked cache")),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
-			    N_("enable untracked cache without testing the filesystem"), 2),
+			    N_("enable untracked cache without testing the filesystem"), FORCE_UC),
 		OPT_END()
 	};
 
@@ -1104,10 +1112,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.split_index = NULL;
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
-	if (untracked_cache > 0) {
+	if (untracked_cache > NO_UC) {
 		struct untracked_cache *uc;
 
-		if (untracked_cache < 2) {
+		if (untracked_cache < FORCE_UC) {
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
 				return 1;
@@ -1123,7 +1131,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 		fprintf(stderr, _("Untracked cache enabled for '%s'\n"), get_git_work_tree());
-	} else if (!untracked_cache && the_index.untracked) {
+	} else if (untracked_cache == NO_UC && the_index.untracked) {
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 		fprintf(stderr, _("Untracked cache disabled\n"));
-- 
2.6.3.478.g9f95483.dirty
