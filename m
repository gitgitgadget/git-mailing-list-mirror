From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [MONKEY PATCH] git-svn: allow two branch configurations
Date: Thu, 18 Jun 2009 16:31:03 +0200
Message-ID: <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net>
References: <4A3A4945.6050307@drmicha.warpmail.net>
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Eric Wong <normalperson@yhbt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 16:31:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHIeT-0004qv-89
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 16:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761790AbZFROba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 10:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760016AbZFROb3
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 10:31:29 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60272 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759599AbZFROb2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 10:31:28 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id EFC2F35E535;
	Thu, 18 Jun 2009 10:31:30 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 18 Jun 2009 10:31:31 -0400
X-Sasl-enc: myHZ+yM618Mh0VKJnZGbMKxvxKON9SVjkbdwIPk2USUM 1245335490
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4467128382;
	Thu, 18 Jun 2009 10:31:30 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.406.gd6a466
In-Reply-To: <4A3A4945.6050307@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121847>

This is a MONKEY PATCH which introduces a long option and config
variable "branchse" analogous to "branches", with a short option "-B".
It has the same meaning and can be used to accomadate svn repos with two
different branches subdirectories.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-svn.perl |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

Well, this is not a serious patch per se, but it shows that git-svn can
very well handle multiple branches configs once it is told to read and
use them. I don't think it's possible to do this with globs, and
extending globs to regexps looks like a more complicated approach
(although they are used internally).

I see two viable options for a real patch now:
- Extend $remote->branches to be an array and use "config --get-all" to
  read the config; do the same for tags.
- Use one single array for branches as well as tags.

Eric, which way do you prefer? The first one is simpler and may be even
doable for me. The second looks more complicated mainly because of "git
svn branch -t" (which element of the combined array is tags?), even
though it's more natural if one thinks about the way svn works.

Michael

diff --git a/git-svn.perl b/git-svn.perl
index 3301797..e6a9422 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -92,11 +92,12 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'localtime' => \$Git::SVN::_localtime,
 		%remote_opts );
 
-my ($_trunk, $_tags, $_branches, $_stdlayout);
+my ($_trunk, $_tags, $_branches, $_branchse, $_stdlayout);
 my %icv;
 my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
                   'trunk|T=s' => \$_trunk, 'tags|t=s' => \$_tags,
                   'branches|b=s' => \$_branches, 'prefix=s' => \$_prefix,
+                  'branchse|B=s' => \$_branchse,
                   'stdlayout|s' => \$_stdlayout,
                   'minimize-url|m' => \$Git::SVN::_minimize_url,
 		  'no-metadata' => sub { $icv{noMetadata} = 1 },
@@ -358,7 +359,7 @@ sub init_subdir {
 sub cmd_clone {
 	my ($url, $path) = @_;
 	if (!defined $path &&
-	    (defined $_trunk || defined $_branches || defined $_tags ||
+	    (defined $_trunk || defined $_branches || defined $_branchse || defined $_tags ||
 	     defined $_stdlayout) &&
 	    $url !~ m#^[a-z\+]+://#) {
 		$path = $url;
@@ -375,7 +376,7 @@ sub cmd_init {
 		$_tags = 'tags' if (!defined $_tags);
 		$_branches = 'branches' if (!defined $_branches);
 	}
-	if (defined $_trunk || defined $_branches || defined $_tags) {
+	if (defined $_trunk || defined $_branches || defined $_branchse || defined $_tags) {
 		return cmd_multi_init(@_);
 	}
 	my $url = shift or die "SVN repository location required ",
@@ -800,7 +801,7 @@ sub cmd_proplist {
 
 sub cmd_multi_init {
 	my $url = shift;
-	unless (defined $_trunk || defined $_branches || defined $_tags) {
+	unless (defined $_trunk || defined $_branches || defined $_branchse || defined $_tags) {
 		usage(1);
 	}
 
@@ -825,9 +826,10 @@ sub cmd_multi_init {
 						   undef, $trunk_ref);
 		}
 	}
-	return unless defined $_branches || defined $_tags;
+	return unless defined $_branches || defined $_branchse || defined $_tags;
 	my $ra = $url ? Git::SVN::Ra->new($url) : undef;
 	complete_url_ls_init($ra, $_branches, '--branches/-b', $_prefix);
+	complete_url_ls_init($ra, $_branchse, '--branchse/-B', $_prefix);
 	complete_url_ls_init($ra, $_tags, '--tags/-t', $_prefix . 'tags/');
 }
 
@@ -1563,7 +1565,7 @@ sub fetch_all {
 	my $base = defined $fetch ? $head : 0;
 
 	# read the max revs for wildcard expansion (branches/*, tags/*)
-	foreach my $t (qw/branches tags/) {
+	foreach my $t (qw/branches branchse tags/) {
 		defined $remote->{$t} or next;
 		push @globs, $remote->{$t};
 		my $max_rev = eval { tmp_config(qw/--int --get/,
@@ -1609,7 +1611,7 @@ sub read_all_remotes {
 			$r->{$1}->{svm} = {};
 		} elsif (m!^(.+)\.url=\s*(.*)\s*$!) {
 			$r->{$1}->{url} = $2;
-		} elsif (m!^(.+)\.(branches|tags)=
+		} elsif (m!^(.+)\.(branches|branchse|tags)=
 		           (.*):refs/remotes/(.+)\s*$/!x) {
 			my ($p, $g) = ($3, $4);
 			my $rs = $r->{$1}->{$2} = {
@@ -1760,7 +1762,7 @@ sub find_by_url { # repos_root and, path are optional
 		next if defined $repos_root && $repos_root ne $u;
 
 		my $fetch = $remotes->{$repo_id}->{fetch} || {};
-		foreach (qw/branches tags/) {
+		foreach (qw/branches branchse tags/) {
 			resolve_local_globs($u, $fetch,
 			                    $remotes->{$repo_id}->{$_});
 		}
-- 
1.6.3.2.406.gd6a466
