From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/2] Add optional parameters to the diff option "--ignore-submodules"
Date: Tue, 08 Jun 2010 18:31:51 +0200
Message-ID: <4C0E7077.9090509@web.de>
References: <4C0E7037.8080403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 08 18:32:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM1ie-0007HA-Vz
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 18:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525Ab0FHQbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 12:31:55 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41946 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab0FHQby (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 12:31:54 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id E5E21154D07D5;
	Tue,  8 Jun 2010 18:31:52 +0200 (CEST)
Received: from [80.128.58.232] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OM1iS-0006DJ-00; Tue, 08 Jun 2010 18:31:52 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4C0E7037.8080403@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18PbJL5g/Q2/FEq3CSWUlueY2dp9R//aNWPog0+
	zUbD9pw/mabczDPv4usSIS/zthaBkxuKmG6/LU/HgK+I6w6XK6
	PYH+7UD6f1RtsAeTXcfg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148689>

In some use cases it is not desirable that the diff family considers
submodules that only contain untracked content as dirty. This may happen
e.g. when the submodule is not under the developers control and not all
build generated files have been added to .gitignore by the upstream
developers. Using the "untracked" parameter for the "--ignore-submodules"
option disables checking for untracked content and lets git diff report
them as changed only when they have new commits or modified content.

Sometimes it is not wanted to have submodules show up as changed when they
just contain changes to their work tree. An example for that are scripts
which just want to check for submodule commits while ignoring any changes
to the work tree. Also users having large submodules known not to change
might want to use this option, as the - sometimes substantial - time it
takes to scan the submodule work tree(s) is saved.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/diff-options.txt   |   10 ++++-
 diff-lib.c                       |    1 +
 diff.c                           |   11 +++++-
 diff.h                           |    1 +
 t/t4027-diff-submodule.sh        |   20 ++++++++-
 t/t4041-diff-submodule-option.sh |   81 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e745a3c..2371262 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -328,8 +328,14 @@ endif::git-format-patch[]
 --no-ext-diff::
 	Disallow external diff drivers.

---ignore-submodules::
-	Ignore changes to submodules in the diff generation.
+--ignore-submodules[=<when>]::
+	Ignore changes to submodules in the diff generation. <when> can be
+	either "untracked", "dirty" or "all", which is the default. When
+	"untracked" is used submodules are not considered dirty when they only
+	contain untracked content (but they are still scanned for modified
+	content). Using "dirty" ignores all changes to the work tree of submodules,
+	only changes to the commits stored in the superproject are shown (this was
+	the behavior until 1.7.0). Using "all" hides all changes to submodules.

 --src-prefix=<prefix>::
 	Show the given source prefix instead of "a/".
diff --git a/diff-lib.c b/diff-lib.c
index c9f6e05..8b8978a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -70,6 +70,7 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 	int changed = ce_match_stat(ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)
 	    && !DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES)
+	    && !DIFF_OPT_TST(diffopt, IGNORE_DIRTY_SUBMODULES)
 	    && (!changed || DIFF_OPT_TST(diffopt, DIRTY_SUBMODULES))) {
 		*dirty_submodule = is_submodule_modified(ce->name, DIFF_OPT_TST(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES));
 	}
diff --git a/diff.c b/diff.c
index 2327cea..71fff7e 100644
--- a/diff.c
+++ b/diff.c
@@ -3174,7 +3174,16 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
 	else if (!strcmp(arg, "--ignore-submodules"))
 		DIFF_OPT_SET(options, IGNORE_SUBMODULES);
