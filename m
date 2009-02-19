From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] git-svn: Create leading directories in create-ignore
Date: Thu, 19 Feb 2009 13:08:04 -0500
Message-ID: <1235066884-56575-1-git-send-email-benji@silverinsanity.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 19:09:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaDLE-0000BL-3E
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 19:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbZBSSIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 13:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbZBSSIM
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 13:08:12 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:55128 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbZBSSIL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 13:08:11 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 693841FFC282; Thu, 19 Feb 2009 18:08:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=4.0 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO autolearn=ham version=3.1.7-deb3
Received: from localhost.localdomain (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	by silverinsanity.com (Postfix) with ESMTP id E99421FFC273;
	Thu, 19 Feb 2009 18:08:01 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc1.241.g7bf82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110726>

Since SVN tracks empty directories and git does not, we can not assume
that the directory exists when creating .gitignore files.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 git-svn.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index cbc5211..8acd69e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -670,7 +670,10 @@ sub cmd_create_ignore {
 	$gs->prop_walk($gs->{path}, $r, sub {
 		my ($gs, $path, $props) = @_;
 		# $path is of the form /path/to/dir/
-		my $ignore = '.' . $path . '.gitignore';
+		$path = '.' . $path;
+		# SVN can have attributes on empty directories, which git won't track
+		mkpath([$path]) unless -d $path;
+		my $ignore = $path . '.gitignore';
 		my $s = $props->{'svn:ignore'} or return;
 		open(GITIGNORE, '>', $ignore)
 		  or fatal("Failed to open `$ignore' for writing: $!");
-- 
1.6.2.rc1.241.g7bf82
