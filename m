X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/3] git-svn: fix multi-init
Date: Tue, 28 Nov 2006 18:51:42 -0800
Message-ID: <1164768705707-git-send-email-normalperson@yhbt.net>
References: <1164768702941-git-send-email-normalperson@yhbt.net> <11647687042130-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Wed, 29 Nov 2006 02:52:02 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.g22a08
In-Reply-To: <11647687042130-git-send-email-normalperson@yhbt.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32607>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpFY7-0006gY-C1 for gcvg-git@gmane.org; Wed, 29 Nov
 2006 03:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756498AbWK2Cvs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 21:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755795AbWK2Cvs
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 21:51:48 -0500
Received: from hand.yhbt.net ([66.150.188.102]:12930 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1756498AbWK2Cvr (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 21:51:47 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id BF2E82DC035; Tue, 28 Nov 2006 18:51:45 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 28 Nov 2006
 18:51:45 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

After the bugfix to connect to repositories where the user has
limited read permissions, multi-init was broken due to our
SVN::Ra connection being limited to working in a subdirectory;
so we now create a new Ra connection for init-ing branches
and another for tags

Along with that fix, allow the user to use the command-line
option flags for multi-init (--revision being the most notable;
but also --no-auth-cache, --config-dir, --username (for passing
to SVN), and --shared/--template for passing to git-init-db

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d8d8716..3891122 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -124,7 +124,12 @@ my %cmd = (
 			  'no-graft-copy' => \$_no_graft_copy } ],
 	'multi-init' => [ \&multi_init,
 			'Initialize multiple trees (like git-svnimport)',
-			{ %multi_opts, %fc_opts } ],
+			{ %multi_opts, %init_opts,
+			 'revision|r=i' => \$_revision,
+			 'username=s' => \$_username,
+			 'config-dir=s' => \$_config_dir,
+			 'no-auth-cache' => \$_no_auth_cache,
+			} ],
 	'multi-fetch' => [ \&multi_fetch,
 			'Fetch multiple trees (like git-svnimport)',
 			\%fc_opts ],
@@ -3316,11 +3321,11 @@ sub libsvn_commit_cb {
 
 sub libsvn_ls_fullurl {
 	my $fullurl = shift;
-	$SVN ||= libsvn_connect($fullurl);
+	my $ra = libsvn_connect($fullurl);
 	my @ret;
 	my $pool = SVN::Pool->new;
-	my ($dirent, undef, undef) = $SVN->get_dir($SVN->{svn_path},
-						$SVN->get_latest_revnum, $pool);
+	my $r = defined $_revision ? $_revision : $ra->get_latest_revnum;
+	my ($dirent, undef, undef) = $ra->get_dir('', $r, $pool);
 	foreach my $d (keys %$dirent) {
 		if ($dirent->{$d}->kind == $SVN::Node::dir) {
 			push @ret, "$d/"; # add '/' for compat with cli svn
-- 
1.4.4.1.g22a08
