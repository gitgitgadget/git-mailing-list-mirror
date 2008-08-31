From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] git svn: catch lack of upstream info for dcommit earlier
Date: Sun, 31 Aug 2008 15:50:59 +0200
Message-ID: <1220190659-5955-1-git-send-email-trast@student.ethz.ch>
References: <c7d83d0d0808310029s15c1413m49cad5c68a568271@mail.gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 15:52:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZnLm-0006aJ-Ls
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 15:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756642AbYHaNvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 09:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756620AbYHaNvE
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 09:51:04 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:35459 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756616AbYHaNvD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 09:51:03 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 31 Aug 2008 15:50:59 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 31 Aug 2008 15:50:59 +0200
X-Mailer: git-send-email 1.6.0.1.278.g5a622
In-Reply-To: <c7d83d0d0808310029s15c1413m49cad5c68a568271@mail.gmail.com>
X-OriginalArrivalTime: 31 Aug 2008 13:50:59.0774 (UTC) FILETIME=[9995BDE0:01C90B70]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94481>

Since 711521e 'git svn dcommit' attempts to use the upstream
information to determine the SVN URL, before it verifies that it even
found an upstream.  Move up the corresponding check.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Weyert de Boer wrote:
> Can't call method "full_url" on an undefined value at
> /opt/local/libexec/git-core/git-svn line 425.

After resolving the problem on IRC, here's the fix to avoid the
unhelpful message.


 git-svn.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7a1d26d..43bf201 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -421,15 +421,15 @@ sub cmd_dcommit {
 	$head ||= 'HEAD';
 	my @refs;
 	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
+	unless ($gs) {
+		die "Unable to determine upstream SVN information from ",
+		    "$head history.\nPerhaps the repository is empty.";
+	}
 	$url = defined $_commit_url ? $_commit_url : $gs->full_url;
 	my $last_rev = $_revision if defined $_revision;
 	if ($url) {
 		print "Committing to $url ...\n";
 	}
-	unless ($gs) {
-		die "Unable to determine upstream SVN information from ",
-		    "$head history.\nPerhaps the repository is empty.";
-	}
 	my ($linear_refs, $parents) = linearize_history($gs, \@refs);
 	if ($_no_rebase && scalar(@$linear_refs) > 1) {
 		warn "Attempting to commit more than one change while ",
-- 
1.6.0.1.278.g5a622
