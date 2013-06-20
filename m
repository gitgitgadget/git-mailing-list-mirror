From: "R. Andrew Ohana" <andrew.ohana@gmail.com>
Subject: [PATCH] octopus: fallback on empty tree for ancestor
Date: Wed, 19 Jun 2013 17:27:14 -0700
Message-ID: <1371688034-12145-1-git-send-email-andrew.ohana@gmail.com>
References: <andrew.ohana@gmail.com>
Cc: "R. Andrew Ohana" <andrew.ohana@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 20 02:27:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpSiv-0001Ui-ET
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 02:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935351Ab3FTA1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 20:27:33 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32882 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934375Ab3FTA1c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 20:27:32 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so5712257pad.14
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 17:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2Mr1Q8q6j23LNJq34YSPQPT+HoOWHQsdfBOEO3ugvnc=;
        b=Rw18TArrNirRDtmwyU42LagmYwn/IJaIKSC1muvLOg7qIgn9kKtg2/xni4Mg3hKtBG
         IuVNJ7bO/Ju0jCBRNjTEk4sqxY4/vxOBRoChGAkeT2Jc59bvfltpsMRhWsqErWliXG61
         U2ACNSPPd0Z3QlJi6tEyVIPRQIPMq+pkaM4Qp7SQyU7/0F/Ij7LzR0B+AOELfgLhEm2M
         9T6h5cwqmezKcBQvtGs/0oYHAvXcaE/oHPPbs+7Bf7RLpj4/ex/KbFD825MPDmJiw0Si
         nV9eYiB2a7OX7OL7ik3UerHMRvcObekEzCUv2gxDvsTYWZVxhr+8IacYFz2PEECI9HFn
         RuTA==
X-Received: by 10.66.162.40 with SMTP id xx8mr8923621pab.178.1371688052254;
        Wed, 19 Jun 2013 17:27:32 -0700 (PDT)
Received: from amy.dhcp4.washington.edu (D-69-91-176-59.dhcp4.washington.edu. [69.91.176.59])
        by mx.google.com with ESMTPSA id qi1sm26894238pac.21.2013.06.19.17.27.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 17:27:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <andrew.ohana@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228434>

From: "R. Andrew Ohana" <andrew.ohana@gmail.com>

This is preferable to just aborting when no
common ancestor is found since it handles merges
of intersecting branches.

This is incredibly useful functionality when
consolidating multiple repositories (potentially
after using filter-branch to fix paths).

See http://stackoverflow.com/questions/10874149.

Signed-off-by: R. Andrew Ohana <andrew.ohana@gmail.com>
---
 git-merge-octopus.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 8643f74..582ae69 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -48,6 +48,7 @@ MRC=$(git rev-parse --verify -q $head)
 MRT=$(git write-tree)
 NON_FF_MERGE=0
 OCTOPUS_FAILURE=0
+EMPTY_TREE=$(git hash-object -t tree /dev/null)
 for SHA1 in $remotes
 do
 	case "$OCTOPUS_FAILURE" in
@@ -67,7 +68,9 @@ do
 		eval pretty_name=\${GITHEAD_$SHA1_UP:-$pretty_name}
 	fi
 	common=$(git merge-base --all $SHA1 $MRC) ||
-		die "Unable to find common commit with $pretty_name"
+		# Try with an empty tree if no common ancestor was
+		# found, since it is common to all trees.
+		common=$EMPTY_TREE
 
 	case "$LF$common$LF" in
 	*"$LF$SHA1$LF"*)
-- 
1.8.2.1
