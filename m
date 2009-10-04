From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] Teach 'rebase -i' the command "amend"
Date: Sun, 04 Oct 2009 21:06:23 +0200
Message-ID: <4AC8F22F.5070101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 04 21:09:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuWSD-0005Qb-Cs
	for gcvg-git-2@lo.gmane.org; Sun, 04 Oct 2009 21:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742AbZJDTHF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Oct 2009 15:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757717AbZJDTHF
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 15:07:05 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:35063 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757644AbZJDTHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 15:07:04 -0400
Received: by ewy7 with SMTP id 7so2905655ewy.17
        for <git@vger.kernel.org>; Sun, 04 Oct 2009 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=OQQb8qiModHoNJRSuocVWlzOsfTdvxipChCvAoni2kM=;
        b=h86yMK02HkysRstAmu5PplYpeErQ5PkHE0peKtxGIC8KSvcJMZR5tNt2q5mkyOoS6q
         VIUl/qRLPyHJBqFmMpyyjpXyIsXs0rbxLcHVRJ6NFNDfQXQ1Ua6WYnLHTFZ8wzmDGxyn
         PTfdqwx4VLiVCyO1L3fv1cIbrilkQjSlAb3y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=L6QfPrt5eVStomfqQAH9Ohc4P3elRlZZt8WKSMlLRY/eki2QZhYk8IenvtW/mAHXuy
         etTD0kdwYc3pZUIh0Ytw1/RDhawu/w/NA6JPBbk34l7/egbiKG6PuzHNUs8qG2kiZJy4
         47RiOW+12dwyQPDwTsNZZJcR3KeYrg9UEUnFQ=
Received: by 10.211.145.11 with SMTP id x11mr5974385ebn.74.1254683186449;
        Sun, 04 Oct 2009 12:06:26 -0700 (PDT)
Received: from bitis.local (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm282254eyb.13.2009.10.04.12.06.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 12:06:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129516>

Make it easier to edit just the commit message for a commit
using 'git rebase -i' by introducing the "amend" command.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
Here is my first ever patch of git.

I find that I often use 'git rebase -i' just to correct typos
in my commit messages or to fill in more details, so I thought
it would be a good idea to add to add an "amend" command to
'git rebase -i'.

/Bj=C3=B6rn

 Documentation/git-rebase.txt  |    3 +++
 git-rebase--interactive.sh    |    9 +++++++++
 t/lib-rebase.sh               |    6 +++---
 t/t3404-rebase-interactive.sh |   14 ++++++++++++++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 0aefc34..28b90ec 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -368,6 +368,9 @@ By replacing the command "pick" with the command "e=
dit", you can tell
 the files and/or the commit message, amend the commit, and continue
 rebasing.
=20
+If you just want to edit the commit message for a commit, you can repl=
ace
+the command "pick" with the command "amend".
+
 If you want to fold two or more commits into one, replace the command
 "pick" with "squash" for the second and subsequent commit.  If the
 commits had different authors, it will attribute the squashed commit t=
o
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 23ded48..3f6bcc0 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -340,6 +340,14 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		;;
+	amend|a)
+		comment_for_reflog amend
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
+#  a, amend =3D use commit, but allow editing of the commit message
 #  e, edit =3D use commit, but stop for amending
 #  s, squash =3D use commit, but meld into previous commit
 #
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 260a231..2ca0481 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -9,8 +9,8 @@
 #
 #	"[<lineno1>] [<lineno2>]..."
 #
-#   If a line number is prefixed with "squash" or "edit", the respecti=
ve line's
-#   command will be replaced with the specified one.
+#   If a line number is prefixed with "squash", "edit", or "amend", th=
e
+#   respective line's command will be replaced with the specified one.
=20
 set_fake_editor () {
 	echo "#!$SHELL_PATH" >fake-editor.sh
@@ -32,7 +32,7 @@ cat "$1".tmp
 action=3Dpick
 for line in $FAKE_LINES; do
 	case $line in
-	squash|edit)
+	squash|edit|amend)
 		action=3D"$line";;
 	*)
 		echo sed -n "${line}s/^pick/$action/p"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 4cae019..3520480 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -470,4 +470,18 @@ test_expect_success 'avoid unnecessary reset' '
 	test 123456789 =3D $MTIME
 '
=20
+test_expect_success 'amend' '
+	git checkout -b amend-branch master &&
+	FAKE_LINES=3D"1 2 3 amend 4" FAKE_COMMIT_MESSAGE=3D"E changed" git re=
base -i A &&
+	git show HEAD | grep "E changed" &&
+	test $(git rev-parse master) !=3D $(git rev-parse HEAD) &&
+	test $(git rev-parse master^) =3D $(git rev-parse HEAD^) &&
+	FAKE_LINES=3D"1 2 amend 3 4" FAKE_COMMIT_MESSAGE=3D"D changed" git re=
base -i A &&
+	git show HEAD^ | grep "D changed" &&
+	FAKE_LINES=3D"amend 1 2 3 4" FAKE_COMMIT_MESSAGE=3D"B changed" git re=
base -i A &&
+	git show HEAD~3 | grep "B changed" &&
+	FAKE_LINES=3D"1 amend 2 3 4" FAKE_COMMIT_MESSAGE=3D"C changed" git re=
base -i A &&
+	git show HEAD~2 | grep "C changed"
+'
+
 test_done
--=20
1.6.5.rc2.18.g117a
