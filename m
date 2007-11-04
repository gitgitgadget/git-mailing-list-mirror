Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 16525 invoked by uid 111); 4 Nov 2007 10:31:19 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 Nov 2007 05:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819AbXKDKbK (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Nov 2007 05:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868AbXKDKbK
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 05:31:10 -0500
Received: from pan.madism.org ([88.191.52.104]:42910 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755350AbXKDKbE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 05:31:04 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7E70B2860E;
	Sun,  4 Nov 2007 11:31:03 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6F3622001E; Sun,  4 Nov 2007 11:31:02 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 03/10] Migrate git-clean.sh to use git-rev-parse --parseopt.
Date:	Sun,  4 Nov 2007 11:30:55 +0100
Message-Id: <1194172262-1563-4-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1498.g0c64
In-Reply-To: <1194172262-1563-3-git-send-email-madcoder@debian.org>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org>
 <1194172262-1563-2-git-send-email-madcoder@debian.org>
 <1194172262-1563-3-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

Also minor consistency tweaks in how errors are caught.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-clean.sh |   38 ++++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/git-clean.sh b/git-clean.sh
index 4491738..6959433 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -3,16 +3,21 @@
 # Copyright (c) 2005-2006 Pavel Roskin
 #
 
-USAGE="[-d] [-f] [-n] [-q] [-x | -X] [--] <paths>..."
-LONG_USAGE='Clean untracked files from the working directory
-	-d	remove directories as well
-	-f	override clean.requireForce and clean anyway
-	-n 	don'\''t remove anything, just show what would be done
-	-q	be quiet, only report errors
-	-x	remove ignored files as well
-	-X	remove only ignored files
+OPTIONS_SPEC="\
+git-clean [options] <paths>...
+
+Clean untracked files from the working directory
+
 When optional <paths>... arguments are given, the paths
-affected are further limited to those that match them.'
+affected are further limited to those that match them.
+--
+d remove directories as well
+f override clean.requireForce and clean anyway
+n don't remove anything, just show what would be done
+q be quiet, only report errors
+x remove ignored files as well
+X remove only ignored files"
+
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
@@ -55,23 +60,20 @@ do
 		shift
 		break
 		;;
-	-*)
-		usage
-		;;
 	*)
-		break
+		usage # should not happen
+		;;
 	esac
 	shift
 done
 
 if [ "$disabled" = true ]; then
-	echo "clean.requireForce set and -n or -f not given; refusing to clean"
-	exit 1
+	die "clean.requireForce set and -n or -f not given; refusing to clean"
 fi
 
-case "$ignored,$ignoredonly" in
-	1,1) usage;;
-esac
+if [ "$ignored,$ignoredonly" = "1,1" ]; then
+	die "-x and -X cannot be set together"
+fi
 
 if [ -z "$ignored" ]; then
 	excl="--exclude-per-directory=.gitignore"
-- 
1.5.3.5.1509.g66d41

