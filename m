From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/3] git-svn: properly set path for "info" command
Date: Tue,  5 Aug 2008 00:35:16 -0700
Message-ID: <1217921718-25011-1-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 09:36:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQH5k-0001pq-QR
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 09:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbYHEHfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 03:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbYHEHfV
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 03:35:21 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52146 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764AbYHEHfU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 03:35:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 58E542DC01B;
	Tue,  5 Aug 2008 00:35:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.69.g797ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91432>

canonicalize_path() was previously changed to better
fit SVN 1.5, but it makes the "info" command not match
svn(1) in two places:

  1) URL ended up with a trailing slash when run without an
     argument.

  2) "Path: " was displayed instead of "Path: ." when run
     without an argument.

We will also handle odd cases where a user wants to
get information on a file or directory named "0", too.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index cc35f50..df0ed90 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -796,8 +796,8 @@ sub cmd_commit_diff {
 }
 
 sub cmd_info {
-	my $path = canonicalize_path(shift or ".");
-	unless (scalar(@_) == 0) {
+	my $path = canonicalize_path(defined($_[0]) ? $_[0] : ".");
+	if (exists $_[1]) {
 		die "Too many arguments specified\n";
 	}
 
@@ -813,6 +813,10 @@ sub cmd_info {
 		die "Unable to determine upstream SVN information from ",
 		    "working tree history\n";
 	}
+
+	# canonicalize_path() will return "" to make libsvn 1.5.x happy,
+	$path = "." if $path eq "";
+
 	my $full_url = $url . ($path eq "." ? "" : "/$path");
 
 	if ($_url) {
-- 
1.6.0.rc1.69.g797ea
