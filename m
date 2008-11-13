From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v2 05/11] gitweb: git_split_heads_body function.
Date: Thu, 13 Nov 2008 23:49:11 +0100
Message-ID: <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 23:50:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0l1U-0004iw-V4
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbYKMWtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbYKMWtO
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:49:14 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:61591 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbYKMWtK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:49:10 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1167024fkq.5
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 14:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dHizDpXfsTMEOcRnelH1wTloy1BarXKd5F/uo7XQftM=;
        b=yHrn9jws6sY8CQg6IHLCLoZGAMn4Mj7D+baCn/Ruxl0Kkq2fw+uWwvQkShRaCP+CTy
         y0DqDfKEgkNhY5LXnchCiC3FJhKK96M59KtQcBsjqnLyqMrBcSrv3FZ8LwMFSfP8sWle
         twWfsc0TPQQxggRyDm87ZbQMIENosfzqdIfZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m3TXE442llCBeYdRqsvxIZSVTY8SQF/2vpBiJ6C6weg8vLVQ0JwqxBUWEerRMGWn4+
         2KCiCOFOYCvOz3rlO/F5NUbM6egUAvUhS47Trv1rbF7pr8B47icOLXNAZ/i1I3eprt4Z
         EhBRL9Yj3d35afnfmAIeQHP9Hh8+zFCh+f4xg=
Received: by 10.181.226.2 with SMTP id d2mr63077bkr.204.1226616547147;
        Thu, 13 Nov 2008 14:49:07 -0800 (PST)
Received: from localhost ([78.15.2.247])
        by mx.google.com with ESMTPS id y15sm5455403fkd.17.2008.11.13.14.49.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 14:49:06 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of this function is to split a headlist into groups
determined by the leading part of the refname, and call git_heads_body()
on each group.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a736f2a..836b6ba 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4271,6 +4271,37 @@ sub git_tags_body {
 	print "</table>\n";
 }
 
+sub git_split_heads_body {
+	my ($headlist, $head, $from, $to, $extra) = @_;
+	my %headlists;
+	my $leader; my $list; my @list;
+
+	# Split @$headlist into a hash of lists
+	map {
+		my %ref = %$_;
+		$ref{'hname'} = $ref{'name'};
+		if ($ref{'name'} =~ /\//) {
+			$ref{'name'} =~ s!^([^/]+)/!!;
+			$leader = $1;
+		} else {
+			$leader = "\000";
+		}
+		if (defined $headlists{$leader}) {
+			@list = @{$headlists{$leader}}
+		} else {
+			@list = ()
+		}
+		push @list, \%ref;
+		$headlists{$leader} = [@list];
+	} @$headlist;
+
+	foreach $leader (sort(keys %headlists)) {
+		print "<b>$leader</b><br/>\n" unless $leader eq "\000";
+		$list = $headlists{$leader};
+		git_heads_body($list, $head, $from, $to, $extra);
+	}
+}
+
 sub git_heads_body {
 	# uses global variable $project
 	my ($headlist, $head, $from, $to, $extra) = @_;
@@ -4541,7 +4572,7 @@ sub git_summary {
 
 	if (@remotelist) {
 		git_print_header_div('remotes');
-		git_heads_body(\@remotelist, $head, 0, 15,
+		git_split_heads_body(\@remotelist, $head, 0, 15,
 		               $#remotelist <= 15 ? undef :
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
-- 
1.5.6.5
