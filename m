From: Jeff King <peff@peff.net>
Subject: Re: irc usage..
Date: Tue, 23 May 2006 02:58:10 -0400
Message-ID: <20060523065810.GB6180@coredump.intra.peff.net>
References: <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> <44720C66.6040304@gentoo.org> <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com> <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org> <20060522214128.GE16677@kiste.smurf.noris.de> <7v8xotadm3.fsf@assigned-by-dhcp.cox.net> <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com> <20060523065232.GA6180@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 23 08:58:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiQqP-0007Lv-Sf
	for gcvg-git@gmane.org; Tue, 23 May 2006 08:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWEWG6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 02:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWEWG6N
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 02:58:13 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:13816 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751270AbWEWG6M (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 02:58:12 -0400
Received: (qmail 12859 invoked from network); 23 May 2006 06:58:11 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 23 May 2006 06:58:11 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2006 02:58:10 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060523065232.GA6180@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20567>

>From nobody Mon Sep 17 00:00:00 2001
From: Jeff King <peff@peff.net>
Date: Tue, 23 May 2006 01:16:07 -0400
Subject: [PATCH 1/2] cvsimport: use git-update-index --index-info

This should reduce the number of git-update-index forks required per
commit. We now do adds/removes in one call, and we are no longer forced to
deal with argv limitations.

---

cb6452bbfda9c52ad8dbeaac6e3440ae61099a05
 git-cvsimport.perl |   36 +++++++++++++-----------------------
 1 files changed, 13 insertions(+), 23 deletions(-)

cb6452bbfda9c52ad8dbeaac6e3440ae61099a05
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index d257e66..4efb0a5 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -565,29 +565,19 @@ my($patchset,$date,$author_name,$author_
 my(@old,@new,@skipped);
 sub commit {
 	my $pid;
-	while(@old) {
-		my @o2;
-		if(@old > 55) {
-			@o2 = splice(@old,0,50);
-		} else {
-			@o2 = @old;
-			@old = ();
-		}
-		system("git-update-index","--force-remove","--",@o2);
-		die "Cannot remove files: $?\n" if $?;
-	}
-	while(@new) {
-		my @n2;
-		if(@new > 12) {
-			@n2 = splice(@new,0,10);
-		} else {
-			@n2 = @new;
-			@new = ();
-		}
-		system("git-update-index","--add",
-			(map { ('--cacheinfo', @$_) } @n2));
-		die "Cannot add files: $?\n" if $?;
-	}
+
+      	open(my $fh, '|-', qw(git-update-index --index-info))
+		or die "unable to open git-update-index: $!";
+	print $fh 
+		(map { "0 0000000000000000000000000000000000000000\t$_\n" }
+			@old),
+		(map { '100' . sprintf('%o', $_->[0]) . " $_->[1]\t$_->[2]\n" }
+			@new)
+		or die "unable to write to git-update-index: $!";
+	close $fh
+		or die "unable to write to git-update-index: $!";
+	$? and die "git-update-index reported error: $?";
+	@old = @new = ();
 
 	$pid = open(C,"-|");
 	die "Cannot fork: $!" unless defined $pid;
-- 
1.3.3.gcb64-dirty
