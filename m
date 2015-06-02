From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 2/2] pull: use git-rev-parse --parseopt for option parsing
Date: Tue,  2 Jun 2015 22:22:53 +0800
Message-ID: <1433254973-13797-3-git-send-email-pyokagan@gmail.com>
References: <1433254973-13797-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 16:23:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzn63-0000WS-Ae
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 16:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759182AbbFBOXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 10:23:12 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35302 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759199AbbFBOXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 10:23:07 -0400
Received: by padjw17 with SMTP id jw17so62121985pad.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pNRcDdVk80ZgJRJl4GHxB/uxOk/Ko2fxiT8LbSXhGhg=;
        b=gnb/zvk9Q65kCWuP4MoNhO/Ipy3xeL34YMqYcIrcxizuWLmapkJ0QRskeWG7wfGzOr
         f5vA30XyRriuQ5mApbSaNaVspngXehneYTBbP1qM273lHbEZeQ7VuXBmO7IUSFDJLW8p
         +NGignYKe+GH+uDJugAhL+MXMUgQDY3xyWufKw9Jrxq+W4/poUs0vaXY5swkC7gDG8DM
         lR+NMULa2aKIR2AD0KHesligAda0Ku2kOFgKZym6MaPqsk8T+L+f/nQIibddi/uNipQL
         BYJFeTatOP20UCNzMY4o4iB+9YUZKbqVlTlh9K8iS5HlrDceSOcjYBUFu8/vdLr4ZMTx
         sCJg==
X-Received: by 10.66.153.173 with SMTP id vh13mr50456621pab.130.1433254986341;
        Tue, 02 Jun 2015 07:23:06 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id fd3sm5329786pac.39.2015.06.02.07.23.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 07:23:05 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433254973-13797-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270544>

To enable unambiguous parsing of abbreviated options, bundled short
options, separate form options and to provide consistent usage help, use
git-rev-parse --parseopt for option parsing. With this, simplify the
option parsing code.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Don't use OPTIONS_KEEPDASHDASH

 git-pull.sh | 97 ++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 57 insertions(+), 40 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 623ba7a..a814bf6 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,13 +4,53 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEAD.
 
-USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff|--ff-only] [--[no-]rebase|--rebase=preserve] [-s strategy]... [<fetch-options>] <repo> <head>...'
-LONG_USAGE='Fetch one or more remote refs and integrate it/them with the current HEAD.'
 SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
+OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=Yes
+OPTIONS_SPEC="\
+git pull [options] [<repository> [<refspec>...]]
+
+Fetch one or more remote refs and integrate it/them with the current HEAD.
+--
+v,verbose                  be more verbose
+q,quiet                    be more quiet
+progress                   force progress reporting
+
+  Options related to merging
+r,rebase?false|true|preserve incorporate changes by rebasing rather than merging
+n!                         do not show a diffstat at the end of the merge
+stat                       show a diffstat at the end of the merge
+summary                    (synonym to --stat)
+log?n                      add (at most <n>) entries from shortlog to merge commit message
+squash                     create a single commit instead of doing a merge
+commit                     perform a commit if the merge succeeds (default)
+e,edit                       edit message before committing
+ff                         allow fast-forward
+ff-only!                   abort if fast-forward is not possible
+verify-signatures          verify that the named commit has a valid GPG signature
+s,strategy=strategy        merge strategy to use
+X,strategy-option=option   option for selected merge strategy
+S,gpg-sign?key-id          GPG sign commit
+
+  Options related to fetching
+all                        fetch from all remotes
+a,append                   append to .git/FETCH_HEAD instead of overwriting
+upload-pack=path           path to upload pack on remote end
+f,force                    force overwrite of local branch
+t,tags                     fetch all tags and associated objects
+p,prune                    prune remote-tracking branches no longer on remote
+recurse-submodules?on-demand control recursive fetching of submodules
+dry-run                    dry run
+k,keep                     keep downloaded pack
+depth=depth                deepen history of shallow clone
+unshallow                  convert to a complete repository
+update-shallow             accept refs that update .git/shallow
+refmap=refmap              specify fetch refmap
+"
+test $# -gt 0 && args="$*"
 . git-sh-setup
 . git-sh-i18n
-set_reflog_action "pull${1+ $*}"
+set_reflog_action "pull${args+ $args}"
 require_work_tree_exists
 cd_to_toplevel
 
@@ -87,17 +127,17 @@ do
 		diffstat=--stat ;;
 	--log|--log=*|--no-log)
 		log_arg="$1" ;;
-	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
+	--no-commit)
 		no_commit=--no-commit ;;
-	--c|--co|--com|--comm|--commi|--commit)
+	--commit)
 		no_commit=--commit ;;
 	-e|--edit)
 		edit=--edit ;;
 	--no-edit)
 		edit=--no-edit ;;
-	--sq|--squ|--squa|--squas|--squash)
+	--squash)
 		squash=--squash ;;
-	--no-sq|--no-squ|--no-squa|--no-squas|--no-squash)
+	--no-squash)
 		squash=--no-squash ;;
 	--ff)
 		no_ff=--ff ;;
@@ -105,39 +145,19 @@ do
 		no_ff=--no-ff ;;
 	--ff-only)
 		ff_only=--ff-only ;;
-	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
-		--strateg=*|--strategy=*|\
-	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
-		case "$#,$1" in
-		*,*=*)
-			strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
-		1,*)
-			usage ;;
-		*)
-			strategy="$2"
-			shift ;;
-		esac
-		strategy_args="${strategy_args}-s $strategy "
+	-s*|--strategy=*)
+		strategy_args="$strategy_args $1"
 		;;
-	-X*)
-		case "$#,$1" in
-		1,-X)
-			usage ;;
-		*,-X)
-			xx="-X $(git rev-parse --sq-quote "$2")"
-			shift ;;
-		*,*)
-			xx=$(git rev-parse --sq-quote "$1") ;;
-		esac
-		merge_args="$merge_args$xx "
+	-X*|--strategy-option=*)
+		merge_args="$merge_args $(git rev-parse --sq-quote "$1")"
 		;;
-	-r=*|--r=*|--re=*|--reb=*|--reba=*|--rebas=*|--rebase=*)
+	-r*|--rebase=*)
 		rebase="${1#*=}"
 		;;
-	-r|--r|--re|--reb|--reba|--rebas|--rebase)
+	--rebase)
 		rebase=true
 		;;
-	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
+	--no-rebase)
 		rebase=false
 		;;
 	--recurse-submodules)
@@ -164,7 +184,7 @@ do
 	-S*)
 		gpg_sign_args=$(git rev-parse --sq-quote "$1")
 		;;
-	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
+	--dry-run)
 		dry_run=--dry-run
 		;;
 	--all|--no-all)
@@ -196,11 +216,8 @@ do
 		shift
 		break
 		;;
-	-*)
-		usage
-		;;
 	*)
-		break
+		usage
 		;;
 	esac
 	shift
-- 
2.1.4
