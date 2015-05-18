From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 2/2] pull: use git-rev-parse --parseopt for option parsing
Date: Mon, 18 May 2015 21:54:56 +0800
Message-ID: <1431957296-31534-3-git-send-email-pyokagan@gmail.com>
References: <1431957296-31534-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:55:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLVo-0002kN-EO
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbbERNzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:55:15 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34102 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbbERNzM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:55:12 -0400
Received: by pabru16 with SMTP id ru16so153494832pab.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AMI7OY01sB8xNZyf4Gssj8lPIAjo2v2u98NJ6GgRMTc=;
        b=et7BRXANpdyxOmtXvNPtPKP/DPGfWY05YUcLETI9mWSDwLQUbHhIdRIAuQ8KhPjHHG
         0+Uxo+I0LPTnUWjKK8qFcKzbV2nnpfk+6AMnkD+H3QTl/3g+hC3JByCCHnBOSE21Gzie
         mjD4QzfgzYG3doLTcWoJHdLQkrsF6alE/ewrEjQdVjJvzyZ3mNbJzMtujEIj7GM42oBa
         WHPBX81gR2eSmS1GqlOqJyZCewIhIkgsbxwPYD9vW7sBonn83rQH6LfiQAy3ugZwy9NE
         wpda7XcolYeJmn/A7nuTzZXnR2lCdzb1Onw+6xKKNVyFEZFjebm4QdswjcUb8SAAPJyK
         pOAA==
X-Received: by 10.68.68.142 with SMTP id w14mr17234811pbt.95.1431957312370;
        Mon, 18 May 2015 06:55:12 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id v2sm10185365pdn.90.2015.05.18.06.55.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:55:11 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431957296-31534-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269250>

To enable unambiguous parsing of abbreviated options, bundled short
options, separate form options and to provide consistent usage help, use
git-rev-parse --parseopt for option parsing. This allows the option parsing
code to be simplified.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-pull.sh | 109 ++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 40 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 633c385..67f825c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,13 +4,53 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEAD.
 
-USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff|--ff-only] [--[no-]rebase|--rebase=preserve] [-s strategy]... [<fetch-options>] <repo> <head>...'
-LONG_USAGE='Fetch one or more remote refs and integrate it/them with the current HEAD.'
 SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
+OPTIONS_KEEPDASHDASH=Yes
+OPTIONS_STUCKLONG=Yes
+OPTIONS_SPEC="\
+git pull [options] [<repo> [<refspec>...]]
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
 
@@ -83,17 +123,17 @@ do
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
@@ -101,39 +141,25 @@ do
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
+	--no-strategy)
+		strategy_args=
+		;;
+	-X*|--strategy-option=*)
+		merge_args="$merge_args $(git rev-parse --sq-quote "$1")"
+		;;
+	--no-strategy-option)
+		merge_args=
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
@@ -160,9 +186,15 @@ do
 	-S*)
 		gpg_sign_args=$(git rev-parse --sq-quote "$1")
 		;;
-	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
+	--no-gpg-sign)
+		gpg_sign_args=--no-gpg-sign
+		;;
+	--dry-run)
 		dry_run=--dry-run
 		;;
+	--no-dry-run)
+		dry_run=
+		;;
 	--all|--no-all)
 		all=$1 ;;
 	-a|--append|--no-append)
@@ -192,11 +224,8 @@ do
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
