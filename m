From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] status: show worktree status of conflicted paths
 separately
Date: Wed,  5 Aug 2009 02:15:45 -0700
Message-ID: <1249463746-21538-5-git-send-email-gitster@pobox.com>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <1249463746-21538-2-git-send-email-gitster@pobox.com>
 <1249463746-21538-3-git-send-email-gitster@pobox.com>
 <1249463746-21538-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:16:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYcbX-00082b-13
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933921AbZHEJQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933919AbZHEJQI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:16:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933916AbZHEJQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:16:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD11B1E08F
	for <git@vger.kernel.org>; Wed,  5 Aug 2009 05:16:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0A5141E08E for
 <git@vger.kernel.org>; Wed,  5 Aug 2009 05:15:59 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.18.g07a4a
In-Reply-To: <1249463746-21538-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 97B18746-81A0-11DE-AF40-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124880>

When a path is unmerged in the index, we used to always say "unmerged" in
the "Changed but not updated" section, even when the path was deleted in
the work tree.

Remove unmerged entries from the "Updated" section, and create a new
section "Unmerged paths".  Describe how the different stages conflict
in more detail in this new section.

Note that with the current 3-way merge policy (with or without recursive),
certain combinations of index stages should never happen.  For example,
having only stage #2 means that a path that did not exist in the common
ancestor was added by us while the other branch did not do anything to it,
which would have autoresolved to take our addition.  The code nevertheless
prepares for the possibility that future merge policies may leave a path
in such a state.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 1614352..f73bf47 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -20,7 +20,7 @@ static char wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RED,    /* WT_STATUS_CHANGED */
 	GIT_COLOR_RED,    /* WT_STATUS_UNTRACKED */
 	GIT_COLOR_RED,    /* WT_STATUS_NOBRANCH */
-	GIT_COLOR_YELLOW, /* WT_STATUS_UNMERGED */
+	GIT_COLOR_RED,    /* WT_STATUS_UNMERGED */
 };
 
 enum untracked_status_type show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
@@ -38,6 +38,8 @@ static int parse_status_slot(const char *var, int offset)
 		return WT_STATUS_UNTRACKED;
 	if (!strcasecmp(var+offset, "nobranch"))
 		return WT_STATUS_NOBRANCH;
+	if (!strcasecmp(var+offset, "unmerged"))
+		return WT_STATUS_UNMERGED;
 	die("bad config variable '%s'", var);
 }
 
@@ -60,6 +62,18 @@ void wt_status_prepare(struct wt_status *s)
 	s->change.strdup_strings = 1;
 }
 
+static void wt_status_print_unmerged_header(struct wt_status *s)
+{
+	const char *c = color(WT_STATUS_HEADER);
+	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
+	if (!s->is_initial)
+		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
+	else
+		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" to unstage)");
+	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to mark resolution)");
+	color_fprintf_ln(s->fp, c, "#");
+}
+
 static void wt_status_print_cached_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER);
@@ -100,6 +114,29 @@ static void wt_status_print_trailer(struct wt_status *s)
 
 #define quote_path quote_path_relative
 
+static void wt_status_print_unmerged_data(struct wt_status *s,
+					  struct string_list_item *it)
+{
+	const char *c = color(WT_STATUS_UNMERGED);
+	struct wt_status_change_data *d = it->util;
+	struct strbuf onebuf = STRBUF_INIT;
+	const char *one, *how = "bug";
+
+	one = quote_path(it->string, -1, &onebuf, s->prefix);
+	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+	switch (d->stagemask >> 1) {
+	case 1: how = "both deleted"; break;
+	case 2: how = "added by us"; break;
+	case 3: how = "deleted by them"; break;
+	case 4: how = "added by them"; break;
+	case 5: how = "deleted by us"; break;
+	case 6: how = "both added"; break;
+	case 7: how = "both modified"; break;
+	}
+	color_fprintf(s->fp, c, "%-20s: %s\n", how, one);
+	strbuf_release(&onebuf);
+}
+
 static void wt_status_print_change_data(struct wt_status *s,
 					int change_type,
 					struct string_list_item *it)
@@ -303,6 +340,29 @@ void wt_status_collect_changes(struct wt_status *s)
 		wt_status_collect_changes_index(s);
 }
 
+static void wt_status_print_unmerged(struct wt_status *s)
+{
+	int shown_header = 0;
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+		it = &(s->change.items[i]);
+		d = it->util;
+		if (!d->stagemask)
+			continue;
+		if (!shown_header) {
+			wt_status_print_unmerged_header(s);
+			shown_header = 1;
+		}
+		wt_status_print_unmerged_data(s, it);
+	}
+	if (shown_header)
+		wt_status_print_trailer(s);
+
+}
+
 static void wt_status_print_updated(struct wt_status *s)
 {
 	int shown_header = 0;
@@ -364,7 +424,8 @@ static void wt_status_print_changed(struct wt_status *s)
 		struct string_list_item *it;
 		it = &(s->change.items[i]);
 		d = it->util;
-		if (!d->worktree_status)
+		if (!d->worktree_status ||
+		    d->worktree_status == DIFF_STATUS_UNMERGED)
 			continue;
 		wt_status_print_change_data(s, WT_STATUS_CHANGED, it);
 	}
@@ -505,6 +566,7 @@ void wt_status_print(struct wt_status *s)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 	}
 
+	wt_status_print_unmerged(s);
 	wt_status_print_updated(s);
 	wt_status_print_changed(s);
 	if (wt_status_submodule_summary)
-- 
1.6.4.18.g07a4a
