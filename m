Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7B7F2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 22:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993418AbcHEWEY (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 18:04:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:64372 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S3003593AbcHEWDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 18:03:20 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 685F984606;
	Fri,  5 Aug 2016 18:03:18 -0400 (EDT)
From:	Jeff Hostetler <git@jeffhostetler.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 4/9] status: collect per-file data for --porcelain=v2
Date:	Fri,  5 Aug 2016 18:00:29 -0400
Message-Id: <1470434434-64283-5-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
References: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Collect extra per-file data for porcelain V2 format.

The output of `git status --porcelain` leaves out many
details about the current status that clients might like
to have.  This can force them to be less efficient as they
may need to launch secondary commands (and try to match
the logic within git) to accumulate this extra information.
For example, a GUI IDE might want the file mode to display
the correct icon for a changed item (without having to stat
it afterwards).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/commit.c |  3 +++
 wt-status.c      | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 wt-status.h      |  4 ++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 185ac35..3d222d3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -153,6 +153,8 @@ static int opt_parse_porcelain(const struct option *opt, const char *arg, int un
 		*value = STATUS_FORMAT_PORCELAIN;
 	else if (!strcmp(arg, "v1") || !strcmp(arg, "1"))
 		*value = STATUS_FORMAT_PORCELAIN;
+	else if (!strcmp(arg, "v2") || !strcmp(arg, "2"))
+		*value = STATUS_FORMAT_PORCELAIN_V2;
 	else
 		die("unsupported porcelain version '%s'", arg);
 
@@ -1104,6 +1106,7 @@ static struct status_deferred_config {
 static void finalize_deferred_config(struct wt_status *s)
 {
 	int use_deferred_config = (status_format != STATUS_FORMAT_PORCELAIN &&
+				   status_format != STATUS_FORMAT_PORCELAIN_V2 &&
 				   !s->null_termination);
 
 	if (s->null_termination) {
diff --git a/wt-status.c b/wt-status.c
index a9031e4..ca8023e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -434,6 +434,31 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		if (S_ISGITLINK(p->two->mode))
 			d->new_submodule_commits = !!oidcmp(&p->one->oid,
 							    &p->two->oid);
+
+		switch (p->status) {
+		case DIFF_STATUS_ADDED:
+			die("BUG: worktree status add???");
+			break;
+
+		case DIFF_STATUS_DELETED:
+			d->mode_index = p->one->mode;
+			oidcpy(&d->oid_index, &p->one->oid);
+			/* mode_worktree is zero for a delete. */
+			break;
+
+		case DIFF_STATUS_MODIFIED:
+		case DIFF_STATUS_TYPE_CHANGED:
+		case DIFF_STATUS_UNMERGED:
+			d->mode_index = p->one->mode;
+			d->mode_worktree = p->two->mode;
+			oidcpy(&d->oid_index, &p->one->oid);
+			break;
+
+		case DIFF_STATUS_UNKNOWN:
+			die("BUG: worktree status unknown???");
+			break;
+		}
+
 	}
 }
 
@@ -479,12 +504,36 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 		if (!d->index_status)
 			d->index_status = p->status;
 		switch (p->status) {
+		case DIFF_STATUS_ADDED:
+			/* Leave {mode,oid}_head zero for an add. */
+			d->mode_index = p->two->mode;
+			oidcpy(&d->oid_index, &p->two->oid);
+			break;
+		case DIFF_STATUS_DELETED:
+			d->mode_head = p->one->mode;
+			oidcpy(&d->oid_head, &p->one->oid);
+			/* Leave {mode,oid}_index zero for a delete. */
+			break;
+
 		case DIFF_STATUS_COPIED:
 		case DIFF_STATUS_RENAMED:
 			d->head_path = xstrdup(p->one->path);
+			d->score = p->score * 100 / MAX_SCORE;
+			/* fallthru */
+		case DIFF_STATUS_MODIFIED:
+		case DIFF_STATUS_TYPE_CHANGED:
+			d->mode_head = p->one->mode;
+			d->mode_index = p->two->mode;
+			oidcpy(&d->oid_head, &p->one->oid);
+			oidcpy(&d->oid_index, &p->two->oid);
 			break;
 		case DIFF_STATUS_UNMERGED:
 			d->stagemask = unmerged_mask(p->two->path);
+			/*
+			 * Don't bother setting {mode,oid}_{head,index} since the print
+			 * code will output the stage values directly and not use the
+			 * values in these fields.
+			 */
 			break;
 		}
 	}
@@ -565,9 +614,18 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 		if (ce_stage(ce)) {
 			d->index_status = DIFF_STATUS_UNMERGED;
 			d->stagemask |= (1 << (ce_stage(ce) - 1));
+			/*
+			 * Don't bother setting {mode,oid}_{head,index} since the print
+			 * code will output the stage values directly and not use the
+			 * values in these fields.
+			 */
 		}
-		else
+		else {
 			d->index_status = DIFF_STATUS_ADDED;
+			/* Leave {mode,oid}_head zero for adds. */
+			d->mode_index = ce->ce_mode;
+			hashcpy(d->oid_index.hash, ce->sha1);
+		}
 	}
 }
 
@@ -1764,6 +1822,9 @@ void wt_status_print(struct wt_status *s)
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
index 9389076..43fd3fc 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -38,6 +38,9 @@ struct wt_status_change_data {
 	int worktree_status;
 	int index_status;
 	int stagemask;
+	int score;
+	int mode_head, mode_index, mode_worktree;
+	struct object_id oid_head, oid_index;
 	char *head_path;
 	unsigned dirty_submodule       : 2;
 	unsigned new_submodule_commits : 1;
@@ -48,6 +51,7 @@ enum wt_status_format {
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
+	STATUS_FORMAT_PORCELAIN_V2,
 
 	STATUS_FORMAT_UNSPECIFIED
 };
-- 
2.8.0.rc4.17.gac42084.dirty

