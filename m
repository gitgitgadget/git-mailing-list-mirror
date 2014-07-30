From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 2/5] notes.c: replace `git_config()` with `git_config_get_value_multi()`
Date: Wed, 30 Jul 2014 06:39:06 -0700
Message-ID: <1406727549-22334-3-git-send-email-tanayabh@gmail.com>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 15:40:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCU7M-0000pi-0C
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 15:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbaG3NkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 09:40:23 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:44424 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaG3NkW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 09:40:22 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so1547608pad.27
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/IhGyueSDBVw6yKsrGS54WvsLpxfrf+fNc4yO45xt/Y=;
        b=Q6g3xslPFaKeCxdiBmXyUA95iqFY3+WatQD+OB/0YFFfAiy2PUUePoHUcgTEhKs8vn
         S84P358qGf+ZyLIpIbKV7NtfyF5Ue6L32/Wjk06EBGXag8l3FtPd0xZYaCAaRdGp3n9l
         5NLYOb2IHjmydYHbpv+JM7iJYF6wA0Mb1/VQdpb3VF+m+yPC704j84b/olAelc7XySE3
         xgyAbB/tKia0gD5BxgrsL1X7jqZVIaFVOgK8Ix37zJCNsuBcquAnO+k4N7NISIhHWFZc
         q8z2fpIwFMN2f/NsC/DsbfiR0da22fJg3zEnnAZnVway7zpp6pB0FggrWuklZ4TooPzP
         OiCw==
X-Received: by 10.68.68.162 with SMTP id x2mr2950946pbt.84.1406727621170;
        Wed, 30 Jul 2014 06:40:21 -0700 (PDT)
Received: from localhost.localdomain ([223.184.63.185])
        by mx.google.com with ESMTPSA id y4sm2397686pbt.60.2014.07.30.06.40.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jul 2014 06:40:20 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254489>

Use `git_config_get_value_multi()` instead of `git_config()` to take
advantage of the config-set API which provides a cleaner control flow,
also previously 'string_list_add_refs_by_glob()' was called even when
the retrieved value was NULL, correct it while we are at it.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 notes.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/notes.c b/notes.c
index 5fe691d..abb0ce0 100644
--- a/notes.c
+++ b/notes.c
@@ -961,19 +961,6 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	free(globs_copy);
 }
 
-static int notes_display_config(const char *k, const char *v, void *cb)
-{
-	int *load_refs = cb;
-
-	if (*load_refs && !strcmp(k, "notes.displayref")) {
-		if (!v)
-			config_error_nonbool(k);
-		string_list_add_refs_by_glob(&display_notes_refs, v);
-	}
-
-	return 0;
-}
-
 const char *default_notes_ref(void)
 {
 	const char *notes_ref = NULL;
@@ -1041,7 +1028,8 @@ struct notes_tree **load_notes_trees(struct string_list *refs)
 void init_display_notes(struct display_notes_opt *opt)
 {
 	char *display_ref_env;
-	int load_config_refs = 0;
+	const struct string_list *values;
+	int load_config_refs = 0, i;
 	display_notes_refs.strdup_strings = 1;
 
 	assert(!display_notes_trees);
@@ -1058,7 +1046,18 @@ void init_display_notes(struct display_notes_opt *opt)
 			load_config_refs = 1;
 	}
 
-	git_config(notes_display_config, &load_config_refs);
+	if (load_config_refs) {
+		values = git_config_get_value_multi("notes.displayref");
+		if (values) {
+			for (i = 0; i < values->nr; i++) {
+				if (!values->items[i].string)
+					config_error_nonbool("notes.displayref");
+				else
+					string_list_add_refs_by_glob(&display_notes_refs,
+								     values->items[i].string);
+			}
+		}
+	}
 
 	if (opt) {
 		struct string_list_item *item;
-- 
1.9.0.GIT
