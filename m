From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] setup_git_directory: Setup cwd properly if worktree is
	found
Date: Mon, 12 Nov 2007 18:24:09 +0700
Message-ID: <20071112112408.GA5420@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 12:27:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrXSC-0003He-Nh
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 12:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757542AbXKLL12 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 06:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757102AbXKLL12
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 06:27:28 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:10826 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484AbXKLL11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 06:27:27 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1143962rvb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 03:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=xea6iamw8vQs2feO8hLUgTcSw2nKILWFbGmfTwHsBf8=;
        b=Y5J12omv62wJp0whKSILcw9OppiXBW38WPWenXAYjH0jzEsPKqDt4CD4l5WIhfu1Pgy+/KzfjwDCw6CE1ScDA7lZmthKp4DD3dLNJBhdL92rYoi3D6QctKi+5oHOw6+bT/pC1Wr9Woa0EdzG/A88KvVfJRdw4NQBqziQTWhw3RM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=ffB07QoWaB5KrE0z2VApEDDueVyMwip0fzxTpJk8ZcFtLg4R0e8bKBqT46VLCXmwsrlknPdLk2PERjfTslBpW42F2Jupe/gWKu0sbNcwMScPp287kZq69VnEmn3UV3RqeOOZaF7G0aKfl/+CmgArz9+IhoQhy/6axu00oCecvNo=
Received: by 10.140.163.3 with SMTP id l3mr2318456rve.1194866847009;
        Mon, 12 Nov 2007 03:27:27 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.0.207])
        by mx.google.com with ESMTPS id g31sm11478632rvb.2007.11.12.03.27.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2007 03:27:26 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 12 Nov 2007 18:24:09 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64604>

This makes sure (if possible) the current working directory is at
root worktree. "git rev-parse --show-cwd" is added to aid the tests.
Also the first test is for "Add missing inside_work_tree" commit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-rev-parse.c |    6 ++++++
 setup.c             |    7 ++++++-
 t/t1501-worktree.sh |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 8d78b69..933875c 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -319,6 +319,12 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 					puts(prefix);
 				continue;
 			}
+			if (!strcmp(arg, "--show-cwd")) {
+				char cwd[PATH_MAX+1];
+				getcwd(cwd, sizeof(cwd));
+				printf("%s\n", cwd);
+				continue;
+			}
 			if (!strcmp(arg, "--show-cdup")) {
 				const char *pfx =3D prefix;
 				if (!is_inside_work_tree()) {
diff --git a/setup.c b/setup.c
index 6f8f769..d90f65e 100644
--- a/setup.c
+++ b/setup.c
@@ -360,7 +360,12 @@ const char *setup_git_directory(void)
 		if (retval && chdir(retval))
 			die ("Could not jump back into original cwd");
 		rel =3D get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
-		return rel && *rel ? strcat(rel, "/") : NULL;
+		if (rel && *rel) {
+			if (chdir(get_git_work_tree()))
+				die ("Could not chdir to %s", get_git_work_tree());
+			return strcat(rel, "/");
+		}
+		return NULL;
 	}
=20
 	return retval;
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 7ee3820..a4e1f72 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -30,6 +30,18 @@ test_rev_parse() {
=20
 mkdir -p work/sub/dir || exit 1
 mv .git repo.git || exit 1
+export SAVED_WORK_DIR=3D$(pwd)/work
+
+say "GIT_WORK_TREE without core.worktree"
+
+export GIT_DIR=3D"$(pwd)"/repo.git
+export GIT_CONFIG=3D"$GIT_DIR"/config
+export GIT_WORK_TREE=3D"$(pwd)"/work
+
+test_expect_success 'cwd is set properly' '
+	(cd work/sub &&
+	 test "$(git rev-parse --show-cwd)" =3D "$SAVED_WORK_DIR")
+'
=20
 say "core.worktree =3D relative path"
 export GIT_DIR=3Drepo.git
@@ -47,6 +59,11 @@ export GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
=20
+test_expect_success 'cwd is set properly' '
+	(cd work/sub &&
+	 test "$(GIT_DIR=3D../../repo.git git rev-parse --show-cwd)" =3D "$SA=
VED_WORK_DIR")
+'
+
 say "core.worktree =3D absolute path"
 export GIT_DIR=3D$(pwd)/repo.git
 export GIT_CONFIG=3D$GIT_DIR/config
@@ -58,6 +75,11 @@ cd sub/dir || exit 1
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
=20
+test_expect_success 'cwd is set properly' '
+	(cd work/sub &&
+	 test "$(git rev-parse --show-cwd)" =3D "$SAVED_WORK_DIR")
+'
+
 say "GIT_WORK_TREE=3Drelative path (override core.worktree)"
 export GIT_DIR=3D$(pwd)/repo.git
 export GIT_CONFIG=3D$GIT_DIR/config
@@ -72,7 +94,13 @@ export GIT_WORK_TREE=3D../..
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
=20
+test_expect_success 'cwd is set properly' '
+	(cd work/sub &&
+	 test "$(GIT_WORK_TREE=3D.. git rev-parse --show-cwd)" =3D "$SAVED_WO=
RK_DIR")
+'
+
 mv work repo.git/work
+export SAVED_WORK_DIR=3D$(pwd)/repo.git/work
=20
 say "GIT_WORK_TREE=3Dabsolute path, work tree below git dir"
 export GIT_DIR=3D$(pwd)/repo.git
@@ -89,6 +117,11 @@ cd sub/dir || exit 1
 test_rev_parse 'in repo.git/sub/dir' false true true sub/dir/
 cd ../../../.. || exit 1
=20
+test_expect_success 'cwd is set properly' '
+	(cd repo.git/work/sub &&
+	 test "$(git rev-parse --show-cwd)" =3D "$SAVED_WORK_DIR")
+'
+
 test_expect_success 'repo finds its work tree' '
 	(cd repo.git &&
 	 : > work/sub/dir/untracked &&
--=20
1.5.3.5.475.gd7a30
