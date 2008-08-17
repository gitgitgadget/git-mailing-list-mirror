From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH try3] Improve error output of git-rebase
Date: Sun, 17 Aug 2008 06:25:43 +0200
Message-ID: <1218947143-12734-1-git-send-email-s-beyer@gmx.net>
References: <20080817041135.GA23513@leksak.fem-net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 06:26:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUZqu-0000mf-8T
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 06:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbYHQEZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 00:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbYHQEZt
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 00:25:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:41231 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750712AbYHQEZs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 00:25:48 -0400
Received: (qmail invoked by alias); 17 Aug 2008 04:25:47 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp028) with SMTP; 17 Aug 2008 06:25:47 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/ETbUa5jjE0d8Xw8xXk3YwMk2jVykX8O3B/rgpvt
	dsq7SDQD39EUkw
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KUZpn-0003Jo-J8; Sun, 17 Aug 2008 06:25:43 +0200
X-Mailer: git-send-email 1.6.0.rc3.18.gc698c8
In-Reply-To: <20080817041135.GA23513@leksak.fem-net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92570>

"git rebase" without arguments on initial startup showed:

	fatal: Needed a single revision
	invalid upstream

This patch makes it show the ordinary usage string.

If .git/rebase-merge or .git/rebase-apply/rebasing exists, git-rebase
will die with a message saying that a rebase is in progress and the user
should try --skip/--abort/--continue.

If .git/rebase-apply/applying exists, git-rebase will die with a message
saying that git-am is in progress, regardless how many arguments are
given.

If no arguments are given and .git/rebase-apply/ exists, but neither a
rebasing nor applying file is in that directory, git-rebase dies with a
message saying that rebase-apply exists and no arguments were given.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
	I've stashed away *these* changes before I made up the try2 patch.
	I tested several cases and I think it is ok.

	Sorry for all the noise.

	Regards

 git-rebase.sh |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 412e135..528b604 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -144,8 +144,19 @@ is_interactive () {
 	done && test -n "$1"
 }
 
+test -f "$GIT_DIR"/rebase-apply/applying &&
+	die 'It looks like git-am is in progress. Cannot rebase.'
+
 is_interactive "$@" && exec git-rebase--interactive "$@"
 
+if test $# -eq 0
+then
+	test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply || usage
+	test -d "$dotest" -o -f "$GIT_DIR"/rebase-apply/rebasing &&
+		die 'A rebase is in progress, try --continue, --skip or --abort.'
+	die "No arguments given and $GIT_DIR/rebase-apply already exists."
+fi
+
 while test $# != 0
 do
 	case "$1" in
@@ -268,16 +279,16 @@ done
 # Make sure we do not have $GIT_DIR/rebase-apply
 if test -z "$do_merge"
 then
-	if mkdir "$GIT_DIR"/rebase-apply
+	if mkdir "$GIT_DIR"/rebase-apply 2>/dev/null
 	then
 		rmdir "$GIT_DIR"/rebase-apply
 	else
 		echo >&2 '
-It seems that I cannot create a '"$GIT_DIR"'/rebase-apply directory,
-and I wonder if you are in the middle of patch application or another
+It seems that I cannot create a rebase-apply directory, and
+I wonder if you are in the middle of patch application or another
 rebase.  If that is not the case, please
 	rm -fr '"$GIT_DIR"'/rebase-apply
- and run me again.  I am stopping in case you still have something
+and run me again.  I am stopping in case you still have something
 valuable there.'
 		exit 1
 	fi
@@ -285,7 +296,7 @@ else
 	if test -d "$dotest"
 	then
 		die "previous rebase directory $dotest still exists." \
-			'try git-rebase < --continue | --abort >'
+			'Try git rebase (--continue | --abort | --skip)'
 	fi
 fi
 
-- 
1.6.0.rc3.18.gc698c8
