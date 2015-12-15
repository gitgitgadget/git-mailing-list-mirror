From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 01/10] update-index: use enum for untracked cache options
Date: Tue, 15 Dec 2015 17:28:18 +0100
Message-ID: <1450196907-17805-2-git-send-email-chriscool@tuxfamily.org>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 17:29:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8sTG-0003cQ-Hf
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 17:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbbLOQ26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 11:28:58 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38378 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbbLOQ25 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 11:28:57 -0500
Received: by mail-wm0-f53.google.com with SMTP id l126so1545863wml.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 08:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yWM460Y+td554xXMvh7tSFgDVwTsZPZZiwACxc3dMyk=;
        b=MuMYiPqFyPHrpqU7jzQI2WVEFi3FgWMLeRsDtRFSNua0XumaSpbIRU8OHAEBWmKa1Q
         lAdKmWv6jGddn/Nf4lYwSR3UulJFL2GY6nRD3iHRBm78P6XihT3pXQI6Rks+jzRXTvrK
         PZ8tnsDmS0lf0k6rFIpTLiRO1n/MCzZn3JlYb5CjzU7HXi5GWeldYMaUIq2hm5ge8yCp
         xpee4mQIBDK/T/kxxUh8gtLHJ9radAj6s7R1G7SpIHXlYsvv3WqbfuE/DIaqAbIOTTVE
         AO8zN/QcI2Q4eYi5t+w9Y1V+8r/iD/qqHOa7ObntoW0PpDVhPQtTH7sm+NcK467rcu0H
         yaYw==
X-Received: by 10.28.174.130 with SMTP id x124mr6254350wme.2.1450196936289;
        Tue, 15 Dec 2015 08:28:56 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s11sm3513817wmb.14.2015.12.15.08.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 08:28:54 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.479.g8eb29d4
In-Reply-To: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282481>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..2430a68 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -35,6 +35,14 @@ static int mark_skip_worktree_only;
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
 
+/* Untracked cache mode */
+enum uc_mode {
+	UC_UNSPECIFIED = -1,
+	UC_DISABLE = 0,
+	UC_ENABLE,
+	UC_FORCE
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
+	enum uc_mode untracked_cache = UC_UNSPECIFIED;
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	int preferred_index_format = 0;
@@ -997,7 +1005,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "untracked-cache", &untracked_cache,
 			N_("enable/disable untracked cache")),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
-			    N_("enable untracked cache without testing the filesystem"), 2),
+			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
 		OPT_END()
 	};
 
@@ -1104,10 +1112,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.split_index = NULL;
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
-	if (untracked_cache > 0) {
+	if (untracked_cache > UC_DISABLE) {
 		struct untracked_cache *uc;
 
-		if (untracked_cache < 2) {
+		if (untracked_cache < UC_FORCE) {
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
 				return 1;
@@ -1122,7 +1130,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		}
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
-	} else if (!untracked_cache && the_index.untracked) {
+	} else if (untracked_cache == UC_DISABLE && the_index.untracked) {
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	}
-- 
2.6.3.479.g8eb29d4
