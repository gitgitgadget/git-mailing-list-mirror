From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 3/3] git-merge-one-file: revise merge error reporting
Date: Sat,  9 Mar 2013 21:21:00 +0200
Message-ID: <1362856860-15205-4-git-send-email-kevin@bracey.fi>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
 <1362856860-15205-1-git-send-email-kevin@bracey.fi>
Cc: Kevin Bracey <kevin@bracey.fi>, David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 20:29:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPSW-00045l-LN
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292Ab3CIT3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:29:06 -0500
Received: from mo5.mail-out.ovh.net ([178.32.228.5]:50050 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab3CIT3F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:29:05 -0500
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Mar 2013 14:29:05 EST
Received: from mail173.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 8F0C0FF9145
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 20:32:47 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 9 Mar 2013 21:21:27 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 9 Mar 2013 21:21:26 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc3.7.g77aeedb
In-Reply-To: <1362856860-15205-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 10067234018646331617
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -60
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeefucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -60
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeefucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217752>

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
index 1236fbf..70f36f1 100755
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
 		create_virtual_base "$orig" "$src1" "$src2"
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
1.8.2.rc3.7.g77aeedb
