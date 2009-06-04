From: Ben Jackson <ben@ben.com>
Subject: [PATCHv2 1/2] Limit start revision of find_rev_before to max existing revision
Date: Wed,  3 Jun 2009 20:45:51 -0700
Message-ID: <1244087152-17002-1-git-send-email-ben@ben.com>
Cc: gitster@pobox.com, normalperson@yhbt.net, Ben Jackson <ben@ben.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 05:46:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC3uM-0003R2-M8
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 05:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbZFDDqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 23:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626AbZFDDqR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 23:46:17 -0400
Received: from kronos.home.ben.com ([71.117.242.19]:61161 "EHLO
	kronos.home.ben.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbZFDDqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 23:46:17 -0400
Received: from kronos.home.ben.com (localhost [127.0.0.1])
	by kronos.home.ben.com (8.14.3/8.14.3) with ESMTP id n543kGN3017071;
	Wed, 3 Jun 2009 20:46:16 -0700 (PDT)
Received: (from bjj@localhost)
	by kronos.home.ben.com (8.14.3/8.14.3/Submit) id n543kEBW017069;
	Wed, 3 Jun 2009 20:46:14 -0700 (PDT)
	(envelope-from bjj)
X-Mailer: git-send-email 1.6.3.GIT
X-Virus-Scanned: ClamAV 0.93.3/9418/Wed Jun  3 05:18:15 2009 on kronos.home.ben.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120676>

Signed-off-by: Ben Jackson <ben@ben.com>
---

On Wed, Jun 03, 2009 at 05:24:06PM -0700, Eric Wong wrote:
>
> find_rev_before can certainly be improved.  I haven't noticed
> performance issues with it myself, but you should be able to improve it.

This avoids a long wait if you do 'git svn reset -r 9999999'.  The
linear search within the contiguous revisions doesn't seem to be a
problem.

 git-svn.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 20bf828..b77710c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3130,6 +3130,8 @@ sub find_rev_before {
 	my ($self, $rev, $eq_ok, $min_rev) = @_;
 	--$rev unless $eq_ok;
 	$min_rev ||= 1;
+	my $max_rev = $self->rev_map_max;
+	$rev = $max_rev if ($rev > $max_rev);
 	while ($rev >= $min_rev) {
 		if (my $c = $self->rev_map_get($rev)) {
 			return ($rev, $c);
-- 
1.6.3.GIT
