From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 15/16] branch: use ref-filter printing APIs
Date: Tue, 15 Mar 2016 22:17:15 +0530
Message-ID: <1458060436-1215-16-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:48:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8k-0001AN-5h
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965357AbcCOQsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:48:08 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33789 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965214AbcCOQsA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:48:00 -0400
Received: by mail-pf0-f178.google.com with SMTP id 124so35904037pfg.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kEAtWF9ZTe3SA/+VGt5XNInUcidIg7/YjJUH64RY/sU=;
        b=Mn2iYyTbCPNOoseIOFt2q03PmiIz53wzSARbaC2HXN20KobfetXxvvNOfjVG67aYw1
         c/GEJW9nzo+Nn9l2XRHB2xhiVwDsu0n/hQOXsgUetFieA4mY52rH+UtHOXY8ZcTAMDK+
         ow8kkENBlxum14aVQCFU1XekSQ4B1BRiX6GDrjj7PIrcTsV/CHNQa1ezN6r2XCqxCBuf
         xyWXGBrM83XVJq9HtnD9JTrc5tl4r7omLjsiSX5YJIFsxoZVApaSPwWuP1m0VmLUMF8U
         kpYnckFAmmk6HQf5sjhNjnA5L4cRNJVzBvtHnkZ/MATT5VWWsqeCD5p9AHezeY5Iwy4W
         eouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kEAtWF9ZTe3SA/+VGt5XNInUcidIg7/YjJUH64RY/sU=;
        b=ms1nkNZhIt/FZAK6wrMpHVBlDzRRWhXJ6cEWjaW1e2twlT9Ym3IsbNnR2zaug57ZiW
         Dt7LDbcTIXOtySJnY96dKcapo/MGyJikk5elcefW0d3xPEARVvN1edo0YgOnJq6yCK7f
         DTy3elG/nWL9j2RpBKiVVQvnvmManLgf/To5wtD0P/+PR6Gs5s98U3wgv+CYmYrZ6MFh
         E/2kq/2aJWruL1khiJoL3b/YrUJicGKjD+YiSZR8exs+49/qpK9F8j9DjJNxov8xCv+k
         jUkUA7cKHBTehiOJT2+a49dPcbfbnccdbCwtFY9IowAqF0u0cnXDOADY4FYa3mBfoxlT
         Gqkg==
X-Gm-Message-State: AD7BkJL+FN/mKC9KJS3WHI0GCKZi45bTUXXEvtw4q5dXNdKoOOtngJ2mvT7yHD8kxozMUA==
X-Received: by 10.66.225.177 with SMTP id rl17mr47919928pac.46.1458060479136;
        Tue, 15 Mar 2016 09:47:59 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:58 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288877>

Port branch.c to use ref-filter APIs for printing. This clears out
most of the code used in branch.c for printing and replaces them with
calls made to the ref-filter library.

Introduce build_format() which gets the format required for printing
of refs. Make amendments to print_ref_list() to reflect these changes.

Change calc_maxwidth() to also account for the length of HEAD ref, by
calling ref-filter:get_head_discription().

Also change the test in t6040 to reflect the changes.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c         | 226 ++++++++++++++---------------------------------
 t/t6040-tracking-info.sh |   2 +-
 2 files changed, 66 insertions(+), 162 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 8747d82..29cd206 100644
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
@@ -271,157 +271,6 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
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
-		find_unique_abbrev(item->commit->object.oid.hash, filter->abbrev),
-		stat.buf, sub);
-	strbuf_release(&stat);
-	strbuf_release(&subject);
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
@@ -432,7 +281,10 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 
 		skip_prefix(it->refname, "refs/heads/", &desc);
 		skip_prefix(it->refname, "refs/remotes/", &desc);
-		w = utf8_strwidth(desc);
+		if (it->kind == FILTER_REFS_DETACHED_HEAD)
+			w = strlen(get_head_description());
+		else
+			w = utf8_strwidth(desc);
 
 		if (it->kind == FILTER_REFS_REMOTES)
 			w += remote_bonus;
@@ -442,12 +294,51 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 	return max;
 }
 
+static char *build_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)
+{
+	struct strbuf fmt = STRBUF_INIT;
+	struct strbuf local = STRBUF_INIT;
+	struct strbuf remote = STRBUF_INIT;
+
+	strbuf_addf(&fmt, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)", branch_get_color(BRANCH_COLOR_CURRENT));
+
+	if (filter->verbose) {
+		strbuf_addf(&local, "%%(align:%d,left)%%(refname:strip=2)%%(end)", maxwidth);
+		strbuf_addf(&local, "%s", branch_get_color(BRANCH_COLOR_RESET));
+		strbuf_addf(&local, " %%(objectname:short=7) ");
+
+		if (filter->verbose > 1)
+			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
+				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
+				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
+		else
+			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
+
+		strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:strip=2)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
+			    "%%(else) %%(objectname:short=7) %%(contents:subject)%%(end)",
+			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
+			    remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
+	} else {
+		strbuf_addf(&local, "%%(refname:strip=2)%s", branch_get_color(BRANCH_COLOR_RESET));
+		strbuf_addf(&remote, "%s%s%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
+			    branch_get_color(BRANCH_COLOR_REMOTE), remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
+	}
+
+	strbuf_addf(&fmt, "%%(if:notequals=remotes)%%(refname:base)%%(then)%s%%(else)%s%%(end)", local.buf, remote.buf);
+
+	strbuf_release(&local);
+	strbuf_release(&remote);
+	return strbuf_detach(&fmt, NULL);
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
@@ -459,12 +350,14 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 
 	memset(&array, 0, sizeof(array));
 
-	verify_ref_format("%(refname)%(symref)");
 	filter_refs(&array, filter, filter->kind | FILTER_REFS_INCLUDE_BROKEN);
 
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
+	format = build_format(filter, maxwidth, remote_prefix);
+	verify_ref_format(format);
+
 	/*
 	 * If no sorting parameter is given then we default to sorting
 	 * by 'refname'. This would give us an alphabetically sorted
@@ -476,10 +369,21 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 		sorting = ref_default_sorting();
 	ref_array_sort(sorting, &array);
 
-	for (i = 0; i < array.nr; i++)
-		format_and_print_ref_item(array.items[i], maxwidth, filter, remote_prefix);
+	for (i = 0; i < array.nr; i++) {
+		format_ref_array_item(array.items[i], format, 0, &out);
+		if (column_active(colopts)) {
+			assert(!filter->verbose && "--column and --verbose are incompatible");
+			 /* format to a string_list to let print_columns() do its job */
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
index 3d5c238..97a0765 100755
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
 
-- 
2.7.3
