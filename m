From: Jason Merrill <jason@redhat.com>
Subject: [PATCH] git-svn: add fetch --parent option
Date: Mon, 06 Apr 2009 16:37:59 -0400
Message-ID: <49DA6827.9020204@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060406040807000600050702"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 22:40:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqvbW-0003nT-Dq
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 22:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbZDFUiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 16:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753019AbZDFUiF
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 16:38:05 -0400
Received: from mx2.redhat.com ([66.187.237.31]:50213 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbZDFUiC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 16:38:02 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n36Kc1Kv022098
	for <git@vger.kernel.org>; Mon, 6 Apr 2009 16:38:01 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n36Kc2p0024115
	for <git@vger.kernel.org>; Mon, 6 Apr 2009 16:38:02 -0400
Received: from [127.0.0.1] (sebastian-int.corp.redhat.com [172.16.52.221])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n36Kc1R5012022
	for <git@vger.kernel.org>; Mon, 6 Apr 2009 16:38:01 -0400
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115877>

This is a multi-part message in MIME format.
--------------060406040807000600050702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------060406040807000600050702
Content-Type: text/x-patch;
 name="0001-git-svn-add-fetch-parent-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-git-svn-add-fetch-parent-option.patch"


Signed-off-by: Jason Merrill <jason@redhat.com>
---
rebase fetches only the SVN parent of the current HEAD; it should
be possible to do that with fetch as well, for instance to support
rebasing with stg rebase rather than git rebase.

 Documentation/git-svn.txt |    3 +++
 git-svn.perl              |   18 ++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b7b1af8..85b2c8d 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -97,6 +97,9 @@ COMMANDS
 	makes 'git-log' (even without --date=local) show the same times
 	that `svn log` would in the local timezone.
 
+--parent;;
+	Fetch only from the SVN parent of the current HEAD.
+
 This doesn't interfere with interoperating with the Subversion
 repository you cloned from, but if you wish for your local Git
 repository to be able to interoperate with someone else's local Git
diff --git a/git-svn.perl b/git-svn.perl
index d919798..cb718b8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -63,7 +63,7 @@ $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_stdin, $_help, $_edit,
 	$_message, $_file,
 	$_template, $_shared,
-	$_version, $_fetch_all, $_no_rebase,
+	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
 	$_git_format, $_commit_url, $_tag);
@@ -112,6 +112,7 @@ my %cmd = (
 	fetch => [ \&cmd_fetch, "Download new revisions from SVN",
 			{ 'revision|r=s' => \$_revision,
 			  'fetch-all|all' => \$_fetch_all,
+			  'parent|p' => \$_fetch_parent,
 			   %fc_opts } ],
 	clone => [ \&cmd_clone, "Initialize and fetch revisions",
 			{ 'revision|r=s' => \$_revision,
@@ -381,12 +382,21 @@ sub cmd_fetch {
 	}
 	my ($remote) = @_;
 	if (@_ > 1) {
-		die "Usage: $0 fetch [--all] [svn-remote]\n";
+		die "Usage: $0 fetch [--all] [--parent] [svn-remote]\n";
 	}
-	$remote ||= $Git::SVN::default_repo_id;
-	if ($_fetch_all) {
+	if ($_fetch_parent) {
+		my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+		unless ($gs) {
+			die "Unable to determine upstream SVN information from ",
+			    "working tree history\n";
+		}
+	        # just fetch, don't checkout.
+		$_no_checkout = 'true';
+		$_fetch_all ? $gs->fetch_all : $gs->fetch;
+	} elsif ($_fetch_all) {
 		cmd_multi_fetch();
 	} else {
+		$remote ||= $Git::SVN::default_repo_id;
 		Git::SVN::fetch_all($remote, Git::SVN::read_all_remotes());
 	}
 }
-- 
1.6.2.2


--------------060406040807000600050702--
