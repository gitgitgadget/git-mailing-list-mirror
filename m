Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 18683 invoked by uid 111); 2 Nov 2007 22:40:10 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 Nov 2007 18:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026AbXKBWkB (ORCPT <rfc822;peff@peff.net>);
	Fri, 2 Nov 2007 18:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755189AbXKBWj7
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 18:39:59 -0400
Received: from pan.madism.org ([88.191.52.104]:45433 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045AbXKBWjz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 18:39:55 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 300BE282C8;
	Fri,  2 Nov 2007 23:39:54 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 22CEA85DB; Fri,  2 Nov 2007 23:39:53 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com, torvalds@linux-foundation.org
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/5] Migrate git-clean.sh to use git-rev-parse --parseopt.
Date:	Fri,  2 Nov 2007 23:39:50 +0100
Message-Id: <1194043193-29601-4-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1460.gdb47
In-Reply-To: <1194043193-29601-3-git-send-email-madcoder@debian.org>
References: alpine.LFD.0.999.0711020844310.3342@woody.linux-foundation.org
 <1194043193-29601-1-git-send-email-madcoder@debian.org>
 <1194043193-29601-2-git-send-email-madcoder@debian.org>
 <1194043193-29601-3-git-send-email-madcoder@debian.org>
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
1.5.3.5.1460.gdb47

