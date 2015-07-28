From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 06/11] branch: roll show_detached HEAD into regular ref_list
Date: Tue, 28 Jul 2015 12:26:31 +0530
Message-ID: <1438066594-5620-6-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 08:56:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJyor-0006Hv-S4
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbbG1G4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:56:47 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34311 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbbG1G4p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:56:45 -0400
Received: by pdbbh15 with SMTP id bh15so65630666pdb.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=agKbpqeoJQUE+8dnLGCgnIQr3vmG6qtzo00R91JVq/Y=;
        b=uEAbgW4Nsw6Xw+ArWeKHnD1X9Oz4g+1kbKujIFmy8lU97Kkuc8XmEHarnTjlgwJMmC
         C6u6NN0q+g4bZFew3oqZVeMjIUwVv6AwkN/m2VEihGCes2n1Z46kYMBkQsWwYMsKPV6u
         BKQydpcreJWWOdHdl5SjymE2cV2vzvE+lxR44va8hy5pndYj4BKEwOug0GKmP9aCYRwC
         seiWydjUsFK1dzLUUg3eakzTRBhPc4SDL0EkMbdEbYTgoV0dfcKAWdUzJ3VPU3Vq5ggP
         nGwumXQxk8DCTYeWqyi0se5YVw94tkgHdUZw0GuMJQY9IZsNAvl/umFCkv00tPZZYi83
         E6cw==
X-Received: by 10.70.32.66 with SMTP id g2mr78652566pdi.82.1438066604718;
        Mon, 27 Jul 2015 23:56:44 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id q7sm33147846pdj.31.2015.07.27.23.56.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 23:56:44 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274744>

Remove show_detached() and make detached HEAD to be rolled into
regular ref_list by adding REF_DETACHED_HEAD as a kind of branch and
supporting the same in append_ref().

Bump get_head_description() to the top.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 122 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 63 insertions(+), 59 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b058b74..f3d83d0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -30,6 +30,7 @@ static const char * const builtin_branch_usage[] = {
 
 #define REF_LOCAL_BRANCH    0x01
 #define REF_REMOTE_BRANCH   0x02
+#define REF_DETACHED_HEAD   0x04
 
 static const char *head;
 static unsigned char head_sha1[20];
@@ -352,8 +353,12 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
 			break;
 		}
 	}
-	if (ARRAY_SIZE(ref_kind) <= i)
-		return 0;
+	if (ARRAY_SIZE(ref_kind) <= i) {
+		if (!strcmp(refname, "HEAD"))
+			kind = REF_DETACHED_HEAD;
+		else
+			return 0;
+	}
 
 	/* Don't add types the caller doesn't want */
 	if ((kind & ref_list->kinds) == 0)
@@ -497,6 +502,37 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 	strbuf_release(&subject);
 }
 
+static char *get_head_description(void)
+{
+	struct strbuf desc = STRBUF_INIT;
+	struct wt_status_state state;
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(&state, 1);
+	if (state.rebase_in_progress ||
+	    state.rebase_interactive_in_progress)
+		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
+			    state.branch);
+	else if (state.bisect_in_progress)
+		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
+			    state.branch);
+	else if (state.detached_from) {
+		/* TRANSLATORS: make sure these match _("HEAD detached at ")
+		   and _("HEAD detached from ") in wt-status.c */
+		if (state.detached_at)
+			strbuf_addf(&desc, _("(HEAD detached at %s)"),
+				state.detached_from);
+		else
+			strbuf_addf(&desc, _("(HEAD detached from %s)"),
+				state.detached_from);
+	}
+	else
+		strbuf_addstr(&desc, _("(no branch)"));
+	free(state.branch);
+	free(state.onto);
+	free(state.detached_from);
+	return strbuf_detach(&desc, NULL);
+}
+
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 			   int abbrev, int current, const char *remote_prefix)
 {
@@ -504,6 +540,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	int color;
 	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
 	const char *prefix = "";
+	const char *desc = item->name;
 
 	if (item->ignore)
 		return;
@@ -516,6 +553,10 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		color = BRANCH_COLOR_REMOTE;
 		prefix = remote_prefix;
 		break;
+	case REF_DETACHED_HEAD:
+		color = BRANCH_COLOR_CURRENT;
+		desc = get_head_description();
+		break;
 	default:
 		color = BRANCH_COLOR_PLAIN;
 		break;
@@ -527,7 +568,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		color = BRANCH_COLOR_CURRENT;
 	}
 
