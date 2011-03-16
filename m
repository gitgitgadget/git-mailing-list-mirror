From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/8] diff --submodule: split into bite-sized pieces
Date: Wed, 16 Mar 2011 02:14:11 -0500
Message-ID: <20110316071411.GI5988@elie>
References: <20110316024959.GA24932@elie>
 <20110316065256.GA5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 08:14:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzkw2-0001EO-7o
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 08:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab1CPHOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 03:14:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41630 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab1CPHOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 03:14:16 -0400
Received: by yxs7 with SMTP id 7so545796yxs.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 00:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=5PvBazJiv/pg8/a3C/+jI6VovmfyTmp3wwTCvtAm3Og=;
        b=QbhbPpzCs+CEwXwBwD3/TER3CGJHc+eb6g1XGuJqxCJ+Nc4nLaulVr4/w/cpIpZ/8T
         9MMivWRmbYpwJDQS/BNGRF64m7uw36bnxvLJ9TEjPtg+kSJiPJsZLgxni9Eu9yHg6rNz
         11i7WZqhojzGE+nL4mXDcmT1aqcGeMvYvq2QE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=POaJLTSVgouWZM8F8WIhwuWbR7IXFN+F1a2JInQpV1lMkNMZCZ6zJyE582zhjmj/1y
         ZahEGBgVdFEHf0X2J4pCuQYcN3kLDROZxuIQcCEcEbru/YQWbkju0RDbLwcSxVfJbsQ9
         xEv9Kp7c8dgSF0M4MkHNABnFjQen67cX2IovM=
Received: by 10.150.32.13 with SMTP id f13mr1019014ybf.211.1300259656031;
        Wed, 16 Mar 2011 00:14:16 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id f2sm563979ybh.19.2011.03.16.00.14.14
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 00:14:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316065256.GA5988@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169116>

Introduce two functions:

 - prepare_submodule_summary prepares the revision walker
   to list changes in a submodule.  That is, it:

   * finds merge bases between the commits pointed to this
     path from before ("left") and after ("right") the change;
   * checks whether this is a fast-forward or fast-backward;
   * prepares a revision walk to list commits in the symmetric
     difference between the commits at each endpoint.

   It returns nonzero on error.

 - print_submodule_summary runs the revision walk and saves
   the result to a strbuf in --left-right format.

The goal is just readability.  No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 submodule.c |  103 +++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 61 insertions(+), 42 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6f1c107..e9f2b19 100644
--- a/submodule.c
+++ b/submodule.c
@@ -152,17 +152,69 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 		die("bad --ignore-submodules argument: %s", arg);
 }
 
+static int prepare_submodule_summary(struct rev_info *rev, const char *path,
+		struct commit *left, struct commit *right,
+		int *fast_forward, int *fast_backward)
+{
+	struct commit_list *merge_bases, *list;
+
+	init_revisions(rev, NULL);
+	setup_revisions(0, NULL, rev, NULL);
+	rev->left_right = 1;
+	rev->first_parent_only = 1;
+	left->object.flags |= SYMMETRIC_LEFT;
+	add_pending_object(rev, &left->object, path);
+	add_pending_object(rev, &right->object, path);
+	merge_bases = get_merge_bases(left, right, 1);
+	if (merge_bases) {
+		if (merge_bases->item == left)
+			*fast_forward = 1;
+		else if (merge_bases->item == right)
+			*fast_backward = 1;
+	}
+	for (list = merge_bases; list; list = list->next) {
+		list->item->object.flags |= UNINTERESTING;
+		add_pending_object(rev, &list->item->object,
+			sha1_to_hex(list->item->object.sha1));
+	}
+	return prepare_revision_walk(rev);
+}
+
+static void print_submodule_summary(struct rev_info *rev, FILE *f,
+		const char *del, const char *add, const char *reset)
+{
+	static const char format[] = "  %m %s";
+	struct strbuf sb = STRBUF_INIT;
+	struct commit *commit;
+
+	while ((commit = get_revision(rev))) {
+		struct pretty_print_context ctx = {0};
+		ctx.date_mode = rev->date_mode;
+		strbuf_setlen(&sb, 0);
+		if (commit->object.flags & SYMMETRIC_LEFT) {
+			if (del)
+				strbuf_addstr(&sb, del);
+		}
+		else if (add)
+			strbuf_addstr(&sb, add);
+		format_commit_message(commit, format, &sb, &ctx);
+		if (reset)
+			strbuf_addstr(&sb, reset);
+		strbuf_addch(&sb, '\n');
+		fprintf(f, "%s", sb.buf);
+	}
+	strbuf_release(&sb);
+}
+
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset)
 {
 	struct rev_info rev;
-	struct commit *commit, *left = left, *right = right;
-	struct commit_list *merge_bases, *list;
+	struct commit *left = left, *right = right;
 	const char *message = NULL;
 	struct strbuf sb = STRBUF_INIT;
-	static const char *format = "  %m %s";
 	int fast_forward = 0, fast_backward = 0;
 
 	if (is_null_sha1(two))
@@ -175,29 +227,10 @@ void show_submodule_summary(FILE *f, const char *path,
 		 !(right = lookup_commit_reference(two)))
 		message = "(commits not present)";
 
-	if (!message) {
-		init_revisions(&rev, NULL);
-		setup_revisions(0, NULL, &rev, NULL);
-		rev.left_right = 1;
-		rev.first_parent_only = 1;
-		left->object.flags |= SYMMETRIC_LEFT;
-		add_pending_object(&rev, &left->object, path);
-		add_pending_object(&rev, &right->object, path);
-		merge_bases = get_merge_bases(left, right, 1);
-		if (merge_bases) {
-			if (merge_bases->item == left)
-				fast_forward = 1;
-			else if (merge_bases->item == right)
-				fast_backward = 1;
-		}
-		for (list = merge_bases; list; list = list->next) {
-			list->item->object.flags |= UNINTERESTING;
-			add_pending_object(&rev, &list->item->object,
-				sha1_to_hex(list->item->object.sha1));
-		}
-		if (prepare_revision_walk(&rev))
-			message = "(revision walker failed)";
-	}
+	if (!message &&
+	    prepare_submodule_summary(&rev, path, left, right,
+					&fast_forward, &fast_backward))
+		message = "(revision walker failed)";
 
 	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
 		fprintf(f, "Submodule %s contains untracked content\n", path);
@@ -221,25 +254,11 @@ void show_submodule_summary(FILE *f, const char *path,
 	fwrite(sb.buf, sb.len, 1, f);
 
 	if (!message) {
-		while ((commit = get_revision(&rev))) {
-			struct pretty_print_context ctx = {0};
-			ctx.date_mode = rev.date_mode;
-			strbuf_setlen(&sb, 0);
-			if (commit->object.flags & SYMMETRIC_LEFT) {
-				if (del)
-					strbuf_addstr(&sb, del);
-			}
-			else if (add)
-				strbuf_addstr(&sb, add);
-			format_commit_message(commit, format, &sb, &ctx);
-			if (reset)
-				strbuf_addstr(&sb, reset);
-			strbuf_addch(&sb, '\n');
-			fprintf(f, "%s", sb.buf);
-		}
+		print_submodule_summary(&rev, f, del, add, reset);
 		clear_commit_marks(left, ~0);
 		clear_commit_marks(right, ~0);
 	}
+
 	strbuf_release(&sb);
 }
 
-- 
1.7.4.1
