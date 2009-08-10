From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/8] Make git_status_config() file scope static to
 builtin-commit.c
Date: Mon, 10 Aug 2009 01:54:21 -0700
Message-ID: <1249894465-11018-5-git-send-email-gitster@pobox.com>
References: <1249894465-11018-1-git-send-email-gitster@pobox.com>
 <1249894465-11018-2-git-send-email-gitster@pobox.com>
 <1249894465-11018-3-git-send-email-gitster@pobox.com>
 <1249894465-11018-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 10:54:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQeV-0007fg-E3
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbZHJIyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbZHJIyg
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:54:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbZHJIyf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:54:35 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 62994569F
	for <git@vger.kernel.org>; Mon, 10 Aug 2009 04:54:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2303569E for
 <git@vger.kernel.org>; Mon, 10 Aug 2009 04:54:35 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.173.g72959
In-Reply-To: <1249894465-11018-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6E39F0A8-858B-11DE-96BE-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125418>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c      |   60 ------------------------------------------------------
 wt-status.h      |    1 -
 3 files changed, 60 insertions(+), 61 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index ca36ba2..601118f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -826,6 +826,66 @@ static int dry_run_commit(int argc, const char **argv, const char *prefix,
 	return commitable ? 0 : 1;
 }
 
+static int parse_status_slot(const char *var, int offset)
+{
+	if (!strcasecmp(var+offset, "header"))
+		return WT_STATUS_HEADER;
+	if (!strcasecmp(var+offset, "updated")
+		|| !strcasecmp(var+offset, "added"))
+		return WT_STATUS_UPDATED;
+	if (!strcasecmp(var+offset, "changed"))
+		return WT_STATUS_CHANGED;
+	if (!strcasecmp(var+offset, "untracked"))
+		return WT_STATUS_UNTRACKED;
+	if (!strcasecmp(var+offset, "nobranch"))
+		return WT_STATUS_NOBRANCH;
+	if (!strcasecmp(var+offset, "unmerged"))
+		return WT_STATUS_UNMERGED;
+	die("bad config variable '%s'", var);
+}
+
+static int git_status_config(const char *k, const char *v, void *cb)
+{
+	struct wt_status *s = cb;
+
+	if (!strcmp(k, "status.submodulesummary")) {
+		int is_bool;
+		s->wt_status_submodule_summary = git_config_bool_or_int(k, v, &is_bool);
+		if (is_bool && s->wt_status_submodule_summary)
+			s->wt_status_submodule_summary = -1;
+		return 0;
+	}
+	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
+		s->wt_status_use_color = git_config_colorbool(k, v, -1);
+		return 0;
+	}
+	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
+		int slot = parse_status_slot(k, 13);
+		if (!v)
+			return config_error_nonbool(k);
+		color_parse(v, k, s->wt_status_colors[slot]);
+		return 0;
+	}
+	if (!strcmp(k, "status.relativepaths")) {
+		s->wt_status_relative_paths = git_config_bool(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "status.showuntrackedfiles")) {
+		if (!v)
+			return config_error_nonbool(k);
+		else if (!strcmp(v, "no"))
+			s->show_untracked_files = SHOW_NO_UNTRACKED_FILES;
+		else if (!strcmp(v, "normal"))
+			s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
+		else if (!strcmp(v, "all"))
+			s->show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
+		else
+			return error("Invalid untracked files mode '%s'", v);
+		return 0;
+	}
+	return git_diff_ui_config(k, v, NULL);
+}
+
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	struct wt_status s;
diff --git a/wt-status.c b/wt-status.c
index a2a7257..68e4d9b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -19,24 +19,6 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RED,    /* WT_STATUS_UNMERGED */
 };
 
-static int parse_status_slot(const char *var, int offset)
-{
-	if (!strcasecmp(var+offset, "header"))
-		return WT_STATUS_HEADER;
-	if (!strcasecmp(var+offset, "updated")
-		|| !strcasecmp(var+offset, "added"))
-		return WT_STATUS_UPDATED;
-	if (!strcasecmp(var+offset, "changed"))
-		return WT_STATUS_CHANGED;
-	if (!strcasecmp(var+offset, "untracked"))
-		return WT_STATUS_UNTRACKED;
-	if (!strcasecmp(var+offset, "nobranch"))
-		return WT_STATUS_NOBRANCH;
-	if (!strcasecmp(var+offset, "unmerged"))
-		return WT_STATUS_UNMERGED;
-	die("bad config variable '%s'", var);
-}
-
 static const char *color(int slot, struct wt_status *s)
 {
 	return s->wt_status_use_color > 0 ? s->wt_status_colors[slot] : "";
@@ -594,45 +576,3 @@ void wt_status_print(struct wt_status *s)
 			printf("nothing to commit (working directory clean)\n");
 	}
 }
-
-int git_status_config(const char *k, const char *v, void *cb)
-{
-	struct wt_status *s = cb;
-
-	if (!strcmp(k, "status.submodulesummary")) {
-		int is_bool;
-		s->wt_status_submodule_summary = git_config_bool_or_int(k, v, &is_bool);
-		if (is_bool && s->wt_status_submodule_summary)
-			s->wt_status_submodule_summary = -1;
-		return 0;
-	}
-	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
-		s->wt_status_use_color = git_config_colorbool(k, v, -1);
-		return 0;
-	}
-	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
-		int slot = parse_status_slot(k, 13);
-		if (!v)
-			return config_error_nonbool(k);
-		color_parse(v, k, s->wt_status_colors[slot]);
-		return 0;
-	}
-	if (!strcmp(k, "status.relativepaths")) {
-		s->wt_status_relative_paths = git_config_bool(k, v);
-		return 0;
-	}
-	if (!strcmp(k, "status.showuntrackedfiles")) {
-		if (!v)
-			return config_error_nonbool(k);
-		else if (!strcmp(v, "no"))
-			s->show_untracked_files = SHOW_NO_UNTRACKED_FILES;
-		else if (!strcmp(v, "normal"))
-			s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
-		else if (!strcmp(v, "all"))
-			s->show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
-		else
-			return error("Invalid untracked files mode '%s'", v);
-		return 0;
-	}
-	return git_diff_ui_config(k, v, NULL);
-}
diff --git a/wt-status.h b/wt-status.h
index f22c3c1..12dc95e 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -50,7 +50,6 @@ struct wt_status {
 	struct string_list change;
 };
 
-int git_status_config(const char *var, const char *value, void *cb);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect_changes(struct wt_status *s);
-- 
1.6.4.173.g72959
