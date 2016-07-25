Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC0DD203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 19:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbcGYT26 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 15:28:58 -0400
Received: from siwi.pair.com ([209.68.5.199]:27479 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839AbcGYT2y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 15:28:54 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 0BD4E84609;
	Mon, 25 Jul 2016 15:28:51 -0400 (EDT)
From:	Jeff Hostetler <jeffhost@microsoft.com>
To:	git@vger.kernel.org
Cc:	git@jeffhostetler.com, peff@peff.net, gitster@pobox.com,
	jeffhost@microsoft.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 4/8] status: per-file data collection for --porcelain=v2
Date:	Mon, 25 Jul 2016 15:25:46 -0400
Message-Id: <1469474750-49075-5-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The output of `git status --porcelain` leaves out many details
about the current status that clients might like to have. This
can force them to be less efficient as they may need to launch
secondary commands (and try to match the logic within git) to
accumulate this extra information.  For example, a GUI IDE might
need the file mode to display the correct icon for a changed item.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/commit.c |   3 ++
 wt-status.c      | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 wt-status.h      |  17 +++++++++
 3 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e6bbb12..5b9efd2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -153,6 +153,8 @@ static int opt_parse_porcelain(const struct option *opt, const char *arg, int un
 		*value = STATUS_FORMAT_PORCELAIN;
 	else if (!strcmp(arg, "v1"))
 		*value = STATUS_FORMAT_PORCELAIN;
+	else if (!strcmp(arg, "v2"))
+		*value = STATUS_FORMAT_PORCELAIN_V2;
 	else
 		die("unsupported porcelain version");
 
@@ -1104,6 +1106,7 @@ static struct status_deferred_config {
 static void finalize_deferred_config(struct wt_status *s)
 {
 	int use_deferred_config = (status_format != STATUS_FORMAT_PORCELAIN &&
+				   status_format != STATUS_FORMAT_PORCELAIN_V2 &&
 				   !s->null_termination);
 
 	if (s->null_termination) {
diff --git a/wt-status.c b/wt-status.c
index a9031e4..54aedc1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -406,6 +406,110 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 	strbuf_release(&twobuf);
 }
 
+static void aux_updated_entry_porcelain_v2(
+	struct wt_status *s,
+	struct wt_status_change_data *d,
+	struct diff_filepair *p)
+{
+	switch (p->status) {
+	case DIFF_STATUS_ADDED:
+		/* {mode,sha1}_head are zero for an add. */
+		d->aux.porcelain_v2.mode_index = p->two->mode;
+		oidcpy(&d->aux.porcelain_v2.oid_index, &p->two->oid);
+		break;
+
+	case DIFF_STATUS_DELETED:
+		d->aux.porcelain_v2.mode_head = p->one->mode;
+		oidcpy(&d->aux.porcelain_v2.oid_head, &p->one->oid);
+		/* {mode,oid}_index are zero for a delete. */
+		break;
+
+	case DIFF_STATUS_RENAMED:
+		d->aux.porcelain_v2.rename_score = p->score * 100 / MAX_SCORE;
+	case DIFF_STATUS_COPIED:
+	case DIFF_STATUS_MODIFIED:
+	case DIFF_STATUS_TYPE_CHANGED:
+	case DIFF_STATUS_UNMERGED:
+		d->aux.porcelain_v2.mode_head = p->one->mode;
+		d->aux.porcelain_v2.mode_index = p->two->mode;
+		oidcpy(&d->aux.porcelain_v2.oid_head, &p->one->oid);
+		oidcpy(&d->aux.porcelain_v2.oid_index, &p->two->oid);
+		break;
+
+	case DIFF_STATUS_UNKNOWN:
+		die("BUG: index status unknown");
+		break;
+	}
+}
+
+/* Save aux info for a head-vs-index change. */
+static void aux_updated_entry(
+	struct wt_status *s,
+	struct wt_status_change_data *d,
+	struct diff_filepair *p)
+{
+	if (s->status_format == STATUS_FORMAT_PORCELAIN_V2)
+		aux_updated_entry_porcelain_v2(s, d, p);
+}
+
+static void aux_changed_entry_porcelain_v2(
+	struct wt_status *s,
+	struct wt_status_change_data *d,
+	const struct diff_filepair *p)
+{
+	switch (p->status) {
+	case DIFF_STATUS_ADDED:
+		die("BUG: worktree status add???");
+		break;
+
+	case DIFF_STATUS_DELETED:
+		d->aux.porcelain_v2.mode_index = p->one->mode;
+		oidcpy(&d->aux.porcelain_v2.oid_index, &p->one->oid);
+		/* mode_worktree is zero for a delete. */
+		break;
+
+	case DIFF_STATUS_MODIFIED:
+	case DIFF_STATUS_TYPE_CHANGED:
+	case DIFF_STATUS_UNMERGED:
+		d->aux.porcelain_v2.mode_index = p->one->mode;
+		d->aux.porcelain_v2.mode_worktree = p->two->mode;
+		oidcpy(&d->aux.porcelain_v2.oid_index, &p->one->oid);
+		break;
+
+	case DIFF_STATUS_UNKNOWN:
+		die("BUG: worktree status unknown???");
+		break;
+	}
+}
+
+/* Save aux info for an index-vs-worktree change. */
+static void aux_changed_entry(
+	struct wt_status *s,
+	struct wt_status_change_data *d,
+	struct diff_filepair *p)
+{
+	if (s->status_format == STATUS_FORMAT_PORCELAIN_V2)
+		aux_changed_entry_porcelain_v2(s, d, p);
+}
+
+static void aux_initial_entry_porcelain_v2(
+	struct wt_status *s,
+	struct wt_status_change_data *d,
+	const struct cache_entry *ce)
+{
+	d->aux.porcelain_v2.mode_index = ce->ce_mode;
+	hashcpy(d->aux.porcelain_v2.oid_index.hash, ce->sha1);
+}
+
+static void aux_initial_entry(
+	struct wt_status *s,
+	struct wt_status_change_data *d,
+	const struct cache_entry *ce)
+{
+	if (s->status_format == STATUS_FORMAT_PORCELAIN_V2)
+		aux_initial_entry_porcelain_v2(s, d, ce);
+}
+
 static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 					 struct diff_options *options,
 					 void *data)
@@ -434,6 +538,7 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		if (S_ISGITLINK(p->two->mode))
 			d->new_submodule_commits = !!oidcmp(&p->one->oid,
 							    &p->two->oid);
+		aux_changed_entry(s, d, p);
 	}
 }
 
