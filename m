Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 18696 invoked by uid 111); 2 Nov 2007 22:40:13 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 Nov 2007 18:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189AbXKBWkB (ORCPT <rfc822;peff@peff.net>);
	Fri, 2 Nov 2007 18:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbXKBWkB
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 18:40:01 -0400
Received: from pan.madism.org ([88.191.52.104]:45437 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754394AbXKBWjz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 18:39:55 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 402AC282CC;
	Fri,  2 Nov 2007 23:39:54 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 289FF94E0; Fri,  2 Nov 2007 23:39:53 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com, torvalds@linux-foundation.org
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 4/5] Migrate git-clone to use git-rev-parse --parseopt
Date:	Fri,  2 Nov 2007 23:39:51 +0100
Message-Id: <1194043193-29601-5-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1460.gdb47
In-Reply-To: <1194043193-29601-4-git-send-email-madcoder@debian.org>
References: alpine.LFD.0.999.0711020844310.3342@woody.linux-foundation.org
 <1194043193-29601-1-git-send-email-madcoder@debian.org>
 <1194043193-29601-2-git-send-email-madcoder@debian.org>
 <1194043193-29601-3-git-send-email-madcoder@debian.org>
 <1194043193-29601-4-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-clone.sh |  102 +++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 0ea3c24..8680a7c 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -8,15 +8,36 @@
 # See git-sh-setup why.
 unset CDPATH
 
+OPTIONS_SPEC="\
+git-clone [options] <repo> [<dir>]
+--
+n,no-checkout        don't create a checkout
+bare                 create a bare repository
+naked                create a bare repository
+l,local              to clone from a local repository
+no-hardlinks         don't use local hardlinks, always copy
+s,shared             setup as a shared repository
+template=            path to the template directory
+q,quiet              be quiet
+reference=           reference repository
+o,origin=            use <name> instead of 'origin' to track upstream
+u,upload-pack=       path to git-upload-pack on the remote
+depth=               create a shallow clone of that depth
+
+use-separate-remote  compatibility, do not use
+no-separate-remote   compatibility, do not use"
+
 die() {
 	echo >&2 "$@"
 	exit 1
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] <repo> [<dir>]"
+	exec "$0" -h
 }
 
+eval `echo "$OPTIONS_SPEC" | git rev-parse --parseopt $PARSEOPT_OPTS -- "$@" || echo exit $?`
+
 get_repo_base() {
 	(
 		cd "`/bin/pwd`" &&
@@ -106,64 +127,57 @@ depth=
 no_progress=
 local_explicitly_asked_for=
 test -t 1 || no_progress=--no-progress
-while
-	case "$#,$1" in
-	0,*) break ;;
-	*,-n|*,--no|*,--no-|*,--no-c|*,--no-ch|*,--no-che|*,--no-chec|\
-	*,--no-check|*,--no-checko|*,--no-checkou|*,--no-checkout)
-	  no_checkout=yes ;;
-	*,--na|*,--nak|*,--nake|*,--naked|\
-	*,-b|*,--b|*,--ba|*,--bar|*,--bare) bare=yes ;;
-	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local)
-	  local_explicitly_asked_for=yes
-	  use_local_hardlink=yes ;;
-	*,--no-h|*,--no-ha|*,--no-har|*,--no-hard|*,--no-hardl|\
-	*,--no-hardli|*,--no-hardlin|*,--no-hardlink|*,--no-hardlinks)
-	  use_local_hardlink=no ;;
-        *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared)
-          local_shared=yes; ;;
-	1,--template) usage ;;
-	*,--template)
+
+while test $# != 0
+do
+	case "$1" in
+	-n|--no-checkout)
+		no_checkout=yes ;;
+	--naked|--bare)
+		bare=yes ;;
+	-l|--local)
+		local_explicitly_asked_for=yes
+		use_local_hardlink=yes
+		;;
+	--no-hardlinks)
+		use_local_hardlink=no ;;
+	-s|--shared)
+		local_shared=yes ;;
+	--template)
 		shift; template="--template=$1" ;;
-	*,--template=*)
-	  template="$1" ;;
-	*,-q|*,--quiet) quiet=-q ;;
-	*,--use-separate-remote) ;;
-	*,--no-separate-remote)
+	-q|--quiet)
+		quiet=-q ;;
+	--use-separate-remote|--no-separate-remote)
 		die "clones are always made with separate-remote layout" ;;
-	1,--reference) usage ;;
-	*,--reference)
+	--reference)
 		shift; reference="$1" ;;
-	*,--reference=*)
-		reference=`expr "z$1" : 'z--reference=\(.*\)'` ;;
-	*,-o|*,--or|*,--ori|*,--orig|*,--origi|*,--origin)
-		case "$2" in
+	-o,--origin)
+		shift;
+		case "$1" in
 		'')
 		    usage ;;
 		*/*)
-		    die "'$2' is not suitable for an origin name"
+		    die "'$1' is not suitable for an origin name"
 		esac
-		git check-ref-format "heads/$2" ||
-		    die "'$2' is not suitable for a branch name"
+		git check-ref-format "heads/$1" ||
+		    die "'$1' is not suitable for a branch name"
 		test -z "$origin_override" ||
 		    die "Do not give more than one --origin options."
 		origin_override=yes
-		origin="$2"; shift
+		origin="$1"
 		;;
-	1,-u|1,--upload-pack) usage ;;
-	*,-u|*,--upload-pack)
+	-u|--upload-pack)
 		shift
 		upload_pack="--upload-pack=$1" ;;
-	*,--upload-pack=*)
-		upload_pack=--upload-pack=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
-	1,--depth) usage;;
-	*,--depth)
+	--depth)
+		shift
+		depth="--depth=$1" ;;
+	--)
 		shift
-		depth="--depth=$1";;
-	*,-*) usage ;;
-	*) break ;;
+		break ;;
+	*)
+		usage ;;
 	esac
-do
 	shift
 done
 
-- 
1.5.3.5.1460.gdb47

