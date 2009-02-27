From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: avoid 'git reset' when possible
Date: Fri, 27 Feb 2009 13:56:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902271354130.6600@intel-tinevez-2-302>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com>  <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302> <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com> <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 14:00:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld2IL-0001cT-3L
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 13:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191AbZB0M45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 07:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbZB0M44
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 07:56:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:51068 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750831AbZB0M44 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 07:56:56 -0500
Received: (qmail invoked by alias); 27 Feb 2009 12:56:53 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp055) with SMTP; 27 Feb 2009 13:56:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8cqYuuCG8ZijxIrfMk7PXiq08O5DuM42SQZMVwu
	EtcfRPZwMsHJE5
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111668>

When picking commits whose parents have not changed, we do not need to
rewrite the commit.  We do not need to reset the working directory to
the parent's state, either.

Requested by Sverre Rabbelier.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 27 Feb 2009, Johannes Schindelin wrote:

	> Having said that, I think yours might be such a common case that
	> it is worth optimizing for.

	And so I did.

 git-rebase--interactive.sh    |   23 +++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |   11 +++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3dc659d..a9617a2 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -442,6 +442,27 @@ do_rest () {
 	done
 }
 
+# skip picking commits whose parents are unchanged
+skip_unnecessary_picks () {
+	current=$ONTO
+	i=0
+	while read command sha1 rest
+	do
+		test pick = "$command" &&
+		test $current = "$(git rev-parse $sha1^)" ||
+		break
+		current=$(git rev-parse $sha1)
+		i=$(($i+1))
+	done < "$TODO"
+	test $i = 0 || {
+		sed -e "${i}q" < "$TODO" >> "$DONE" &&
+		sed -e "1,${i}d" < "$TODO" >> "$TODO".new &&
+		mv -f "$TODO".new "$TODO" &&
+		ONTO=$current ||
+		die "Could not skip $i pick commands"
+	}
+}
+
 # check if no other options are set
 is_standalone () {
 	test $# -eq 2 -a "$2" = '--' &&
@@ -746,6 +767,8 @@ EOF
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
+		test -d "$REWRITTEN" || skip_unnecessary_picks
+
 		git update-ref ORIG_HEAD $HEAD
 		output git checkout $ONTO && do_rest
 		;;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 603b003..c32ff66 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -459,4 +459,15 @@ test_expect_success 'submodule rebase -i' '
 	FAKE_LINES="1 squash 2 3" git rebase -i A
 '
 
+test_expect_success 'avoid unnecessary reset' '
+	git checkout master &&
+	test-chmtime =123456789 file3 &&
+	git update-index --refresh &&
+	HEAD=$(git rev-parse HEAD) &&
+	git rebase -i HEAD~4 &&
+	test $HEAD = $(git rev-parse HEAD) &&
+	MTIME=$(test-chmtime -v +0 file3 | sed 's/[^0-9].*$//') &&
+	test 123456789 = $MTIME
+'
+
 test_done
-- 
1.6.2.rc1.350.g6caf6
