From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 8/9] branch: use ref-filter printing APIs
Date: Fri,  2 Oct 2015 23:09:05 +0530
Message-ID: <1443807546-5985-9-git-send-email-Karthik.188@gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 19:39:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi4J9-0004CR-Sn
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 19:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbbJBRjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 13:39:40 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34059 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbbJBRjh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 13:39:37 -0400
Received: by padhy16 with SMTP id hy16so112082684pad.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PK8glGYq40YkJKNf/dpXLzfIZPtWqMVbI4VUps66XK8=;
        b=ZRVRqkGq/jljWUsrOkm0HNEOkPEqLyYfz8HkYm58qK30vRhaP2Ge2nQ2hWFLF88IoB
         72AQpV8WGAsJlPqbcDumV/yWQTSWpXlhgLTUrDVvIC/uVtZWWaDdDhkXlXXsjj725km5
         gUy1vdclnykwsSePkB1lEtQlpTeYfqlBL1A3Xsd7H8i2x/J02hVZhiVIw5ANcQ9cxOfW
         A0zyiin+M6UI4xEGVM61TbBD2QOZ0xjIuf7O2CFmDbUjJSvVi5HodhLaKXKOt5PUtKyG
         WSr4wfp3gx2txIXZLII+QBLMYHYmypE09Q7uhblEhSkBs8d4J/VWjAugOhZ3wSNxMQNt
         yCLg==
X-Received: by 10.66.66.196 with SMTP id h4mr6751972pat.38.1443807576467;
        Fri, 02 Oct 2015 10:39:36 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pq1sm12993384pbb.91.2015.10.02.10.39.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 10:39:36 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278933>

Port branch.c to use ref-filter APIs for printing. This clears out
most of the code used in branch.c for printing and replaces them with
calls made to the ref-filter library.

Introduce get_format() which gets the format required for printing of
refs. Make amendments to print_ref_list() to reflect these changes.

Since branch.c is being ported to use ref-filter APIs to print the
required data, it is constricted to the constraints of printing as per
ref-filter. Which means branch.c can only print as per the atoms
available in ref-filter. Hence the "-vv" option of 'git branch' now
prints the upstream and its tracking details separately as
"[<upstream>] [<tracking info>]" instead of "[<upstream>: <tracking
info>]".

Make changes in /t/t6040-tracking-info.sh to reflect the change.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c         | 258 ++++++++++++-----------------------------------
 t/t6040-tracking-info.sh |  12 +--
 2 files changed, 69 insertions(+), 201 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 67ef9f1..48fbca1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -35,12 +35,12 @@ static unsigned char head_sha1[20];
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
-	GIT_COLOR_RESET,
-	GIT_COLOR_NORMAL,	/* PLAIN */
-	GIT_COLOR_RED,		/* REMOTE */
-	GIT_COLOR_NORMAL,	/* LOCAL */
-	GIT_COLOR_GREEN,	/* CURRENT */
-	GIT_COLOR_BLUE,		/* UPSTREAM */
+	"%(color:reset)",
+	"%(color:reset)",	/* PLAIN */
+	"%(color:red)",		/* REMOTE */
+	"%(color:reset)",	/* LOCAL */
+	"%(color:green)",	/* CURRENT */
+	"%(color:blue)",	/* UPSTREAM */
 };
 enum color_branch {
 	BRANCH_COLOR_RESET = 0,
@@ -271,192 +271,6 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	return(ret);
 }
 
