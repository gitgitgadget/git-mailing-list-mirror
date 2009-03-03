From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] rebase -i: avoid 'git reset' when possible
Date: Tue, 3 Mar 2009 10:55:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903031024420.6399@intel-tinevez-2-302>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com> <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302> <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com> <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302>
 <alpine.DEB.1.00.0902271354130.6600@intel-tinevez-2-302> <7vvdqt8wob.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903012242180.10279@pacific.mpi-cbg.de> <7v1vtfl8xi.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903031008580.6399@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 10:57:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeRN2-00086v-NA
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 10:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbZCCJzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 04:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbZCCJzg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 04:55:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:41261 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752834AbZCCJzf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 04:55:35 -0500
Received: (qmail invoked by alias); 03 Mar 2009 09:55:33 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp018) with SMTP; 03 Mar 2009 10:55:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KAHUHOJMKmG/DMBVB+ru4ApECaESraMxxT5Wm+Y
	p+LMuaWqxIf+Gm
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.0903031008580.6399@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112045>

When picking commits whose parents have not changed, we do not need to
rewrite the commit.  We do not need to reset the working directory to
the parent's state, either.

Requested by Sverre Rabbelier.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Actually, I did not think things through.  Of _course_ we need
	that rev-parse, to determine the parent of the to-be-picked
	commit.

	Changes since v1: use only one loop instead of counting the number 
	of skipped commits first, and then actually skipping them.

 git-rebase--interactive.sh    |   26 ++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |   11 +++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3dc659d..72f7fc7 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -442,6 +442,30 @@ do_rest () {
 	done
 }
 
+# skip picking commits whose parents are unchanged
+skip_unnecessary_picks () {
+	fd=3
+	while read command sha1 rest
+	do
+		# fd=3 means we skip the command
+		case "$fd,$command,$(git rev-parse --verify --quiet $sha1^)" in
+		3,pick,"$ONTO"*|t,p,"$ONTO"*)
+			# pick a commit whose parent is current $ONTO -> skip
+			ONTO=$sha1
+			;;
+		3,#*|3,,*)
+			# copy comments
+			;;
+		*)
+			fd=1
+			;;
+		esac
+		echo "$command${sha1:+ }$sha1${rest:+ }$rest" >&$fd
+	done < "$TODO" > "$TODO.new" 3>> "$DONE" &&
+	mv -f "$TODO".new "$TODO" ||
+	die "Could not skip unnecessary pick commands"
+}
+
 # check if no other options are set
 is_standalone () {
 	test $# -eq 2 -a "$2" = '--' &&
@@ -746,6 +770,8 @@ EOF
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
1.6.2.rc1.456.g3dbe7
