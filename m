From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Move common date code to the library file
Date: Wed, 27 Apr 2005 01:55:32 +0200
Message-ID: <20050426235532.GF28560@diku.dk>
References: <20050426232729.GE28560@diku.dk> <20050426233439.GS13224@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 01:51:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQZpO-0003lm-U5
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 01:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVDZXzr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 19:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVDZXzr
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 19:55:47 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:15341 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261853AbVDZXzd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 19:55:33 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 9FE946E175C; Wed, 27 Apr 2005 01:54:38 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 5DF186E13EA; Wed, 27 Apr 2005 01:54:38 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id D69E961FDE; Wed, 27 Apr 2005 01:55:32 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050426233439.GS13224@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Move common date conversion code to showdate() library function.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit e7ab52f0d69a45e69d78f2992c7997283855ac48
tree 01c206a9520ffa599c3ce17c901b4fce9b162b08
parent 09da825be78580e991bfd0ccbb90de15bfa18113
author Jonas Fonseca <fonseca@diku.dk> Wed, 27 Apr 2005 01:53:04 +0200
committer Jonas Fonseca <fonseca@diku.dk> Wed, 27 Apr 2005 01:53:04 +0200

 cg-Xlib    |    9 +++++++++
 cg-log     |    7 ++-----
 cg-mkpatch |    7 ++-----
 3 files changed, 13 insertions(+), 10 deletions(-)

Index: cg-Xlib
===================================================================
--- 6b45f2ad7c95fa110c7e8b53dae6d099d726bd4c/cg-Xlib  (mode:100755 sha1:5d84bbdb19510b7399f39ffd920636821a37248c)
+++ 01c206a9520ffa599c3ce17c901b4fce9b162b08/cg-Xlib  (mode:100755 sha1:665b84360050e7151eb2aa34327a10821ddc9ccf)
@@ -33,6 +33,15 @@
 	$(which mktemp) $dirarg $prefix"$1"
 }
 
+showdate () {
+	date="$1"
+	sec=${date[0]}; tz=${date[1]}
+	dtz=${tz/+/}
+	lsec=$(expr $dtz / 100 \* 3600 + $dtz % 100 \* 60 + $sec)
+	pdate="$(date -Rud "1970-01-01 UTC + $lsec sec" 2>/dev/null)"
+
+	echo "${pdate/+0000/$tz}"
+}
 
 # Compatibility hacks:
 # 2005-04-26
Index: cg-log
===================================================================
--- 6b45f2ad7c95fa110c7e8b53dae6d099d726bd4c/cg-log  (mode:100755 sha1:1c53b31a956e7c8cbfe653143cc0f91df02a2f86)
+++ 01c206a9520ffa599c3ce17c901b4fce9b162b08/cg-log  (mode:100755 sha1:5d0b602d32068af0d6e958f1c9c4dd6c870a9ce1)
@@ -96,12 +96,9 @@
 				fi
 
 				date=(${rest#*> })
-				sec=${date[0]}; tz=${date[1]}
-				dtz=${tz/+/}
-				lsec=$(expr $dtz / 100 \* 3600 + $dtz % 100 \* 60 + $sec)
-				pdate="$(date -Rud "1970-01-01 UTC + $lsec sec" 2>/dev/null)"
+				pdate="$(showdate $date)"
 				if [ "$pdate" ]; then
-					echo -n $color$key $rest | sed "s/>.*/> ${pdate/+0000/$tz}/"
+					echo -n $color$key $rest | sed "s/>.*/> $pdate/"
 					echo $coldefault
 				else
 					echo $color$key $rest $coldefault
Index: cg-mkpatch
===================================================================
--- 6b45f2ad7c95fa110c7e8b53dae6d099d726bd4c/cg-mkpatch  (mode:100755 sha1:efee5dc887677d3122d8630b9ee3ef396b7adbd3)
+++ 01c206a9520ffa599c3ce17c901b4fce9b162b08/cg-mkpatch  (mode:100755 sha1:c6aa52b6c773718a64feef47a165885b684b593b)
@@ -16,12 +16,9 @@
 		case "$key" in
 			"author"|"committer")
 				date=(${rest#*> })
-				sec=${date[0]}; tz=${date[1]}
-				dtz=${tz/+/}
-				lsec=$(expr $dtz / 100 \* 3600 + $dtz % 100 \* 60 + $sec)
-				pdate="$(date -Rud "1970-01-01 UTC + $lsec sec" 2>/dev/null)"
+				pdate="$(showdate $date)"
 				if [ "$pdate" ]; then
-					echo $key $rest | sed "s/>.*/> ${pdate/+0000/$tz}/" >> $header
+					echo $key $rest | sed "s/>.*/> $pdate/" >> $header
 				else
 					echo $key $rest >> $header
 				fi

-- 
Jonas Fonseca
