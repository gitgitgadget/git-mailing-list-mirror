From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] Teach 'rebase -i' the command "reword"
Date: Mon, 05 Oct 2009 18:16:17 +0200
Message-ID: <4ACA1BD1.6050905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 18:25:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuqNH-0002tv-W8
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 18:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbZJEQR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 12:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbZJEQR2
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 12:17:28 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:1474 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZJEQR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 12:17:28 -0400
Received: by ey-out-2122.google.com with SMTP id 4so610254eyf.19
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=IBxucI3opiqEvvpvI1UfxrgBKe/XX+qH9rBKQP0SblI=;
        b=gQGRFf4z/6kQ15yCDNIUD0mIkSUY+O5mdR6K6bRKShFUZyXRFjHO7nGpidByAbTVS+
         QWD5SrgovYwYD1ZdFUUiL4js7TdUDsyz8qrFletv46+CZF7RAiM/kVXXZ4cI+J+NrmcD
         ua8hqNeNvuxOoVTb7425duBEFzXX4VMhDEqzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=hs9CbW4iwWYkVpT+F13cpFfWROAuXS+JojEizGHEOTyzMH3DxM7Ey2AoKTsDxXQunR
         UTvJ+HFskGMHu+XZBGzA5bzY5GFtlaEq4PBkpxDBmmvruXXMEirL4eOj1HK1ZIsalzS0
         +9DVHsqUAXxzG1DF52l8mWsue/BuwHPjI9RCQ=
Received: by 10.210.3.21 with SMTP id 21mr223020ebc.40.1254759379838;
        Mon, 05 Oct 2009 09:16:19 -0700 (PDT)
Received: from bitis.local (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm71805eyd.5.2009.10.05.09.16.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Oct 2009 09:16:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129571>

Make it easier to edit just the commit message for a commit
using 'git rebase -i' by introducing the "reword" command.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---

Here is the re-roll of my previous patch.

The only difference is that "amend" (which would be mis-leading)
has been replaced with "reword".

 Documentation/git-rebase.txt  |    3 +++
 git-rebase--interactive.sh    |    9 +++++++++
 t/lib-rebase.sh               |    6 +++---
 t/t3404-rebase-interactive.sh |   14 ++++++++++++++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 0aefc34..52af656 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -368,6 +368,9 @@ By replacing the command "pick" with the command "e=
dit", you can tell
 the files and/or the commit message, amend the commit, and continue
 rebasing.
=20
+If you just want to edit the commit message for a commit, you can repl=
ace
+the command "pick" with the command "reword".
+
 If you want to fold two or more commits into one, replace the command
 "pick" with "squash" for the second and subsequent commit.  If the
 commits had different authors, it will attribute the squashed commit t=
o
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 23ded48..30c2f62 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -340,6 +340,14 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		;;
+	reword|r)
+		comment_for_reflog reword
+
+		mark_action_done
+		pick_one $sha1 ||
+			die_with_patch $sha1 "Could not apply $sha1... $rest"
+		output git commit --amend
+		;;
 	edit|e)
 		comment_for_reflog edit
=20
@@ -752,6 +760,7 @@ first and then run 'git rebase --continue' again."
 #
 # Commands:
 #  p, pick =3D use commit
+#  r, reword =3D use commit, but allow editing of the commit message
 #  e, edit =3D use commit, but stop for amending
 #  s, squash =3D use commit, but meld into previous commit
 #
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 260a231..62f452c 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -9,8 +9,8 @@
 #
 #	"[<lineno1>] [<lineno2>]..."
 #
-#   If a line number is prefixed with "squash" or "edit", the respecti=
ve line's
-#   command will be replaced with the specified one.
+#   If a line number is prefixed with "squash", "edit", or "reword", t=
he
+#   respective line's command will be replaced with the specified one.
=20
 set_fake_editor () {
 	echo "#!$SHELL_PATH" >fake-editor.sh
@@ -32,7 +32,7 @@ cat "$1".tmp
 action=3Dpick
 for line in $FAKE_LINES; do
 	case $line in
-	squash|edit)
+	squash|edit|reword)
 		action=3D"$line";;
 	*)
 		echo sed -n "${line}s/^pick/$action/p"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 4cae019..3a37793 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -470,4 +470,18 @@ test_expect_success 'avoid unnecessary reset' '
 	test 123456789 =3D $MTIME
 '
=20
+test_expect_success 'reword' '
+	git checkout -b reword-branch master &&
+	FAKE_LINES=3D"1 2 3 reword 4" FAKE_COMMIT_MESSAGE=3D"E changed" git r=
ebase -i A &&
+	git show HEAD | grep "E changed" &&
+	test $(git rev-parse master) !=3D $(git rev-parse HEAD) &&
+	test $(git rev-parse master^) =3D $(git rev-parse HEAD^) &&
+	FAKE_LINES=3D"1 2 reword 3 4" FAKE_COMMIT_MESSAGE=3D"D changed" git r=
ebase -i A &&
+	git show HEAD^ | grep "D changed" &&
+	FAKE_LINES=3D"reword 1 2 3 4" FAKE_COMMIT_MESSAGE=3D"B changed" git r=
ebase -i A &&
+	git show HEAD~3 | grep "B changed" &&
+	FAKE_LINES=3D"1 reword 2 3 4" FAKE_COMMIT_MESSAGE=3D"C changed" git r=
ebase -i A &&
+	git show HEAD~2 | grep "C changed"
+'
+
 test_done
--=20
1.6.5.rc2.18.g020de
