From: Brian Campbell <brian.p.campbell@dartmouth.edu>
Subject: [PATCH 2/2] [TopGit] Portability: Don't use alternation ("|") in sed regular expressions
Date: Thu, 12 Mar 2009 01:56:29 -0400
Message-ID: <1236837389-35687-2-git-send-email-brian.p.campbell@dartmouth.edu>
References: <1236837389-35687-1-git-send-email-brian.p.campbell@dartmouth.edu>
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Brian Campbell <brian.p.campbell@dartmouth.edu>
To: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Mar 12 07:11:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhe8x-00009C-Nc
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 07:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbZCLGKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 02:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbZCLGKK
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 02:10:10 -0400
Received: from mailhub2.dartmouth.edu ([129.170.17.107]:42247 "EHLO
	mailhub2.dartmouth.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZCLGKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 02:10:09 -0400
X-Greylist: delayed 793 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2009 02:10:08 EDT
Received: from localhost.localdomain (c-75-69-96-104.hsd1.nh.comcast.net [75.69.96.104])
	(authenticated bits=0)
	by mailhub2.dartmouth.edu (8.13.5/DND2.0/8.13.5) with ESMTP id n2C5uUun012861
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Mar 2009 01:56:33 -0400
X-Mailer: git-send-email 1.6.2.185.g8b635.dirty
In-Reply-To: <1236837389-35687-1-git-send-email-brian.p.campbell@dartmouth.edu>
X-MailScanner: Found to be clean by mailhub.Dartmouth.EDU
X-MailScanner-From: brian.p.campbell@dartmouth.edu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113004>

There is no portable way in sed to express alternation (the "|"
operator).  POSIX does not specify any way of expressing alternation;
according to POSIX, sed uses basic regular expressions which do not
support alternation.  GNU sed allows "\|" to express alternation,
and BSD sed (as tested on Mac OS X) allows for the use of extended
regular expressions with the -E flag, but there appears to be no
portable way to express this.

This patch works around the problem by changing a single sed
expression into two.  This patch also factors out all the call
sites that were doing this, to determing the current branch,
into a single function current_branch in tg.sh.

Signed-off-by: Brian Campbell <brian.p.campbell@dartmouth.edu>
---
 tg-info.sh    |    2 +-
 tg-patch.sh   |    2 +-
 tg-summary.sh |    2 +-
 tg-update.sh  |    2 +-
 tg.sh         |    5 +++++
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tg-info.sh b/tg-info.sh
index 7d6a34c..25c753c 100644
--- a/tg-info.sh
+++ b/tg-info.sh
@@ -20,7 +20,7 @@ while [ -n "$1" ]; do
 	esac
 done
 
-[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+[ -n "$name" ] || name="$(current_branch)"
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not a TopGit-controlled branch"
 
diff --git a/tg-patch.sh b/tg-patch.sh
index d701c54..ba788c8 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -35,7 +35,7 @@ done
 [ -n "$name"  -a  -z "$diff_committed_only" ]  &&
 	die "-i/-w are mutually exclusive with NAME"
 
-[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+[ -n "$name" ] || name="$(current_branch)"
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not a TopGit-controlled branch"
 
diff --git a/tg-summary.sh b/tg-summary.sh
index 50ee883..62b499e 100644
--- a/tg-summary.sh
+++ b/tg-summary.sh
@@ -22,7 +22,7 @@ while [ -n "$1" ]; do
 	esac
 done
 
-curname="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+curname="$(current_branch)"
 
 ! [ -n "$terse" -a -n "$graphviz" ] ||
 	die "-t and --graphviz options are mutual exclusive"
diff --git a/tg-update.sh b/tg-update.sh
index 288ec14..0cff0ac 100644
--- a/tg-update.sh
+++ b/tg-update.sh
@@ -14,7 +14,7 @@ if [ -n "$1" ]; then
 fi
 
 
-name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+name="$(current_branch)"
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not a TopGit-controlled branch"
 
diff --git a/tg.sh b/tg.sh
index 43d1c9f..232a8b7 100644
--- a/tg.sh
+++ b/tg.sh
@@ -18,6 +18,11 @@ die()
 	exit 1
 }
 
+current_branch()
+{
+	echo "$(git symbolic-ref HEAD | sed -e 's#^refs/heads/##' -e 's#^refs/top-bases/##')"
+}
+
 # cat_file "topic:file"
 # Like `git cat-file blob $1`, but topics '(i)' and '(w)' means index and worktree
 cat_file()
-- 
1.6.2.185.g8b635.dirty
