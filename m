From: Toby Allsopp <toby.allsopp@navman.co.nz>
Subject: [PATCH 2/2] git-svn: handle SVN merges from revisions past the tip of the branch
Date: Fri, 13 Nov 2009 09:18:48 +1300
Message-ID: <871vk35o86.fsf@navakl084.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 00:30:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8j7f-0007Yn-Bj
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 00:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbZKLXa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 18:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbZKLXa2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 18:30:28 -0500
Received: from ip-58-28-171-25.wxnz.net ([58.28.171.25]:57855 "EHLO
	AKLEXFE01.mitacad.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755156AbZKLXa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 18:30:27 -0500
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2009 18:30:27 EST
Received: from AKLEXVS01.mitacad.com ([10.112.5.36]) by AKLEXFE01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Nov 2009 12:15:40 +1300
Received: from navakl084.mitacad.com.navman.co.nz ([10.112.8.86]) by AKLEXVS01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Nov 2009 12:15:39 +1300
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
X-OriginalArrivalTime: 12 Nov 2009 23:15:39.0263 (UTC) FILETIME=[0C4400F0:01CA63EE]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-6.000.1038-17006.000
X-TM-AS-Result: No-0.037400-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132804>

When recording the revisions that it has merged, SVN sets the top
revision to be the latest revision in the repository, which is not
necessarily a revision on the branch that is being merged from.  When
it is not on the branch, git-svn fails to add the extra parent to
represent the merge because it relies on finding the commit on the
branch that corresponds to the top of the SVN merge range.

In order to correctly handle this case, we look for the maximum
revision less than or equal to the top of the SVN merge range that is
actually on the branch being merged from.

Signed-off-by: Toby Allsopp <toby.allsopp@navman.co.nz>
---
 git-svn.perl             |    7 +++++--
 t/t9151-svn-mergeinfo.sh |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 6a3b501..27fbe30 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2950,8 +2950,11 @@ sub find_extra_svn_parents {
 			my $bottom_commit =
 				$gs->rev_map_get($bottom, $self->ra_uuid) ||
 				$gs->rev_map_get($bottom+1, $self->ra_uuid);
-			my $top_commit =
-				$gs->rev_map_get($top, $self->ra_uuid);
+			my $top_commit;
+			for (; !$top_commit && $top >= $bottom; --$top) {
+				$top_commit =
+					$gs->rev_map_get($top, $self->ra_uuid);
+			}
 
 			unless ($top_commit and $bottom_commit) {
 				warn "W:unknown path/rev in svn:mergeinfo "
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 0d42c84..f57daf4 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -19,7 +19,7 @@ test_expect_success 'represent svn merges without intervening commits' "
 	[ `git cat-file commit HEAD^1 | grep parent | wc -l` -eq 2 ]
 	"
 
-test_expect_failure 'represent svn merges with intervening commits' "
+test_expect_success 'represent svn merges with intervening commits' "
 	[ `git cat-file commit HEAD | grep parent | wc -l` -eq 2 ]
 	"
 
-- 
1.6.5.2.155.gbb47.dirty
