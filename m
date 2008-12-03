From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: [PATCH] Implement rebase -q to fix pull --rebase -q
Date: Wed,  3 Dec 2008 05:06:52 +0100
Message-ID: <1228277212-5917-1-git-send-email-tuncer.ayaz@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 03 05:08:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7j2c-0006fU-Ek
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 05:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbYLCEH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 23:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754945AbYLCEHZ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 23:07:25 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:4035 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbYLCEHX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 23:07:23 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2738687fkq.5
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 20:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Ws0iRCizow/lBglHQZHx7AIKIymiAQ8b7wQ+Bs6Nvbk=;
        b=ogO2Kd35Jub3bgFYrw6OHlrD/iV3dFdattBaWemuizzQBH1DxpE9Gqh7P8hDEb3tis
         GerWVSOLmX6gytoEHVY3TonzeTt6y3TP26XwbVPyKoDxNyUFuExP+TNYPTP44trsOBCB
         02nvJ9LPStDWFq13tKc+pZQbusZldhzzeYwls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=c6vCwvcHcBhc99fh6g3PdW5DvRCh+71NICEZ0r2Sn0TfibyfoLiiqHG3pl1xeViCVg
         2+2nPjLDsuiJqJbB0tJX8yw8D6l0XqoxcMkBK5ybFGOcOxmXMb632cXZxn08liOtUMbG
         YmGvv8ZNGGf/fukmd+hkxuzrpB9OiRZhuyusU=
Received: by 10.180.224.4 with SMTP id w4mr4490972bkg.174.1228277241353;
        Tue, 02 Dec 2008 20:07:21 -0800 (PST)
Received: from localhost (achn-4db49f37.pool.einsundeins.de [77.180.159.55])
        by mx.google.com with ESMTPS id 22sm2647466fkr.24.2008.12.02.20.07.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Dec 2008 20:07:20 -0800 (PST)
X-Mailer: git-send-email 1.6.0.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102211>

This is needed on top of the fetch/pull -q/-v changes
to make
$ git pull --rebase -q
as quiet as expected.

Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
---
 git-pull.sh   |    2 +-
 git-rebase.sh |   31 +++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 1cac898..57fcee9 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -184,6 +184,6 @@ fi
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
-	${oldremoteref:-$merge_head}
+	$verbosity ${oldremoteref:-$merge_head}
 exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_args \
 	"$merge_name" HEAD $merge_head $verbosity
diff --git a/git-rebase.sh b/git-rebase.sh
index 023a6dc..bbfdc2e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
+USAGE='[--interactive | -i] [-q] [-v] [--onto <newbase>] <upstream> [<branch>]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -45,7 +45,7 @@ strategy=recursive
 do_merge=
 dotest="$GIT_DIR"/rebase-merge
 prec=4
-verbose=
+verbosity=1
 git_am_opt=
 
 continue_merge () {
@@ -135,7 +135,10 @@ move_to_original_branch () {
 finish_rb_merge () {
 	move_to_original_branch
 	rm -r "$dotest"
-	echo "All done."
+	if test $verbosity -gt 0
+	then
+		echo "All done."
+	fi
 }
 
 is_interactive () {
@@ -288,8 +291,11 @@ do
 		esac
 		do_merge=t
 		;;
+	-q|--quiet)
+		verbosity=0
+		;;
 	-v|--verbose)
-		verbose=t
+		verbosity=2
 		;;
 	--whitespace=*)
 		git_am_opt="$git_am_opt $1"
@@ -401,11 +407,14 @@ if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
 then
 	# Lazily switch to the target branch if needed...
 	test -z "$switch_to" || git checkout "$switch_to"
-	echo >&2 "Current branch $branch_name is up to date."
+	if test $verbosity -gt 0
+	then
+		echo >&2 "Current branch $branch_name is up to date."
+	fi
 	exit 0
 fi
 
-if test -n "$verbose"
+if test $verbosity -gt 1
 then
 	echo "Changes from $mb to $onto:"
 	# We want color (if set), but no pager
@@ -413,7 +422,10 @@ then
 fi
 
 # Detach HEAD and reset the tree
-echo "First, rewinding head to replay your work on top of it..."
+if test $verbosity -gt 0
+then
+	echo "First, rewinding head to replay your work on top of it..."
+fi
 git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $branch
 
@@ -421,7 +433,10 @@ git update-ref ORIG_HEAD $branch
 # we just fast forwarded.
 if test "$mb" = "$branch"
 then
-	echo >&2 "Fast-forwarded $branch_name to $onto_name."
+	if test $verbosity -gt 0
+	then
+		echo >&2 "Fast-forwarded $branch_name to $onto_name."
+	fi
 	move_to_original_branch
 	exit 0
 fi
-- 
1.6.0.2.GIT
