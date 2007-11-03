Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 3310 invoked by uid 111); 3 Nov 2007 17:50:44 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 03 Nov 2007 13:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbXKCRu0 (ORCPT <rfc822;peff@peff.net>);
	Sat, 3 Nov 2007 13:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754870AbXKCRuZ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 13:50:25 -0400
Received: from pan.madism.org ([88.191.52.104]:52559 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754841AbXKCRuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 13:50:21 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 352362848E;
	Sat,  3 Nov 2007 18:50:20 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7FB2716F8C; Sat,  3 Nov 2007 18:50:19 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 8/5] Migrate git-instaweb.sh to use git-rev-parse --parseopt
Date:	Sat,  3 Nov 2007 18:50:17 +0100
Message-Id: <1194112219-19968-3-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1496.gcb1d6-dirty
In-Reply-To: <1194112219-19968-2-git-send-email-madcoder@debian.org>
References: <1194043193-29601-5-git-send-email-madcoder@debian.org>
 <1194112219-19968-1-git-send-email-madcoder@debian.org>
 <1194112219-19968-2-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-instaweb.sh |   73 ++++++++++++++++++++++---------------------------------
 1 files changed, 29 insertions(+), 44 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 95c3e5a..d912bf5 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -2,9 +2,20 @@
 #
 # Copyright (c) 2006 Eric Wong
 #
-USAGE='[--start] [--stop] [--restart]
-  [--local] [--httpd=<httpd>] [--port=<port>] [--browser=<browser>]
-  [--module-path=<path> (for Apache2 only)]'
+
+OPTIONS_SPEC="\
+git-instaweb [options] (--start | --stop | --restart)
+--
+l,local        only bind on 127.0.0.1
+p,port=        the port to bind to
+d,httpd=       the command to launch
+b,browser=     the browser to launch
+m,module-path= the module path (only needed for apache2)
+ Action
+stop           stop the web server
+start          start the web server
+restart        restart the web server
+"
 
 . git-sh-setup
 
@@ -78,52 +89,26 @@ do
 		start_httpd
 		exit 0
 		;;
-	--local|-l)
+	-l|--local)
 		local=true
 		;;
-	-d|--httpd|--httpd=*)
-		case "$#,$1" in
-		*,*=*)
-			httpd=`expr "$1" : '-[^=]*=\(.*\)'` ;;
-		1,*)
-			usage ;;
-		*)
-			httpd="$2"
-			shift ;;
-		esac
+	-d|--httpd)
+		shift
+		httpd="$1"
+		;;
+	-b|--browser)
+		shift
+		browser="$1"
 		;;
-	-b|--browser|--browser=*)
-		case "$#,$1" in
-		*,*=*)
-			browser=`expr "$1" : '-[^=]*=\(.*\)'` ;;
-		1,*)
-			usage ;;
-		*)
-			browser="$2"
-			shift ;;
-		esac
+	-p|--port)
+		shift
+		port="$1"
 		;;
-	-p|--port|--port=*)
-		case "$#,$1" in
-		*,*=*)
-			port=`expr "$1" : '-[^=]*=\(.*\)'` ;;
-		1,*)
-			usage ;;
-		*)
-			port="$2"
-			shift ;;
-		esac
+	-m|--module-path)
+		shift
+		module_path="$1"
 		;;
-	-m|--module-path=*|--module-path)
-		case "$#,$1" in
-		*,*=*)
-			module_path=`expr "$1" : '-[^=]*=\(.*\)'` ;;
-		1,*)
-			usage ;;
-		*)
-			module_path="$2"
-			shift ;;
-		esac
+	--)
 		;;
 	*)
 		usage
-- 
1.5.3.5.1496.gcb1d6-dirty

