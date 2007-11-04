Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 16603 invoked by uid 111); 4 Nov 2007 10:31:43 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 Nov 2007 05:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbXKDKbX (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Nov 2007 05:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755750AbXKDKbW
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 05:31:22 -0500
Received: from pan.madism.org ([88.191.52.104]:42929 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755751AbXKDKbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 05:31:05 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1DF2428615;
	Sun,  4 Nov 2007 11:31:04 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 97B791FED2; Sun,  4 Nov 2007 11:31:02 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 10/10] Migrate git-repack.sh to use git-rev-parse --parseopt
Date:	Sun,  4 Nov 2007 11:31:02 +0100
Message-Id: <1194172262-1563-11-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1498.g0c64
In-Reply-To: <1194172262-1563-10-git-send-email-madcoder@debian.org>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org>
 <1194172262-1563-2-git-send-email-madcoder@debian.org>
 <1194172262-1563-3-git-send-email-madcoder@debian.org>
 <1194172262-1563-4-git-send-email-madcoder@debian.org>
 <1194172262-1563-5-git-send-email-madcoder@debian.org>
 <1194172262-1563-6-git-send-email-madcoder@debian.org>
 <1194172262-1563-7-git-send-email-madcoder@debian.org>
 <1194172262-1563-8-git-send-email-madcoder@debian.org>
 <1194172262-1563-9-git-send-email-madcoder@debian.org>
 <1194172262-1563-10-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

---
 git-repack.sh |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 7220635..4d4840e 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -3,7 +3,21 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
-USAGE='[-a|-A] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--window-memory=N] [--depth=N]'
+OPTIONS_SPEC="\
+git-repack [options]
+--
+a               pack everything in a single pack
+A               same as -a, and keep unreachable objects too
+d               remove redundant packs, and run git-prune-packed
+f               pass --no-reuse-delta to git-pack-objects
+q,quiet         be quiet
+l               pass --local to git-pack-objects
+ Packing constraints
+window=         size of the window used for delta compression
+window-memory=  same as the above, but limit memory size instead of entries count
+depth=          limits the maximum delta depth
+max-pack-size=  maximum size of each packfile
+"
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
@@ -20,10 +34,9 @@ do
 	-q)	quiet=-q ;;
 	-f)	no_reuse=--no-reuse-object ;;
 	-l)	local=--local ;;
-	--max-pack-size=*) extra="$extra $1" ;;
-	--window=*) extra="$extra $1" ;;
-	--window-memory=*) extra="$extra $1" ;;
-	--depth=*) extra="$extra $1" ;;
+	--max-pack-size|--window|--window-memory|--depth)
+		extra="$extra $1=$2"; shift ;;
+	--) shift; break;;
 	*)	usage ;;
 	esac
 	shift
-- 
1.5.3.5.1509.g66d41

