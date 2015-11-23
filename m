From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] filter-branch: deal with object name vs. pathname ambiguity in tree-filter
Date: Mon, 23 Nov 2015 13:23:16 +0100
Message-ID: <1448281396-5049-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 23 13:23:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0q9q-0004NG-B9
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 13:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbbKWMXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2015 07:23:44 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:39047 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753290AbbKWMXm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2015 07:23:42 -0500
Received: from x590d9c5d.dyn.telefonica.de ([89.13.156.93] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1a0q9d-0004ld-Bh; Mon, 23 Nov 2015 13:23:38 +0100
X-Mailer: git-send-email 2.6.3.416.g766831e
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1448281418.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281583>

'git filter-branch' fails complaining about an ambiguous argument, if
a tree-filter renames a path and the new pathname happens to match an
existing object name.

After the tree-filter has been applied, 'git filter-branch' looks for
changed paths by running:

  git diff-index -r --name-only --ignore-submodules $commit

which then, because of the lack of disambiguating double-dash, can't
decide whether to treat '$commit' as revision or path and errors out.

Add that disambiguating double-dash after 'git diff-index's revision
argument to make sure that '$commit' is interpreted as a revision.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 git-filter-branch.sh     | 2 +-
 t/t7003-filter-branch.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 27c9c54fbd..cefd1452c6 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -349,7 +349,7 @@ while read commit parents; do
 			die "tree filter failed: $filter_tree"
=20
 		(
-			git diff-index -r --name-only --ignore-submodules $commit &&
+			git diff-index -r --name-only --ignore-submodules $commit -- &&
 			git ls-files --others
 		) > "$tempdir"/tree-state || exit
 		git update-index --add --replace --remove --stdin \
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 377c648e04..869e0bf073 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -418,4 +418,11 @@ test_expect_success 'filter commit message without=
 trailing newline' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'tree-filter deals with object name vs pathname am=
biguity' '
+	test_when_finished "git reset --hard original" &&
+	ambiguous=3D$(git rev-list -1 HEAD) &&
+	git filter-branch --tree-filter "mv file.t $ambiguous" HEAD^.. &&
+	git show HEAD:$ambiguous
+'
+
 test_done
--=20
2.6.3.416.g766831e
