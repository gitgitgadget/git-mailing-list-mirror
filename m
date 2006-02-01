From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: [PATCH] git-svnimport.perl: fix for 'arg list too long...'
Date: Wed, 1 Feb 2006 17:53:31 +0200
Message-ID: <20060201155331.GE18078@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 16:54:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4KIR-0004P0-4O
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 16:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWBAPxA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 10:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbWBAPw7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 10:52:59 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:18285 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1161097AbWBAPw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 10:52:58 -0500
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 1 Feb 2006 17:52:57 +0200
Received: by sashak (sSMTP sendmail emulation); Wed,  1 Feb 2006 17:53:31 +0200
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 01 Feb 2006 15:52:57.0809 (UTC) FILETIME=[9258C410:01C62747]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15422>

Hello,

This fixes 'arg list too long' problem when passed to git-ls-files.

Sasha.


This fixes 'arg list too long..' problem with git-ls-files.

Note that second arg list separation loop (with 'git-update-index') is
needed since git-ls-files arguments can be directories.

Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>

diff --git a/git-svnimport.perl b/git-svnimport.perl
index 6e3a44a..b6799d8 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -546,23 +546,30 @@ sub commit {
 			}
 		}
 
-		if(@old) {
-			open my $F, "-|", "git-ls-files", "-z", @old or die $!;
-			@old = ();
+		while(@old) {
+			my @o1;
+			if(@old > 55) {
+				@o1 = splice(@old,0,50);
+			} else {
+				@o1 = @old;
+				@old = ();
+			}
+			open my $F, "-|", "git-ls-files", "-z", @o1 or die $!;
+			@o1 = ();
 			local $/ = "\0";
 			while(<$F>) {
 				chomp;
-				push(@old,$_);
+				push(@o1,$_);
 			}
 			close($F);
 
-			while(@old) {
+			while(@o1) {
 				my @o2;
-				if(@old > 55) {
-					@o2 = splice(@old,0,50);
+				if(@o1 > 55) {
+					@o2 = splice(@o1,0,50);
 				} else {
-					@o2 = @old;
-					@old = ();
+					@o2 = @o1;
+					@o1 = ();
 				}
 				system("git-update-index","--force-remove","--",@o2);
 				die "Cannot remove files: $?\n" if $?;
