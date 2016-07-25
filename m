Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA21203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 19:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbcGYT3A (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 15:29:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:27492 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbcGYT2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 15:28:55 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 94C328460B;
	Mon, 25 Jul 2016 15:28:53 -0400 (EDT)
From:	Jeff Hostetler <jeffhost@microsoft.com>
To:	git@vger.kernel.org
Cc:	git@jeffhostetler.com, peff@peff.net, gitster@pobox.com,
	jeffhost@microsoft.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 5/8] status: print per-file porcelain v2 status data
Date:	Mon, 25 Jul 2016 15:25:47 -0400
Message-Id: <1469474750-49075-6-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Print per-file information in porcelain v2 format.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 wt-status.c | 285 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 284 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 54aedc1..ffdfe11 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1864,6 +1864,8 @@ static void wt_porcelain_print(struct wt_status *s)
 	wt_shortstatus_print(s);
 }
 
+static void wt_porcelain_v2_print(struct wt_status *s);
+
 void wt_status_print(struct wt_status *s)
 {
 	switch (s->status_format) {
@@ -1874,7 +1876,7 @@ void wt_status_print(struct wt_status *s)
 		wt_porcelain_print(s);
 		break;
 	case STATUS_FORMAT_PORCELAIN_V2:
-		/* TODO */
+		wt_porcelain_v2_print(s);
 		break;
 	case STATUS_FORMAT_UNSPECIFIED:
 		die("BUG: finalize_deferred_config() should have been called");
@@ -1885,3 +1887,284 @@ void wt_status_print(struct wt_status *s)
 		break;
 	}
 }
