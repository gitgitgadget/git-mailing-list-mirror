From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/2] rebase: teach quiet option
Date: Sat, 13 Jun 2009 13:21:40 -0700
Message-ID: <1244924500-27391-3-git-send-email-bebarino@gmail.com>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
 <1244924500-27391-2-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 22:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFZjf-0007Uf-RM
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 22:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758570AbZFMUVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 16:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758246AbZFMUVu
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 16:21:50 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:59906 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757279AbZFMUVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 16:21:49 -0400
Received: by pzk17 with SMTP id 17so1211706pzk.33
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=VGlPNJXYGi+IgGfHtI/xw+57CmYeAXYVU+s2K9Thc7I=;
        b=kV1SWb0/8yKKNHMV5Glcxit8lqpMqufA6VO+Kv6qU3OjN+OTyn24CMwu1G0bhbC008
         UnuoYkls31+d3TlkY330T3hVnc8SrG9TYSd2F2OJWChzygBF2i9AlmnUkCDw0lM4/Q0l
         HcfHKHlcIW/8FuU1MZsp0Al5aUI+VgcWMSHCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uq72xfB1n4vXoywWkANoaQKO4JoGMT/EXP2btZveE4LddeyT6H3H5CnC3sq40l6yh9
         lRTb7M3xRbrqTsMlm5dqj2HEyF3GWoTzp/2DyriakbtEIRCw/eTbkl/vyNgCYg2fxcWP
         TfA7+LZlLS5HmDmsPS4nF/090/twuiahI4mKI=
Received: by 10.114.60.7 with SMTP id i7mr8397648waa.6.1244924511367;
        Sat, 13 Jun 2009 13:21:51 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id m28sm3265682waf.37.2009.06.13.13.21.49
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 13:21:50 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 13 Jun 2009 13:21:47 -0700
X-Mailer: git-send-email 1.6.3.2.225.gb8364
In-Reply-To: <1244924500-27391-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121522>

This is useful for scripts using rebase. Instead of redirecting to
/dev/null, the script writers can just use -q

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-rebase.txt |    4 +++
 git-rebase.sh                |   49 ++++++++++++++++++++++++++++++++---------
 t/t3400-rebase.sh            |    7 ++++++
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 26f3b7b..db1b71d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -236,6 +236,10 @@ OPTIONS
 	is used instead ('git-merge-recursive' when merging a single
 	head, 'git-merge-octopus' otherwise).  This implies --merge.
 
+-q::
+--quiet::
+	Be quiet. Implies --no-stat.
+
 -v::
 --verbose::
 	Be verbose. Implies --stat.
diff --git a/git-rebase.sh b/git-rebase.sh
index b83fd3f..9a39f0f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--onto <newbase>] [<upstream>|--root] [<branch>]'
+USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -46,11 +46,20 @@ do_merge=
 dotest="$GIT_DIR"/rebase-merge
 prec=4
 verbose=
+quiet=
 diffstat=$(git config --bool rebase.stat)
 git_am_opt=
 rebase_root=
 force_rebase=
 
+say ()
+{
+    if test -z "$quiet"
+    then
+	echo $@
+    fi
+}
+
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
 	test -d "$dotest" || die "$dotest directory does not exist"
@@ -72,9 +81,15 @@ continue_merge () {
 			echo "directly, but instead do one of the following: "
 			die "$RESOLVEMSG"
 		fi
-		printf "Committed: %0${prec}d " $msgnum
+		if test -z "$quiet"
+		then
+			printf "Committed: %0${prec}d " $msgnum
+		fi
 	else
-		printf "Already applied: %0${prec}d " $msgnum
+		if test -z "$quiet"
+		then
+			printf "Already applied: %0${prec}d " $msgnum
+		fi
 	fi
 	git rev-list --pretty=oneline -1 "$cmt" | sed -e 's/^[^ ]* //'
 
@@ -138,7 +153,7 @@ move_to_original_branch () {
 finish_rb_merge () {
 	move_to_original_branch
 	rm -r "$dotest"
-	echo "All done."
+	say "All done."
 }
 
 is_interactive () {
@@ -221,7 +236,7 @@ do
 		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
 		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
 		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
-		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
+		git am --resolved $quiet --3way --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
@@ -249,7 +264,7 @@ do
 		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
 		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
 		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
-		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
+		git am -3 --skip $quiet --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
@@ -300,6 +315,12 @@ do
 	-v|--verbose)
 		verbose=t
 		diffstat=t
+		quiet=
+		;;
+	-q|--quiet)
+		quiet="-q"
+		verbose=
+		diffstat=
 		;;
 	--whitespace=*)
 		git_am_opt="$git_am_opt $1"
@@ -445,15 +466,18 @@ then
 	then
 		# Lazily switch to the target branch if needed...
 		test -z "$switch_to" || git checkout "$switch_to"
-		echo >&2 "Current branch $branch_name is up to date."
+		if test -z "$quiet"
+		then
+			echo >&2 "Current branch $branch_name is up to date."
+		fi
 		exit 0
 	else
-		echo "Current branch $branch_name is up to date, rebase forced."
+		say "Current branch $branch_name is up to date, rebase forced."
 	fi
 fi
 
 # Detach HEAD and reset the tree
-echo "First, rewinding head to replay your work on top of it..."
+say "First, rewinding head to replay your work on top of it..."
 git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $branch
 
@@ -471,7 +495,10 @@ fi
 # we just fast forwarded.
 if test "$mb" = "$branch"
 then
-	echo >&2 "Fast-forwarded $branch_name to $onto_name."
+	if test -z "$quiet"
+	then
+		echo >&2 "Fast-forwarded $branch_name to $onto_name."
+	fi
 	move_to_original_branch
 	exit 0
 fi
@@ -487,7 +514,7 @@ if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
 		$root_flag "$revisions" |
-	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
+	git am $git_am_opt $quiet --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
 	test 0 != $ret -a -d "$GIT_DIR"/rebase-apply &&
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 7f62bfb..9456b2f 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -126,4 +126,11 @@ test_expect_success 'Show verbose error when HEAD could not be detached' '
      grep "Untracked working tree file .B. would be overwritten" output.err
 '
 
+test_expect_success 'rebase -q is quiet' '
+    rm B &&
+    git checkout -b quiet topic &&
+    git rebase -q master > output.out &&
+    test ! -s output.out
+'
+
 test_done
-- 
1.6.3.2.225.gb8364
