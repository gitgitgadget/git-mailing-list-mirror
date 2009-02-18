From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [PATCH RFC 1/2] gitweb: Fix warnings with override permitted but no repo override
Date: Tue, 17 Feb 2009 19:00:42 -0800
Message-ID: <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org>
References: <499AD871.8000808@oak.homeunix.org>
Cc: jnareb@gmail.com, fg@one2team.net, giuseppe.bilotta@gmail.com,
	pasky@suse.cz, "Marcel M. Cary" <marcel@oak.homeunix.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 04:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZchV-0005lw-TY
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 04:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbZBRDAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 22:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbZBRDAt
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 22:00:49 -0500
Received: from n26.bullet.mail.mud.yahoo.com ([68.142.206.221]:20528 "HELO
	n26.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751379AbZBRDAs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2009 22:00:48 -0500
Received: from [68.142.200.221] by n26.bullet.mail.mud.yahoo.com with NNFMP; 18 Feb 2009 03:00:47 -0000
Received: from [68.142.201.245] by t9.bullet.mud.yahoo.com with NNFMP; 18 Feb 2009 03:00:47 -0000
Received: from [127.0.0.1] by omp406.mail.mud.yahoo.com with NNFMP; 18 Feb 2009 03:00:47 -0000
X-Yahoo-Newman-Id: 287396.30263.bm@omp406.mail.mud.yahoo.com
Received: (qmail 75426 invoked from network); 18 Feb 2009 03:00:46 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.103.6 with plain)
  by smtp110.sbc.mail.sp1.yahoo.com with SMTP; 18 Feb 2009 03:00:45 -0000
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LZcfz-0002PP-Cv; Tue, 17 Feb 2009 19:00:43 -0800
X-Mailer: git-send-email 1.6.1
In-Reply-To: <499AD871.8000808@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110499>

When a feature like "blame" is permitted to be overridden in the
repository configuration but it is not actually set in the
repository, a warning is emitted due to the undefined value
of the repository configuration, even though it's a perfectly
normal condition.

The warning is grounds for test failure in the gitweb test script,
so it causes some new feature tests of mine to fail.

This patch prevents warning and adds a test case to exercise it.

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---

Here's a small patch I put together while tinkering with bug hyperlinking.
Does this look reasonable?

Marcel


 gitweb/gitweb.perl                     |    8 +++++---
 t/t9500-gitweb-standalone-no-errors.sh |    5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7c48181..653f0be 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -402,13 +402,13 @@ sub feature_bool {
 	my $key = shift;
 	my ($val) = git_get_project_config($key, '--bool');
 
-	if ($val eq 'true') {
+	if (!defined $val) {
+		return ($_[0]);
+	} elsif ($val eq 'true') {
 		return (1);
 	} elsif ($val eq 'false') {
 		return (0);
 	}
-
-	return ($_[0]);
 }
 
 sub feature_snapshot {
@@ -1978,6 +1978,8 @@ sub git_get_project_config {
 		$config_file = "$git_dir/config";
 	}
 
+	return undef if (!defined $config{"gitweb.$key"});
+
 	# ensure given type
 	if (!defined $type) {
 		return $config{"gitweb.$key"};
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 7c6f70b..559045e 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -662,6 +662,11 @@ cat >>gitweb_config.perl <<EOF
 EOF
 
 test_expect_success \
+	'config override: tree view, features not overridden in repo config' \
+	'gitweb_run "p=.git;a=tree"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
 	'config override: tree view, features disabled in repo config' \
 	'git config gitweb.blame no &&
 	 git config gitweb.snapshot none &&
-- 
1.6.1
