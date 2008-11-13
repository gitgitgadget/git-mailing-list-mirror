From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v2 03/11] gitweb: separate heads and remotes list in summary view
Date: Thu, 13 Nov 2008 23:49:09 +0100
Message-ID: <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 23:50:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0l1T-0004iw-JK
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbYKMWtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbYKMWtH
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:49:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:31154 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbYKMWtB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:49:01 -0500
Received: by fg-out-1718.google.com with SMTP id 19so912881fgg.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 14:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=d/NCBtYvXLayJEUSogKm4AZxn08/JZDreFmvE3/68Lk=;
        b=BCRxh1kB3o3UJpnum6NSjCzOL0tLT6mAup1Z+yaZmtNn1nMMqgrwBW9NOqm7XE14hN
         BMKWv1yA3gIwkzJRX8S3mRelBJOJ3+7bkZG6Cow/WdlBtO3OS/33zjfv2bGMGKQ089ML
         xrsDEGVAH8E/n2l4DtfjKR5/HBDOGo4gVfsSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oir7d6M3bUSUVM97aO1kShyfiRxy6NmxJBPGdwAmi6hluGsVXzs/LvAgxFMoZ+8Sso
         9SjWPR6eYAEDEp/g9xRwJk89/u7Nwam+KtC9xYXO9N1OmTwJC6QM3Gpd6aMMMcis9evT
         elmes7YyNHmJ06vX1ihpQ1ydnSE6xgQgFkuAw=
Received: by 10.180.252.8 with SMTP id z8mr66601bkh.158.1226616541036;
        Thu, 13 Nov 2008 14:49:01 -0800 (PST)
Received: from localhost ([78.15.2.247])
        by mx.google.com with ESMTPS id h2sm5419962fkh.11.2008.11.13.14.48.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 14:49:00 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d7c97a3..ab29aec 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4449,6 +4449,7 @@ sub git_summary {
 	my %co = parse_commit("HEAD");
 	my %cd = %co ? parse_date($co{'committer_epoch'}, $co{'committer_tz'}) : ();
 	my $head = $co{'id'};
+	my ($remote_heads) = gitweb_check_feature('remote_heads');
 
 	my $owner = git_get_project_owner($project);
 
@@ -4456,7 +4457,8 @@ sub git_summary {
 	# These get_*_list functions return one more to allow us to see if
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
-	my @headlist = git_get_heads_list(16);
+	my @headlist = git_get_heads_list(16, 'heads');
+	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
 	my @forklist;
 	my ($check_forks) = gitweb_check_feature('forks');
 
@@ -4535,6 +4537,13 @@ sub git_summary {
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
 
+	if (@remotelist) {
+		git_print_header_div('remotes');
+		git_heads_body(\@remotelist, $head, 0, 15,
+		               $#remotelist <= 15 ? undef :
+		               $cgi->a({-href => href(action=>"heads")}, "..."));
+	}
+
 	if (@forklist) {
 		git_print_header_div('forks');
 		git_project_list_body(\@forklist, 'age', 0, 15,
-- 
1.5.6.5
