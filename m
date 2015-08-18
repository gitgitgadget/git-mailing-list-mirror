From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 1/8] branch: refactor width computation
Date: Wed, 19 Aug 2015 00:45:38 +0530
Message-ID: <1439925345-9969-2-git-send-email-Karthik.188@gmail.com>
References: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 21:16:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRmMZ-0003fv-NZ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 21:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbbHRTPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 15:15:44 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35919 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbbHRTPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 15:15:43 -0400
Received: by pdbmi9 with SMTP id mi9so30662205pdb.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vQptzrVzJEiS22RSfB3lZAmrHczY474civybJTkbHGk=;
        b=GNErtqZJ3Bp6Monhf4yP4hxXnHoOh2An0TWDBult3RVe6d4w2iNSnrZf5GjR/cVbLI
         YsvW8wyQ0eLTqL1JOO8G67p/N8S5mpfwkx675yJhagLIj+BPFYSTL/PeEz673B/dNdnz
         dLTBhOVklBrnYLX2/Y7LkZ3qoQQASVuTiYn2W/DB46UXvSKn9/S/VUI9I+3SNw/h15W5
         jUTxkO7BRZcBUYbk6VaePw0EN8bsEJWyX9q/dLBJLs3CuvrAG20aCd1/eZVbqbhnlhM2
         omCaULpIcBb37cYwnBY4oy4BYzGtNSHyLezFcq3rr46+jvy1sYcn2pjEen5RJSFJ5nvD
         omSg==
X-Received: by 10.70.127.206 with SMTP id ni14mr16263091pdb.53.1439925342741;
        Tue, 18 Aug 2015 12:15:42 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id v2sm43800pda.34.2015.08.18.12.15.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 12:15:42 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276153>

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
2.5.0
