From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 3/3] git-merge-one-file: revise merge error reporting
Date: Sun, 24 Mar 2013 14:26:25 +0200
Message-ID: <1364127985-13366-4-git-send-email-kevin@bracey.fi>
References: <CAJDDKr4swZzzv3e+Huz72CVmisFKU8T74jFj3-uGmZHReRGVBw@mail.gmail.com>
 <1364127985-13366-1-git-send-email-kevin@bracey.fi>
Cc: David Aguilar <davvid@gmail.com>, Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 13:52:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJkOy-0000dK-Dj
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 13:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab3CXMv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 08:51:28 -0400
Received: from 12.mo4.mail-out.ovh.net ([178.33.104.253]:33304 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753558Ab3CXMv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 08:51:28 -0400
X-Greylist: delayed 3377 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Mar 2013 08:51:28 EDT
Received: from mail643.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 42D0A104DC26
	for <git@vger.kernel.org>; Sun, 24 Mar 2013 13:38:14 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 24 Mar 2013 14:25:51 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 24 Mar 2013 14:25:50 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc3.21.g744ac65
In-Reply-To: <1364127985-13366-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 17351806416152793313
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218954>

Commit 718135e improved the merge error reporting for the resolve
strategy's merge conflict and permission conflict cases, but led to a
malformed "ERROR:  in myfile.c" message in the case of a file added
differently.

This commit reverts that change, and uses an alternative approach without
this flaw.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 git-merge-one-file.sh | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 39b7799..e231d20 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -107,10 +107,12 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
+	ret=0
 	src2=$(git-unpack-file $3)
 	case "$1" in
 	'')
-		echo "Added $4 in both, but differently."
+		echo "ERROR: Added $4 in both, but differently." >&2
+		ret=1
 		orig=$(git-unpack-file $2)
 		create_virtual_base "$orig" "$src2"
 		;;
@@ -124,11 +126,10 @@ case "${1:-.}${2:-.}${3:-.}" in
 	# would confuse "merge" greatly.
 	src1=$(git-unpack-file $2)
 	git merge-file "$src1" "$orig" "$src2"
-	ret=$?
-	msg=
-	if test $ret != 0
+	if test $? != 0
 	then
-		msg='content conflict'
+		echo "ERROR: Content conflict in $4" >&2
+		ret=1
 	fi
 
 	# Create the working tree file, using "our tree" version from the
@@ -138,21 +139,12 @@ case "${1:-.}${2:-.}${3:-.}" in
 
 	if test "$6" != "$7"
 	then
-		if test -n "$msg"
-		then
-			msg="$msg, "
-		fi
-		msg="${msg}permissions conflict: $5->$6,$7"
-		ret=1
-	fi
-	if test -z "$1"
-	then
+		echo "ERROR: Permissions conflict: $5->$6,$7" >&2
 		ret=1
 	fi
 
 	if test $ret != 0
 	then
-		echo "ERROR: $msg in $4" >&2
 		exit 1
 	fi
 	exec git update-index -- "$4"
-- 
1.8.2.rc3.21.g744ac65
