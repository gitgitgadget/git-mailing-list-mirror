From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 02/14] gitweb: make remote heads in heads list optional
Date: Fri, 31 Aug 2007 12:55:12 +0200
Message-ID: <11885577122839-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 12:57:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4BV-0005Jq-Br
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 12:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbXHaK4x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 06:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbXHaK4x
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 06:56:53 -0400
Received: from jack.tiscali.it ([213.205.33.53]:37503 "EHLO jack.tiscali.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476AbXHaK4w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 06:56:52 -0400
Received: from localhost.localdomain (84.221.55.162) by jack.tiscali.it (7.3.122)
        id 46A8A7D10038FBAB; Fri, 31 Aug 2007 12:56:51 +0200
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57150>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 65953db..6514bef 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -271,6 +271,18 @@ our %feature = (
 	'forks' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# Make gitweb show remotes too in the heads list
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'remote_heads'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'remote_heads'}{'override'} = 1;
+	# and in project config gitweb.remote_heads = 0|1;
+	'remote_heads' => {
+		'sub' => \&feature_remote_heads,
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_check_feature {
@@ -336,6 +348,18 @@ sub feature_pickaxe {
 	return ($_[0]);
 }
 
+sub feature_remote_heads {
+	my ($val) = git_get_project_config('remote_heads', '--bool');
+
+	if ($val eq 'true') {
+		return (1);
+	} elsif ($val eq 'false') {
+		return (0);
+	}
+
+	return ($_[0]);
+}
+
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
@@ -2060,10 +2084,12 @@ sub git_get_heads_list {
 	my $limit = shift;
 	my @headslist;
 
+	my ($remote_heads) = gitweb_check_feature('remote_heads');
+
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
 		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-		'refs/heads', 'refs/remotes'
+		'refs/heads', ( $remote_heads ? 'refs/remotes' : '')
 		or return;
 	while (my $line = <$fd>) {
 		my %ref_item;
-- 
1.5.2.5
