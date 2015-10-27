From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/2] Fix interactive rebase when the editor saves with
 CR/LF
Date: Tue, 27 Oct 2015 10:47:10 +0100 (CET)
Message-ID: <cover.1445939154.git.johannes.schindelin@gmx.de>
References: <cover.1445782122.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 10:47:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr0qy-0000dh-0u
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 10:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbbJ0Jrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 05:47:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:51674 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224AbbJ0Jr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 05:47:29 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LjLwB-1aMDrN1uud-00dUU8;
 Tue, 27 Oct 2015 10:47:10 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445782122.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:2h9UzrBLDG+DifO+wMJJd22/eG8fwd2zGGxVIlyN4SH20Ju4RKN
 CLinogMe714zk1biOcZWBA9ppJ+RpYYPjfECvVcDe0VqSnQfqXOs1CPIiiQOofav+w6AXfM
 RDyPb7pEPXq6+XDy2cFqY5EnWvk74UKilCjROKi56Habam61SskL/QaPZjFcLpX/N08i4z5
 kJiHOo3tX+nXevQd9Xbpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U9OaDa5Tv9U=:2dEo5f1ubldPvwT1pzHJSP
 33Llvf1pb9nMMfuPLWVIg7l4YV96qjdRPri5NcLayKp56Un58rxXQFr1E0vN0DEXJ1HTWnGq5
 1UXEh3zXqFr59OqrYgeCToVO71Bt8BACNqNXcY7pOr6lLJAiqZImUqseUXjyxhn+Akq/Lvekt
 Uvn3QhWsl7VCK5mtOyLKXOU4I2MUTyHX0xqIipDNhWhePdG9l/4ehVTqAn0XSm46GB8j8qU2g
 TJFel1h78A7xLL8IowNC3CZSa78FnNXKsnHRvAMSbFG6fTP+J7T53WUJLni+DZxIGfNqffw+k
 wDhwG8WCzcCc/INGAO/A5+/Hx9Si7Q8GRfVMJ+SMpBxO7rTUL/lCvyUdnKA/zxcwaLz2dOArS
 TZpXU6HgIs5VT3JBkTk/u2wyQlo+XebNRmKgQPCvAiCOr75u+VeIdlU3liKhMyMYHTo5VpBES
 CcRRbWt935ZP36rb8KMMuZQcLzt/stfBr6oDaaJbSAdf41TQOAcMRQasAXTWvPkmsKJAHoeuf
 uae+ztREcvJwHBA4jmrWn5wSeSVg2CEmgc0IX4TYdsX8Uj/yWx7yCU0McaknXv7QPTpOF5yP8
 KHcjVR3DdawSsGjKu0+wgipy4rg7WFbL12QKZebuuX6QT5YHIvPOJCb95fKUSH/zwbZ8pIJiq
 4xngqn+RONmUeqpWy7854Hns3JZPC0t43OKFlx6BjQqjG+b6kK1Gi0qluYr9RglSulOZlV2t3
 u2IWyj7oFMPNLS3Y93hih7uLClP0ndxQm/iadIwpaLwQAR/tFpcs4AXTxMgoTxfLeDkGJY1X 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280253>

Chad Boles reported that `git rebase -i` recently started producing
errors when the editor saves files with DOS line endings. The symptom
is:

	Warning: the command isn't recognized in the following line:
	 -

	You can fix this with 'git rebase --edit-todo'.
	Or you can abort the rebase with 'git rebase --abort'.

The real bummer is that simply calling `git rebase --continue` "fixes"
it.

Turns out that we now check whether a single Carriage Return is a valid
command. This new check was introduced recently (1db168ee9, ironically
named "rebase-i: loosen over-eager check_bad_cmd check").

The proposed fix is to teach *all* shell scripts in Git to accept CR as
a field separator. Since LF is already specified as such, it should be
an uncontentious change.


Johannes Schindelin (1):
  Demonstrate rebase fails when the editor saves with CR/LF

Junio C Hamano (1):
  rebase-i: work around Windows CRLF line endings

 git-rebase--interactive.sh    | 13 +++++++++++++
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 2 files changed, 25 insertions(+)

Interdiff vs v2:

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d65c06e..daadf2d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -77,6 +77,10 @@ amend="$state_dir"/amend
 rewritten_list="$state_dir"/rewritten-list
 rewritten_pending="$state_dir"/rewritten-pending
 
+# Work around a Windows port of shell that does not strip
+# the newline at the end of a line correctly.
+cr=$(printf "\015")
+
 strategy_args=
 if test -n "$do_merge"
 then
@@ -518,6 +522,11 @@ do_next () {
 	"$comment_char"*|''|noop|drop|d)
 		mark_action_done
 		;;
+	"$cr")
+		# Windows port of shell not stripping the newline
+		# at the end of an empty line correctly.
+		mark_action_done
+		;;
 	pick|p)
 		comment_for_reflog pick
 
@@ -896,6 +905,10 @@ check_bad_cmd_and_sha () {
 		"$comment_char"*|''|noop|x|exec)
 			# Doesn't expect a SHA-1
 			;;
+		"$cr")
+			# Windows port of shell not stripping the newline
+			# at the end of an empty line correctly.
+			;;
 		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
 			if ! check_commit_sha "${rest%%[ 	]*}" "$lineno" "$1"
 			then
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index e34673d..4691fbc 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -11,9 +11,9 @@ unset CDPATH
 
 # Similarly for IFS, but some shells (e.g. FreeBSD 7.2) are buggy and
 # do not equate an unset IFS with IFS with the default, so here is
-# an explicit SP HT LF CR.
+# an explicit SP HT LF.
 IFS=' 	
-'"$(printf '\r')"
+'
 
 git_broken_path_fix () {
 	case ":$PATH:" in

-- 
2.1.4
