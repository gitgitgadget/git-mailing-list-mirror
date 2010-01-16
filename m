From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 2/2] Teach diff that modified submodule directory is dirty
Date: Sat, 16 Jan 2010 18:42:53 +0100
Message-ID: <4B51FA9D.7070206@web.de>
References: <4B51F9EB.5090202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 18:46:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWCjC-00069R-QF
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 18:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab0APRqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 12:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408Ab0APRqX
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 12:46:23 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:51304 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321Ab0APRqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 12:46:22 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id D0CEA14C0B595;
	Sat, 16 Jan 2010 18:46:21 +0100 (CET)
Received: from [80.128.127.37] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NWCfl-0007y5-00; Sat, 16 Jan 2010 18:42:53 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <4B51F9EB.5090202@web.de>
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137240>

From: Junio C Hamano <gitster@pobox.com>

A diff run in superproject only compares the name of the commit object
bound at the submodule paths.  When we compare with a work tree and the
checked out submodule directory is dirty (e.g. has either staged or
unstaged changes, or has new files the user forgot to add to the index),
show the work tree side as "dirty".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Changed since the last version:
- I added 3 tests for "git diff HEAD" when refs match (the HEAD in the
  submodule is the same as last committed in the superproject)


 diff.c                    |    9 ++++-
 t/t4027-diff-submodule.sh |   84 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 5060b48..012b3d3 100644
--- a/diff.c
+++ b/diff.c
@@ -2029,9 +2029,14 @@ static int populate_from_stdin(struct diff_filespec *s)
 static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
 {
 	int len;
-	char *data = xmalloc(100);
+	char *data = xmalloc(100), *dirty = "";
+
+	/* Are we looking at the work tree? */
+	if (!s->sha1_valid && is_submodule_modified(s->path))
+		dirty = "-dirty";
+
 	len = snprintf(data, 100,
-		"Subproject commit %s\n", sha1_to_hex(s->sha1));
+		       "Subproject commit %s%s\n", sha1_to_hex(s->sha1), dirty);
 	s->data = data;
 	s->size = len;
 	s->should_free = 1;
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 5cf8924..83c1914 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -32,7 +32,8 @@ test_expect_success setup '
 		cd sub &&
 		git rev-list HEAD
 	) &&
-	echo ":160000 160000 $3 $_z40 M	sub" >expect
+	echo ":160000 160000 $3 $_z40 M	sub" >expect &&
+	subtip=$3 subprev=$2
 '

 test_expect_success 'git diff --raw HEAD' '
@@ -50,6 +51,87 @@ test_expect_success 'git diff-files --raw' '
 	test_cmp expect actual.files
 '

+expect_from_to () {
+	printf "%sSubproject commit %s\n+Subproject commit %s\n" \
+		"-" "$1" "$2"
+}
+
+test_expect_success 'git diff HEAD' '
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (work tree)' '
+	echo >>sub/world &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (index)' '
+	(
+		cd sub &&
+		git reset --hard &&
+		echo >>world &&
+		git add world
+	) &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (untracked)' '
+	(
+		cd sub &&
+		git reset --hard &&
+		git clean -qfdx &&
+		>cruft
+	) &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)' '
+	git commit -m "x" sub &&
+	echo >>sub/world &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (index, refs match)' '
+	(
+		cd sub &&
+		git reset --hard &&
+		echo >>world &&
+		git add world
+	) &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)' '
+	(
+		cd sub &&
+		git reset --hard &&
+		git clean -qfdx &&
+		>cruft
+	) &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
 test_expect_success 'git diff (empty submodule dir)' '
 	: >empty &&
 	rm -rf sub/* sub/.git &&
-- 
1.6.6.332.g1985b
