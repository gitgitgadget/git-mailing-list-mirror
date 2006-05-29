From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Allow multiple -m options to git-commit.
Date: Mon, 29 May 2006 04:45:49 -0400
Message-ID: <20060529084549.GA29500@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 10:45:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkdNu-0000Uu-IM
	for gcvg-git@gmane.org; Mon, 29 May 2006 10:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWE2Ipy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 04:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWE2Ipy
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 04:45:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44953 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750769AbWE2Ipy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 04:45:54 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FkdNm-00083o-C5; Mon, 29 May 2006 04:45:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4F48020E445; Mon, 29 May 2006 04:45:50 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20935>

I find it very convenient to be able to supply multiple paragraphs
of text on the command line with a single git-commit call.  This
change permits multiple -m/--message type options to be supplied
to git-commit with each message being added as its own paragraph
of text in the commit message.

The -m option is still not permitted with -c/-C/-F nor are multiple
occurrences of these options permitted.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-commit.sh |   37 ++++++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 0a01a0b..a092b72 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -260,20 +260,41 @@ do
   -m|--m|--me|--mes|--mess|--messa|--messag|--message)
       case "$#" in 1) usage ;; esac
       shift
-      log_given=t$log_given
-      log_message="$1"
+      log_given=m$log_given
+      if test "$log_message" = ''
+      then
+          log_message="$1"
+      else
+          log_message="$log_message
+
+$1"
+      fi
       no_edit=t
       shift
       ;;
   -m*)
-      log_given=t$log_given
-      log_message=`expr "$1" : '-m\(.*\)'`
+      log_given=m$log_given
+      if test "$log_message" = ''
+      then
+          log_message=`expr "$1" : '-m\(.*\)'`
+      else
+          log_message="$log_message
+
+`expr "$1" : '-m\(.*\)'`"
+      fi
       no_edit=t
       shift
       ;;
   --m=*|--me=*|--mes=*|--mess=*|--messa=*|--messag=*|--message=*)
-      log_given=t$log_given
-      log_message=`expr "$1" : '-[^=]*=\(.*\)'`
+      log_given=m$log_given
+      if test "$log_message" = ''
+      then
+          log_message=`expr "$1" : '-[^=]*=\(.*\)'`
+      else
+          log_message="$log_message
+
+`expr "$1" : '-[^=]*=\(.*\)'`"
+      fi
       no_edit=t
       shift
       ;;
@@ -378,7 +399,9 @@ esac
 
 case "$log_given" in
 tt*)
-  die "Only one of -c/-C/-F/-m can be used." ;;
+  die "Only one of -c/-C/-F can be used." ;;
+*tm*|*mt*)
+  die "Option -m cannot be combined with -c/-C/-F." ;;
 esac
 
 case "$#,$also,$only,$amend" in
-- 
1.3.3.g45d8
