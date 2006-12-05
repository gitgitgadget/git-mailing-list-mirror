X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 2/5] git-svn: let libsvn_ls_fullurl return properties too
Date: Tue, 05 Dec 2006 16:17:38 +1100
Message-ID: <20061205051738.16552.59004.stgit@localhost>
References: <20061205051738.16552.8987.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Tue, 5 Dec 2006 05:22:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061205051738.16552.8987.stgit@localhost>
User-Agent: StGIT/0.10
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33304>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrSlS-0001nh-0s for gcvg-git@gmane.org; Tue, 05 Dec
 2006 06:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968366AbWLEFWa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 00:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967723AbWLEFWa
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 00:22:30 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:44777 "EHLO
 magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937349AbWLEFWY (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 00:22:24 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003) id 731201380C2;
 Tue,  5 Dec 2006 18:22:18 +1300 (NZDT)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

From: Sam Vilain <sam@vilain.net>

Allow an extra parameter to be passed to the libsvn_ls_fullurl
function to collect and return the properties of the URL being listed.
---

 git-svn.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3891122..93cfcc4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3321,18 +3321,19 @@ sub libsvn_commit_cb {
 
 sub libsvn_ls_fullurl {
 	my $fullurl = shift;
+	my $want_props = shift;
 	my $ra = libsvn_connect($fullurl);
-	my @ret;
+	my (@ret, @props);
 	my $pool = SVN::Pool->new;
 	my $r = defined $_revision ? $_revision : $ra->get_latest_revnum;
-	my ($dirent, undef, undef) = $ra->get_dir('', $r, $pool);
+	my ($dirent, undef, $props) = $ra->get_dir('', $r, $pool);
 	foreach my $d (keys %$dirent) {
 		if ($dirent->{$d}->kind == $SVN::Node::dir) {
 			push @ret, "$d/"; # add '/' for compat with cli svn
 		}
 	}
 	$pool->clear;
-	return @ret;
+	return ($want_props ? (\@ret, $props) : @ret);
 }
 
 
