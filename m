From: Thomas Rast <tr@thomasrast.ch>
Subject: [POC PATCH 5/9] log: add a merge base inspection option
Date: Tue,  4 Feb 2014 23:17:34 +0100
Message-ID: <b21890769d387293182b74f0b06e3e19ab9cfada.1391549294.git.tr@thomasrast.ch>
References: <cover.1391549294.git.tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 23:18:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoK0-0001w8-D2
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935306AbaBDWSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:18:09 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:54786 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935750AbaBDWR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:17:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 6B6034D65D0
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 23:17:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RkScB1El--xr for <git@vger.kernel.org>;
	Tue,  4 Feb 2014 23:17:50 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 0BDEA4D65E8
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 23:17:41 +0100 (CET)
X-Mailer: git-send-email 1.9.rc2.232.gdd31389
In-Reply-To: <cover.1391549294.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241568>

With the new --bases, print merge commits' parents' merge bases.  This
is mostly a proof of viability, in particular wrt. revision walk
decoupling and speed.

We can do "inline" get_merge_bases() (via get_octopus_merge_bases)
because the walks in get_merge_bases() only use flag bits 16-19, and
we reset them after use.  The get_revision()/log display walk OTOH
uses only flag bits 0-15 (actually only 0-10 as of this commit).

Speed-wise it turns out to be better than attempting to compute merge
bases in one go, mostly because the latter approach would require
extensive data structures to track flags.  This commit does not have
to: the commit graph will be loaded anyway, and the room for flags is
already there.  As a big plus, this approach also works in a streaming
fashion, showing the first few commits very quickly.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---

As indicated in the cover letter, this is cute, but I'm not married to
it.  It's probably just a useless instance of feature creep.

 Documentation/rev-list-options.txt |  7 +++++++
 log-tree.c                         |  3 +++
 pretty.c                           |  3 +++
 revision.c                         |  2 ++
 revision.h                         |  2 ++
 t/t4202-log.sh                     | 31 +++++++++++++++++++++++++++++++
 6 files changed, 48 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 03533af..d023290 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -705,6 +705,13 @@ endif::git-rev-list[]
 	Print also the children of the commit (in the form "commit child...").
 	Also enables parent rewriting, see 'History Simplification' below.
 
+ifndef::git-rev-list[]
+--bases::
+	For merge commits, print the merge bases of the commit's
+	parents.  (These are the bases that were used in the creation
+	of the merge itself.)
+endif::git-rev-list[]
+
 ifdef::git-rev-list[]
 --timestamp::
 	Print the raw commit timestamp.
diff --git a/log-tree.c b/log-tree.c
index 08970bf..080f412 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -622,6 +622,8 @@ void show_log(struct rev_info *opt)
 	ctx.output_encoding = get_log_output_encoding();
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident = &opt->from_ident;
+	if (opt->show_merge_bases && commit->parents && commit->parents->next)
+		ctx.merge_bases = get_octopus_merge_bases(commit->parents);
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
@@ -662,6 +664,7 @@ void show_log(struct rev_info *opt)
 
 	strbuf_release(&msgbuf);
 	free(ctx.notes_message);
+	free(ctx.merge_bases);
 }
 
 int log_tree_diff_flush(struct rev_info *opt)
diff --git a/pretty.c b/pretty.c
index 5e44cf8..8b28664 100644
--- a/pretty.c
+++ b/pretty.c
@@ -552,6 +552,9 @@ static void add_merge_info(const struct pretty_print_context *pp,
 		return;
 
 	pp_commit_list(pp, sb, "Merge:", parent);
+
+	if (pp->merge_bases)
+		pp_commit_list(pp, sb, "Bases:", pp->merge_bases);
 }
 
 static char *get_header(const struct commit *commit, const char *msg,
diff --git a/revision.c b/revision.c
index a0df72f..72255fb 100644
--- a/revision.c
+++ b/revision.c
@@ -1729,6 +1729,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--parents")) {
 		revs->rewrite_parents = 1;
 		revs->print_parents = 1;
+	} else if (!strcmp(arg, "--merge-bases")) {
+		revs->show_merge_bases = 1;
 	} else if (!strcmp(arg, "--dense")) {
 		revs->dense = 1;
 	} else if (!strcmp(arg, "--sparse")) {
diff --git a/revision.h b/revision.h
index 88967d6..3111228 100644
--- a/revision.h
+++ b/revision.h
@@ -19,6 +19,7 @@
 #define PATCHSAME	(1u<<9)
 #define BOTTOM		(1u<<10)
 #define ALL_REV_FLAGS	((1u<<11)-1)
+/* merge-base.c uses bits 16-19.  --merge-bases will break if they overlap! */
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
@@ -137,6 +138,7 @@ struct rev_info {
 			preserve_subject:1;
 	unsigned int	disable_stdin:1;
 	unsigned int	leak_pending:1;
+	unsigned int	show_merge_bases:1;
 
 	enum date_mode date_mode;
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index cb03d28..64f34a6 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -841,4 +841,35 @@ test_expect_success 'dotdot is a parent directory' '
 	test_cmp expect actual
 '
 
+shorten () {
+	for arg; do
+		git rev-parse --short "$arg"
+	done
+}
+
+fill_in_merge_bases () {
+	while IFS= read line; do
+		case "$line" in
+		Merge:*)
+			printf "%s\n" "$line"
+			printf "%s" "Bases:"
+			printf " %s" $(shorten \
+			    $(git merge-base --all --octopus \
+				${line##Merge:}))
+			printf "\n"
+			;;
+		*)
+			printf "%s\n" "$line"
+			;;
+		esac
+	done
+}
+
+test_expect_success '--merge-bases' '
+	git log |
+	fill_in_merge_bases >expect
+	git log --merge-bases >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.9.rc2.232.gdd31389
