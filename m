X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 1/4] git-svn: let libsvn_ls_fullurl return properties too
Date: Mon, 4 Dec 2006 20:33:03 +1100
Message-ID: <20061204235724.46FD7139B0C@magnus.utsl.gen.nz>
NNTP-Posting-Date: Mon, 4 Dec 2006 23:57:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33267>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrNgg-0005UP-6b for gcvg-git@gmane.org; Tue, 05 Dec
 2006 00:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935336AbWLDX5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 18:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937190AbWLDX5Z
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 18:57:25 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:49721 "EHLO
 magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S935336AbWLDX5Z (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 18:57:25 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003) id 46FD7139B0C;
 Tue,  5 Dec 2006 12:57:24 +1300 (NZDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

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
 
 
-- 
1.4.4.1.ge918e-dirty
