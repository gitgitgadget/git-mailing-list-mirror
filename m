Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 16136 invoked by uid 111); 2 Nov 2007 15:09:40 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 Nov 2007 11:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbXKBPJ3 (ORCPT <rfc822;peff@peff.net>);
	Fri, 2 Nov 2007 11:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbXKBPJ2
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:09:28 -0400
Received: from pan.madism.org ([88.191.52.104]:50886 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754169AbXKBPJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:09:25 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7FB3528146;
	Fri,  2 Nov 2007 16:09:23 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 91D80347A57; Fri,  2 Nov 2007 16:09:22 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com, torvalds@linux-foundation.org
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Migrate git-clean.sh to use git-parseoptions(1)
Date:	Fri,  2 Nov 2007 16:09:21 +0100
Message-Id: <1194016162-23599-4-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1458.g2aa13-dirty
In-Reply-To: <1194016162-23599-3-git-send-email-madcoder@debian.org>
References: alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org
 <1194016162-23599-1-git-send-email-madcoder@debian.org>
 <1194016162-23599-2-git-send-email-madcoder@debian.org>
 <1194016162-23599-3-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

Also minor consistency tweaks in how errors are caught.
---

    This patch is a pretty good example of the fact that git-parseopt(1)
    is not very disruptive to the general coding style thanks to
    git-sh-setup.

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
1.5.3.5.1458.g2aa13-dirty

