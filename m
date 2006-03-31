From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsimport: use git-update-ref when updating
Date: Fri, 31 Mar 2006 13:14:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0603311310580.23287@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0603301405160.18852@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk6ab1iy2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0603311207270.20122@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060331103230.GB15159@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 13:14:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPHae-00048E-Up
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 13:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWCaLOs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 06:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWCaLOs
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 06:14:48 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:43157 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750920AbWCaLOr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 06:14:47 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 091821BC1;
	Fri, 31 Mar 2006 13:14:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id F013561AB;
	Fri, 31 Mar 2006 13:14:45 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id CF9E71BC1;
	Fri, 31 Mar 2006 13:14:45 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060331103230.GB15159@hand.yhbt.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18226>

Hi,

On Fri, 31 Mar 2006, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> > 
> > On Thu, 30 Mar 2006, Junio C Hamano wrote:
> > 
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > 
> > > > This simplifies code, and also fixes a subtle bug: when importing in a
> > > > shared repository, where another user last imported from CVS, cvsimport
> > > > used to complain that it could not open <branch> for update.
> > > 
> > > The second hunk look sensible but I do not know about "use Fcntl"
> > > since I do not see anything you are adding that starts to use it...
> > 
> > O_EXCL. Without "use Fcntl;" perl says I am not allowed to use bareword 
> > things in strict mode or some such.
> 
> Huh?  I still don't see where O_EXCL is used.

Yes. I did not make that point clear enough, I guess. My first approach 
was to reimplement git-update-ref in perl, which worked well enough, until 
I remembered that you could just call programs from perl :-)

> > > > +       system("git-update-ref refs/heads/$branch $cid") == 0
> 
> Passing args to system() in list form is always preferable in case
> there's a shell-unfriendly variable:
> 
> 	system("git-update-ref", "refs/heads/$branch", $cid) == 0

Old habit dies hard.

---

 git-cvsimport.perl |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 3728294..fe6298b 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -677,11 +677,7 @@ my $commit = sub {
 	waitpid($pid,0);
 	die "Error running git-commit-tree: $?\n" if $?;
 
-	open(C,">$git_dir/refs/heads/$branch")
-		or die "Cannot open branch $branch for update: $!\n";
-	print C "$cid\n"
-		or die "Cannot write branch $branch for update: $!\n";
-	close(C)
+	system("git-update-ref", "refs/heads/$branch", $cid) == 0
 		or die "Cannot write branch $branch for update: $!\n";
 
 	if($tag) {
