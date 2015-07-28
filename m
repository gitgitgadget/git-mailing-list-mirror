From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 05/11] branch: fix width computation
Date: Tue, 28 Jul 2015 12:26:30 +0530
Message-ID: <1438066594-5620-5-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 08:56:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJyoi-0006E5-36
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbbG1G4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:56:44 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35294 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbbG1G4m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:56:42 -0400
Received: by pabkd10 with SMTP id kd10so65021751pab.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rGq+jgHypVdotJJiOUROegIV3EzVPH4NLKxcUHflBpA=;
        b=j7Qcdeg7IDkiLBpwSoEaJuLBkgc5nOAFx1EikVi4lkLTHaONvyUuE29a6EgwiaiigB
         onhBLxXc9HJZALZGPOJoXl/Z7fxyBdcCCGodXW+wBqU64o8H4/6hxsDRxs0dxH1Z0q3z
         YZWzQh0DxWLvtn+5SaGdPhy+UFyapHt8Llx7Squ34Kq77AnpqJWw7rNx6k1OVt+m9b0u
         TMRgjfgvT/0ppFM8gbE9d0LL4PU7e1DohuX4nX6uz2Wm/D0Qsoyv+EamHCLg2jn4pfoY
         qyFz3LaU7Kl0eqWtMF5LKXmIsoz8ZD+Y4eFatRxmziZgmDwmGV7TnW9njfj0l2OK+BJP
         7wjQ==
X-Received: by 10.66.218.130 with SMTP id pg2mr3224313pac.53.1438066601952;
        Mon, 27 Jul 2015 23:56:41 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id q7sm33147846pdj.31.2015.07.27.23.56.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 23:56:41 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274741>

From: Karthik Nayak <karthik.188@gmail.com>

Remove unnecessary variables from ref_list and ref_item
which were used for width computation. Make other changes
accordingly. This patch is a precursor for porting branch.c
to use ref-filter APIs.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 61 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4fc8beb..b058b74 100644
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
@@ -557,16 +552,21 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	strbuf_release(&out);
 }
 
-static int calc_maxwidth(struct ref_list *refs)
+static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
 {
-	int i, w = 0;
+	int i, max = 0;
 	for (i = 0; i < refs->index; i++) {
+		struct ref_item *it = &refs->list[i];
+		int w = utf8_strwidth(it->name);
+
 		if (refs->list[i].ignore)
 			continue;
-		if (refs->list[i].width > w)
-			w = refs->list[i].width;
+		if (it->kind == REF_REMOTE_BRANCH)
+			w += remote_bonus;
+		if (w > max)
+			max = w;
 	}
-	return w;
+	return max;
 }
 
 static char *get_head_description(void)
@@ -600,21 +600,18 @@ static char *get_head_description(void)
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
@@ -624,6 +621,16 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
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
@@ -667,26 +674,22 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
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
2.4.6
