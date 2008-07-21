From: Brad King <brad.king@kitware.com>
Subject: [PATCH 2/2] git-svn: make use of svn auto-props optional
Date: Mon, 21 Jul 2008 17:40:29 -0400
Message-ID: <4885024D.2070402@kitware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060902070202050200080103"
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 23:49:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL3GH-0002fz-VJ
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 23:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbYGUVsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 17:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753742AbYGUVsl
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 17:48:41 -0400
Received: from public.kitware.com ([66.194.253.19]:38933 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572AbYGUVsk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 17:48:40 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jul 2008 17:48:40 EDT
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id 6046F1FC6;
	Mon, 21 Jul 2008 17:41:49 -0400 (EDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by hythloth (Postfix) with ESMTP id 78FF44F71E;
	Mon, 21 Jul 2008 17:40:29 -0400 (EDT)
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89409>

This is a multi-part message in MIME format.
--------------060902070202050200080103
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


In order to preserve existing default behavior, dcommit should use svn
auto-props only if instructed to do so.  This commit creates a config
option 'svn.autoprops' to enable the behavior.

Signed-off-by: Brad King <brad.king@kitware.com>
---
Topics for discussion:

Should we instead call this option 'useAutoProps' or some other name?

Does a 'svn-remote.<name>.autoprops' version make sense?
(I'll need help with this one because I'm learning perl just for this).

Should we still honor/require the svn config option 'enable-auto-props',
or treat that as an option specific to 'svn add' and let this git-specific
one take over here?

 Documentation/git-svn.txt |    7 +++++++
 git-svn.perl              |    7 +++++--
 2 files changed, 12 insertions(+), 2 deletions(-)




--------------060902070202050200080103
Content-Type: text/x-patch;
 name="4c068ff135558651ac51de5771815b40e63a2c07.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="4c068ff135558651ac51de5771815b40e63a2c07.diff"

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index e7c0f1c..300a9e0 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -448,6 +448,13 @@ svn-remote.<name>.rewriteRoot::
 	the repository with a public http:// or svn:// URL in the
 	metadata so users of it will see the public URL.
 
+svn.autoprops::
+
+	Tells 'dcommit' to use '[auto-props]' entries from the user
+	SVN configuration to set properties on added files.  The
+	'enable-auto-props' option in the user SVN configuration must
+	also be enabled.
+
 --
 
 Since the noMetadata, rewriteRoot, useSvnsyncProps and useSvmProps
diff --git a/git-svn.perl b/git-svn.perl
index 1975b62..9e8799d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -73,6 +73,7 @@ my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache );
 my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'authors-file|A=s' => \$_authors,
+		'autoprops' => \$Git::SVN::_auto_props,
 		'repack:i' => \$Git::SVN::_repack,
 		'noMetadata' => \$Git::SVN::_no_metadata,
 		'useSvmProps' => \$Git::SVN::_use_svm_props,
@@ -1273,7 +1274,7 @@ use constant rev_map_fmt => 'NH40';
 use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
             $_repack $_repack_flags $_use_svm_props $_head
             $_use_svnsync_props $no_reuse_existing $_minimize_url
-	    $_use_log_author $_add_author_from/;
+	    $_use_log_author $_add_author_from $_auto_props/;
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
@@ -3581,7 +3582,9 @@ sub A {
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 					undef, -1);
 	print "\tA\t$m->{file_b}\n" unless $::_q;
-        $self->apply_autoprops($file, $fbat);
+	if ($Git::SVN::_auto_props) {
+		$self->apply_autoprops($file, $fbat);
+	}
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }





--------------060902070202050200080103--
