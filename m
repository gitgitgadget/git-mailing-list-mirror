From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/8] wt-status: collect untracked files in a separate
 "collect" phase
Date: Mon, 10 Aug 2009 01:54:22 -0700
Message-ID: <1249894465-11018-6-git-send-email-gitster@pobox.com>
References: <1249894465-11018-1-git-send-email-gitster@pobox.com>
 <1249894465-11018-2-git-send-email-gitster@pobox.com>
 <1249894465-11018-3-git-send-email-gitster@pobox.com>
 <1249894465-11018-4-git-send-email-gitster@pobox.com>
 <1249894465-11018-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 10:54:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQeW-0007fg-5C
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbZHJIyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbZHJIyj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:54:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbZHJIyh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:54:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA69E24664
	for <git@vger.kernel.org>; Mon, 10 Aug 2009 04:54:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F295C24663 for
 <git@vger.kernel.org>; Mon, 10 Aug 2009 04:54:37 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.173.g72959
In-Reply-To: <1249894465-11018-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6FA8C93C-858B-11DE-9E9E-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125415>

In a way similar to updated and locally modified files are collected.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c |   58 ++++++++++++++++++++++++++++++++++++----------------------
 wt-status.h |    3 ++-
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 68e4d9b..b6ae12c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -41,6 +41,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->fp = stdout;
 	s->index_file = get_index_file();
 	s->change.strdup_strings = 1;
+	s->untracked.strdup_strings = 1;
 }
 
 static void wt_status_print_unmerged_header(struct wt_status *s)
@@ -311,7 +312,30 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 	}
 }
 
-void wt_status_collect_changes(struct wt_status *s)
+static void wt_status_collect_untracked(struct wt_status *s)
+{
+	int i;
+	struct dir_struct dir;
+
+	if (!s->show_untracked_files)
+		return;
+	memset(&dir, 0, sizeof(dir));
+	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
+		dir.flags |=
+			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+	setup_standard_excludes(&dir);
+
+	fill_directory(&dir, NULL);
+	for(i = 0; i < dir.nr; i++) {
+		struct dir_entry *ent = dir.entries[i];
+		if (!cache_name_is_other(ent->name, ent->len))
+			continue;
+		s->workdir_untracked = 1;
+		string_list_insert(ent->name, &s->untracked);
+	}
+}
+
+void wt_status_collect(struct wt_status *s)
 {
 	wt_status_collect_changes_worktree(s);
 
@@ -319,6 +343,7 @@ void wt_status_collect_changes(struct wt_status *s)
 		wt_status_collect_changes_initial(s);
 	else
 		wt_status_collect_changes_index(s);
+	wt_status_collect_untracked(s);
 }
 
 static void wt_status_print_unmerged(struct wt_status *s)
@@ -446,31 +471,20 @@ static void wt_status_print_submodule_summary(struct wt_status *s)
 
 static void wt_status_print_untracked(struct wt_status *s)
 {
-	struct dir_struct dir;
 	int i;
-	int shown_header = 0;
 	struct strbuf buf = STRBUF_INIT;
 
-	memset(&dir, 0, sizeof(dir));
-	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
-		dir.flags |=
-			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
-	setup_standard_excludes(&dir);
+	if (!s->untracked.nr)
+		return;
 
-	fill_directory(&dir, NULL);
-	for(i = 0; i < dir.nr; i++) {
-		struct dir_entry *ent = dir.entries[i];
-		if (!cache_name_is_other(ent->name, ent->len))
-			continue;
-		if (!shown_header) {
-			s->workdir_untracked = 1;
-			wt_status_print_untracked_header(s);
-			shown_header = 1;
-		}
+	wt_status_print_untracked_header(s);
+	for (i = 0; i < s->untracked.nr; i++) {
+		struct string_list_item *it;
+		it = &(s->untracked.items[i]);
 		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
 		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED, s), "%s",
-				quote_path(ent->name, ent->len,
-					&buf, s->prefix));
+				 quote_path(it->string, strlen(it->string),
+					    &buf, s->prefix));
 	}
 	strbuf_release(&buf);
 }
@@ -539,7 +553,7 @@ void wt_status_print(struct wt_status *s)
 			wt_status_print_tracking(s);
 	}
 
-	wt_status_collect_changes(s);
+	wt_status_collect(s);
 
 	if (s->is_initial) {
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
@@ -566,7 +580,7 @@ void wt_status_print(struct wt_status *s)
 			; /* nothing */
 		else if (s->workdir_dirty)
 			printf("no changes added to commit (use \"git add\" and/or \"git commit -a\")\n");
-		else if (s->workdir_untracked)
+		else if (s->untracked.nr)
 			printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
 		else if (s->is_initial)
 			printf("nothing to commit (create/copy files and use \"git add\" to track)\n");
diff --git a/wt-status.h b/wt-status.h
index 12dc95e..33240b3 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -48,10 +48,11 @@ struct wt_status {
 	FILE *fp;
 	const char *prefix;
 	struct string_list change;
+	struct string_list untracked;
 };
 
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
-void wt_status_collect_changes(struct wt_status *s);
+void wt_status_collect(struct wt_status *s);
 
 #endif /* STATUS_H */
-- 
1.6.4.173.g72959
