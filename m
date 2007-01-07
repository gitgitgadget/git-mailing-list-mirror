From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] git-svnimport: support for incremental import
Date: Sun, 7 Jan 2007 20:59:06 +0200
Message-ID: <20070107185906.GD18379@sashak.voltaire.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <20070104213142.GE11861@sashak.voltaire.com> <204011cb0701041404g684525fdm1d057e57a57aca92@mail.gmail.com> <20070107001719.GB16771@sashak.voltaire.com> <204011cb0701071012g30cb69a5h4622d94574d10521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 19:51:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3d7a-0000FK-SF
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 19:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbXAGSvs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 13:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbXAGSvs
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 13:51:48 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:45147 "EHLO
	taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964915AbXAGSvr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 13:51:47 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 7 Jan 2007 20:51:45 +0200
Received: by sashak (sSMTP sendmail emulation); Sun,  7 Jan 2007 20:59:06 +0200
To: Chris Lee <chris133@gmail.com>
Content-Disposition: inline
In-Reply-To: <204011cb0701071012g30cb69a5h4622d94574d10521@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 07 Jan 2007 18:51:45.0656 (UTC) FILETIME=[E1174F80:01C7328C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36182>

On 10:12 Sun 07 Jan     , Chris Lee wrote:
> On 1/6/07, Sasha Khapyorsky <sashak@voltaire.com> wrote:
> >This adds ability to do import "in chunks" (default 1000 revisions),
> >after each chunk git repo will be repacked. The option -R is used to
> >change default value of chunk size (or how often repository will
> >repacked).
> 
> Actually, I just noticed an issue here with this - it appears to be
> double-importing the edge revisions.
> 
> So if I started with -s 349000 and tell it to repack every 1000
> revisions, it's now importing every thousandth revision twice.

Indeed. There is the fix:


diff --git a/git-svnimport.perl b/git-svnimport.perl
index afbbe63..f1f1a7d 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -943,10 +943,10 @@ if ($opt_l < $current_rev) {
 print "Processing from $current_rev to $opt_l ...\n" if $opt_v;
 
 my $from_rev;
-my $to_rev = $current_rev;
+my $to_rev = $current_rev - 1;
 
 while ($to_rev < $opt_l) {
-	$from_rev = $to_rev;
+	$from_rev = $to_rev + 1;
 	$to_rev = $from_rev + $repack_after;
 	$to_rev = $opt_l if $opt_l < $to_rev;
 	print "Fetching from $from_rev to $to_rev ...\n" if $opt_v;


Sasha
