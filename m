From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH Cogito] cg-log: improve parsing -r
Date: Sun, 29 May 2005 03:41:38 +0200
Message-ID: <20050529014138.GB7520@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 03:39:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcClx-0004dn-Ei
	for gcvg-git@gmane.org; Sun, 29 May 2005 03:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVE2Blo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 21:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVE2Blo
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 21:41:44 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:18653 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261205AbVE2Blk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2005 21:41:40 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 21EF56E1AF7; Sun, 29 May 2005 03:41:09 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id DD4976E0FA8; Sun, 29 May 2005 03:41:08 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2C9F761FE0; Sun, 29 May 2005 03:41:39 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Move parsing of the -r option to the option parsing loop so it no longer
needs to be last in the argument list.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-log |   32 +++++++++++++++-----------------
 1 files changed, 15 insertions(+), 17 deletions(-)

--- c8e987e5e4608c1144293cd3f852210d70b572cb/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -37,7 +37,10 @@
 colsignoff=
 coldefault=
 list_files=
+log_start=
+log_end=
 user=
+
 while [ "$1" ]; do
 	# TODO: Parse -r here too.
 	case "$1" in
@@ -59,6 +62,18 @@
 		user="${1#-u}"
 		shift
 		;;
+	-r)
+		shift
+		if echo "$1" | grep -q ':'; then
+			log_end=$(echo "$1" | cut -d : -f 2)
+			log_start=$(echo "$1" | cut -d : -f 1)
+		elif [ -z "$log_start" ]; then
+			log_start="$1"
+		else
+			log_end="$1"
+		fi
+		shift
+		;;
 	*)
 		break
 		;;
@@ -93,23 +108,6 @@
 	echo "$coldefault:"
 }
 
-log_start=
-log_end=
-if [ "$1" = "-r" ]; then
-	shift
-	log_start="$1"
-	shift
-	if echo "$log_start" | grep -q ':'; then
-		log_end=$(echo "$log_start" | cut -d : -f 2)
-		log_start=$(echo "$log_start" | cut -d : -f 1)
-	fi
-fi
-if [ "$1" = "-r" ]; then
-	shift
-	log_end="$1"
-	shift
-fi
-
 if [ "$log_end" ]; then
 	id1="$(commit-id $log_start)" || exit 1
 	id2="$(commit-id $log_end)" || exit 1
-- 
Jonas Fonseca