-	else if (!strcmp(arg, "--submodule"))
+	else if (!prefixcmp(arg, "--ignore-submodules=")) {
+		if (!strcmp(arg + 20, "all"))
+			DIFF_OPT_SET(options, IGNORE_SUBMODULES);
+		else if (!strcmp(arg + 20, "untracked"))
+			DIFF_OPT_SET(options, IGNORE_UNTRACKED_IN_SUBMODULES);
+		else if (!strcmp(arg + 20, "dirty"))
+			DIFF_OPT_SET(options, IGNORE_DIRTY_SUBMODULES);
+		else
+			die("bad --ignore-submodules argument: %s", arg + 20);
+	} else if (!strcmp(arg, "--submodule"))
 		DIFF_OPT_SET(options, SUBMODULE_LOG);
 	else if (!prefixcmp(arg, "--submodule=")) {
 		if (!strcmp(arg + 12, "log"))
diff --git a/diff.h b/diff.h
index 48abe7a..5248cd8 100644
--- a/diff.h
+++ b/diff.h
@@ -74,6 +74,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_SUBMODULE_LOG       (1 << 23)
 #define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
 #define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
+#define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)

 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 83c1914..559b41e 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -103,9 +103,17 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
 	git diff HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
-	test_cmp expect.body actual.body
+	test_cmp expect.body actual.body &&
+	git diff --ignore-submodules HEAD >actual2 &&
+	echo -n "" | test_cmp - actual2 &&
+	git diff --ignore-submodules=untracked HEAD >actual3 &&
+	sed -e "1,/^@@/d" actual3 >actual3.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual3.body &&
+	git diff --ignore-submodules=dirty HEAD >actual4 &&
+	echo -n "" | test_cmp - actual4
 '
-
+test_done
 test_expect_success 'git diff HEAD with dirty submodule (index, refs match)' '
 	(
 		cd sub &&
@@ -129,7 +137,13 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 	git diff HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
-	test_cmp expect.body actual.body
+	test_cmp expect.body actual.body &&
+	git diff --ignore-submodules=all HEAD >actual2 &&
+	echo -n "" | test_cmp - actual2 &&
+	git diff --ignore-submodules=untracked HEAD >actual3 &&
+	echo -n "" | test_cmp - actual3 &&
+	git diff --ignore-submodules=dirty HEAD >actual4 &&
+	echo -n "" | test_cmp - actual4
 '

 test_expect_success 'git diff (empty submodule dir)' '
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 019acb9..f44b906 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -205,6 +205,21 @@ Submodule sm1 contains untracked content
 EOF
 "

+test_expect_success 'submodule contains untracked content (untracked ignored)' "
+	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	echo -n '' | diff actual -
+"
+
+test_expect_success 'submodule contains untracked content (dirty ignored)' "
+	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
+	echo -n '' | diff actual -
+"
+
+test_expect_success 'submodule contains untracked content (all ignored)' "
+	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
+	echo -n '' | diff actual -
+"
+
 test_expect_success 'submodule contains untracked and modifed content' "
 	echo new > sm1/foo6 &&
 	git diff-index -p --submodule=log HEAD >actual &&
@@ -214,6 +229,26 @@ Submodule sm1 contains modified content
 EOF
 "

+test_expect_success 'submodule contains untracked and modifed content (untracked ignored)' "
+	echo new > sm1/foo6 &&
+	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 contains modified content
+EOF
+"
+
+test_expect_success 'submodule contains untracked and modifed content (dirty ignored)' "
+	echo new > sm1/foo6 &&
+	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
+	echo -n '' | diff actual -
+"
+
+test_expect_success 'submodule contains untracked and modifed content (all ignored)' "
+	echo new > sm1/foo6 &&
+	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
+	echo -n '' | diff actual -
+"
+
 test_expect_success 'submodule contains modifed content' "
 	rm -f sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
@@ -242,6 +277,27 @@ Submodule sm1 $head6..$head8:
 EOF
 "

+test_expect_success 'modified submodule contains untracked content (untracked ignored)' "
+	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6..$head8:
+  > change
+EOF
+"
+
+test_expect_success 'modified submodule contains untracked content (dirty ignored)' "
+	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6..$head8:
+  > change
+EOF
+"
+
+test_expect_success 'modified submodule contains untracked content (all ignored)' "
+	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
+	echo -n '' | diff actual -
+"
+
 test_expect_success 'modified submodule contains untracked and modifed content' "
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --submodule=log HEAD >actual &&
@@ -253,6 +309,31 @@ Submodule sm1 $head6..$head8:
 EOF
 "

+test_expect_success 'modified submodule contains untracked and modifed content (untracked ignored)' "
+	echo modification >> sm1/foo6 &&
+	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 contains modified content
+Submodule sm1 $head6..$head8:
+  > change
+EOF
+"
+
+test_expect_success 'modified submodule contains untracked and modifed content (dirty ignored)' "
+	echo modification >> sm1/foo6 &&
+	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6..$head8:
+  > change
+EOF
+"
+
+test_expect_success 'modified submodule contains untracked and modifed content (all ignored)' "
+	echo modification >> sm1/foo6 &&
+	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
+	echo -n '' | diff actual -
+"
+
 test_expect_success 'modified submodule contains modifed content' "
 	rm -f sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
-- 
1.7.1.447.g4d763
