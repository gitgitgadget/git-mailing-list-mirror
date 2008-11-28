From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 1/2] gitweb: fixes to gitweb feature check code
Date: Fri, 28 Nov 2008 21:39:52 +0100
Message-ID: <1227904793-1821-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1227904793-1821-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 28 21:41:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6A91-0007Jo-En
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 21:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbYK1Ujg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 15:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbYK1Ujg
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 15:39:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:16189 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbYK1Ujf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 15:39:35 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2079235ugf.37
        for <git@vger.kernel.org>; Fri, 28 Nov 2008 12:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=57cS0UMs6G1fbE1rRSMQ+9387On0FUDDRs7eOx0qDdA=;
        b=lhMuMuJ2SAIOA3LEhhemCDy0KFwIcpxtvW8Zy6YtrVmyZNgE1kU7EzJE8GH3DdL6T4
         mSZy5Y9FU3TN1lO0qn5teRu+OPfas0iw3thjAMp0eRTR2qDU/FoeCsa8FJxmTgy5Sux9
         3fo5zxoqrLvEXc4zxG8jF6ptRgFYh6WBNmfus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m14qZANZTaYAuEmySPFVp1uWmotr2yT0WqLm/GiLzacCjQ+MH/4uGQq220s9iD1Cju
         iVO6sljqbRzGmnhg1Qk2t7gk48tliDIyYGh62Qrghx9manDrvngUQ8DIcrBJwQAJSQc0
         treZqQJpsPR9nspcrcjtD1IZ3SixZmu9wc3PQ=
Received: by 10.103.92.8 with SMTP id u8mr3293904mul.34.1227904774247;
        Fri, 28 Nov 2008 12:39:34 -0800 (PST)
Received: from localhost ([78.15.14.10])
        by mx.google.com with ESMTPS id y37sm2691247mug.36.2008.11.28.12.39.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Nov 2008 12:39:33 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1227904793-1821-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101883>

The gitweb_check_feature routine was being used for two different
purposes: retrieving the actual feature value (such as the list of
snapshot formats or the list of additional actions), and to check if a
feature was enabled.

For the latter use, since all features return an array, it led to either
clumsy code or subtle bugs, with disabled features appearing enabled
because (0) evaluates to 1.

We fix these bugs, and simplify the code, by separating feature (list)
value retrieval (gitweb_get_feature) from boolean feature check (i.e.
retrieving the first/only item in the feature value list). Usage of
gitweb_check_feature is replaced by gitweb_get_feature where
appropriate.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 933e137..128d7ad 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -190,7 +190,9 @@ our %feature = (
 	# if there is no 'sub' key (no feature-sub), then feature cannot be
 	# overriden
 	#
-	# use gitweb_check_feature(<feature>) to check if <feature> is enabled
+	# use gitweb_get_feature(<feature>) to retrieve the <feature> value
+	# (an array) or gitweb_check_feature(<feature>) to check if <feature>
+	# is enabled
 
 	# Enable the 'blame' blob view, showing the last commit that modified
 	# each line in the file. This can be very CPU-intensive.
@@ -329,7 +331,8 @@ our %feature = (
 		'default' => [0]},
 );
 
-sub gitweb_check_feature {
+# retrieve the value of a given feature, as an array
+sub gitweb_get_feature {
 	my ($name) = @_;
 	return unless exists $feature{$name};
 	my ($sub, $override, @defaults) = (
@@ -344,6 +347,21 @@ sub gitweb_check_feature {
 	return $sub->(@defaults);
 }
 
+# check if a given feature is enabled or not, returning the first (and only)
+# value of the feature. Comfort code, allowing the use of
+#   my $bool_feat = gitweb_check_feature('bool_feat');
+# or
+#   gitweb_check_feature('bool_feat') or somecode;
+# instead of
+#   my ($bool_feat) = gitweb_git_feature('bool_feat');
+# or
+#   (gitweb_check_feature('bool_feat'))[0] or somecode;
+# respectively
+sub gitweb_check_feature {
+	return (gitweb_get_feature(@_))[0];
+}
+
+
 sub feature_blame {
 	my ($val) = git_get_project_config('blame', '--bool');
 
@@ -767,7 +785,7 @@ our $git_dir;
 $git_dir = "$projectroot/$project" if $project;
 
 # list of supported snapshot formats
-our @snapshot_fmts = gitweb_check_feature('snapshot');
+our @snapshot_fmts = gitweb_get_feature('snapshot');
 @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 
 # dispatch
@@ -3084,7 +3102,7 @@ sub git_print_page_nav {
 	$arg{'tree'}{'hash'} = $treehead if defined $treehead;
 	$arg{'tree'}{'hash_base'} = $treebase if defined $treebase;
 
-	my @actions = gitweb_check_feature('actions');
+	my @actions = gitweb_get_feature('actions');
 	my %repl = (
 		'%' => '%',
 		'n' => $project,         # project name
-- 
1.5.6.5
