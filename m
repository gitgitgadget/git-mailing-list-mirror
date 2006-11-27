X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: use ~/.subversion config files when using SVN:: libraries
Date: Mon, 27 Nov 2006 13:20:53 -0800
Message-ID: <11646624532615-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Mon, 27 Nov 2006 21:21:24 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.g36f2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32451>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gonug-0000tL-Pn for gcvg-git@gmane.org; Mon, 27 Nov
 2006 22:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933675AbWK0VU5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 16:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933676AbWK0VU5
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 16:20:57 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60903 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S933675AbWK0VU4 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 16:20:56 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 38E072DC034; Mon, 27 Nov 2006 13:20:54 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 27 Nov 2006
 13:20:53 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This allows users to use HTTP proxy information (among other settings)
from ~/.subversion/servers and ~/.subversion/config

--config-dir (as before) may be passed to git-svn to override the
default choice of '~/.subversion' for the configuration directory.

Thanks to tko on #git for pointing this out.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index de4e74a..d5d9c49 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2822,7 +2822,9 @@ sub libsvn_connect {
 	    SVN::Client::get_username_prompt_provider(
 	      \&_username_prompt, 2),
 	  ]);
+	my $config = SVN::Core::config_get_config($_config_dir);
 	my $ra = SVN::Ra->new(url => $url, auth => $baton,
+	                      config => $config,
 	                      pool => SVN::Pool->new,
 	                      auth_provider_callbacks => $callbacks);
 	$ra->{svn_path} = $url;
@@ -2834,8 +2836,8 @@ sub libsvn_connect {
 
 sub libsvn_dup_ra {
 	my ($ra) = @_;
-	SVN::Ra->new(map { $_ => $ra->{$_} }
-	             qw/url auth auth_provider_callbacks repos_root svn_path/);
+	SVN::Ra->new(map { $_ => $ra->{$_} } qw/config url
+	             auth auth_provider_callbacks repos_root svn_path/);
 }
 
 sub libsvn_get_file {
-- 
1.4.4.1.g36f2
