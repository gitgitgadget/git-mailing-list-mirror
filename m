From: "martin f. krafft" <madduck@madduck.net>
Subject: [PATCH] git-svn init/clone --stdlayout option to default-init trunk/tags/branches
Date: Sat, 14 Jul 2007 11:25:28 +0200
Message-ID: <1184405128718-git-send-email-madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 12:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9egw-0003OX-8d
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 12:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166AbXGNKRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 06:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754598AbXGNKRc
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 06:17:32 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:56172 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbXGNKRa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 06:17:30 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 8AF07895D7D
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 12:17:29 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30832-04 for <git@vger.kernel.org>;
	Sat, 14 Jul 2007 12:17:29 +0200 (CEST)
Received: from lapse.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 4717E895D72
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 12:17:29 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 66F564FD4B; Sat, 14 Jul 2007 11:25:27 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc1.9.gf029
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52462>

The --stdlayout option to git-svn init/clone initialises the default
Subversion values of trunk,tags,branches: -T trunk -b branches -t tags.
If any of the -T/-t/-b options are given in addition, they are given
preference.

Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 Documentation/git-svn.txt |    6 +++++-
 git-svn.perl              |   11 +++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 0a210e4..9e74b27 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -44,10 +44,14 @@ COMMANDS
 --tags=<tags_subdir>;;
 -b<branches_subdir>;;
 --branches=<branches_subdir>;;
+--stdlayout;;
 	These are optional command-line options for init.  Each of
 	these flags can point to a relative repository path
 	(--tags=project/tags') or a full url
-	(--tags=https://foo.org/project/tags)
+	(--tags=https://foo.org/project/tags). The option --stdlayout is
+	a shorthand way of setting trunk,tags,branches as the relative paths,
+	which is the Subversion default. If any of the other options are given
+	as well, they take precedence.
 --no-metadata;;
 	Set the 'noMetadata' option in the [svn-remote] config.
 --use-svm-props;;
diff --git a/git-svn.perl b/git-svn.perl
index b3dffcc..affba8e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -77,11 +77,12 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		   \$Git::SVN::_repack_flags,
 		%remote_opts );
 
-my ($_trunk, $_tags, $_branches);
+my ($_trunk, $_tags, $_branches, $_stdlayout);
 my %icv;
 my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
                   'trunk|T=s' => \$_trunk, 'tags|t=s' => \$_tags,
                   'branches|b=s' => \$_branches, 'prefix=s' => \$_prefix,
+                  'stdlayout' => \$_stdlayout,
                   'minimize-url|m' => \$Git::SVN::_minimize_url,
 		  'no-metadata' => sub { $icv{noMetadata} = 1 },
 		  'use-svm-props' => sub { $icv{useSvmProps} = 1 },
@@ -292,7 +293,8 @@ sub init_subdir {
 sub cmd_clone {
 	my ($url, $path) = @_;
 	if (!defined $path &&
-	    (defined $_trunk || defined $_branches || defined $_tags) &&
+	    (defined $_trunk || defined $_branches || defined $_tags ||
+		defined $_stdlayout) &&
 	    $url !~ m#^[a-z\+]+://#) {
 		$path = $url;
 	}
@@ -302,6 +304,11 @@ sub cmd_clone {
 }
 
 sub cmd_init {
+        if (defined $_stdlayout) {
+          $_trunk = 'trunk' if (!defined $_trunk);
+          $_tags = 'tags' if (!defined $_tags);
+          $_branches = 'branches' if (!defined $_branches);
+        }
 	if (defined $_trunk || defined $_branches || defined $_tags) {
 		return cmd_multi_init(@_);
 	}
-- 
1.5.3.rc1.9.gf029
