From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] gitweb: pass the option name to the feature callback
Date: Mon, 15 Dec 2008 23:36:38 -0800
Message-ID: <1229412998-8385-1-git-send-email-kraai@ftbfs.org>
References: <1229408179-7655-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 08:39:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCUWH-0000ga-Qt
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 08:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767AbYLPHhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 02:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755755AbYLPHhJ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 02:37:09 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:47858 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755724AbYLPHhH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 02:37:07 -0500
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net ([71.119.193.199] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1LCUUA-0002lQ-Dr; Mon, 15 Dec 2008 23:36:58 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1LCUTu-0002DD-Gg; Mon, 15 Dec 2008 23:36:38 -0800
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1229408179-7655-1-git-send-email-kraai@ftbfs.org>
X-Spam-Score-Int: -41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103254>

The feature_bool callback required the option name to be passed to
it.  Make gitweb_get_feature do so instead of constructing an
anonymous subroutine for each overrideable boolean option.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 gitweb/gitweb.perl |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

   Sorry for the churn; I read the corresponding part of Higher-Order
   Perl *after* sending my previous patches.  :(

   If I should squash this into my previous patch and resubmit it,
   please let me know.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 827e5c5..3459293 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -203,7 +203,7 @@ our %feature = (
 	# $feature{'blame'}{'override'} = 1;
 	# and in project config gitweb.blame = 0|1;
 	'blame' => {
-		'sub' => sub { feature_bool('blame', @_) },
+		'sub' => \&feature_bool,
 		'override' => 0,
 		'default' => [0]},
 
@@ -241,7 +241,7 @@ our %feature = (
 	# $feature{'grep'}{'override'} = 1;
 	# and in project config gitweb.grep = 0|1;
 	'grep' => {
-		'sub' => sub { feature_bool('grep', @_) },
+		'sub' => \&feature_bool,
 		'override' => 0,
 		'default' => [1]},
 
@@ -255,7 +255,7 @@ our %feature = (
 	# $feature{'pickaxe'}{'override'} = 1;
 	# and in project config gitweb.pickaxe = 0|1;
 	'pickaxe' => {
-		'sub' => sub { feature_bool('pickaxe', @_) },
+		'sub' => \&feature_bool,
 		'override' => 0,
 		'default' => [1]},
 
@@ -344,7 +344,7 @@ sub gitweb_get_feature {
 		warn "feature $name is not overrideable";
 		return @defaults;
 	}
-	return $sub->(@defaults);
+	return $sub->($name, @defaults);
 }
 
 # A wrapper to check if a given feature is enabled.
@@ -377,9 +377,9 @@ sub feature_bool {
 }
 
 sub feature_snapshot {
-	my (@fmts) = @_;
+	my ($key, @fmts) = @_;
 
-	my ($val) = git_get_project_config('snapshot');
+	my ($val) = git_get_project_config($key);
 
 	if ($val) {
 		@fmts = ($val eq 'none' ? () : split /\s*[,\s]\s*/, $val);
-- 
1.5.6.5
