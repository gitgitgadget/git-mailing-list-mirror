From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-mkpatch: Show human-readable dates
Date: Wed, 27 Apr 2005 01:27:29 +0200
Message-ID: <20050426232729.GE28560@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 01:23:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQZNr-0000dY-Gz
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 01:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVDZX1f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 19:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVDZX1f
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 19:27:35 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:10730 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261841AbVDZX1b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 19:27:31 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id E4C2F6E18CA; Wed, 27 Apr 2005 01:26:35 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A9E7A6E17A3; Wed, 27 Apr 2005 01:26:35 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2924261FDE; Wed, 27 Apr 2005 01:27:30 +0200 (CEST)
To: pasky@ucw.cz
Mail-Followup-To: pasky@ucw.cz, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Use the approach from from cg-log to show author and commit date
in a human-readable format.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit e9f5d35741f92d64945a072759450b1c43b2b6e4
tree 01bda4c4ac0c3b938fb4e7954193f2441554acfb
parent e5eb91b0a47e1169006034af434312c7f38dc902
author Jonas Fonseca <fonseca@diku.dk> Wed, 27 Apr 2005 01:24:31 +0200
committer Jonas Fonseca <fonseca@diku.dk> Wed, 27 Apr 2005 01:24:31 +0200

 cg-mkpatch |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

Index: cg-mkpatch
===================================================================
--- bd580d135661ff0bc8eb32cb36025cd1e7bdda13/cg-mkpatch  (mode:100755 sha1:25c67a29296730daeac00e43fd4c18cf914a1c87)
+++ 01bda4c4ac0c3b938fb4e7954193f2441554acfb/cg-mkpatch  (mode:100755 sha1:efee5dc887677d3122d8630b9ee3ef396b7adbd3)
@@ -12,15 +12,31 @@
 showpatch () {
 	header=$(mktemp -t gitpatch.XXXXXX)
 	id=$1
-	cat-file commit $id | while read line; do
-		if [ ! "$line" ]; then
-			cat
-			echo
-			echo ---
-			echo commit $id
-			cat $header
-		fi
-		echo $line >>$header
+	cat-file commit $id | while read key rest; do
+		case "$key" in
+		"author"|"committer")
+			date=(${rest#*> })
+			sec=${date[0]}; tz=${date[1]}
+			dtz=${tz/+/}
+			lsec=$(expr $dtz / 100 \* 3600 + $dtz % 100 \* 60 + $sec)
+			pdate="$(date -Rud "1970-01-01 UTC + $lsec sec" 2>/dev/null)"
+			if [ "$pdate" ]; then
+				echo $key $rest | sed "s/>.*/> ${pdate/+0000/$tz}/" >> $header
+			else
+				echo $key $rest >> $header
+			fi
+			;;
+		"")
+			cat
+			echo
+			echo ---
+			echo commit $id
+			cat $header
+			;;
+		*)
+			echo $key $rest >>$header
+			;;
+		esac
 	done
 	echo
 	cg-diff -p -r $id > $header

-- 
Jonas Fonseca
