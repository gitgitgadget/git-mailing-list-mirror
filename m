X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: error out when the SVN connection fails during a fetch
Date: Tue, 28 Nov 2006 14:06:05 -0800
Message-ID: <20061128220605.GA1253@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 22:07:41 +0000 (UTC)
Cc: Seth Falcon <sethfalcon@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32591>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpB6A-000350-Hf for gcvg-git@gmane.org; Tue, 28 Nov
 2006 23:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757457AbWK1WGM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 17:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757459AbWK1WGL
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 17:06:11 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34176 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1757457AbWK1WGK (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 17:06:10 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 251BE2DC035; Tue, 28 Nov 2006 14:06:08 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 28 Nov 2006
 14:06:05 -0800
To: Junio C Hamano <junkio@cox.net>, Pazu <pazu@pazu.com.br>
Sender: git-owner@vger.kernel.org

finish_report does seem to return a useful value indicating success
or failure, so we'll just set a flag when close_edit is called
(it is not called on failures, nor is abort_edit) and check
the flag before proceeding.

Thanks to Pazu for pointing this out.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7942bba..c3ad5ec 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2941,6 +2941,9 @@ sub libsvn_fetch_delta {
 	$reporter->set_path('', $last_rev, 0, @lock, $pool);
 	$reporter->finish_report($pool);
 	$pool->clear;
+	unless ($ed->{git_commit_ok}) {
+		die "SVN connection failed somewhere...\n";
+	}
 	libsvn_log_entry($rev, $author, $date, $msg, [$last_commit]);
 }
 
@@ -3195,6 +3198,9 @@ sub libsvn_new_tree {
 		$reporter->set_path('', $rev, 1, @lock, $pool);
 		$reporter->finish_report($pool);
 		$pool->clear;
+		unless ($ed->{git_commit_ok}) {
+			die "SVN connection failed somewhere...\n";
+		}
 	} else {
 		open my $gui, '| git-update-index -z --index-info' or croak $!;
 		libsvn_traverse($gui, '', $SVN->{svn_path}, $rev);
@@ -3501,7 +3507,8 @@ sub abort_edit {
 
 sub close_edit {
 	my $self = shift;
-	close $self->{gui} or croak;
+	close $self->{gui} or croak $!;
+	$self->{git_commit_ok} = 1;
 	$self->SUPER::close_edit(@_);
 }
 
-- 
1.4.4.1.ge151
