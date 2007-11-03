Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 3350 invoked by uid 111); 3 Nov 2007 17:50:52 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 03 Nov 2007 13:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbXKCRua (ORCPT <rfc822;peff@peff.net>);
	Sat, 3 Nov 2007 13:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754929AbXKCRu3
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 13:50:29 -0400
Received: from pan.madism.org ([88.191.52.104]:52560 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754863AbXKCRuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 13:50:21 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 507F628490;
	Sat,  3 Nov 2007 18:50:20 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 86B3916F95; Sat,  3 Nov 2007 18:50:19 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 9/5] Migrate git-checkout.sh to use git-rev-parse --parseopt --keep-dashdash
Date:	Sat,  3 Nov 2007 18:50:18 +0100
Message-Id: <1194112219-19968-4-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1496.gcb1d6-dirty
In-Reply-To: <1194112219-19968-3-git-send-email-madcoder@debian.org>
References: <1194043193-29601-5-git-send-email-madcoder@debian.org>
 <1194112219-19968-1-git-send-email-madcoder@debian.org>
 <1194112219-19968-2-git-send-email-madcoder@debian.org>
 <1194112219-19968-3-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

Also fix some space versus tabs issues.
---
 git-checkout.sh |   99 +++++++++++++++++++++++++++----------------------------
 1 files changed, 49 insertions(+), 50 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 8993920..5424745 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -1,6 +1,16 @@
 #!/bin/sh
 
-USAGE='[-q] [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
+PARSEOPT_OPTS=--keep-dashdash
+OPTIONS_SPEC="\
+git-branch [options] [<branch>] [<paths>...]
+--
+b=          create a new branch started at <branch>
+l           create the new branchs reflog
+track       tells if the new branch should track the remote branch
+f           proceed even if the index or working tree is not HEAD
+m           performa  three-way merge on local modifications if needed
+q,quiet     be quiet
+"
 SUBDIRECTORY_OK=Sometimes
 . git-sh-setup
 require_work_tree
@@ -20,13 +30,12 @@ quiet=
 v=-v
 LF='
 '
-while [ "$#" != "0" ]; do
-    arg="$1"
-    shift
-    case "$arg" in
-	"-b")
-		newbranch="$1"
+
+while test $# != 0; do
+	case "$1" in
+	-b)
 		shift
+		newbranch="$1"
 		[ -z "$newbranch" ] &&
 			die "git checkout: -b needs a branch name"
 		git show-ref --verify --quiet -- "refs/heads/$newbranch" &&
@@ -34,64 +43,54 @@ while [ "$#" != "0" ]; do
 		git check-ref-format "heads/$newbranch" ||
 			die "git checkout: we do not like '$newbranch' as a branch name."
 		;;
-	"-l")
+	-l)
 		newbranch_log=-l
 		;;
-	"--track"|"--no-track")
-		track="$arg"
+	--track|--no-track)
+		track="$1"
 		;;
-	"-f")
+	-f)
 		force=1
 		;;
 	-m)
 		merge=1
 		;;
-	"-q")
+	-q|--quiet)
 		quiet=1
 		v=
 		;;
 	--)
+		shift
 		break
 		;;
-	-*)
-		usage
-		;;
 	*)
-		if rev=$(git rev-parse --verify "$arg^0" 2>/dev/null)
-		then
-			if [ -z "$rev" ]; then
-				echo "unknown flag $arg"
-				exit 1
-			fi
-			new_name="$arg"
-			if git show-ref --verify --quiet -- "refs/heads/$arg"
-			then
-				rev=$(git rev-parse --verify "refs/heads/$arg^0")
-				branch="$arg"
-			fi
-			new="$rev"
-		elif rev=$(git rev-parse --verify "$arg^{tree}" 2>/dev/null)
-		then
-			# checking out selected paths from a tree-ish.
-			new="$rev"
-			new_name="$arg^{tree}"
-			branch=
-		else
-			new=
-			new_name=
-			branch=
-			set x "$arg" "$@"
-			shift
-		fi
-		case "$1" in
-		--)
-			shift ;;
-		esac
-		break
+		usage
 		;;
-    esac
+	esac
+	shift
 done
 
+arg="$1"
+if rev=$(git rev-parse --verify "$arg^0" 2>/dev/null)
+then
+	[ -z "$rev" ] && die "unknown flag $arg"
+	new_name="$arg"
+	if git show-ref --verify --quiet -- "refs/heads/$arg"
+	then
+		rev=$(git rev-parse --verify "refs/heads/$arg^0")
+		branch="$arg"
+	fi
+	new="$rev"
+	shift
+elif rev=$(git rev-parse --verify "$arg^{tree}" 2>/dev/null)
+then
+	# checking out selected paths from a tree-ish.
+	new="$rev"
+	new_name="$arg^{tree}"
+	shift
+fi
+[ "$1" = "--" ] && shift
+
 case "$newbranch,$track" in
 ,--*)
 	die "git checkout: --track and --no-track require -b"
@@ -138,8 +137,8 @@ Did you intend to checkout '$@' which can not be resolved as commit?"
 	git ls-files -- "$@" |
 	git checkout-index -f -u --stdin
 
-        # Run a post-checkout hook -- the HEAD does not change so the
-        # current HEAD is passed in for both args
+	# Run a post-checkout hook -- the HEAD does not change so the
+	# current HEAD is passed in for both args
 	if test -x "$GIT_DIR"/hooks/post-checkout; then
 	    "$GIT_DIR"/hooks/post-checkout $old $old 0
 	fi
@@ -294,5 +293,5 @@ fi
 
 # Run a post-checkout hook
 if test -x "$GIT_DIR"/hooks/post-checkout; then
-        "$GIT_DIR"/hooks/post-checkout $old $new 1
+	"$GIT_DIR"/hooks/post-checkout $old $new 1
 fi
-- 
1.5.3.5.1496.gcb1d6-dirty