@@ -487,6 +592,8 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 			d->stagemask = unmerged_mask(p->two->path);
 			break;
 		}
+
+		aux_updated_entry(s, d, p);
 	}
 }
 
@@ -566,8 +673,10 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 			d->index_status = DIFF_STATUS_UNMERGED;
 			d->stagemask |= (1 << (ce_stage(ce) - 1));
 		}
-		else
+		else {
 			d->index_status = DIFF_STATUS_ADDED;
+			aux_initial_entry(s, d, ce);
+		}
 	}
 }
 
@@ -1764,6 +1873,9 @@ void wt_status_print(struct wt_status *s)
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(s);
 		break;
+	case STATUS_FORMAT_PORCELAIN_V2:
+		/* TODO */
+		break;
 	case STATUS_FORMAT_UNSPECIFIED:
 		die("BUG: finalize_deferred_config() should have been called");
 		break;
diff --git a/wt-status.h b/wt-status.h
index a859a12..f2cb65d 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -34,6 +34,21 @@ enum commit_whence {
 	FROM_CHERRY_PICK /* commit came from cherry-pick */
 };
 
+/*
+ * Additional per-file info which may vary based
+ * upon the chosen format.
+ */
+struct wt_status_aux_change_data {
+	struct {
+		int rename_score;
+		int mode_head;
+		int mode_index;
+		int mode_worktree;
+		struct object_id oid_head;
+		struct object_id oid_index;
+	} porcelain_v2;
+};
+
 struct wt_status_change_data {
 	int worktree_status;
 	int index_status;
@@ -41,6 +56,7 @@ struct wt_status_change_data {
 	char *head_path;
 	unsigned dirty_submodule       : 2;
 	unsigned new_submodule_commits : 1;
+	struct wt_status_aux_change_data aux;
 };
 
  enum wt_status_format {
@@ -48,6 +64,7 @@ struct wt_status_change_data {
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
+	STATUS_FORMAT_PORCELAIN_V2,
 
 	STATUS_FORMAT_UNSPECIFIED
  };
-- 
2.8.0.rc4.17.gac42084.dirty

