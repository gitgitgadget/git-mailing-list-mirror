From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Make pickaxe search a feature
Date: Mon, 11 Sep 2006 00:29:27 +0200
Message-ID: <200609110029.28021.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 11 00:29:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMXo0-0001v9-Lz
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 00:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWIJW3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 18:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWIJW3d
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 18:29:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:1832 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932154AbWIJW3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 18:29:33 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1038328nfa
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 15:29:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Tcq/xemi61r/PYz3Qiu9cNl0N8TvybiputE8UWxwowPotX6P6ePf8sf60wyQ6N2EWyaUgC7sNIZIxiTymXPv5XLhPjOpVKa6A0RKqbo0FvcHekbsZ2781+ky3roO+CWOILXVKV3tJTRjDb3FFPeUir4TUFeMHh+tMe/Ykqu8CvM=
Received: by 10.49.41.18 with SMTP id t18mr7254172nfj;
        Sun, 10 Sep 2006 15:29:31 -0700 (PDT)
Received: from host-81-190-17-209.torun.mm.pl ( [81.190.17.209])
        by mx.gmail.com with ESMTP id 28sm4201378hua.2006.09.10.15.29.27;
        Sun, 10 Sep 2006 15:29:27 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26818>

As pickaxe search (selected using undocumented 'pickaxe:' operator in
search query) is resource consuming, allow to turn it on/off using
feature meachanism.  Turned on by default, for historical reasons.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The difference compared to the previous version is that it is turned
on by default.

 gitweb/gitweb.perl |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d89f709..53e3478 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -90,6 +90,11 @@ our %feature = (
 		'override' => 0,
 		#         => [content-encoding, suffix, program]
 		'default' => ['x-gzip', 'gz', 'gzip']},
+
+	'pickaxe' => {
+		'sub' => \&feature_pickaxe,
+		'override' => 0,
+		'default' => [1]},
 );
 
 sub gitweb_check_feature {
@@ -143,6 +148,24 @@ sub feature_snapshot {
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
@@ -3128,8 +3151,7 @@ sub git_search {
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
 	}
-	# pickaxe may take all resources of your box and run for several minutes
-	# with every query - so decide by yourself how public you make this feature :)
+
 	my $commit_search = 1;
 	my $author_search = 0;
 	my $committer_search = 0;
@@ -3141,6 +3163,13 @@ sub git_search {
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
