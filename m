From: Fabian Franz <git@fabian-franz.de>
Subject: [PATCH v4] submodule: add +<branch> syntax for track to allow automatic pulling.
Date: Sat, 10 Jan 2009 00:10:09 -0200
Message-ID: <1231553410-7541-4-git-send-email-git@fabian-franz.de>
References: <1231553410-7541-1-git-send-email-git@fabian-franz.de>
 <1231553410-7541-2-git-send-email-git@fabian-franz.de>
 <1231553410-7541-3-git-send-email-git@fabian-franz.de>
Cc: j.sixt@viscovery.net, hjemli@gmail.com, gitster@pobox.com,
	Fabian Franz <git@fabian-franz.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 03:27:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLTZ8-0000aO-Qa
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 03:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbZAJCZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 21:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754404AbZAJCZr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 21:25:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:56728 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754275AbZAJCZp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 21:25:45 -0500
Received: (qmail invoked by alias); 10 Jan 2009 02:25:43 -0000
Received: from unknown (EHLO localhost.localdomain) [200.142.84.36]
  by mail.gmx.net (mp048) with SMTP; 10 Jan 2009 03:25:43 +0100
X-Authenticated: #590723
X-Provags-ID: V01U2FsdGVkX1/cCDIqctrc8FhecIhLdK9NKNDRBYd0odyp42uG3H
	b297Ui39G1P2WU
X-Mailer: git-send-email 1.6.1.81.g21235
In-Reply-To: <1231553410-7541-3-git-send-email-git@fabian-franz.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105066>

When the track parameter is set to +<branch>, on update command a
new branch is created tracking the remote branch (if it does not
yet exist). Then the branch is checked out and git-pull is run.

Signed-off-by: Fabian Franz <git@fabian-franz.de>
---
 Documentation/git-submodule.txt |    3 +++
 git-submodule.sh                |   26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 175b4b5..fbb18ee 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -166,6 +166,9 @@ OPTIONS
 -t::
 --track::
 	Branch/Tag/HEAD (pathspec) of repository to track in a submodule.
+	If you give +<branch> as parameter, a new branch will be created and
+	setup to track the remote branch. Then on update git-pull is used to
+	update the branch.
 
 --cached::
 	This option is only valid for status and summary commands.  These
diff --git a/git-submodule.sh b/git-submodule.sh
index 81b96dd..54b59b2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -372,6 +372,32 @@ cmd_update()
 			die "Unable to find current revision in submodule path '$path'"
 		fi
 
+		pull=
+		case "$track" in
+			"+"*)
+				pull=1
+				track=${track#+}
+			;;
+		esac
+
+		if test -n "$pull"
+		then
+			say "Pulling updates for branch '$track' for submodule path '$path'"
+			origin=$(unset GIT_DIR; cd "$path" &&
+				get_default_remote) ||
+			die "Unable to get default remote destination in submodule path '$path'."
+			(unset GIT_DIR; cd "$path" &&
+				git-rev-parse --verify --quiet "refs/heads/$track" >/dev/null || 
+				git-branch --track "$track" "$origin/$track") || 
+			die "Unable to create branch '$track' in submodule path '$path'"
+
+			(unset GIT_DIR; cd "$path" &&
+				git-checkout -q "$track" &&
+				git-pull ${quiet:+-q}) ||
+			die "Unable to pull for branch '$track' in submodule path '$path'"
+			sha1="$track"
+		fi
+
 		if test "$subsha1" != "$sha1"
 		then
 			force=
-- 
1.5.3.6
