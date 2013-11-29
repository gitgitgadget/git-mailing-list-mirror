From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/WIP PATCH v2] disable complete ignorance of submodules for
 index <-> HEAD diff
Date: Sat, 30 Nov 2013 00:11:26 +0100
Message-ID: <20131129231125.GC31636@sandbox-ub>
References: <20131128071001.GA1057@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 00:11:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmXDl-0000Jt-6T
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 00:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab3K2XLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 18:11:32 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:51584 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab3K2XLb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 18:11:31 -0500
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VmXDb-0007hb-Ly; Sat, 30 Nov 2013 00:11:28 +0100
Content-Disposition: inline
In-Reply-To: <20131128071001.GA1057@book.hvoigt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238542>

If the value of ignore for submodules is set to "all" we would not show
whats actually committed during status or diff. This can result in the
user committing unexpected submodule references. Lets be nicer and always
show whats in the index.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
On Thu, Nov 28, 2013 at 08:10:01AM +0100, Heiko Voigt wrote:
> On Mon, Nov 25, 2013 at 03:01:34PM +0600, Sergey Sharybin wrote:
> > Tested the patch. `git status` now shows the changes to the
> > submodules, which is nice :)
> > 
> > However, is it possible to make it so `git commit` lists submodules in
> > "changes to be committed" section, so you'll see what's gonna to be in
> > the commit while typing the commit message as well?
> 
> Yes, of course that should be shown. Will add in the next iteration.
> Which will hopefully be a much simpler implementation. Possibly getting
> rid of this new flag.

Here is an updated version of this patch. The code is a little bit more
simplified and I changed the existing tests to account for the new
behavior we are discussing. If everyone agrees that this a desired
change in behavior I would continue adding more tests so commit, status
and so on are more explicitly tested.

Cheers Heiko

P.S.: This is still work in progress, the complete series should contain
both my patches from this thread.

 builtin/diff.c            |  2 ++
 diff-lib.c                |  3 +++
 diff.h                    |  2 +-
 submodule.c               | 16 ++++++++++++++--
 submodule.h               |  1 +
 t/t4027-diff-submodule.sh | 12 +++++++++---
 t/t7508-status.sh         |  6 +++++-
 7 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index adb93a9..c47614d 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -162,6 +162,8 @@ static int builtin_diff_tree(struct rev_info *revs,
 	if (argc > 1)
 		usage(builtin_diff_usage);
 
+	enforce_no_complete_ignore_submodule(&revs->diffopt);
+
 	/*
 	 * We saw two trees, ent0 and ent1.  If ent1 is uninteresting,
 	 * swap them.
diff --git a/diff-lib.c b/diff-lib.c
index 346cac6..c5219cb 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -483,6 +483,9 @@ int run_diff_index(struct rev_info *revs, int cached)
 {
 	struct object_array_entry *ent;
 
+	if (cached)
+		enforce_no_complete_ignore_submodule(&revs->diffopt);
+
 	ent = revs->pending.objects;
 	if (diff_cache(revs, ent->item->sha1, ent->name, cached))
 		exit(128);
diff --git a/diff.h b/diff.h
index e342325..81561b3 100644
--- a/diff.h
+++ b/diff.h
@@ -64,7 +64,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
 #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
 #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
-/* (1 <<  9) unused */
+#define DIFF_OPT_NO_IGNORE_SUBMODULE (1 <<  9)
 #define DIFF_OPT_HAS_CHANGES         (1 << 10)
 #define DIFF_OPT_QUICK               (1 << 11)
 #define DIFF_OPT_NO_INDEX            (1 << 12)
diff --git a/submodule.c b/submodule.c
index 1905d75..e0719b6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -294,6 +294,16 @@ int parse_submodule_config_option(const char *var, const char *value)
 	return 0;
 }
 
+void enforce_no_complete_ignore_submodule(struct diff_options *diffopt)
+{
+	DIFF_OPT_SET(diffopt, NO_IGNORE_SUBMODULE);
+	if (DIFF_OPT_TST(diffopt, OVERRIDE_SUBMODULE_CONFIG) &&
+	    DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES)) {
+		DIFF_OPT_CLR(diffopt, IGNORE_SUBMODULES);
+		DIFF_OPT_SET(diffopt, IGNORE_DIRTY_SUBMODULES);
+	}
+}
+
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
@@ -301,9 +311,11 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 	DIFF_OPT_CLR(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	DIFF_OPT_CLR(diffopt, IGNORE_DIRTY_SUBMODULES);
 
-	if (!strcmp(arg, "all"))
+	if (!strcmp(arg, "all")) {
+		if (DIFF_OPT_TST(diffopt, NO_IGNORE_SUBMODULE))
+			return;
 		DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
-	else if (!strcmp(arg, "untracked"))
+	} else if (!strcmp(arg, "untracked"))
 		DIFF_OPT_SET(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	else if (!strcmp(arg, "dirty"))
 		DIFF_OPT_SET(diffopt, IGNORE_DIRTY_SUBMODULES);
diff --git a/submodule.h b/submodule.h
index 7beec48..2c8087e 100644
--- a/submodule.h
+++ b/submodule.h
@@ -20,6 +20,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
 int parse_submodule_config_option(const char *var, const char *value);
+void enforce_no_complete_ignore_submodule(struct diff_options *diffopt);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 void show_submodule_summary(FILE *f, const char *path,
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 518bf95..bd84ea7 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -258,7 +258,9 @@ test_expect_success 'git diff between submodule commits' '
 	expect_from_to >expect.body $subtip $subprev &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules HEAD^..HEAD >actual &&
-	! test -s actual
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body
 '
 
 test_expect_success 'git diff between submodule commits [.git/config]' '
@@ -274,7 +276,9 @@ test_expect_success 'git diff between submodule commits [.git/config]' '
 	test_cmp expect.body actual.body &&
 	git config submodule.subname.ignore all &&
 	git diff HEAD^..HEAD >actual &&
-	! test -s actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules=dirty HEAD^..HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subtip $subprev &&
@@ -294,7 +298,9 @@ test_expect_success 'git diff between submodule commits [.gitmodules]' '
 	test_cmp expect.body actual.body &&
 	git config -f .gitmodules submodule.subname.ignore all &&
 	git diff HEAD^..HEAD >actual &&
-	! test -s actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body &&
 	git config submodule.subname.ignore dirty &&
 	git config submodule.subname.path sub &&
 	git diff  HEAD^..HEAD >actual &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c987b5e..977295f 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1357,6 +1357,11 @@ test_expect_success "status (core.commentchar with two chars with submodule summ
 test_expect_success "--ignore-submodules=all suppresses submodule summary" '
 	cat > expect << EOF &&
 On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   sm
+
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
@@ -1374,7 +1379,6 @@ Untracked files:
 	output
 	untracked
 
-no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --ignore-submodules=all > output &&
 	test_i18ncmp expect output
-- 
1.8.5.rc3.1.g223caec
