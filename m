From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [WIP PATCH] Manual rename correction
Date: Tue, 31 Jul 2012 21:15:36 +0700
Message-ID: <20120731141536.GA26283@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 16:16:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwDFY-0005Ql-5v
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 16:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095Ab2GaOQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 10:16:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35158 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab2GaOQd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 10:16:33 -0400
Received: by pbbrp8 with SMTP id rp8so11733143pbb.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=OdThA1fQf2jVgkrrr352qWst5EkKJ9MCRtHUQPVBbvs=;
        b=O9dlhqD+DxB3amVqGf45ctcYzVcNgLuPmfEShEmYdydyjZPIGbJ2EG6y9FKHr264W8
         8qQ31m3Cm2hC73EBlMuF1igtHFXoZcgdEjIOE7jwe1uDSV0dN0MkFBU5SEuk6nEHfll0
         L7qkeSJkGp0R5lmcByJniTWGjyIWnGZO353AglmgxeTbUjvs9n6hXIrAvDZPPNIJh06w
         t+4yerR0E0v1Px0g2liMw8jgC4fHOWUd9tJZbk9ZluHWjDThM477VgDYa8ttSLHweAt4
         NUkmu/4dZMsW4/lWISczo1BeFovi+alqRD85gYflv/a813bjw/KpJ5Uy1rA+YS2C3X0t
         x/3w==
Received: by 10.68.219.162 with SMTP id pp2mr43844573pbc.85.1343744192821;
        Tue, 31 Jul 2012 07:16:32 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.62.80])
        by mx.google.com with ESMTPS id ov8sm375057pbb.2.2012.07.31.07.16.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2012 07:16:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 31 Jul 2012 21:15:36 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202654>

Git's rename detection is good but still not perfect. There have been
a few times I wanted to correct git for better output but I
couldn't. This PoC WIP patch attempts to address that. It allows to
break/rearrange any file pairs. We can do something crazy like this:

 attr.c => dir.c      | 1786 ++++++++++++++++++++++++++++++++-----------------
 dir.c => attr.c      | 1788 +++++++++++++++++---------------------------------
 t/t1306-xdg-files.sh |   39 ++
 t/test-lib.sh        |    1 +
 4 files changed, 1828 insertions(+), 1786 deletions(-)

The above output is done with "git diff --manual-rename=foo A B"
and "foo" contains (probably not in the best format though)

-- 8< --
attr.c dir.c
dir.c attr.c
-- 8< --

The plan is to use git-notes to record rename corrections like above
so that "git log --patch" for example can make use of them. I'm not
sure what to do with merge commits yet (can we track renames in a
merge?). We can generate rename file from "diff -CM", then users can
edit and save it.

If you want to diff between two arbitrary trees, you'll have to feed
rename corrections via command line as git-notes are for commit diff
only.

In some cases, manual rename may be cheaper than --find-copies-harder,
so this feature could help reduce cpu usage. Though that's not my main
aim.

Oh and I think rename detection in diff other than tree-tree does not
work. Maybe I tested it the wrong way?

Comments?

-- 8< --
diff --git a/diff.c b/diff.c
index 62cbe14..c8d55d2 100644
--- a/diff.c
+++ b/diff.c
@@ -3547,6 +3547,12 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, RENAME_EMPTY);
 	else if (!strcmp(arg, "--no-rename-empty"))
 		DIFF_OPT_CLR(options, RENAME_EMPTY);