-static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
-		int show_upstream_ref)
-{
-	int ours, theirs;
-	char *ref = NULL;
-	struct branch *branch = branch_get(branch_name);
-	const char *upstream;
-	struct strbuf fancy = STRBUF_INIT;
-	int upstream_is_gone = 0;
-	int added_decoration = 1;
-
-	if (stat_tracking_info(branch, &ours, &theirs, &upstream) < 0) {
-		if (!upstream)
-			return;
-		upstream_is_gone = 1;
-	}
-
-	if (show_upstream_ref) {
-		ref = shorten_unambiguous_ref(upstream, 0);
-		if (want_color(branch_use_color))
-			strbuf_addf(&fancy, "%s%s%s",
-					branch_get_color(BRANCH_COLOR_UPSTREAM),
-					ref, branch_get_color(BRANCH_COLOR_RESET));
-		else
-			strbuf_addstr(&fancy, ref);
-	}
-
-	if (upstream_is_gone) {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s: gone]"), fancy.buf);
-		else
-			added_decoration = 0;
-	} else if (!ours && !theirs) {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s]"), fancy.buf);
-		else
-			added_decoration = 0;
-	} else if (!ours) {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);
-		else
-			strbuf_addf(stat, _("[behind %d]"), theirs);
-
-	} else if (!theirs) {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s: ahead %d]"), fancy.buf, ours);
-		else
-			strbuf_addf(stat, _("[ahead %d]"), ours);
-	} else {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
-				    fancy.buf, ours, theirs);
-		else
-			strbuf_addf(stat, _("[ahead %d, behind %d]"),
-				    ours, theirs);
-	}
-	strbuf_release(&fancy);
-	if (added_decoration)
-		strbuf_addch(stat, ' ');
-	free(ref);
-}
-
-static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
-			     struct ref_filter *filter, const char *refname)
-{
-	struct strbuf subject = STRBUF_INIT, stat = STRBUF_INIT;
-	const char *sub = _(" **** invalid ref ****");
-	struct commit *commit = item->commit;
-
-	if (!parse_commit(commit)) {
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, &subject);
-		sub = subject.buf;
-	}
-
-	if (item->kind == FILTER_REFS_BRANCHES)
-		fill_tracking_info(&stat, refname, filter->verbose > 1);
-
-	strbuf_addf(out, " %s %s%s",
-		find_unique_abbrev(item->commit->object.sha1, filter->abbrev),
-		stat.buf, sub);
-	strbuf_release(&stat);
-	strbuf_release(&subject);
-}
-
-/*
- * This is duplicated in ref-filter.c, will be removed when we adopt
- * ref-filter's printing APIs.
- */
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
-static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
-				      struct ref_filter *filter, const char *remote_prefix)
-{
-	char c;
-	int current = 0;
-	int color;
-	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
-	const char *prefix = "";
-	const char *desc = item->refname;
-	char *to_free = NULL;
-
-	switch (item->kind) {
-	case FILTER_REFS_BRANCHES:
-		skip_prefix(desc, "refs/heads/", &desc);
-		if (!filter->detached && !strcmp(desc, head))
-			current = 1;
-		else
-			color = BRANCH_COLOR_LOCAL;
-		break;
-	case FILTER_REFS_REMOTES:
-		skip_prefix(desc, "refs/remotes/", &desc);
-		color = BRANCH_COLOR_REMOTE;
-		prefix = remote_prefix;
-		break;
-	case FILTER_REFS_DETACHED_HEAD:
-		desc = to_free = get_head_description();
-		current = 1;
-		break;
-	default:
-		color = BRANCH_COLOR_PLAIN;
-		break;
-	}
-
-	c = ' ';
-	if (current) {
-		c = '*';
-		color = BRANCH_COLOR_CURRENT;
-	}
-
-	strbuf_addf(&name, "%s%s", prefix, desc);
-	if (filter->verbose) {
-		int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
-		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
-			    maxwidth + utf8_compensation, name.buf,
-			    branch_get_color(BRANCH_COLOR_RESET));
-	} else
-		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
-			    name.buf, branch_get_color(BRANCH_COLOR_RESET));
-
-	if (item->symref) {
-		skip_prefix(item->symref, "refs/remotes/", &desc);
-		strbuf_addf(&out, " -> %s", desc);
-	}
-	else if (filter->verbose)
-		/* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
-		add_verbose_info(&out, item, filter, desc);
-	if (column_active(colopts)) {
-		assert(!filter->verbose && "--column and --verbose are incompatible");
-		string_list_append(&output, out.buf);
-	} else {
-		printf("%s\n", out.buf);
-	}
-	strbuf_release(&name);
-	strbuf_release(&out);
-	free(to_free);
-}
-
 static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 {
 	int i, max = 0;
@@ -477,12 +291,54 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 	return max;
 }
 
+static char *get_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)
+{
+	char *remote = NULL;
+	char *local = NULL;
+	char *final = NULL;
+
+	if (filter->verbose) {
+		if (filter->verbose > 1)
+			local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(align:%d,left)%%(refname:short)%%(end)%s"
+					" %%(objectname:short,7) %%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s] %%(end)"
+					"%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)",
+					branch_get_color(BRANCH_COLOR_CURRENT), maxwidth, branch_get_color(BRANCH_COLOR_RESET),
+					branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
+
+		else
+			local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(align:%d,left)%"
+					"%(refname:short)%%(end)%s %%(objectname:short,7) %%(if)%%(upstream:track)%"
+					"%(then)%%(upstream:track) %%(end)%%(contents:subject)",
+					branch_get_color(BRANCH_COLOR_CURRENT), maxwidth, branch_get_color(BRANCH_COLOR_RESET));
+
+		remote = xstrfmt("  %s%%(align:%d,left)%s%%(refname:short)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
+				 "%%(else) %%(objectname:short,7) %%(contents:subject)%%(end)",
+				 branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
+				 remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
+		final = xstrfmt("%%(if:notequals=remotes)%%(path:short)%%(then)%s%%(else)%s%%(end)", local, remote);
+
+	} else {
+		local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(refname:short)%s",
+				branch_get_color(BRANCH_COLOR_CURRENT), branch_get_color(BRANCH_COLOR_RESET));
+		remote = xstrfmt("  %s%s%%(refname:short)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
+				 branch_get_color(BRANCH_COLOR_REMOTE), remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
+		final = xstrfmt("%%(if:notequals=remotes)%%(path:short)%%(then)%s%%(else)%s%%(end)", local, remote);
+	}
+
+	free(local);
+	free(remote);
+
+	return final;
+}
+
 static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting)
 {
 	int i;
 	struct ref_array array;
 	int maxwidth = 0;
 	const char *remote_prefix = "";
+	struct strbuf out = STRBUF_INIT;
+	char *format;
 
 	/*
 	 * If we are listing more than just remote branches,
@@ -494,12 +350,14 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 
 	memset(&array, 0, sizeof(array));
 
-	verify_ref_format("%(refname)%(symref)");
 	filter_refs(&array, filter, filter->kind | FILTER_REFS_INCLUDE_BROKEN);
 
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
+	format = get_format(filter, maxwidth, remote_prefix);
+	verify_ref_format(format);
+
 	/*
 	 * If no sorting parameter is given then we default to sorting
 	 * by 'refname'. This would give us an alphabetically sorted
@@ -511,10 +369,20 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 		sorting = ref_default_sorting();
 	ref_array_sort(sorting, &array);
 
-	for (i = 0; i < array.nr; i++)
-		format_and_print_ref_item(array.items[i], maxwidth, filter, remote_prefix);
+	for (i = 0; i < array.nr; i++) {
+		format_ref_array_item(array.items[i], format, 0, &out);
+		if (column_active(colopts)) {
+			assert(!filter->verbose && "--column and --verbose are incompatible");
+			string_list_append(&output, out.buf);
+		} else {
+			fwrite(out.buf, 1, out.len, stdout);
+			putchar('\n');
+		}
+		strbuf_release(&out);
+	}
 
 	ref_array_clear(&array);
+	free(format);
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 3d5c238..d110f26 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -44,7 +44,7 @@ b1 [ahead 1, behind 1] d
 b2 [ahead 1, behind 1] d
 b3 [behind 1] b
 b4 [ahead 2] f
-b5 g
+b5 [gone] g
 b6 c
 EOF
 
@@ -58,11 +58,11 @@ test_expect_success 'branch -v' '
 '
 
 cat >expect <<\EOF
-b1 [origin/master: ahead 1, behind 1] d
-b2 [origin/master: ahead 1, behind 1] d
-b3 [origin/master: behind 1] b
-b4 [origin/master: ahead 2] f
-b5 [brokenbase: gone] g
+b1 [origin/master] [ahead 1, behind 1] d
+b2 [origin/master] [ahead 1, behind 1] d
+b3 [origin/master] [behind 1] b
+b4 [origin/master] [ahead 2] f
+b5 [brokenbase] [gone] g
 b6 [origin/master] c
 EOF
 
-- 
2.6.0
