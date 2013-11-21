From: Torsten =?iso-8859-1?q?B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH v6 06/10] t5500: Test case for diag-url
Date: Thu, 21 Nov 2013 21:40:58 +0100
Message-ID: <201311212140.58804.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 21:41:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjb3l-0000eZ-R8
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab3KUUlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 15:41:06 -0500
Received: from mout.web.de ([212.227.17.11]:53845 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020Ab3KUUlE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 15:41:04 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MOAnY-1VmuRG2dEa-005cu3 for <git@vger.kernel.org>; Thu,
 21 Nov 2013 21:41:02 +0100
X-Provags-ID: V03:K0:BVEv62Q4txjeI3zeLEVQqJZrvGP/tUQ9WmUZiyYtV9heH0l/mwA
 WUnqsBDuQMh5nlzeTb2yBypjDo7FwJvbfatC5OgoQR/JE3GBzTEA6/AfUTzoGPjt8cJNLo/
 +Mma8hanJlvejqiKjdqdg/MZ08/znG1wVcY6u9i9+t2gNcHKXLoGXm9Zt+quvOpaB07+lQg
 TaLwwHTXvCo5KQKTgNSIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238147>

Add test cases using git fetch-pack --diag-url:

- parse out host and path for URLs with a scheme (git:// file:// ssh://)
- parse host names embedded by [] correctly
- extract the port number, if present
- seperate URLs like "file" (which are local)
  from URLs like "host:repo" which should use ssh
---
 t/t5500-fetch-pack.sh | 72 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 16 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 9136f2a..7f55b95 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -533,7 +533,7 @@ test_expect_success 'shallow fetch with tags does not break the repository' '
 '
 check_prot_path() {
 	> actual &&
-	(git fetch-pack --diag-url "$1" 2>&1 1>stdout) | grep -v host= >actual &&
+	(git fetch-pack --diag-url  "$1" 2>&1 1>stdout) | grep -v host= >actual &&
 	echo "Diag: url=$1" >expected &&
 	echo "Diag: protocol=$2" >>expected &&
 	echo "Diag: path=$3" >>expected &&
@@ -542,7 +542,7 @@ check_prot_path() {
 
 check_prot_host_path() {
 	> actual &&
-	git fetch-pack --diag-url "$1" 2>actual &&
+	git fetch-pack --diag-url  "$1" 2>actual &&
 	echo "Diag: url=$1" >expected &&
 	echo "Diag: protocol=$2" >>expected &&
 	echo "Diag: host=$3" >>expected &&
@@ -564,29 +564,69 @@ do
 				hh=$h
 				pp=$p
 			fi
-			test_expect_success "fetch-pack $p://$h/$r" '
+			test_expect_success "fetch-pack --diag-url $p://$h/$r" '
 				check_prot_host_path $p://$h/$r $pp "$hh" "/$r"
 			'
-			# "/~" -> "~" conversion for git
-			test_expect_success "fetch-pack $p://$h/~$r" '
+			# "/~" -> "~" conversion
+			test_expect_success "fetch-pack --diag-url $p://$h/~$r" '
 				check_prot_host_path $p://$h/~$r $pp "$hh" "~$r"
 			'
 		done
 	done
+	p=file
 	# file with scheme
-	for p in file
+	for h in "" host host:12 [::1] [::1]:23
 	do
-		for h in "" host host:12 [::1] [::1]:23
-		do
-			test_expect_success "fetch-pack $p://$h/$r" '
-				check_prot_path $p://$h/$r $p "/$r"
-			'
-			# No "/~" -> "~" conversion for file
-			test_expect_success "fetch-pack $p://$h/~$r" '
-				check_prot_path $p://$h/~$r $p "/~$r"
-			'
-		done
+		test_expect_success "fetch-pack --diag-url $p://$h/$r" '
+			check_prot_path $p://$h/$r $p "/$r"
+		'
+		# No "/~" -> "~" conversion for file
+		test_expect_success "fetch-pack --diag-url $p://$h/~$r" '
+			check_prot_path $p://$h/~$r $p "/~$r"
+		'
+	done
+	# file without scheme
+	for h in nohost nohost:12 [::1] [::1]:23 [ [:aa
+	do
+		test_expect_success "fetch-pack --diag-url ./$h:$r" '
+			check_prot_path ./$h:$r $p "./$h:$r"
+		'
+		# No "/~" -> "~" conversion for file
+		test_expect_success "fetch-pack --diag-url ./$p:$h/~$r" '
+		check_prot_path ./$p:$h/~$r $p "./$p:$h/~$r"
+		'
+	done
+	#ssh without scheme
+	p=ssh
+	for h in host [::1]
+	do
+		hh=$(echo $h | tr -d "[]")
+		test_expect_success "fetch-pack --diag-url $h:$r" '
+			check_prot_path $h:$r $p "$r"
+		'
 	done
+	h=host
+	hh=host
+	# "/~" -> "~" conversion
+	test_expect_failure "fetch-pack --diag-url $h:/~$r" '
+		check_prot_host_path $h:/~$r $p "$hh" "~$r"
+	'
+	h=[::1]
+	hh=$(echo $h | tr -d "[]")
+	# "/~" -> "~" conversion
+	test_expect_success "fetch-pack --diag-url $h:/~$r" '
+		check_prot_host_path $h:/~$r $p "$hh" "~$r"
+	'
 done
 
+test_expect_success MINGW 'fetch-pack --diag-url file://c:/repo' '
+	check_prot_path file://c:/repo file c:/repo
+'
+test_expect_success MINGW 'fetch-pack --diag-url file:///c:/repo' '
+	check_prot_path file://c:/repo file c:/repo
+'
+test_expect_success MINGW 'fetch-pack --diag-url c:repo' '
+	check_prot_path c:repo file c:repo
+'
+
 test_done
-- 
1.8.4.457.g424cb08
