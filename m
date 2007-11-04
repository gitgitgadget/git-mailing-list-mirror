Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 16577 invoked by uid 111); 4 Nov 2007 10:31:34 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 Nov 2007 05:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868AbXKDKbT (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Nov 2007 05:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755575AbXKDKbS
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 05:31:18 -0500
Received: from pan.madism.org ([88.191.52.104]:42925 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755592AbXKDKbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 05:31:05 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id DD05B28610;
	Sun,  4 Nov 2007 11:31:03 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7A7A62003F; Sun,  4 Nov 2007 11:31:02 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 05/10] Migrate git-am.sh to use git-rev-parse --parseopt
Date:	Sun,  4 Nov 2007 11:30:57 +0100
Message-Id: <1194172262-1563-6-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1498.g0c64
In-Reply-To: <1194172262-1563-5-git-send-email-madcoder@debian.org>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org>
 <1194172262-1563-2-git-send-email-madcoder@debian.org>
 <1194172262-1563-3-git-send-email-madcoder@debian.org>
 <1194172262-1563-4-git-send-email-madcoder@debian.org>
 <1194172262-1563-5-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-am.sh |   93 +++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 2514d07..2d2b1c6 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -2,11 +2,25 @@
 #
 # Copyright (c) 2005, 2006 Junio C Hamano
 
-USAGE='[--signoff] [--dotest=<dir>] [--keep] [--utf8 | --no-utf8]
-  [--3way] [--interactive] [--binary]
-  [--whitespace=<option>] [-C<n>] [-p<n>]
-  <mbox>|<Maildir>...
-  or, when resuming [--skip | --resolved]'
+OPTIONS_SPEC="\
+git-am [options] <mbox>|<Maildir>...
+git-am [options] --resolved
+git-am [options] --skip
+--
+d,dotest=       use <dir> and not .dotest
+i,interactive=  run interactively
+b,binary        pass --allo-binary-replacement to git-apply
+3,3way          allow fall back on 3way merging if needed
+s,signoff       add a Signed-off-by line to the commit message
+u,utf8          recode into utf8 (default)
+k,keep          pass -k flagg to git-mailinfo
+whitespace=     pass it through git-apply
+C=              pass it through git-apply
+p=              pass it through git-apply
+resolvemsg=     override error message when patch failure occurs
+r,resolved      to be used after a patch failure
+skip            skip the current patch"
+
 . git-sh-setup
 set_reflog_action am
 require_work_tree
@@ -110,49 +124,38 @@ git_apply_opt=
 while test $# != 0
 do
 	case "$1" in
-	-d=*|--d=*|--do=*|--dot=*|--dote=*|--dotes=*|--dotest=*)
-	dotest=`expr "z$1" : 'z-[^=]*=\(.*\)'`; shift ;;
-	-d|--d|--do|--dot|--dote|--dotes|--dotest)
-	case "$#" in 1) usage ;; esac; shift
-	dotest="$1"; shift;;
-
-	-i|--i|--in|--int|--inte|--inter|--intera|--interac|--interact|\
-	--interacti|--interactiv|--interactive)
-	interactive=t; shift ;;
-
-	-b|--b|--bi|--bin|--bina|--binar|--binary)
-	binary=t; shift ;;
-
-	-3|--3|--3w|--3wa|--3way)
-	threeway=t; shift ;;
-	-s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
-	sign=t; shift ;;
-	-u|--u|--ut|--utf|--utf8)
-	utf8=t; shift ;; # this is now default
-	--no-u|--no-ut|--no-utf|--no-utf8)
-	utf8=; shift ;;
-	-k|--k|--ke|--kee|--keep)
-	keep=t; shift ;;
-
-	-r|--r|--re|--res|--reso|--resol|--resolv|--resolve|--resolved)
-	resolved=t; shift ;;
-
-	--sk|--ski|--skip)
-	skip=t; shift ;;
-
-	--whitespace=*|-C*|-p*)
-	git_apply_opt="$git_apply_opt $1"; shift ;;
-
-	--resolvemsg=*)
-	resolvemsg=${1#--resolvemsg=}; shift ;;
-
+	-i|--interactive)
+		interactive=t ;;
+	-b|--binary)
+		binary=t ;;
+	-3|--3way)
+		threeway=t ;;
+	-s--signoff)
+		sign=t ;;
+	-u|--utf8)
+		utf8=t ;; # this is now default
+	--no-utf8)
+		utf8= ;;
+	-k|--keep)
+		keep=t ;;
+	-r|--resolved)
+		resolved=t ;;
+	--skip)
+		skip=t ;;
+	-d|--dotest)
+		shift; dotest=$1;;
+	--resolvemsg)
+		shift; resolvemsg=$1 ;;
+	--whitespace)
+		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
+	-C|-p)
+		git_apply_opt="$git_apply_opt $1$2"; shift ;;
 	--)
-	shift; break ;;
-	-*)
-	usage ;;
+		shift; break ;;
 	*)
-	break ;;
+		usage ;;
 	esac
+	shift
 done
 
 # If the dotest directory exists, but we have finished applying all the
-- 
1.5.3.5.1509.g66d41

