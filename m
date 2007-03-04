From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix show-ignore when not connected to the repository root
Date: Sun,  4 Mar 2007 00:15:29 -0800
Message-ID: <1172996129553-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 09:15:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNlsg-0002QA-3y
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 09:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbXCDIPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 03:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbXCDIPc
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 03:15:32 -0500
Received: from hand.yhbt.net ([66.150.188.102]:36101 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbXCDIPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 03:15:31 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C3A657DC094;
	Sun,  4 Mar 2007 00:15:29 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 04 Mar 2007 00:15:29 -0800
X-Mailer: git-send-email 1.5.0.1.212.g2e5e24
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41348>

It was traversing the entire repository before.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 41961b5..326e89f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -447,7 +447,7 @@ sub cmd_show_ignore {
 	my $url = (::working_head_info('HEAD'))[0];
 	my $gs = Git::SVN->find_by_url($url) || Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
-	$gs->traverse_ignore(\*STDOUT, '', $r);
+	$gs->traverse_ignore(\*STDOUT, $gs->{path}, $r);
 }
 
 sub cmd_multi_init {
@@ -1334,7 +1334,7 @@ sub traverse_ignore {
 	my $ra = $self->ra;
 	my ($dirent, undef, $props) = $ra->get_dir($path, $r);
 	my $p = $path;
-	$p =~ s#^\Q$ra->{svn_path}\E/##;
+	$p =~ s#^\Q$self->{path}\E(/|$)##;
 	print $fh length $p ? "\n# $p\n" : "\n# /\n";
 	if (my $s = $props->{'svn:ignore'}) {
 		$s =~ s/[\r\n]+/\n/g;
-- 
1.5.0.1.212.g2e5e24
