From: Alex Vandiver <alexmv@MIT.EDU>
Subject: [PATCH 1/2] git-svn: Fix for svn paths removed > log-window-size revisions ago
Date: Wed,  6 May 2009 16:18:52 -0400
Message-ID: <1241641133-6974-1-git-send-email-alexmv@mit.edu>
Cc: Alex Vandiver <alexmv@MIT.EDU>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 22:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1nqf-0004fl-TJ
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 22:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629AbZEFUgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 16:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbZEFUgE
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 16:36:04 -0400
Received: from SOUTH-STATION-ANNEX.MIT.EDU ([18.72.1.2]:61248 "EHLO
	south-station-annex.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751171AbZEFUgD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 16:36:03 -0400
Received: from grand-central-station.mit.edu (GRAND-CENTRAL-STATION.MIT.EDU [18.7.21.82])
	by south-station-annex.mit.edu (8.13.6/8.9.2) with ESMTP id n46KJILQ025356;
	Wed, 6 May 2009 16:19:19 -0400 (EDT)
Received: from outgoing-legacy.mit.edu (OUTGOING-LEGACY.MIT.EDU [18.7.22.104])
	by grand-central-station.mit.edu (8.13.6/8.9.2) with ESMTP id n46KJ3lW018855;
	Wed, 6 May 2009 16:19:04 -0400 (EDT)
Received: from localhost.localdomain (75-147-59-54-NewEngland.hfc.comcastbusiness.net [75.147.59.54])
	)
	by outgoing-legacy.mit.edu (8.13.6/8.12.4) with ESMTP id n46KJ10u003118;
	Wed, 6 May 2009 16:19:03 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc4.225.g060aa4
X-Scanned-By: MIMEDefang 2.42
X-Spam-Score: -2.464
X-Spam-Flag: NO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118380>

Instead of trying to find the end of the commit history only in the
last window, track if we have seen commits yet, and use that to judge
if we need to backtrack and look for a tail.  Otherwise, conversion
can silently lose up to 100 revisions of a branch if it was deleted
>100 revisions ago.

Signed-off-by: Alex Vandiver <alexmv@mit.edu>
---
 git-svn.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ef1d30d..5836dde 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4438,6 +4438,7 @@ sub gs_fetch_loop_common {
 	my ($min, $max) = ($base, $head < $base + $inc ? $head : $base + $inc);
 	my $longest_path = longest_common_path($gsv, $globs);
 	my $ra_url = $self->{url};
+	my $find_trailing_edge;
 	while (1) {
 		my %revs;
 		my $err;
@@ -4455,8 +4456,10 @@ sub gs_fetch_loop_common {
 		               sub { $revs{$_[1]} = _cb(@_) });
 		if ($err) {
 			print "Checked through r$max\r";
+		} else {
+			$find_trailing_edge = 1;
 		}
-		if ($err && $max >= $head) {
+		if ($err and $find_trailing_edge) {
 			print STDERR "Path '$longest_path' ",
 				     "was probably deleted:\n",
 				     $err->expanded_message,
@@ -4475,6 +4478,7 @@ sub gs_fetch_loop_common {
 					last;
 				}
 			}
+			$find_trailing_edge = 0;
 		}
 		$SVN::Error::handler = $err_handler;
 
-- 
1.6.3.rc4.225.g060aa4
