From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v3 3/3] git-merge-one-file: revise merge error reporting
Date: Wed, 13 Mar 2013 03:12:22 +0200
Message-ID: <1363137142-18606-3-git-send-email-kevin@bracey.fi>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
 <1363137142-18606-1-git-send-email-kevin@bracey.fi>
Cc: David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 02:13:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFaFb-0002qj-Rd
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 02:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795Ab3CMBMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 21:12:37 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:34021 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932473Ab3CMBMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 21:12:36 -0400
Received: from mail433.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id E9850104DEC7
	for <git@vger.kernel.org>; Wed, 13 Mar 2013 02:23:51 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 13 Mar 2013 03:12:47 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 13 Mar 2013 03:12:46 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc3.7.g1100d09.dirty
In-Reply-To: <1363137142-18606-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 15172064195617067232
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -48
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrgedtucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlhedvmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -48
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrgedtucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlhedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218020>

Commit 718135e improved the merge error reporting for the resolve
strategy's merge conflict and permission conflict cases, but led to a
malformed "ERROR:  in myfile.c" message in the case of a file added
differently.

This commit reverts that change, and uses an alternative approach without
this flaw.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 git-merge-one-file.sh | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 0f164e5..78b07a8 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -104,11 +104,13 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
+	ret=0
 	src1=$(git-unpack-file $2)
 	src2=$(git-unpack-file $3)
 	case "$1" in
 	'')
-		echo "Added $4 in both, but differently."
+		echo "ERROR: Added $4 in both, but differently."
+		ret=1
 		orig=$(git-unpack-file $2)
 		create_virtual_base "$orig" "$src2"
 		;;
@@ -121,10 +123,9 @@ case "${1:-.}${2:-.}${3:-.}" in
 	# Be careful for funny filename such as "-L" in "$4", which
 	# would confuse "merge" greatly.
 	git merge-file "$src1" "$orig" "$src2"
-	ret=$?
-	msg=
-	if [ $ret -ne 0 ]; then
-		msg='content conflict'
+	if [ $? -ne 0 ]; then
+		echo "ERROR: Content conflict in $4"
+		ret=1
 	fi
 
 	# Create the working tree file, using "our tree" version from the
@@ -133,18 +134,11 @@ case "${1:-.}${2:-.}${3:-.}" in
 	rm -f -- "$orig" "$src1" "$src2"
 
 	if [ "$6" != "$7" ]; then
-		if [ -n "$msg" ]; then
-			msg="$msg, "
-		fi
-		msg="${msg}permissions conflict: $5->$6,$7"
-		ret=1
-	fi
-	if [ "$1" = '' ]; then
+		echo "ERROR: Permissions conflict: $5->$6,$7"
 		ret=1
 	fi
 
 	if [ $ret -ne 0 ]; then
-		echo "ERROR: $msg in $4"
 		exit 1
 	fi
 	exec git update-index -- "$4"
-- 
1.8.2.rc3.7.g1100d09.dirty
