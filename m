From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH 1/2] git-svn: Set svn.authorsfile to an absolute path when cloning
Date: Tue,  8 Dec 2009 15:54:10 -0500
Message-ID: <1260305651-11111-1-git-send-email-alex@chmrr.net>
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 21:54:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI74p-0008Kz-SJ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 21:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965818AbZLHUyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 15:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965801AbZLHUyS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 15:54:18 -0500
Received: from chmrr.net ([209.67.253.66]:41207 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937890AbZLHUyR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 15:54:17 -0500
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1NI74e-0006ch-D1; Tue, 08 Dec 2009 15:54:23 -0500
X-Mailer: git-send-email 1.6.6.rc0.360.gc408
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-12-08 15:54:23
X-Connected-IP: 75.147.59.54:40989
X-Message-Linecount: 38
X-Body-Linecount: 30
X-Message-Size: 1281
X-Body-Size: 952
X-Received-Count: 1
X-Recipient-Count: 2
X-Local-Recipient-Count: 2
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134913>

If --authors-file is passed a relative path, cloning will work, but
future `git svn fetch`es will fail to locate the authors file
correctly.  Thus, use File::Spec->rel2abs to determine an absolute
path for the authors file before setting it.

Signed-off-by: Alex Vandiver <alex@chmrr.net>
---
 git-svn.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 957d44e..cf5e75e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -392,9 +392,11 @@ sub cmd_clone {
 		$path = $url;
 	}
 	$path = basename($url) if !defined $path || !length $path;
+	my $authors_absolute = $_authors ? File::Spec->rel2abs($_authors) : "";
 	cmd_init($url, $path);
 	Git::SVN::fetch_all($Git::SVN::default_repo_id);
-	command_oneline('config', 'svn.authorsfile', $_authors) if $_authors;
+	command_oneline('config', 'svn.authorsfile', $authors_absolute)
+	    if $_authors;
 }
 
 sub cmd_init {
-- 
1.6.6.rc0.360.gc408
