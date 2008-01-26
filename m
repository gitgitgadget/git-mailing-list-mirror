From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] pull --rebase: be cleverer with rebased upstream branches
Date: Sat, 26 Jan 2008 18:04:37 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801261801360.23907@racer.site>
References: <alpine.LSU.1.00.0801211542150.5731@racer.site> <7vir1nxcoh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 19:06:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIpPe-0005OU-9Q
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 19:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbYAZSFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 13:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbYAZSFW
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 13:05:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:44749 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750932AbYAZSFV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 13:05:21 -0500
Received: (qmail invoked by alias); 26 Jan 2008 18:05:19 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp050) with SMTP; 26 Jan 2008 19:05:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/y8d7Cp0/vzlmt3WV7f7aCHmEH2WYvExTtJiEOD
	YBKbnHBQOM7yy/
X-X-Sender: gene099@racer.site
In-Reply-To: <7vir1nxcoh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71786>


When the upstream branch is tracked, we can detect if that branch
was rebased since it was last fetched.  Teach git to use that
information to rebase from the old remote head onto the new remote head.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 21 Jan 2008, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > However, if we already have refs/remotes/blabla/master, we 
	> > could DWIM the --rebase call to
	> >
	> > 	git rebase --onto FETCH_HEAD refs/remotes/blabla/master
	> 
	> FWIW, I like it, and I think that is what users expect it to do.

	Sorry, took me quite some time.

	But I had a problem with the documentation: how am I supposed to 
	do the continuation of an indented paragraph, without using that 
	ugly "+" and unindenting the next paragraph?

 Documentation/git-pull.txt |    6 +++++-
 git-pull.sh                |   12 +++++++++++-
 t/t5520-pull.sh            |   17 +++++++++++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index f9f1e0d..4cc633a 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -35,7 +35,11 @@ include::urls-remotes.txt[]
 include::merge-strategies.txt[]
 
 \--rebase::
-	Instead of a merge, perform a rebase after fetching.
+	Instead of a merge, perform a rebase after fetching.  If
+	there is a remote ref for the upstream branch, and this branch
+	was rebased since last fetched, the rebase uses that information
+	to avoid rebasing non-local changes.
+
 	*NOTE:* This is a potentially _dangerous_ mode of operation.
 	It rewrites history, which does not bode well when you
 	published that history already.  Do *not* use this option
diff --git a/git-pull.sh b/git-pull.sh
index fa97b0f..46da0f4 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -106,6 +106,15 @@ error_on_no_merge_candidates () {
 	exit 1
 }
 
+test true = "$rebase" && {
+	. git-parse-remote &&
+	origin="$1"
+	test -z "$origin" && origin=$(get_default_remote)
+	reflist="$(get_remote_refs_for_fetch "$@" 2>/dev/null |
+		sed "s|refs/heads/\(.*\):|\1|")" &&
+	oldremoteref="$(git rev-parse --verify \
+		"refs/remotes/$origin/$reflist" 2>/dev/null)"
+}
 orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
 git-fetch --update-head-ok "$@" || exit 1
 
@@ -164,6 +173,7 @@ then
 fi
 
 merge_name=$(git fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
-test true = "$rebase" && exec git-rebase $merge_head
+test true = "$rebase" &&
+	exec git-rebase --onto $merge_head ${oldremoteref:-$merge_head}
 exec git-merge $no_summary $no_commit $squash $no_ff $strategy_args \
 	"$merge_name" HEAD $merge_head
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 52b3a0c..9484129 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -71,8 +71,25 @@ test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
 	git config branch.to-rebase.rebase 1 &&
 	git pull . copy &&
+	git config branch.to-rebase.rebase 0 &&
 	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
 '
 
+test_expect_success '--rebase with rebased upstream' '
+
+	git remote add -f me . &&
+	git checkout copy &&
+	git reset --hard HEAD^ &&
+	echo conflicting modification > file &&
+	git commit -m conflict file &&
+	git checkout to-rebase &&
+	echo file > file2 &&
+	git commit -m to-rebase file2 &&
+	git pull --rebase me copy &&
+	test "conflicting modification" = "$(cat file)" &&
+	test file = $(cat file2)
+
+'
+
 test_done
-- 
1.5.4.rc4.36.g6e122
