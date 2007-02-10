From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] git-svn: detect SVN::Mirror breadcrumbs on multi-init
Date: Sun, 11 Feb 2007 12:15:11 +1300
Message-ID: <20070210233735.96EBF13A382@magnus.utsl.gen.nz>
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 00:37:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG1mt-00069P-Re
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 00:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbXBJXhi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 18:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbXBJXhi
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 18:37:38 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:50531 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbXBJXhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 18:37:38 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id 96EBF13A382; Sun, 11 Feb 2007 12:37:35 +1300 (NZDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39263>

SVN::Mirror leaves a little directory property on the root of its
mirrored paths to say the URL and repository UUID of the path that
this path mirrors.  If we see them, save them in the config for later
use.
---
 git-svn.perl |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0c36e8b..59d9faf 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -358,8 +358,34 @@ sub cmd_multi_init {
 						   undef, $trunk_ref);
 		}
 	}
+	my $ra;
+	if ($url) {
+		$ra = Git::SVN::Ra->new($url);
+		my $r = $ra->get_latest_revnum;
+		my (undef, undef, $props) = $ra->get_dir('', $r);
+		if ( my $src = $props->{'svm:source'} ) {
+			# don't know wtf a ! is there for, also the
+			# username is of no interest
+			$src =~ s{!$}{};
+			$src =~ s{(^[a-z\+]*://)[^/@]*@}{$1};
+
+			# XXX - is this right?
+			my $remote_id = $Git::SVN::default_repo_id;
+			my $section = "svn-remote.$remote_id";
+
+			print STDERR "SVN::Mirror breadcrumbs detected:\n",
+			    "    $src => $url\n";
+
+			# store the source as a repo-config item
+			command_noisy('config', "$section.source", $src);
+
+			my $uuid = $props->{'svm:uuid'};
+			$uuid =~ m{^[0-9a-f\-]{30,}$}
+			    or croak "doesn't look right - svm:uuid is '$uuid'";
+			command_noisy('config', "$section.uuid", $uuid);
+		}
+	}
 	return unless defined $_branches || defined $_tags;
-	my $ra = $url ? Git::SVN::Ra->new($url) : undef;
 	complete_url_ls_init($ra, $_branches, '--branches/-b', $_prefix);
 	complete_url_ls_init($ra, $_tags, '--tags/-t', $_prefix . 'tags/');
 }
-- 
1.5.0.rc3.g3e023
