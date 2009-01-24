From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 2/2 (v2)] git-am: Add --ignore-date option
Date: Sat, 24 Jan 2009 10:18:02 +0900
Message-ID: <20090124101802.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 02:19:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQXBa-00036o-AX
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 02:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbZAXBSR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2009 20:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbZAXBSR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 20:18:17 -0500
Received: from karen.lavabit.com ([72.249.41.33]:53008 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420AbZAXBSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 20:18:16 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id CE89BC7AA6;
	Fri, 23 Jan 2009 19:18:15 -0600 (CST)
Received: from 7951.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id AJN1JPYYPTDY; Fri, 23 Jan 2009 19:18:15 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=yMJropgjjM0sXxoIEHOYG+LyKTSH0k7ADfWds4cRCJEQd+uchHg0W4CkyKGUMXPRlWUJu1MV7YzoZvhfnit6wisDkFlFvoN7MR8bDX8Voi2CMHml1iwibRDW/c2NmGhgSbEiEMm0Iz8TVBG5BvIXlVzDTSNGGIHAfuNdodF/Vpg=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106940>

This new option tells 'git-am' to ignore the date header field
recorded in the format-patch output. The commits will have the
timestamp when they are created instead.

You can work a lot in one day to accumulate many changes, but
apply and push to the public repository only some of them at
the end of the first day. Then next day you can spend all your
working hours reading comics or chatting with your coworkers,
and apply your remaining patches from the previous day using
this option to pretend that you have been working at the end
of the day.

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@lavabit.com>
---

Added documentation and copied your response about the new
test as a comment.

 Documentation/git-am.txt |   17 ++++++++++++++++-
 git-am.sh                |    8 ++++++++
 t/t4150-am.sh            |   13 +++++++++++++
 3 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 5cbbe76..c10c91b 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git am' [--signoff] [--keep] [--utf8 | --no-utf8]
-	 [--3way] [--interactive]
+	 [--3way] [--interactive] [--committer-date-is-author-date]
+	 [--ignore-date]
 	 [--whitespace=3D<option>] [-C<n>] [-p<n>] [--directory=3D<dir>]
 	 [<mbox> | <Maildir>...]
 'git am' (--skip | --resolved | --abort)
@@ -71,6 +72,20 @@ default.   You could use `--no-utf8` to override thi=
s.
 --interactive::
 	Run interactively.
=20
+--committer-date-is-author-date::
+	By default the command records the date from the e-mail
+	message as the commit author date, and uses the time of
+	commit creation as the committer date. This allows the
+	user to lie about the committer date by using the same
+	timestamp as the author date.
+
+--ignore-date::
+	By default the command records the date from the e-mail
+	message as the commit author date, and uses the time of
+	commit creation as the committer date. This allows the
+	user to lie about author timestamp by using the same
+	timestamp as the committer date.
+
 --skip::
 	Skip the current patch.  This is only meaningful when
 	restarting an aborted patch.
diff --git a/git-am.sh b/git-am.sh
index e96071d..f935178 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -24,6 +24,7 @@ r,resolved      to be used after a patch failure
 skip            skip the current patch
 abort           restore the original branch and abort the patching ope=
ration.
 committer-date-is-author-date    lie about committer date
+ignore-date     use current timestamp for author date
 rebasing        (internal use for git-rebase)"
=20
 . git-sh-setup
@@ -135,6 +136,7 @@ sign=3D utf8=3Dt keep=3D skip=3D interactive=3D res=
olved=3D rebasing=3D abort=3D
 resolvemsg=3D resume=3D
 git_apply_opt=3D
 committer_date_is_author_date=3D
+ignore_date=3D
=20
 while test $# !=3D 0
 do
@@ -172,6 +174,8 @@ do
 		git_apply_opt=3D"$git_apply_opt $(sq "$1$2")"; shift ;;
 	--committer-date-is-author-date)
 		committer_date_is_author_date=3Dt ;;
+	--ignore-date)
+		ignore_date=3Dt ;;
 	--)
 		shift; break ;;
 	*)
@@ -526,6 +530,10 @@ do
 	tree=3D$(git write-tree) &&
 	parent=3D$(git rev-parse --verify HEAD) &&
 	commit=3D$(
+		if test -n "$ignore_date"
+		then
+			GIT_AUTHOR_DATE=3D
+		fi
 		if test -n "$committer_date_is_author_date"
 		then
 			GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 8d3fb00..2ad9048 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -277,4 +277,17 @@ test_expect_success 'am without --committer-date-i=
s-author-date' '
 	test "$at" !=3D "$ct"
 '
=20
+# This checks for +0000 because TZ is set to UTC and that should
+# show up when the current time is used. The date in message is set
+# by test_tick that uses -0700 timezone; if this feature does not
+# work, we will see that instead of +0000.
+test_expect_success 'am --ignore-date' '
+	git checkout first &&
+	test_tick &&
+	git am --ignore-date patch1 &&
+	git cat-file commit HEAD | sed -e "/^$/q" >head1 &&
+	at=3D$(sed -ne "/^author /s/.*> //p" head1) &&
+	echo "$at" | grep "+0000"
+'
+
 test_done
--=20
1.6.1

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