-	strbuf_addf(&name, "%s%s", prefix, item->name);
+	strbuf_addf(&name, "%s%s", prefix, desc);
 	if (verbose) {
 		int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
 		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
@@ -569,56 +610,9 @@ static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
 	return max;
 }
 
-static char *get_head_description(void)
-{
-	struct strbuf desc = STRBUF_INIT;
-	struct wt_status_state state;
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, 1);
-	if (state.rebase_in_progress ||
-	    state.rebase_interactive_in_progress)
-		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
-			    state.branch);
-	else if (state.bisect_in_progress)
-		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
-			    state.branch);
-	else if (state.detached_from) {
-		/* TRANSLATORS: make sure these match _("HEAD detached at ")
-		   and _("HEAD detached from ") in wt-status.c */
-		if (state.detached_at)
-			strbuf_addf(&desc, _("(HEAD detached at %s)"),
-				state.detached_from);
-		else
-			strbuf_addf(&desc, _("(HEAD detached from %s)"),
-				state.detached_from);
-	}
-	else
-		strbuf_addstr(&desc, _("(no branch)"));
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
-	return strbuf_detach(&desc, NULL);
-}
-
-static void show_detached(struct ref_list *ref_list, int maxwidth)
-{
-	struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
-
-	if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {
-		struct ref_item item;
-		item.name = get_head_description();
-		item.kind = REF_LOCAL_BRANCH;
-		item.dest = NULL;
-		item.commit = head_commit;
-		item.ignore = 0;
-		print_ref_item(&item, maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
-		free(item.name);
-	}
-}
-
 static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
 {
-	int i;
+	int i, index;
 	struct append_ref_cb cb;
 	struct ref_list ref_list;
 	int maxwidth = 0;
@@ -643,6 +637,8 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	cb.pattern = pattern;
 	cb.ret = 0;
 	for_each_rawref(append_ref, &cb);
+	if (detached)
+		head_ref(append_ref, &cb);
 	/*
 	 * The following implementation is currently duplicated in ref-filter. It
 	 * will eventually be removed when we port branch.c to use ref-filter APIs.
@@ -678,15 +674,20 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	if (verbose)
 		maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
 
-	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
+	index = ref_list.index;
+
+	/* Print detached heads before sorting and printing the rest */
+	if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
+	    !strcmp(ref_list.list[index - 1].name, head)) {
+		print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
+			       1, remote_prefix);
+		index -= 1;
+	}
 
-	detached = (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached && match_patterns(pattern, "HEAD"))
-		show_detached(&ref_list, maxwidth);
+	qsort(ref_list.list, index, sizeof(struct ref_item), ref_cmp);
 
-	for (i = 0; i < ref_list.index; i++) {
-		int current = !detached &&
-			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
+	for (i = 0; i < index; i++) {
+		int current = !detached && (ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
 			!strcmp(ref_list.list[i].name, head);
 		print_ref_item(&ref_list.list[i], maxwidth, verbose,
 			       abbrev, current, remote_prefix);
@@ -913,7 +914,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("branch name required"));
 		return delete_branches(argc, argv, delete > 1, kinds, quiet);
 	} else if (list) {
-		int ret = print_ref_list(kinds, detached, verbose, abbrev,
+		int ret;
+		if (kinds & REF_LOCAL_BRANCH)
+			kinds |= REF_DETACHED_HEAD;
+		ret = print_ref_list(kinds, detached, verbose, abbrev,
 					 with_commit, argv);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
-- 
2.4.6
