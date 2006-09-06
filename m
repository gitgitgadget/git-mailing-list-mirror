From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/7] gitweb: Make pickaxe search a feature
Date: Wed,  6 Sep 2006 15:08:05 +0200
Message-ID: <1157548091229-git-send-email-jnareb@gmail.com>
References: <200609061504.40725.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 06 15:08:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKx8g-0005m3-KW
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 15:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWIFNIT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 09:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWIFNIT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 09:08:19 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:40427 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750855AbWIFNIR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 09:08:17 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k86D6prD031848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Sep 2006 15:06:52 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k86D8Bfp008395;
	Wed, 6 Sep 2006 15:08:11 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k86D8B3G008394;
	Wed, 6 Sep 2006 15:08:11 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <200609061504.40725.jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26524>

As pickaxe search (selected using undocumented 'pickaxe:' operator in
search query) is resource consuming, allow to turn it on/off using
feature meachanism.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d6f546d..e95d16f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -93,6 +93,11 @@ our %feature = (
 		'override' => 0,
 		#         => [content-encoding, suffix, program]
 		'default' => ['x-gzip', 'gz', 'gzip']},
+
+	'pickaxe' => {
+		'sub' => \&feature_pickaxe,
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_check_feature {
@@ -146,6 +151,24 @@ sub feature_snapshot {
 	return ($ctype, $suffix, $command);
 }
 
+# To enable system wide have in $GITWEB_CONFIG
+# $feature{'pickaxe'}{'default'} = [1];
+# To have project specific config enable override in $GITWEB_CONFIG
+# $feature{'pickaxe'}{'override'} = 1;
+# and in project config gitweb.pickaxe = 0|1;
+
+sub feature_pickaxe {
+	my ($val) = git_get_project_config('pickaxe', '--bool');
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
 # rename detection options for git-diff and git-diff-tree
 # - default is '-M', with the cost proportional to
 #   (number of removed files) * (number of new files).
@@ -3131,8 +3154,7 @@ sub git_search {
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
 	}
-	# pickaxe may take all resources of your box and run for several minutes
-	# with every query - so decide by yourself how public you make this feature :)
+
 	my $commit_search = 1;
 	my $author_search = 0;
 	my $committer_search = 0;
@@ -3144,6 +3166,13 @@ sub git_search {
 	} elsif ($searchtext =~ s/^pickaxe\\://i) {
 		$commit_search = 0;
 		$pickaxe_search = 1;
+
+		# pickaxe may take all resources of your box and run for several minutes
+		# with every query - so decide by yourself how public you make this feature
+		my ($have_pickaxe) = gitweb_check_feature('pickaxe');
+		if (!$have_pickaxe) {
+			die_error('403 Permission denied', "Permission denied");
+		}
 	}
 	git_header_html();
 	git_print_page_nav('','', $hash,$co{'tree'},$hash);
-- 
1.4.2
