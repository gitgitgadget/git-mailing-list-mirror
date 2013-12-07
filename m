From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 2/4] subtree: allow --squash and --message with push
Date: Sat,  7 Dec 2013 11:21:23 -0700
Message-ID: <1386440485-3092-2-git-send-email-mmogilvi_git@miniinfo.net>
References: <1386440485-3092-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: greened@obbligato.org, amdmi3@amdmi3.ru, john@keeping.me.uk,
	techlivezheng@gmail.com, apenwarr@gmail.com,
	Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 19:24:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpMYX-0006KW-IM
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 19:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab3LGSYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 13:24:36 -0500
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:57612 "EHLO
	qmta04.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754825Ab3LGSYW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Dec 2013 13:24:22 -0500
Received: from omta23.emeryville.ca.mail.comcast.net ([76.96.30.90])
	by qmta04.emeryville.ca.mail.comcast.net with comcast
	id yiLZ1m0011wfjNsA4iQNgk; Sat, 07 Dec 2013 18:24:22 +0000
Received: from mmogilvi.dynu.net ([50.183.100.68])
	by omta23.emeryville.ca.mail.comcast.net with comcast
	id yiQM1m00E1UYGSS8jiQMLp; Sat, 07 Dec 2013 18:24:22 +0000
Received: from rand.mmogilvi.local (rand.mmogilvi.local [192.168.30.68])
	by mmogilvi.dynu.net (Postfix) with ESMTP id 1DD901E9601A;
	Sat,  7 Dec 2013 11:24:21 -0700 (MST)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1386440485-3092-1-git-send-email-mmogilvi_git@miniinfo.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1386440662;
	bh=tE7Jf7g75nCZgTMWwRetyLEl6EeSaeMBEZZqaPECFPE=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=UeKWFnSALwHa7NIm5gqnXqlPeeZyTAEzqc4CebW9IjD2H4o7zXBNbZEME361vEcej
	 DcOVtcfoS4It3/5FhWfK47jDgRFQ+ujpbWdqWYuWSMHF50AgyeHCuJXQqudtes+M2j
	 INuQMEJzOGQEDUOsVeq+Myl37nKHKIihoBPRzKCl+BWa7IJgGfpkTRhN3y5c4UOghi
	 atjPjzJQNXbVqrekM0H2yPXNWqDqxSL3/l0p8pURMMj8T9j3eUprc8lfQ94EP4WGbN
	 h15dwNyrnpJec0gHeoAXXJ2ueZnS7SyTOCLwoTiYLUi1l2ndbKrbb+dKHbbsAQYVoH
	 flLtwSKHbyiLw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239010>

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 contrib/subtree/git-subtree.sh  | 8 +++++++-
 contrib/subtree/git-subtree.txt | 9 ---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 998a9c5..56d915f 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -743,11 +743,17 @@ cmd_push()
 	if [ $# -ne 2 ]; then
 	    die "You must provide <repository> <refspec>"
 	fi
+
+	opts=
+	if [ -n "$squash" ]; then
+		opts="-squash"
+	fi
+
 	if [ -e "$dir" ]; then
 	    repository=$1
 	    refspec=$2
 	    echo "git push using: " $repository $refspec
-	    localrev=$(git subtree split --prefix="$prefix") || die
+	    localrev=$(git subtree split --prefix="$prefix" $opts --message="$message") || die
 	    git push $repository $localrev:refs/heads/$refspec
 	else
 	    die "'$dir' must already exist. Try 'git subtree add'."
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 92e7a4d..03092bc 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -140,20 +140,11 @@ OPTIONS
 	want to manipulate.  This option is mandatory
 	for all commands.
 
-
-OPTIONS FOR add, merge, pull, rejoin
-----------------------------------
 -m <message>::
 --message=<message>::
-	This option is only valid for add, merge, pull, and
-	split '--rejoin'.
-
 	Specify <message> as the commit message for the merge commit.
 
 --squash::
-	This option is only valid for add, merge, pull, and
-	split '--rejoin'.
-
 	Instead of merging the entire history from the subtree
 	project, produce only a single commit that contains all
 	the differences you want to merge, and then merge that
-- 
1.8.3.2
