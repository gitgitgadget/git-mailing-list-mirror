From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v2 01/11] gitweb: introduce remote_heads feature
Date: Thu, 13 Nov 2008 23:49:07 +0100
Message-ID: <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 23:50:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0l0t-0004Vv-E4
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbYKMWs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYKMWs7
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:48:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:31154 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbYKMWs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:48:57 -0500
Received: by fg-out-1718.google.com with SMTP id 19so912881fgg.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 14:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=04552Vp2EuB+kaOCdfwO8LjZvhiz/skInpfgvr52AFw=;
        b=CzQzRhzp8zcKvQWut1Zcahj6ORwXeWyPWvGdLevmFG+C2eIqeEp3y+t5/NJnEtiro1
         +FE04mnIVoKLeRp3Bm/MJbGMq1uUnSDlZrEaVO8EeE7FAqxEa5gqjth6TsplTxJnPqQR
         AwfBRT6G2oPdZYQqDn6NDXm4v021zxTgq5inw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wkdOAM7Di+Cnxld36hoc/NCK5cFWxmKOynwBFGvrx9FIcvzbi3SYHwq3V/uIslN/Ma
         o1nq/TcQ3PxVKOIjYOUCoeB6Z0MI6boieB/XGW2uPIi6tqV2j7FFJDBm0FvU7XeRlymw
         LLTJI0nQy6G5fPsnqvT8t73Vo4x6qEb+wEwHI=
Received: by 10.181.61.2 with SMTP id o2mr69997bkk.101.1226616535118;
        Thu, 13 Nov 2008 14:48:55 -0800 (PST)
Received: from localhost ([78.15.2.247])
        by mx.google.com with ESMTPS id z15sm5425940fkz.16.2008.11.13.14.48.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 14:48:54 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With this feature enabled, remotes are retrieved (and displayed)
when getting (and displaying) the heads list.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 933e137..b6c4233 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -327,6 +327,18 @@ our %feature = (
 	'ctags' => {
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
@@ -392,6 +404,18 @@ sub feature_pickaxe {
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
@@ -2642,10 +2666,12 @@ sub git_get_heads_list {
 	my $limit = shift;
 	my @headslist;
 
+	my ($remote_heads) = gitweb_check_feature('remote_heads');
+
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
 		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-		'refs/heads'
+		'refs/heads', ( $remote_heads ? 'refs/remotes' : '')
 		or return;
 	while (my $line = <$fd>) {
 		my %ref_item;
@@ -2656,8 +2682,9 @@ sub git_get_heads_list {
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
 		$ref_item{'fullname'}  = $name;
-		$name =~ s!^refs/heads/!!;
+		$name =~ s!^refs/(head|remote)s/!!;
 
+		$ref_item{'class'} = $1;
 		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
 		$ref_item{'title'} = $title || '(no commit message)';
-- 
1.5.6.5
