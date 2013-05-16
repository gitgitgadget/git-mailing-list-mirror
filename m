From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 04/15] t6111: allow checking the parents as well
Date: Thu, 16 May 2013 18:32:30 +0300
Message-ID: <1368718361-27859-5-git-send-email-kevin@bracey.fi>
References: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 17:40:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0Ho-00012I-VE
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab3EPPj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:39:57 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:33984 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752863Ab3EPPjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:39:40 -0400
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id F2C2010540C5
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:08 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:08 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:33:04 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18171743022951010530
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -58
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -58
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224583>

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6111-rev-list-treesame.sh | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index b2bca77..1e4a550 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -20,7 +20,7 @@ note () {
 }
 
 unnote () {
-	git name-rev --tags --stdin | sed -e "s|$_x40 (tags/\([^)]*\)) |\1 |g"
+	git name-rev --tags --stdin | sed -e "s|$_x40 (tags/\([^)]*\))\([ 	]\)|\1\2|g"
 }
 
 test_expect_success setup '
@@ -66,23 +66,34 @@ test_expect_success setup '
 	test_commit M file "Parts 1+2"
 '
 
-FMT='tformat:%P 	%H | %s'
-
 # could we soup this up to optionally check parents? So "(BA)C" would check
 # that C is shown and has parents B A.
 check_outcome () {
 	outcome=$1
 	shift
-	for c in $1
-	do
-		echo "$c"
-	done >expect &&
-	shift &&
+
+	case "$1" in
+	*"("*)
+		FMT="%P	%H | %s"
+		munge_actual="
+			s/^\([^	]*\)	\([^ ]*\) .*/(\1)\2/
+			s/ //g
+			s/()//
+		"
+		;;
+	*)
+		FMT="%H | %s"
+		munge_actual="s/^\([^ ]*\) .*/\1/"
+		;;
+	esac &&
+	printf "%s\n" $1 >expect &&
+	shift
+
 	param="$*" &&
 	test_expect_$outcome "log $param" '
 		git log --format="$FMT" $param |
 		unnote >actual &&
-		sed -e "s/^.*	\([^ ]*\) .*/\1/" >check <actual &&
+		sed -e "$munge_actual" <actual >check &&
 		test_cmp expect check || {
 			cat actual
 			false
@@ -99,6 +110,7 @@ check_result () {
 # shown in normal full-history, as we can't distinguish unless we do a
 # simplification pass. After simplification, D is dropped but G remains.
 check_result 'M L K J I H G F E D C B A'
+check_result '(LH)M (K)L (GJ)K (I)J (G)I (G)H (FE)G (D)F (B)E (BC)D (A)C (A)B A'
 check_result 'M H L K J I G E F D C B A' --topo-order
 check_result 'M L H B A' -- file
 check_result 'M L H B A' --parents -- file
-- 
1.8.3.rc0.28.g4b02ef5
