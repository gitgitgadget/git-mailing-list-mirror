From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Support for custom per-project owner string
Date: Wed, 20 Sep 2006 00:55:22 +0200
Message-ID: <20060919225522.GB13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=fixed
X-From: git-owner@vger.kernel.org Wed Sep 20 00:55:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPoUx-0003jH-OS
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWISWzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbWISWzZ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:55:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2966 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751096AbWISWzY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 18:55:24 -0400
Received: (qmail 27881 invoked by uid 2001); 20 Sep 2006 00:55:22 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27310>

This adds very simple support for per-project setting of the owner string
(in an environment where the actual owners won't have access to the
repositories accessed by gitweb, so faking identity is not an issue).

There should be an option to disable this, but this is just a patch
that someone might like (and/or pick up and polish), not intended for
inclusion as it is.

Also, ideally this would be in the configfile but calling repoconfig for
each repository in the index would slow things down way too much.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7ecd7df..d50bae5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -818,6 +818,13 @@ sub git_get_project_owner {
 		}
 		close $fd;
 	}
+	if (!defined $owner and -f "$projectroot/$project/owner") {
+		if (open my $fd, "$projectroot/$project/owner") {
+			$owner = <$fd>;
+			chomp $owner;
+			close $fd;
+		}
+	}
 	if (!defined $owner) {
 		$owner = get_file_owner("$projectroot/$project");
 	}
@@ -2186,7 +2193,7 @@ sub git_project_list {
 			$pr->{'descr'} = chop_str($descr, 25, 5);
 		}
 		if (!defined $pr->{'owner'}) {
-			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}") || "";
+			$pr->{'owner'} = git_get_project_owner($pr->{'path'}) || "";
 		}
 		push @projects, $pr;
 	}
@@ -2275,7 +2282,7 @@ sub git_project_index {
 
 	foreach my $pr (@projects) {
 		if (!exists $pr->{'owner'}) {
-			$pr->{'owner'} = get_file_owner("$projectroot/$project");
+			$pr->{'owner'} = git_get_project_owner($project);
 		}
 
 		my ($path, $owner) = ($pr->{'path'}, $pr->{'owner'});
