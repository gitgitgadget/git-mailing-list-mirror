From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 1/8] branch: refactor width computation
Date: Sun, 13 Sep 2015 12:53:48 +0530
Message-ID: <1442129035-31386-2-git-send-email-Karthik.188@gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 09:23:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb1dk-0002fB-4W
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 09:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbbIMHXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 03:23:52 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34303 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbbIMHXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 03:23:50 -0400
Received: by padhy16 with SMTP id hy16so113322710pad.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pyH55+8q91sQ9+cfdK3iBYLH0+kDRJeng6gO+HI56DQ=;
        b=QCqtUIuLlMPNL91OrRqFykyp2zQmXt1NNmNKFCkk/2SGMeeeJ+JftGTLh0mGM5XS8L
         nV8nBJA0JfN2aSJ8nw32auiDFyrUKZBPD0rPXvcUwFvMgdoxdJHI1YRAixRKNA35fz1z
         kC0tZ8Xt8Jr2g5AgHi+iVMWjw+YkEZSFu6caHCWY+8jmXeYXXklZdOplGrxIC9ALHNNV
         KEJsfIkGKhB5nmlZJIqZjjNWHG3X8J5kzyYGhq/JCmhVPbhOi+XF/XV+gp+7qNLiQYLN
         FEwUHdp59pGAouFulZ6rRAADaduP/PMe2XtHx7E1nQoHuJZpYCsy1giTMt8UcjbrNqyt
         9jIw==
X-Received: by 10.66.246.193 with SMTP id xy1mr19255646pac.144.1442129030115;
        Sun, 13 Sep 2015 00:23:50 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id g5sm7688014pat.21.2015.09.13.00.23.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Sep 2015 00:23:49 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277760>

From: Karthik Nayak <karthik.188@gmail.com>

Remove unnecessary variables from ref_list and ref_item which were
used for width computation. This is to make ref_item similar to
ref-filter's ref_array_item. This will ensure a smooth port of
branch.c to use ref-filter APIs in further patches.

Previously the maxwidth was computed when inserting the refs into the
ref_list. Now, we obtain the entire ref_list and then compute
maxwidth.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 64 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4fc8beb..28a10d6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -282,14 +282,14 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 struct ref_item {
 	char *name;
 	char *dest;
-	unsigned int kind, width;
+	unsigned int kind;
 	struct commit *commit;
 	int ignore;
 };
 
 struct ref_list {
 	struct rev_info revs;
-	int index, alloc, maxwidth, verbose, abbrev;
+	int index, alloc, verbose, abbrev;
 	struct ref_item *list;
 	struct commit_list *with_commit;
 	int kinds;
@@ -386,15 +386,8 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
 	newitem->name = xstrdup(refname);
 	newitem->kind = kind;
 	newitem->commit = commit;
-	newitem->width = utf8_strwidth(refname);
 	newitem->dest = resolve_symref(orig_refname, prefix);
 	newitem->ignore = 0;
-	/* adjust for "remotes/" */
-	if (newitem->kind == REF_REMOTE_BRANCH &&
-	    ref_list->kinds != REF_REMOTE_BRANCH)
-		newitem->width += 8;
-	if (newitem->width > ref_list->maxwidth)
-		ref_list->maxwidth = newitem->width;
 
 	return 0;
 }
@@ -505,11 +498,12 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 }
 
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
-			   int abbrev, int current, char *prefix)
+			   int abbrev, int current, const char *remote_prefix)
 {
 	char c;
 	int color;
 	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
+	const char *prefix = "";
 
 	if (item->ignore)
 		return;
@@ -520,6 +514,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		break;
 	case REF_REMOTE_BRANCH:
 		color = BRANCH_COLOR_REMOTE;
+		prefix = remote_prefix;
 		break;
 	default:
 		color = BRANCH_COLOR_PLAIN;
@@ -557,16 +552,22 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	strbuf_release(&out);
 }
 
-static int calc_maxwidth(struct ref_list *refs)
+static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
 {
-	int i, w = 0;
+	int i, max = 0;
 	for (i = 0; i < refs->index; i++) {
-		if (refs->list[i].ignore)
+		struct ref_item *it = &refs->list[i];
+		int w;
+
+		if (it->ignore)
 			continue;
-		if (refs->list[i].width > w)
-			w = refs->list[i].width;
+		w = utf8_strwidth(it->name);
+		if (it->kind == REF_REMOTE_BRANCH)
+			w += remote_bonus;
+		if (w > max)
+			max = w;
 	}
-	return w;
+	return max;
 }
 
 static char *get_head_description(void)
@@ -600,21 +601,18 @@ static char *get_head_description(void)
 	return strbuf_detach(&desc, NULL);
 }
 
-static void show_detached(struct ref_list *ref_list)
+static void show_detached(struct ref_list *ref_list, int maxwidth)
 {
 	struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
 
 	if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {
 		struct ref_item item;
 		item.name = get_head_description();
-		item.width = utf8_strwidth(item.name);
 		item.kind = REF_LOCAL_BRANCH;
 		item.dest = NULL;
 		item.commit = head_commit;
 		item.ignore = 0;
-		if (item.width > ref_list->maxwidth)
-			ref_list->maxwidth = item.width;
-		print_ref_item(&item, ref_list->maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
+		print_ref_item(&item, maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
 		free(item.name);
 	}
 }
@@ -624,6 +622,16 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	int i;
 	struct append_ref_cb cb;
 	struct ref_list ref_list;
+	int maxwidth = 0;
+	const char *remote_prefix = "";
+
+	/*
+	 * If we are listing more than just remote branches,
+	 * then remote branches will have a "remotes/" prefix.
+	 * We need to account for this in the width.
+	 */
+	if (kinds != REF_REMOTE_BRANCH)
+		remote_prefix = "remotes/";
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
@@ -667,26 +675,22 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 			clear_commit_marks(item->commit, ALL_REV_FLAGS);
 		}
 		clear_commit_marks(filter, ALL_REV_FLAGS);
-
-		if (verbose)
-			ref_list.maxwidth = calc_maxwidth(&ref_list);
 	}
+	if (verbose)
+		maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
 
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
 	if (detached && match_patterns(pattern, "HEAD"))
-		show_detached(&ref_list);
+		show_detached(&ref_list, maxwidth);
 
 	for (i = 0; i < ref_list.index; i++) {
 		int current = !detached &&
 			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
 			!strcmp(ref_list.list[i].name, head);
-		char *prefix = (kinds != REF_REMOTE_BRANCH &&
-				ref_list.list[i].kind == REF_REMOTE_BRANCH)
-				? "remotes/" : "";
-		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose,
-			       abbrev, current, prefix);
+		print_ref_item(&ref_list.list[i], maxwidth, verbose,
+			       abbrev, current, remote_prefix);
 	}
 
 	free_ref_list(&ref_list);
-- 
2.5.1
