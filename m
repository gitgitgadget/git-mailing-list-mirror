From: Vineet Kumar <vineet@doorstop.net>
Subject: [PATCH] git-svn: add a show-externals command.
Date: Mon, 19 Nov 2007 14:56:15 -0800
Message-ID: <1195512975-3647-1-git-send-email-vineet@doorstop.net>
Cc: Vineet Kumar <vineet@doorstop.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 20 00:51:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuGOo-0000GG-2K
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 00:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbXKSXvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 18:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbXKSXvM
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 18:51:12 -0500
Received: from doorstop.net ([69.55.226.61]:47155 "EHLO philo.doorstop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbXKSXvL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 18:51:11 -0500
X-Greylist: delayed 3295 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2007 18:51:11 EST
Received: from vineet by philo.doorstop.net with local (Exim 4.63)
	(envelope-from <vineet@doorstop.net>)
	id 1IuFXL-00011T-SW; Mon, 19 Nov 2007 14:56:15 -0800
X-Mailer: git-send-email 1.5.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65518>

show-externals can be used by scripts to provide svn:externals-like
functionality.  For example, a script can list all of the externals and then
use check out the listed URLs at the appropriate paths, similar to what the svn
client does.  Said script (or perhaps git-svn itself, in the future) could
simply invoke svn export on the paths, or it could go one further, using
git-svn clone and even git-submodule together to better integrate externals
checkouts.

The implementation is shamelessly copied from show-ignores.  A more general
command to list user-specified properties is probably a better idea.

Signed-off-by: Vineet Kumar <vineet@doorstop.net>
---
 git-svn.perl |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 5b1deea..74966ed 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -141,6 +141,9 @@ my %cmd = (
 	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
 			{ 'revision|r=i' => \$_revision
 			} ],
+	'show-externals' => [ \&cmd_show_externals, "Show svn:externals listings",
+			{ 'revision|r=i' => \$_revision
+			} ],
 	'multi-fetch' => [ \&cmd_multi_fetch,
 	                   "Deprecated alias for $0 fetch --all",
 			   { 'revision|r=s' => \$_revision, %fc_opts } ],
@@ -560,6 +563,21 @@ sub cmd_show_ignore {
 	});
 }
 
+sub cmd_show_externals {
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	$gs ||= Git::SVN->new;
+	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
+	$gs->prop_walk($gs->{path}, $r, sub {
+		my ($gs, $path, $props) = @_;
+		print STDOUT "\n# $path\n";
+		my $s = $props->{'svn:externals'} or return;
+		$s =~ s/[\r\n]+/\n/g;
+		chomp $s;
+		$s =~ s#^#$path#gm;
+		print STDOUT "$s\n";
+	});
+}
+
 sub cmd_create_ignore {
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
-- 
1.5.3.4
