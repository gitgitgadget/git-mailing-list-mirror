From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] cvsimport: handle the parsing of uppercase config options
Date: Wed, 29 Dec 2010 22:55:34 +0100
Message-ID: <1f8628ba77f5aaeb00a627c851b431274b60c740.1293659350.git.git@drmicha.warpmail.net>
References: <cover.1293659350.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 22:55:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY3zA-0007TG-LK
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 22:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab0L2Vy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 16:54:56 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:37573 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753917Ab0L2Vyz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Dec 2010 16:54:55 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E27A9600
	for <git@vger.kernel.org>; Wed, 29 Dec 2010 16:54:54 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 29 Dec 2010 16:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=7SqVKhmxk2NUStaOaA2ifY6uvdw=; b=lPbZiF9sX4GGbh+sDHx7i7HWmrlj6ohXtZTLAHy70HcHYRWRfEzBZlH5iB7pBExRbNYlPQT6Vg+H+VUWWmv01Lt4z3Qoqiw2LjhHHAsdUP0YoGelMvEx99Qtwx1NblYFBzyXQFUvC9TlCT7vTUIjRLAnO6Ze46GOL+CoP2tj6VQ=
X-Sasl-enc: RLYbEOHF5YqU83/5nMhTpQigyV46MVUk8yl6pCvF/Vm4 1293659694
Received: from localhost (p54858E58.dip0.t-ipconnect.de [84.133.142.88])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0782B441338;
	Wed, 29 Dec 2010 16:54:53 -0500 (EST)
X-Mailer: git-send-email 1.7.3.4.865.ga2bc4
In-Reply-To: <cover.1293659350.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164335>

The current code leads to

fatal: bad config value for 'cvsimport.r' in .git/config

for a standard use case with cvsimport.r set:

cvsimport sets internal variables by checking the config for each
possible command line option. The problem is that config items are case
insensitive, so config.r and config.R are the same. The ugly error is
due to that fact that cvsimport expects a bool for -R (and thus
config.R) but a remote name for -r (and thus config.r).

Fix this by making cvsimport expect long names for uppercase options.

config options for cvsimport have been undocumented so far, though
present in the code and advertised in several tutorials. So one may read
"enhance" for "fix". Similarly, the names for the options are
"documented" in the code, waitiing for their lowercase equivalents to be
transformed into long config options, as well.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-cvsimport.perl   |   19 ++++++++++++++++++-
 t/t9600-cvsimport.sh |    7 +++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 7888b77..8e683e5 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -90,6 +90,14 @@ sub write_author_info($) {
 }
 
 # convert getopts specs for use by git config
+my %longmap = (
+	'A:' => 'authors-file',
+	'M:' => 'merge-regex',
+	'P:' => undef,
+	'R' => 'track-revisions',
+	'S:' => 'ignore-paths',
+);
+
 sub read_repo_config {
 	# Split the string between characters, unless there is a ':'
 	# So "abc:de" becomes ["a", "b", "c:", "d", "e"]
@@ -99,8 +107,17 @@ sub read_repo_config {
 		$key =~ s/://g;
 		my $arg = 'git config';
 		$arg .= ' --bool' if ($o !~ /:$/);
-
-		chomp(my $tmp = `$arg --get cvsimport.$key`);
+		my $ckey = $key;
+
+		if (exists $longmap{$o}) {
+			# An uppercase option like -R cannot be
+			# expressed in the configuration, as the
+			# variable names are downcased.
+			$ckey = $longmap{$o};
+			next if (! defined $ckey);
+			$ckey =~ s/-//g;
+		}
+		chomp(my $tmp = `$arg --get cvsimport.$ckey`);
 		if ($tmp && !($arg =~ /--bool/ && $tmp eq 'false')) {
 			no strict 'refs';
 			my $opt_name = "opt_" . $key;
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 432b82e..4c384ff 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -89,7 +89,8 @@ EOF
 test_expect_success PERL 'update git module' '
 
 	(cd module-git &&
-	git cvsimport -a -R -z 0 module &&
+	git config cvsimport.trackRevisions true &&
+	git cvsimport -a -z 0 module &&
 	git merge origin
 	) &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna
@@ -117,7 +118,8 @@ test_expect_success PERL 'cvsimport.module config works' '
 
 	(cd module-git &&
 		git config cvsimport.module module &&
-		git cvsimport -a -R -z0 &&
+		git config cvsimport.trackRevisions true &&
+		git cvsimport -a -z0 &&
 		git merge origin
 	) &&
 	test_cmp module-cvs/tick module-git/tick
@@ -137,6 +139,7 @@ test_expect_success PERL 'import from a CVS working tree' '
 
 	$CVS co -d import-from-wt module &&
 	(cd import-from-wt &&
+		git config cvsimport.trackRevisions false &&
 		git cvsimport -a -z0 &&
 		echo 1 >expect &&
 		git log -1 --pretty=format:%s%n >actual &&
-- 
1.7.3.4.865.ga2bc4
