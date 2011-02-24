From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] rebase: define options in OPTIONS_SPEC
Date: Wed, 23 Feb 2011 22:07:55 -0500
Message-ID: <1298516875-10765-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <4D5BE49D.1040402@viscovery.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 04:08:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsRZ2-0008Er-Sp
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 04:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162Ab1BXDIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 22:08:19 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47801 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071Ab1BXDIS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 22:08:18 -0500
Received: by qyg14 with SMTP id 14so112752qyg.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 19:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=vywJlJjnKM6oR5n/LlQ8b0cwGEquzvyWEWQdOAkwdF8=;
        b=V4GB9XzjYMiBkc3iEfha6EWXcCJbTGl/F1qYdCx2RPAbGMJwoR2tELuewriZa6hbFI
         QpWJ3aD/P/MCsdl7FTs0lfiw0OJR9UJeSBS1fsN7U8aTcCwd2kUiv8HTONj5MlaUuZzU
         cxIUC0OyBEOJT8RFWlHu5OuP15TV4bTLl1dwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xzpIU1t0B1l/5eGkjzBjTZOK/rtcl8J3IsHkvXx0TadxI/xeSaii0h0J2GWRMf3OUw
         5SK2x1KCtYS8bj/wldfD/nSWfRcIIIDLdeYf8Xplp9389AeODfBT2lidR+CDwYoYfMl7
         xS2EHIm8M15gY0fpMjhqdCWrQ+Mp8gUet3WZE=
Received: by 10.224.208.135 with SMTP id gc7mr194295qab.298.1298516896903;
        Wed, 23 Feb 2011 19:08:16 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id q12sm6044117qcu.42.2011.02.23.19.08.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 19:08:15 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.79.gba571.dirty
In-Reply-To: <4D5BE49D.1040402@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167770>

Interactive rebase used to have its own command line processing. Since
it used the 'git rev-parse --parseopt' functionality exposed through
git-sh-setup, it had some flexibility, like matching prefixes of long
options, that non-interactive rebase didn't. When interactive rebase's
command line processing was factored out into git-rebase.sh in cf432ca
(rebase: factor out command line option processing, 2011-02-06), this
flexibility was lost. Give back that flexibility to interactive and
non-interactive.

Also improve the usage message to contain the --continue, --skip and
--abort commands.
---

Applies on top of mz/rebase.

Are USAGE and LONG_USAGE still needed?

I based the definitions on the now-lost OPTIONS_SPEC from interactive
rebase. I added some descriptions that were not too hard to describe
in a concise way. The rest, I simply hid (with the "*" marker). Should
the list be exhaustive?

What is the difference between the "options" and "actions" sections?

 git-rebase.sh |  104 ++++++++++++++++++++++++++++++++------------------------
 1 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index a040ab5..7857059 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -28,7 +28,42 @@ Example:       git-rebase master~1 topic
 '
 
 SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
+git rebase [-i] [options] --onto <newbase> --root [<branch>]
+git-rebase [-i] --continue | --abort | --skip
+--
+ Available options are
+v,verbose          display a diffstat of what changed upstream
+q,quiet            be quiet. implies --no-stat
+onto=              rebase onto given branch instead of upstream
+p,preserve-merges  try to recreate merges instead of ignoring them
+s,strategy=        use the given merge strategy
+no-ff              cherry-pick all commits, even if unchanged
+m,merge            use merging strategies to rebase
+i,interactive      let the user edit the list of commits to rebase
+f,force-rebase*    -
+X,strategy-option= pass the argument through to the merge strategy
+stat*              -
+n,no-stat*         -
+whitespace=*       -
+ignore-whitespace* -
+committer-date-is-author-date* -
+ignore-date*       -
+C=*                -
+rerere-autoupdate* -
+no-rerere-autoupdate* -
+ Actions:
+continue           continue rebasing process
+abort              abort rebasing process and restore original branch
+skip               skip current patch and continue rebasing process
+no-verify          override pre-rebase hook from stopping the operation
+verify             allow pre-rebase hook to run
+root               rebase all reachable commmits up to the root(s)
+autosquash         move commits that begin with squash!/fixup! under -i
+no-autosquash*     -
+"
 . git-sh-setup
 set_reflog_action rebase
 require_work_tree
@@ -175,7 +210,7 @@ do
 		ok_to_skip_pre_rebase=
 		;;
 	--continue|--skip|--abort)
-		test $total_argc -eq 1 || usage
+		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
 	--onto)
@@ -183,10 +218,10 @@ do
 		onto="$2"
 		shift
 		;;
-	-i|--interactive)
+	-i)
 		interactive_rebase=explicit
 		;;
-	-p|--preserve-merges)
+	-p)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
 		;;
@@ -196,62 +231,42 @@ do
 	--no-autosquash)
 		autosquash=
 		;;
-	-M|-m|--m|--me|--mer|--merg|--merge)
+	-M|-m)
 		do_merge=t
 		;;
-	-X*|--strategy-option*)
-		case "$#,$1" in
-		1,-X|1,--strategy-option)
-			usage ;;
-		*,-X|*,--strategy-option)
-			newopt="$2"
-			shift ;;
-		*,--strategy-option=*)
-			newopt="$(expr " $1" : ' --strategy-option=\(.*\)')" ;;
-		*,-X*)
-			newopt="$(expr " $1" : ' -X\(.*\)')" ;;
-		1,*)
-			usage ;;
-		esac
-		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$newopt")"
+	-X)
+		shift
+		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$1")"
 		do_merge=t
 		test -z "$strategy" && strategy=recursive
 		;;
-	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
-		--strateg=*|--strategy=*|\
-	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
-		case "$#,$1" in
-		*,*=*)
-			strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
-		1,*)
-			usage ;;
-		*)
-			strategy="$2"
-			shift ;;
-		esac
+	-s)
+		shift
+		strategy="$1"
 		do_merge=t
 		;;
-	-n|--no-stat)
+	-n)
 		diffstat=
 		;;
 	--stat)
 		diffstat=t
 		;;
-	-v|--verbose)
+	-v)
 		verbose=t
 		diffstat=t
 		GIT_QUIET=
 		;;
-	-q|--quiet)
+	-q)
 		GIT_QUIET=t
 		git_am_opt="$git_am_opt -q"
 		verbose=
 		diffstat=
 		;;
-	--whitespace=*)
-		git_am_opt="$git_am_opt $1"
+	--whitespace)
+		shift
+		git_am_opt="$git_am_opt --whitespace=$1"
 		case "$1" in
-		--whitespace=fix|--whitespace=strip)
+		fix|strip)
 			force_rebase=t
 			;;
 		esac
@@ -263,22 +278,21 @@ do
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
-	-C*)
-		git_am_opt="$git_am_opt $1"
+	-C)
+		shift
+		git_am_opt="$git_am_opt -C$1"
 		;;
 	--root)
 		rebase_root=t
 		;;
-	-f|--f|--fo|--for|--forc|--force|--force-r|--force-re|--force-reb|--force-reba|--force-rebas|--force-rebase|--no-ff)
+	-f|--no-ff)
 		force_rebase=t
 		;;
 	--rerere-autoupdate|--no-rerere-autoupdate)
 		allow_rerere_autoupdate="$1"
 		;;
-	-*)
-		usage
-		;;
-	*)
+	--)
+		shift
 		break
 		;;
 	esac
-- 
1.7.4.1.79.gba571.dirty
