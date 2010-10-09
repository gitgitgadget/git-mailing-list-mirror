From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Ebenlendr?= <ebik@ucw.cz>
Subject: [PATCH] git-svn.perl: Fix glob matching on svn paths
Date: Sat,  9 Oct 2010 11:07:16 +0200
Message-ID: <1286615236-29732-2-git-send-email-ebik@ucw.cz>
References: <1286615236-29732-1-git-send-email-ebik@ucw.cz>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Tom=C3=A1=C5=A1=20Ebenlendr?= <ebik@ucw.cz>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Oct 09 11:21:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4VcH-0001Hm-Sl
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 11:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760118Ab0JIJVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 05:21:08 -0400
Received: from drak.ucw.cz ([212.71.128.78]:36065 "EHLO drak.ucw.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865Ab0JIJVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 05:21:05 -0400
Received: from Chewbacca.cub (localhost [127.0.0.1])
	by drak.ucw.cz (Postfix) with ESMTP id 283E35A;
	Sat,  9 Oct 2010 11:07:34 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1286615236-29732-1-git-send-email-ebik@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158579>

* Git::SVN::GlobSPec::new():
  - Directories or files with empty name are not allowed: The star pattern
    has to match at least one character.
  - The main pattern has to start with full path, i.e. "^/" is prepended.
    Also it has to end with directory boundary, i.e. "(/|$)" is appended.
---
 git-svn.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 18cfb24..01ae6a1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -6132,7 +6132,7 @@ sub new {
 		if ($part eq "*") {
 			die $die_msg if $state eq "right";
 			$state = "pattern";
-			push(@patterns, "[^/]*");
+			push(@patterns, "[^/]+");
 		} elsif ($pattern_ok && $part =~ /^\{(.*)\}$/) {
 			die $die_msg if $state eq "right";
 			$state = "pattern";
@@ -6155,8 +6155,8 @@ sub new {
 	my $left = join('/', @left);
 	my $right = join('/', @right);
 	$re = join('/', @patterns);
-	$re = join('\/',
-		   grep(length, quotemeta($left), "($re)", quotemeta($right)));
+	$re = '^\/'.join('\/',
+		   grep(length, quotemeta($left), "($re)", quotemeta($right))).'(?:\/|$)';
 	my $left_re = qr/^\/\Q$left\E(\/|$)/;
 	bless { left => $left, right => $right, left_regex => $left_re,
 	        regex => qr/$re/, glob => $glob, depth => $depth }, $class;
-- 
1.7.1
