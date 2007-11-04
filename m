Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 16564 invoked by uid 111); 4 Nov 2007 10:31:31 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 Nov 2007 05:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647AbXKDKbS (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Nov 2007 05:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755498AbXKDKbP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 05:31:15 -0500
Received: from pan.madism.org ([88.191.52.104]:42926 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755647AbXKDKbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 05:31:05 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id DEBCF28611;
	Sun,  4 Nov 2007 11:31:03 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7F0B23C887; Sun,  4 Nov 2007 11:31:02 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 06/10] Migrate git-merge.sh to use git-rev-parse --parseopt
Date:	Sun,  4 Nov 2007 11:30:58 +0100
Message-Id: <1194172262-1563-7-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1498.g0c64
In-Reply-To: <1194172262-1563-6-git-send-email-madcoder@debian.org>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org>
 <1194172262-1563-2-git-send-email-madcoder@debian.org>
 <1194172262-1563-3-git-send-email-madcoder@debian.org>
 <1194172262-1563-4-git-send-email-madcoder@debian.org>
 <1194172262-1563-5-git-send-email-madcoder@debian.org>
 <1194172262-1563-6-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-merge.sh |  125 ++++++++++++++++++++++++---------------------------------
 1 files changed, 53 insertions(+), 72 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index b9f0519..d19bfc2 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -3,7 +3,18 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n] [--summary] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-s <strategy>] [-m=<merge-message>] <commit>+'
+OPTIONS_SPEC="\
+git-merge [options] <remote>...
+git-merge [options] <msg> HEAD <remote>
+--
+summary              show a diffstat at the end of the merge
+n,no-summary         don't show a diffstat at the end of the merge
+squash               create a single commit instead of doing a merge
+commit               perform a commit if the merge sucesses (default)
+ff                   allow fast forward (default)
+s,strategy=          merge strategy to use
+m,message=           message to be used for the merge commit (if any)
+"
 
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -132,72 +143,47 @@ merge_name () {
 	fi
 }
 
-parse_option () {
-	case "$1" in
-	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
-		--no-summa|--no-summar|--no-summary)
-		show_diffstat=false ;;
-	--summary)
-		show_diffstat=t ;;
-	--sq|--squ|--squa|--squas|--squash)
-		allow_fast_forward=t squash=t no_commit=t ;;
-	--no-sq|--no-squ|--no-squa|--no-squas|--no-squash)
-		allow_fast_forward=t squash= no_commit= ;;
-	--c|--co|--com|--comm|--commi|--commit)
-		allow_fast_forward=t squash= no_commit= ;;
-	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
-		allow_fast_forward=t squash= no_commit=t ;;
-	--ff)
-		allow_fast_forward=t squash= no_commit= ;;
-	--no-ff)
-		allow_fast_forward=false squash= no_commit= ;;
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
-		case " $all_strategies " in
-		*" $strategy "*)
-			use_strategies="$use_strategies$strategy " ;;
-		*)
-			die "available strategies are: $all_strategies" ;;
-		esac
-		;;
-	-m=*|--m=*|--me=*|--mes=*|--mess=*|--messa=*|--messag=*|--message=*)
-		merge_msg=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-		have_message=t
-		;;
-	-m|--m|--me|--mes|--mess|--messa|--messag|--message)
-		shift
-		case "$#" in
-		1)	usage ;;
-		esac
-		merge_msg="$1"
-		have_message=t
-		;;
-	-*)	usage ;;
-	*)	return 1 ;;
-	esac
-	shift
-	args_left=$#
-}
-
 parse_config () {
-	while test $# -gt 0
-	do
-		parse_option "$@" || usage
-		while test $args_left -lt $#
-		do
+	while test $# != 0; do
+		case "$1" in
+		-n|--no-summary)
+			show_diffstat=false ;;
+		--summary)
+			show_diffstat=t ;;
+		--squash)
+			allow_fast_forward=t squash=t no_commit=t ;;
+		--no-squash)
+			allow_fast_forward=t squash= no_commit= ;;
+		--commit)
+			allow_fast_forward=t squash= no_commit= ;;
+		--no-commit)
+			allow_fast_forward=t squash= no_commit=t ;;
+		--ff)
+			allow_fast_forward=t squash= no_commit= ;;
+		--no-ff)
+			allow_fast_forward=false squash= no_commit= ;;
+		-s|--strategy)
+			shift
+			case " $all_strategies " in
+			*" $1 "*)
+				use_strategies="$use_strategies$1 " ;;
+			*)
+				die "available strategies are: $all_strategies" ;;
+			esac
+			;;
+		-m|--message)
 			shift
-		done
+			merge_msg="$1"
+			have_message=t
+			;;
+		--)
+			shift
+			break ;;
+		*)	usage ;;
+		esac
+		shift
 	done
+	args_left=$#
 }
 
 test $# != 0 || usage
@@ -209,17 +195,12 @@ then
 	mergeopts=$(git config "branch.${branch#refs/heads/}.mergeoptions")
 	if test -n "$mergeopts"
 	then
-		parse_config $mergeopts
+		parse_config $mergeopts --
 	fi
 fi
 
-while parse_option "$@"
-do
-	while test $args_left -lt $#
-	do
-		shift
-	done
-done
+parse_config "$@"
+while test $args_left -lt $#; do shift; done
 
 if test -z "$show_diffstat"; then
     test "$(git config --bool merge.diffstat)" = false && show_diffstat=false
-- 
1.5.3.5.1509.g66d41

