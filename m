From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] filter-branch: Fix renaming a directory in the tree-filter
Date: Mon, 31 Mar 2008 09:14:15 +0200
Message-ID: <1206947655-20272-2-git-send-email-johannes.sixt@telecom.at>
References: <C46D6D0D-44E1-4976-8956-1D84B6351535@yahoo.ca>
 <1206947655-20272-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	=?utf-8?q?Jean-Fran=C3=A7ois=20Veillette?= 
	<jean_francois_veillette@yahoo.ca>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: =?utf-8?q?Jean-Fran=C3=A7ois=20Veillette?= 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Mon Mar 31 09:51:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgEnr-0006KT-Hn
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 09:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbYCaHuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Mar 2008 03:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbYCaHup
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 03:50:45 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43982 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbYCaHup convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2008 03:50:45 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1JgECl-00033R-1y; Mon, 31 Mar 2008 09:13:19 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3A131FF0C; Mon, 31 Mar 2008 09:14:16 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id E0075FA41; Mon, 31 Mar 2008 09:14:15 +0200 (CEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1206947655-20272-1-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78566>

=46rom: Jean-Fran=C3=A7ois Veillette <jean francois veillette@yahoo.ca>

Commit d89c1dfac939623a269f60d4e27e3a2929dca29c replaced a
'ls-files | xargs rm' pipeline by 'git clean'. But since 'git clean' do=
es
not recurse and remove directories by default. Now, consider a tree-fil=
ter
that renames a directory.

1. For the first commit everything works as expected
2. Then filter-branch checks out the files for the next commit. This
   leaves the new directory behind because there is no real "branch
   switching" involved that would notice that the directory can be
   removed.
3. Then filter-branch invokes 'git clean' to remove exactly those
   left-overs. But here it does not remove the directory.
4. The next tree-filter does not work as expected because there already
   exists a directory with the new name.

Just add -d to 'git clean'.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Jean-Francois, there's no sign-off from you. Ok to add it?

 -- Hannes

 git-filter-branch.sh     |    2 +-
 t/t7003-filter-branch.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 22b6ed4..ea59015 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -281,7 +281,7 @@ while read commit parents; do
 			die "Could not checkout the index"
 		# files that $commit removed are now still in the working tree;
 		# remove them, else they would be added again
-		git clean -q -f -x
+		git clean -d -q -f -x
 		eval "$filter_tree" < /dev/null ||
 			die "tree filter failed: $filter_tree"
=20
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 53b5ce6..efd658a 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -53,7 +53,7 @@ test_expect_success 'rewrite, renaming a specific dir=
ectory' '
 	git-filter-branch -f --tree-filter "mv dir diroh || :" HEAD
 '
=20
-test_expect_failure 'test that the directory was renamed' '
+test_expect_success 'test that the directory was renamed' '
 	test dir/d =3D "$(git show HEAD:diroh/d --)" &&
 	! test -d dir &&
 	test -d diroh &&
--=20
1.5.4.4