+
+/*
+ * Convert various submodule status values into a
+ * string of characters in the buffer provided.
+ */
+static void wt_porcelain_v2_submodule_state(
+	struct wt_status_change_data *d,
+	char sub[5])
+{
+	if (S_ISGITLINK(d->aux.porcelain_v2.mode_head) ||
+		S_ISGITLINK(d->aux.porcelain_v2.mode_index) ||
+		S_ISGITLINK(d->aux.porcelain_v2.mode_worktree)) {
+		sub[0] = 'S';
+		sub[1] = d->new_submodule_commits ? 'C' : '.';
+		sub[2] = (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED) ? 'M' : '.';
+		sub[3] = (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ? 'U' : '.';
+	} else {
+		sub[0] = 'N';
+		sub[1] = '.';
+		sub[2] = '.';
+		sub[3] = '.';
+	}
+	sub[4] = 0;
+}
+
+/*
+ * Fix-up changed entries before we print them.
+ */
+static void wt_porcelain_v2_fix_up_changed(
+	struct string_list_item *it,
+	struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+
+	if (!d->index_status) {
+		/*
+		 * This entry is unchanged in the index (relative to the head).
+		 * Therefore, the collect_updated_cb was never called for this
+		 * entry (during the head-vs-index scan) and so the head column
+		 * fields were never set.
+		 *
+		 * We must have data for the index column (from the
+		 * index-vs-worktree scan (otherwise, this entry should not be
+		 * in the list of changes)).
+		 *
+		 * Copy index column fields to the head column, so that our
+		 * output looks complete.
+		 */
+		assert(d->aux.porcelain_v2.mode_head == 0);
+		d->aux.porcelain_v2.mode_head = d->aux.porcelain_v2.mode_index;
+		oidcpy(&d->aux.porcelain_v2.oid_head, &d->aux.porcelain_v2.oid_index);
+	}
+
+	if (!d->worktree_status) {
+		/*
+		 * This entry is unchanged in the worktree (relative to the index).
+		 * Therefore, the collect_changed_cb was never called for this entry
+		 * (during the index-vs-worktree scan) and so the worktree column
+		 * fields were never set.
+		 *
+		 * We must have data for the index column (from the head-vs-index
+		 * scan).
+		 *
+		 * Copy the index column fields to the worktree column so that
+		 * our output looks complete.
+		 *
+		 * Note that we only have a mode field in the worktree column
+		 * because the scan code tries really hard to not have to compute it.
+		 */
+		assert(d->aux.porcelain_v2.mode_worktree == 0);
+		d->aux.porcelain_v2.mode_worktree = d->aux.porcelain_v2.mode_index;
+	}
+}
+
+/*
+ * Print porcelain v2 info for tracked entries with changes.
+ */
+static void wt_porcelain_v2_print_changed_entry(
+	struct string_list_item *it,
+	struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+	struct strbuf buf_current = STRBUF_INIT;
+	struct strbuf buf_rename_src = STRBUF_INIT;
+	const char *path_current = NULL;
+	const char *path_rename_src = NULL;
+	char key[3];
+	char submodule_token[5];
+	char changed_prefix = 'c';
+	char sep_char, eol_char;
+
+	wt_porcelain_v2_fix_up_changed(it, s);
+	wt_porcelain_v2_submodule_state(d, submodule_token);
+
+	key[0] = d->index_status ? d->index_status : '.';
+	key[1] = d->worktree_status ? d->worktree_status : '.';
+	key[2] = 0;
+
+	if (s->null_termination) {
+		/*
+		 * In -z mode, we DO NOT C-Quote pathnames.  Current path is ALWAYS first.
+		 * A single NUL character separates them.
+		 */
+		sep_char = '\0';
+		eol_char = '\0';
+		path_current = it->string;
+		path_rename_src = d->head_path;
+	} else {
+		/*
+		 * Path(s) are C-Quoted if necessary. Current path is ALWAYS first.
+		 * The rename source path is only present when necessary.
+		 * A single TAB separates them (because paths can contain spaces
+		 * which are not escaped and C-Quoting does escape TAB characters).
+		 */
+		sep_char = '\t';
+		eol_char = '\n';
+		path_current = quote_path(it->string, s->prefix, &buf_current);
+		if (d->head_path)
+			path_rename_src = quote_path(d->head_path, s->prefix, &buf_rename_src);
+	}
+
+	fprintf(s->fp, "%c %s %s %06o %06o %06o %s %s R%d %s",
+			changed_prefix, key, submodule_token,
+			d->aux.porcelain_v2.mode_head,
+			d->aux.porcelain_v2.mode_index,
+			d->aux.porcelain_v2.mode_worktree,
+			oid_to_hex(&d->aux.porcelain_v2.oid_head),
+			oid_to_hex(&d->aux.porcelain_v2.oid_index),
+			d->aux.porcelain_v2.rename_score,
+			path_current);
+	if (path_rename_src)
+		fprintf(s->fp, "%c%s", sep_char, path_rename_src);
+	fprintf(s->fp, "%c", eol_char);
+	
+	strbuf_release(&buf_current);
+	strbuf_release(&buf_rename_src);
+}
+
+/*
+ * Print porcelain v2 status info for unmerged entries.
+ */
+static void wt_porcelain_v2_print_unmerged_entry(
+	struct string_list_item *it,
+	struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+	const struct cache_entry *ce;
+	struct strbuf buf_current = STRBUF_INIT;
+	const char *path_current = NULL;
+	int pos, stage, sum;
+	struct {
+		int mode;
+		struct object_id oid;
+	} stages[3];
+	char *key;
+	char submodule_token[5];
+	char unmerged_prefix = 'u';
+	char eol_char = s->null_termination ? '\0' : '\n';
+
+	wt_porcelain_v2_submodule_state(d, submodule_token);
+
+	switch (d->stagemask) {
+	case 1: key = "DD"; break; /* both deleted */
+	case 2: key = "AU"; break; /* added by us */
+	case 3: key = "UD"; break; /* deleted by them */
+	case 4: key = "UA"; break; /* added by them */
+	case 5: key = "DU"; break; /* deleted by us */
+	case 6: key = "AA"; break; /* both added */
+	case 7: key = "UU"; break; /* both modified */
+	}
+
+	/*
+	 * Disregard d.aux.porcelain_v2 data that we accumulated
+	 * for the head and index columns during the scans and
+	 * replace with the actual stage data.
+	 *
+	 * Note that this is a last-one-wins for each the individual
+	 * stage [123] columns in the event of multiple cache rows
+	 * for a stage.
+	 */
+	memset(stages, 0, sizeof(stages));
+	sum = 0;
+	pos = cache_name_pos(it->string, strlen(it->string));
+	assert(pos < 0);
+	pos = -pos-1;
+	while (pos < active_nr) {
+		ce = active_cache[pos++];
+		stage = ce_stage(ce);
+		if (strcmp(ce->name, it->string) || !stage)
+			break;
+		stages[stage - 1].mode = ce->ce_mode;
+		hashcpy(stages[stage - 1].oid.hash, ce->sha1);
+		sum++;
+	}
+	if (!sum)
+		die("BUG: unmerged entry without any stages");
+
+	if (s->null_termination)
+		path_current = it->string;
+	else
+		path_current = quote_path(it->string, s->prefix, &buf_current);
+
+	fprintf(s->fp, "%c %s %s %06o %06o %06o %06o %s %s %s %s%c",
+			unmerged_prefix, key, submodule_token,
+			stages[0].mode, /* stage 1 */
+			stages[1].mode, /* stage 2 */
+			stages[2].mode, /* stage 3 */
+			d->aux.porcelain_v2.mode_worktree,
+			oid_to_hex(&stages[0].oid), /* stage 1 */
+			oid_to_hex(&stages[1].oid), /* stage 2 */
+			oid_to_hex(&stages[2].oid), /* stage 3 */
+			path_current,
+			eol_char);
+
+	strbuf_release(&buf_current);
+}
+
+/*
+ * Print porcelain V2 status info for untracked and ignored entries.
+ */
+static void wt_porcelain_v2_print_other(
+	struct string_list_item *it,
+	struct wt_status *s,
+	char prefix)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *path;
+	char eol_char;
+
+	if (s->null_termination) {
+		path = it->string;
+		eol_char = '\0';
+	} else {
+		path = quote_path(it->string, s->prefix, &buf);
+		eol_char = '\n';
+	}
+
+	fprintf(s->fp, "%c %s%c", prefix, path, eol_char);
+
+	strbuf_release(&buf);
+}
+
+/*
+ * Print porcelain V2 status.
+ *
+ * [<v2_changed_items>]*
+ * [<v2_unmerged_items>]*
+ * [<v2_untracked_items>]*
+ * [<v2_ignored_items>]*
+ *
+ */
+void wt_porcelain_v2_print(struct wt_status *s)
+{
+	struct wt_status_change_data *d;
+	struct string_list_item *it;
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		it = &(s->change.items[i]);
+		d = it->util;
+		if (!d->stagemask)
+			wt_porcelain_v2_print_changed_entry(it, s);
+	}
+
+	for (i = 0; i < s->change.nr; i++) {
+		it = &(s->change.items[i]);
+		d = it->util;
+		if (d->stagemask)
+			wt_porcelain_v2_print_unmerged_entry(it, s);
+	}
+
+	for (i = 0; i < s->untracked.nr; i++) {
+		it = &(s->untracked.items[i]);
+		wt_porcelain_v2_print_other(it, s, '?');
+	}
+
+	for (i = 0; i < s->ignored.nr; i++) {
+		it = &(s->ignored.items[i]);
+		wt_porcelain_v2_print_other(it, s, '!');
+	}
+}
-- 
2.8.0.rc4.17.gac42084.dirty