+	else if (!prefixcmp(arg, "--manual-rename=")) {
+		int ret = strbuf_read_file(&options->renames, arg + 16, 0);
+		if (ret == -1)
+			die("unable to read %s", arg + 16);
+		DIFF_OPT_SET(options, MANUAL_RENAME);
+	}
 	else if (!strcmp(arg, "--relative"))
 		DIFF_OPT_SET(options, RELATIVE_NAME);
 	else if (!prefixcmp(arg, "--relative=")) {
@@ -4621,6 +4627,8 @@ void diffcore_std(struct diff_options *options)
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
 	if (!options->found_follow) {
+		if (DIFF_OPT_TST(options, MANUAL_RENAME))
+			diffcore_manual_rename(options);
 		/* See try_to_follow_renames() in tree-diff.c */
 		if (options->break_opt != -1)
 			diffcore_break(options->break_opt);
diff --git a/diff.h b/diff.h
index e027650..60d104e 100644
--- a/diff.h
+++ b/diff.h
@@ -61,6 +61,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
 #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
 #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
+#define DIFF_OPT_MANUAL_RENAME       (1 <<  9)
 /* (1 <<  9) unused */
 #define DIFF_OPT_HAS_CHANGES         (1 << 10)
 #define DIFF_OPT_QUICK               (1 << 11)
@@ -147,6 +148,7 @@ struct diff_options {
 	int close_file;
 
 	struct pathspec pathspec;
+	struct strbuf renames;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
 	diff_format_fn_t format_callback;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 216a7a4..05da99f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -722,3 +722,148 @@ void diffcore_rename(struct diff_options *options)
 	rename_src_nr = rename_src_alloc = 0;
 	return;
 }
+
+struct rename {
+	char *one, *two;
+	struct rename *next_one, *next_two;
+	struct diff_filespec *spec_one;
+	struct diff_filespec *spec_two;
+};
+
+static unsigned int string_hash(const char *s)
+{
+	unsigned int v = 1;
+	while (s && *s)
+		v += (unsigned char)*s++;
+	return v;
+}
+
+void diffcore_manual_rename(struct diff_options *options)
+{
+	struct rename *renames = NULL;
+	int i, nr = 0, alloc = 0;
+	const char *next, *p, *end;
+	struct hash_table hash_one, hash_two;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+
+	/* parse rename instructions */
+	end = options->renames.buf + options->renames.len;
+	for (p = options->renames.buf; p < end; p = next) {
+		struct rename *r;
+		const char *sep, *nl, *next_sep;
+
+		nl = strchr(p, '\n');
+		if (!nl)
+			nl = next = end;
+		else {
+			next = nl + 1;
+			if (p == nl)
+				continue;
+		}
+
+		/* one space to separate two paths (for now, quoting can come later) */
+		sep = strchr(p, ' ');
+		if (!sep || sep >= nl)
+			die("invalid syntax");
+		next_sep = strchr(sep + 1, ' ');
+		if (next_sep && next_sep < nl)
+			die("invalid syntax");
+
+		ALLOC_GROW(renames, nr + 1, alloc);
+		r = renames + nr++;
+		memset(r, 0, sizeof(*r));
+		if (p < sep)
+			r->one = xstrndup(p, sep - p);
+		if (sep < nl)
+			r->two = xstrndup(sep + 1, nl - (sep + 1));
+	}
+
+
+	/* initialize hash tables */
+	init_hash(&hash_one);
+	init_hash(&hash_two);
+	for (i = 0; i < nr; i++) {
+		struct rename *r = renames + i;
+		void** p;
+		p = insert_hash(string_hash(r->one), r, &hash_one);
+		if (p)  {
+			r->next_one = *p;
+			*p = r;
+		}
+		p = insert_hash(string_hash(r->two), r, &hash_two);
+		if (p) {
+			r->next_two = *p;
+			*p = r;
+		}
+	}
+
+	/* rename */
+	DIFF_QUEUE_CLEAR(&outq);
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		struct rename *r1 = NULL, *r2 = NULL;
+		int hash, skip = 0;
+		if (DIFF_PAIR_UNMERGED(p))
+			continue;
+		if (DIFF_FILE_VALID(p->one)) {
+			hash = string_hash(p->one->path);
+			r1 = lookup_hash(hash, &hash_one);
+			while (r1) {
+				if (!strcmp(p->one->path, r1->one)) {
+					r1->spec_one = p->one;
+					skip = 1;
+				}
+				r1 = r1->next_one;
+			}
+		}
+		if (DIFF_FILE_VALID(p->two)) {
+			hash = string_hash(p->two->path);
+			r2 = lookup_hash(hash, &hash_two);
+			while (r2) {
+				if (!strcmp(p->two->path, r2->two)) {
+					r2->spec_two = p->two;
+					skip = 1;
+				}
+				r2 = r2->next_two;
+			}
+		}
+
+		/* This pair has nothing to do with manual renames,
+		   reinsert it */
+		if (!skip)
+			diff_q(&outq, p);
+	}
+	free(q->queue);
+
+	for (i = 0; i < nr; i++) {
+		struct rename *r = renames + i;
+		struct diff_filepair *dp;
+		if (r->spec_one && r->spec_two) {
+			dp = diff_queue(&outq, r->spec_one, r->spec_two);
+			dp->renamed_pair = 1;
+			dp->score = MAX_SCORE;
+		} else if (r->spec_one && !r->two) {
+			dp = diff_queue(&outq, r->spec_one,
+					alloc_filespec(r->one));
+		} else if (!r->one && r->spec_two) {
+			dp = diff_queue(&outq, alloc_filespec(r->two),
+					r->spec_two);
+		} else {
+			die("incorrect rename %s %s", r->one, r->two);
+		}
+	}
+	*q = outq;
+	/* required? */
+	diffcore_fix_diff_index(options);
+
+	/* cleanup */
+	for (i = 0; i < nr; i++) {
+		struct rename *r = renames + i;
+		free(r->one);
+		free(r->two);
+	}
+	free(renames);
+	free_hash(&hash_one);
+	free_hash(&hash_two);
+}
diff --git a/diffcore.h b/diffcore.h
index be0739c..193bc67 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -107,6 +107,7 @@ extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
 extern void diffcore_break(int);
 extern void diffcore_rename(struct diff_options *);
+extern void diffcore_manual_rename(struct diff_options *);
 extern void diffcore_merge_broken(void);
 extern void diffcore_pickaxe(struct diff_options *);
 extern void diffcore_order(const char *orderfile);
-- 8< --
-- 
Duy
