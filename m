From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] cvsimport-in-Perl: Limit the number of arguments to git-update-cache
Date: Thu, 30 Jun 2005 12:34:00 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.30.10.34.00.807346@smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Jun 30 12:36:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnwOy-0007eX-72
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 12:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbVF3Kmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 06:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVF3KmF
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 06:42:05 -0400
Received: from main.gmane.org ([80.91.229.2]:24494 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262950AbVF3KiZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 06:38:25 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DnwJm-0006xX-1Y
	for git@vger.kernel.org; Thu, 30 Jun 2005 12:30:50 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Jun 2005 12:30:50 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Jun 2005 12:30:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A small fix to git-cvsimport-script:

Limit the number of arguments to git-update-cache.
(Limiting their length may make a bit more sense, but I'm lazy.)

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

---

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -395,14 +395,32 @@ my $state = 0;
 
 my($patchset,$date,$author,$branch,$ancestor,$tag,$logmsg);
 my(@old,@new);
 my $commit = sub {
 	my $pid;
-	system("git-update-cache","--force-remove","--",@old) if @old;
-	die "Cannot remove files: $?\n" if $?;
-	system("git-update-cache","--add","--",@new) if @new;
-	die "Cannot add files: $?\n" if $?;
+	while(@old) {
+		my @o2;
+		if(@old > 55) {
+			@o2 = splice(@old,0,50);
+		} else {
+			@o2 = @old;
+			@old = ();
+		}
+		system("git-update-cache","--force-remove","--",@o2);
+		die "Cannot remove files: $?\n" if $?;
+	}
+	while(@new) {
+		my @n2;
+		if(@new > 55) {
+			@n2 = splice(@new,0,50);
+		} else {
+			@n2 = @new;
+			@new = ();
+		}
+		system("git-update-cache","--add","--",@n2);
+		die "Cannot add files: $?\n" if $?;
+	}
 
 	$pid = open(C,"-|");
 	die "Cannot fork: $!" unless defined $pid;
 	unless($pid) {
 		exec("git-write-tree");
@@ -478,13 +496,10 @@ my $commit = sub {
 			or die "Cannot write tag $branch: $!\n";
 		close(C)
 			or die "Cannot write tag $branch: $!\n";
 		print "Created tag '$tag' on '$branch'\n" if $opt_v;
 	}
-
-	@old = ();
-	@new = ();
 };
 
 while(<CVS>) {
 	chomp;
 	if($state == 0 and /^-+$/) {
