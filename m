X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [RFC/PATCH] Implement poor-man's submodule support in pre-commit hook
Date: Wed, 20 Dec 2006 09:01:30 +0000
Message-ID: <200612200901.30584.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 09:01:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: 73cd9cabeb401690
X-UID: 197
X-Length: 2796
Content-Disposition: inline
X-OriginalArrivalTime: 20 Dec 2006 09:03:39.0716 (UTC) FILETIME=[BD98A840:01C72415]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34912>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwxKT-0003mw-Vm for gcvg-git@gmane.org; Wed, 20 Dec
 2006 10:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964943AbWLTJBf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 04:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWLTJBf
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 04:01:35 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:25345 "EHLO
 369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S964943AbWLTJBe (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 04:01:34 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Wed, 20 Dec 2006 09:03:39 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GwxKO-0007Q4-00 for <git@vger.kernel.org>; Wed, 20 Dec
 2006 09:01:32 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Make a file called .gitmodules.  In it, list the paths containing a
submodule.  Add that file to the index.

This addition to the pre-commit hook finds that file and pulls the HEAD
hash out of each of the listed submodule repositories.  That hash is
then listed to the .gitmodules file along with the submodule name and
.gitmodules is added back to the repository.

You've now got poor-man's submodule support.  Any commits to the
submodule will change the hash and hence the .gitmodules file will be
different and therefore will show up as "modified" to git.

It's not got any nice UI for checking out (obviously) or merging; but it
does at least record the state of a project with a bit of manual work to
check out the right commit in the submodule.

Problems:
 - git-prune in the submodule could destroy supermodule-referenced
   commits
 - no checkout support
 - no merge support (other than what git provides for the .gitmodule
   file)
 - no check for dirty submodule before commit

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--pre-commit |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 723a9ef..7a71d81 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -67,5 +67,34 @@ perl -e '
 	}
     }
     exit($found_bad);
-'
+' || exit 1
+
+# Enable poor-man's submodule support when .gitmodules is present
+# Simply create a .gitmodules file listing the paths in your repository
+# that contain other git repositories; each line will be replaced with the
+# path followed by the hash of the current HEAD of the submodule.
+# When the submodule changes hash this file will be different from the
+# version in the repository and a change will be noted - voila, submodules.
+# Of course there is no checkout support, but at least the current state
+# will be accurately recorded
+if [ -f .gitmodules ]; then
+	cat .gitmodules |
+	while read subdir hash
+	do
+		# XXX: check if the line is a comment
+
+		# XXX: really need a check here and quit if the submodule is
+		# dirty
+
+		echo "$subdir $(GIT_DIR=$subdir/.git git-rev-parse HEAD)"
+	done > .gitmodules
+
+	# This relies on the .gitmodules file having already been added to
+	# the repository - perhaps this should be automated?
+	git-update-index .gitmodules ||
+	(
+	echo "Submodule tracker file is not tracked by this repository." >&2
+	exit 1
+	)
+fi
 
-- 
1.4.4.2.g95ee-dirty
