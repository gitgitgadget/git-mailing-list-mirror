From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] cvsimport: use git-update-index --index-info
Date: Tue, 23 May 2006 03:27:45 -0400
Message-ID: <37251.1135334664$1148369282@news.gmane.org>
References: <20060523070007.GC6180@coredump.intra.peff.net>
Reply-To: Jeff King <peff@peff.net>
Cc: martin@catalyst.net.nz, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue May 23 09:28:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiRJ7-0004zD-Ks
	for gcvg-git@gmane.org; Tue, 23 May 2006 09:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWEWH1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 03:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWEWH1t
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 03:27:49 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:7415 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932081AbWEWH1s (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 03:27:48 -0400
Received: (qmail 14177 invoked from network); 23 May 2006 07:27:46 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 23 May 2006 07:27:46 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2006 03:27:46 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g3408
In-Reply-To: <20060523070007.GC6180@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20571>

This should reduce the number of git-update-index forks required per
commit. We now do adds/removes in one call, and we are no longer forced to
deal with argv limitations.

---

This is a repost using -z/NUL instead of line feeds.

d82d215430ae5e79210f73a31f5f8a053f36c27f
 git-cvsimport.perl |   36 +++++++++++++-----------------------
 1 files changed, 13 insertions(+), 23 deletions(-)

d82d215430ae5e79210f73a31f5f8a053f36c27f
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index d257e66..a65bea6 100755
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
+	open(my $fh, '|-', qw(git-update-index -z --index-info))
+		or die "unable to open git-update-index: $!";
+	print $fh 
+		(map { "0 0000000000000000000000000000000000000000\t$_\0" }
+			@old),
+		(map { '100' . sprintf('%o', $_->[0]) . " $_->[1]\t$_->[2]\0" }
+			@new)
+		or die "unable to write to git-update-index: $!";
+	close $fh
+		or die "unable to write to git-update-index: $!";
+	$? and die "git-update-index reported error: $?";
+	@old = @new = ();
 
 	$pid = open(C,"-|");
 	die "Cannot fork: $!" unless defined $pid;
-- 
1.3.3.g3408
