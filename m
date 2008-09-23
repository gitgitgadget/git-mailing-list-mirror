From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH maint] git-stash.sh: don't default to refs/stash if invalid
 ref supplied
Date: Tue, 23 Sep 2008 18:57:09 -0500
Message-ID: <twy9P1UnbmZHs2ZDeFBjSzrleLQ225-I7ESNrFkwoXZL-mJCTf4hYw@cipher.nrlssc.navy.mil>
References: <klevRMI-z5Id8iuqn2rqrKQZ8LdPNE4lABeC502X9y1Es5wwQ-s8GA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: mattjackets <mattlist@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Sep 24 01:58:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiHlv-0006VX-Ie
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 01:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbYIWX5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 19:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbYIWX5O
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 19:57:14 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43108 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYIWX5N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 19:57:13 -0400
Received: by mail.nrlssc.navy.mil id m8NNvACO008206; Tue, 23 Sep 2008 18:57:10 -0500
In-Reply-To: <klevRMI-z5Id8iuqn2rqrKQZ8LdPNE4lABeC502X9y1Es5wwQ-s8GA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 23 Sep 2008 23:57:10.0331 (UTC) FILETIME=[17A090B0:01C91DD8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96612>

apply_stash() and show_stash() each call rev-parse with
'--default refs/stash' as an argument. This option causes rev-parse to
operate on refs/stash if it is not able to successfully operate on any
element of the command line. This includes failure to supply a "valid"
revision. This has the effect of causing 'stash apply' and 'stash show'
to operate as if stash@{0} had been supplied when an invalid revision is
supplied.

e.g. 'git stash apply stahs@{1}' would fall back to
     'git stash apply stash@{0}'

This patch modifies these two functions so that they avoid using the
--default option of rev-parse.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This should fix the case I mention above, but it does not fix the
case where a non-existent reflog entry is specified. In this case
the last entry will be selected.

	$ git stash list
	stash@{0}: WIP on master: c050772... small java change
	stash@{1}: WIP on master: c050772... small java change
	stash@{2}: WIP on master: c050772... small java change
	stash@{3}: WIP on master: c050772... small java change
	$ git stash apply stash@{10}
	warning: Log for 'stash' only has 4 entries.
	# On branch master
	# Changed but not updated:
	... etc.

stash@{3} was applied.

Luckily, the dangerous case has no effect.

	$ git stash drop stash@{10}
	Dropped stash@{10} (b7a2467e58109c92d799d059f508f35853d0bff7)
	$ git stash list
	stash@{0}: WIP on master: c050772... small java change
	stash@{1}: WIP on master: c050772... small java change
	stash@{2}: WIP on master: c050772... small java change
	stash@{3}: WIP on master: c050772... small java change

-brandon


 git-stash.sh |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index d799c76..6bd2572 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -144,7 +144,14 @@ show_stash () {
 	then
 		flags=--stat
 	fi
-	s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@")
+
+	if test $# = 0
+	then
+		set x "$ref_stash@{0}"
+		shift
+	fi
+
+	s=$(git rev-parse --revs-only --no-flags "$@")
 
 	w_commit=$(git rev-parse --verify "$s") &&
 	b_commit=$(git rev-parse --verify "$s^") &&
@@ -163,13 +170,19 @@ apply_stash () {
 		shift
 	esac
 
+	if test $# = 0
+	then
+		set x "$ref_stash@{0}"
+		shift
+	fi
+
 	# current index state
 	c_tree=$(git write-tree) ||
 		die 'Cannot apply a stash in the middle of a merge'
 
 	# stash records the work tree, and is a merge between the
 	# base commit (first parent) and the index tree (second parent).
-	s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@") &&
+	s=$(git rev-parse --revs-only --no-flags "$@") &&
 	w_tree=$(git rev-parse --verify "$s:") &&
 	b_tree=$(git rev-parse --verify "$s^1:") &&
 	i_tree=$(git rev-parse --verify "$s^2:") ||
-- 
1.6.0.1.244.gdc19
