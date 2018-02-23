Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE5E1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 17:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeBWRV4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 12:21:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:57582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751351AbeBWRVz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 12:21:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 56704AE21;
        Fri, 23 Feb 2018 17:21:54 +0000 (UTC)
From:   "Bernhard M. Wiedemann" <bwiedemann@suse.de>
To:     git@vger.kernel.org
Cc:     Ben Walton <bdwalton@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Ryuichi Kokubo <ryu1kkb@gmail.com>,
        "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Subject: [PATCH] Call timegm and timelocal with 4-digit year
Date:   Fri, 23 Feb 2018 18:20:45 +0100
Message-Id: <20180223172045.32090-1-bwiedemann@suse.de>
X-Mailer: git-send-email 2.13.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

amazingly timegm(gmtime(0)) is only 0 before 2020
because perl's timegm deviates from GNU timegm(3) in how it handles years.

man Time::Local says

 Whenever possible, use an absolute four digit year instead.

with a detailed explanation about ambiguity of 2-digit years above that.

Even though this ambiguity is error-prone with >50% of users getting it
wrong, it has been like this for 20+ years, so we just use 4-digit years
everywhere to be on the safe side.

We add some extra logic to cvsimport because it allows 2-digit year
input and interpreting an 18 as 1918 can be avoided easily and safely.

Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>
---
 contrib/examples/git-svnimport.perl | 2 +-
 git-cvsimport.perl                  | 4 +++-
 perl/Git.pm                         | 4 +++-
 perl/Git/SVN.pm                     | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/examples/git-svnimport.perl b/contrib/examples/git-svnimport.perl
index c414f0d9c..75a43e23b 100755
--- a/contrib/examples/git-svnimport.perl
+++ b/contrib/examples/git-svnimport.perl
@@ -238,7 +238,7 @@ sub pdate($) {
 	my($d) = @_;
 	$d =~ m#(\d\d\d\d)-(\d\d)-(\d\d)T(\d\d):(\d\d):(\d\d)#
 		or die "Unparseable date: $d\n";
-	my $y=$1; $y-=1900 if $y>1900;
+	my $y=$1; $y+=1900 if $y<1000;
 	return timegm($6||0,$5,$4,$3,$2-1,$y);
 }
 
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 2d8df8317..b31613cb8 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -601,7 +601,9 @@ sub pdate($) {
 	my ($d) = @_;
 	m#(\d{2,4})/(\d\d)/(\d\d)\s(\d\d):(\d\d)(?::(\d\d))?#
 		or die "Unparseable date: $d\n";
-	my $y=$1; $y-=1900 if $y>1900;
+	my $y=$1;
+	$y+=100 if $y<70;
+	$y+=1900 if $y<1000;
 	return timegm($6||0,$5,$4,$3,$2-1,$y);
 }
 
diff --git a/perl/Git.pm b/perl/Git.pm
index ffa09ace9..df62518c7 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -534,7 +534,9 @@ If TIME is not supplied, the current local time is used.
 sub get_tz_offset {
 	# some systems don't handle or mishandle %z, so be creative.
 	my $t = shift || time;
-	my $gm = timegm(localtime($t));
+	my @t = localtime($t);
+	$t[5] += 1900;
+	my $gm = timegm(@t);
 	my $sign = qw( + + - )[ $gm <=> $t ];
 	return sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
 }
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index bc4eed3d7..991a5885e 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1405,7 +1405,7 @@ sub parse_svn_date {
 		$ENV{TZ} = 'UTC';
 
 		my $epoch_in_UTC =
-		    Time::Local::timelocal($S, $M, $H, $d, $m - 1, $Y - 1900);
+		    Time::Local::timelocal($S, $M, $H, $d, $m - 1, $Y);
 
 		# Determine our local timezone (including DST) at the
 		# time of $epoch_in_UTC.  $Git::SVN::Log::TZ stored the
-- 
2.13.6

