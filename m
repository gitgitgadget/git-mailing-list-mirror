From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [RFC PATCH] Fix gitdir detection when in subdir of gitdir
Date: Fri, 16 Jan 2009 16:37:33 +0100
Message-ID: <1232120253-1551-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 16:39:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNqml-0004nk-Us
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 16:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbZAPPhk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 10:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbZAPPhj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 10:37:39 -0500
Received: from francis.fzi.de ([141.21.7.5]:52393 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751747AbZAPPhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 10:37:38 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 16:37:32 +0100
X-Mailer: git-send-email 1.6.1.153.g15508
X-OriginalArrivalTime: 16 Jan 2009 15:37:32.0608 (UTC) FILETIME=[59044C00:01C977F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105966>

If the current working directory is a subdirectory of the gitdir (e.g.
<repo>/.git/refs/), then setup_git_directory_gently() will climb its
parent directories until it finds itself in a gitdir.  However, no
matter how many parent directories it climbs, it sets
'GIT_DIR_ENVIRONMENT' to ".", which is obviously wrong.

This behaviour affected at least 'git rev-parse --git-dir' and hence
caused some errors in bash completion (e.g. customized command prompt
when on a detached head and completion of refs).

To fix this, we set the absolute path of the found gitdir instead.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

  I'm not sure about setting an absolut path instead of a relative one
  (hence the RFC), although I think it should not make any difference.
  Of course I could have count the number of chdir("..") calls and then
  construct a "../../..", but that would have been more intrusive than
  this two-liner.

 setup.c             |    3 ++-
 t/t1501-worktree.sh |    7 +++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 6b277b6..b787a54 100644
--- a/setup.c
+++ b/setup.c
@@ -456,7 +456,8 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 			inside_git_dir =3D 1;
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
-			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+			cwd[offset] =3D '\0';
+			setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index f6a6f83..27dc6c5 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -92,6 +92,13 @@ cd sub/dir || exit 1
 test_rev_parse 'in repo.git/sub/dir' false true true sub/dir/
 cd ../../../.. || exit 1
=20
+test_expect_success 'detecting gitdir when cwd is in a subdir of gitdi=
r' '
+	(expected=3D$(pwd)/repo.git &&
+	 cd repo.git/refs &&
+	 unset GIT_DIR &&
+	 test "$expected" =3D "$(git rev-parse --git-dir)")
+'
+
 test_expect_success 'repo finds its work tree' '
 	(cd repo.git &&
 	 : > work/sub/dir/untracked &&
--=20
1.6.1.153.g15508
