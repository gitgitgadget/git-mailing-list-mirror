From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] pull: introduce a pull.rebase option to enable --rebase
Date: Sat,  5 Nov 2011 15:35:58 +0000
Message-ID: <1320507358-3407-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Eric Herman <eric@freesa.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 16:37:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMiJT-0006oL-Cu
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 16:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab1KEPgc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 11:36:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37773 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab1KEPgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 11:36:31 -0400
Received: by faao14 with SMTP id o14so3622053faa.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=V6cDfWRdq0gAXW2J1g2468BdAlUXys1po8Jlr448hjs=;
        b=xh1JSTUamkqnDAsqFC5fLd/GicE6Tix+KWDjk3a0P3GBa/sqdRXzLrEUkc2SSX83ny
         IpTWCgnBVcaZOYLCocGckjowEI27MAYIT2RcPxgmA2OskhkGk34uzJRnb84FB3akOlaB
         qu+ktuEyHrgkr7CM3y1njBh0okfAKgJqPTQTU=
Received: by 10.223.91.143 with SMTP id n15mr32627672fam.23.1320507389507;
        Sat, 05 Nov 2011 08:36:29 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id a8sm22140341faa.11.2011.11.05.08.36.28
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 08:36:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184853>

Currently we either need to set branch.<name>.rebase for existing
branches if we'd like "git pull" to mean "git pull --rebase", or have
the forethought of setting "branch.autosetuprebase" before we create
the branch.

But there's no way to globally configure "git pull" to mean "git pull
--rebase" for existing branches, introduce a "pull.rebase" option to
do that.

This option will be considered at a lower priority than
branch.<name>.rebase, i.e. we could set pull.rebase=3Dtrue and
branch.<name>.rebase=3Dfalse and the latter configuration option would
win.

Reviewed-by: Sverre Rabbelier <srabbelier@gmail.com>
Reviewed-by: Fernando Vezzosi <buccia@repnz.net>
Reviewed-by: Eric Herman <eric@freesa.org>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/config.txt   |   14 +++++++++++++-
 Documentation/git-pull.txt |    2 +-
 git-pull.sh                |    4 ++++
 t/t5520-pull.sh            |   24 ++++++++++++++++++++++--
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5a841da..b2d7d92 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -677,7 +677,9 @@ branch.<name>.mergeoptions::
 branch.<name>.rebase::
 	When true, rebase the branch <name> on top of the fetched branch,
 	instead of merging the default branch from the default remote when
-	"git pull" is run.
+	"git pull" is run. See "pull.rebase" for doing this in a non
+	branch-specific manner.
+
 	*NOTE*: this is a possibly dangerous operation; do *not* use
 	it unless you understand the implications (see linkgit:git-rebase[1]
 	for details).
@@ -1590,6 +1592,16 @@ pretty.<name>::
 	Note that an alias with the same name as a built-in format
 	will be silently ignored.
=20
+pull.rebase::
+	When true, rebase branches on top of the fetched branch, instead
+	of merging the default branch from the default remote when "git
+	pull" is run. See "branch.<name>.rebase" for setting this on a
+	per-branch basis.
+
+	*NOTE*: this is a possibly dangerous operation; do *not* use
+	it unless you understand the implications (see linkgit:git-rebase[1]
+	for details).
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e1da468..0f18ec8 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -108,7 +108,7 @@ include::merge-options.txt[]
 	fetched, the rebase uses that information to avoid rebasing
 	non-local changes.
 +
-See `branch.<name>.rebase` and `branch.autosetuprebase` in
+See `pull.rebase`, `branch.<name>.rebase` and `branch.autosetuprebase`=
 in
 linkgit:git-config[1] if you want to make `git pull` always use
 `{litdd}rebase` instead of merging.
 +
diff --git a/git-pull.sh b/git-pull.sh
index 9868a0b..24b6b7c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -44,6 +44,10 @@ merge_args=3D
 curr_branch=3D$(git symbolic-ref -q HEAD)
 curr_branch_short=3D"${curr_branch#refs/heads/}"
 rebase=3D$(git config --bool branch.$curr_branch_short.rebase)
+if test -z "$rebase"
+then=20
+	rebase=3D$(git config --bool pull.rebase)
+fi
 dry_run=3D
 while :
 do
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0e5eb67..ecc4fdc 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -94,16 +94,36 @@ test_expect_success '--rebase' '
 	test $(git rev-parse HEAD^) =3D $(git rev-parse copy) &&
 	test new =3D $(git show HEAD:file2)
 '
+test_expect_success 'pull.rebase' '
+	git reset --hard before-rebase &&
+	git config --bool pull.rebase true &&
+	test_when_finished "git config --unset pull.rebase" &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^) =3D $(git rev-parse copy) &&
+	test new =3D $(git show HEAD:file2)
+'
=20
 test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
-	git config branch.to-rebase.rebase 1 &&
+	git config --bool branch.to-rebase.rebase true &&
+	test_when_finished "git config --unset branch.to-rebase.rebase" &&
 	git pull . copy &&
-	git config branch.to-rebase.rebase 0 &&
 	test $(git rev-parse HEAD^) =3D $(git rev-parse copy) &&
 	test new =3D $(git show HEAD:file2)
 '
=20
+test_expect_success 'branch.to-rebase.rebase should override pull.reba=
se' '
+	git reset --hard before-rebase &&
+	git config --bool pull.rebase true &&
+	test_when_finished "git config --unset pull.rebase" &&
+	git config --bool branch.to-rebase.rebase false &&
+	test_when_finished "git config --unset branch.to-rebase.rebase" &&
+	git pull . copy &&
+	git config --unset branch.to-rebase.rebase &&
+	test $(git rev-parse HEAD^) !=3D $(git rev-parse copy) &&
+	test new =3D $(git show HEAD:file2)
+'
+
 test_expect_success '--rebase with rebased upstream' '
=20
 	git remote add -f me . &&
--=20
1.7.7
