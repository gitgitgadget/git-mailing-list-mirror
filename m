From: Tomash Brechko <tomash.brechko@gmail.com>
Subject: [PATCH (resend)] cvsexportcommit -p : fix the usage of git-apply -C.
Date: Mon, 9 Apr 2007 15:24:02 +0400
Message-ID: <20070409112402.GD11593@moonlight.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 13:24:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Harz5-0005e5-1K
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 13:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbXDILYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 07:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094AbXDILYL
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 07:24:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:56455 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbXDILYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 07:24:10 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1520288uga
        for <git@vger.kernel.org>; Mon, 09 Apr 2007 04:24:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=jwb8T4Da+we0quGii9qL4xxXA0eMrkjalSC/c83BGVyb0sL1eIlsFNKxyLqslAHNMnCPBzEcHPUu8nyeH3vvI++dI5LEH253VOTjb7SI+rR1rWR/QHV+lZ3pMjCp/T4I+AYXx/AkAQwblxXrNDPNzmTRbyy5cRgBt2YXanNjuxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=E3ULdQ8lWbT0v6CVHuD58dNggKaiPeAri11uvS2DM3wuRBMj5aFfln4EoaNeyY11ui2GotiHLgwC1McOAycjbjgKlFQfjqa8UTYehwnkLXuuvvxyACaqQAlqpketXjQzC772su3V/hhytNU0gNxoWLF0tJmZhwpOc53QtviEToc=
Received: by 10.66.224.19 with SMTP id w19mr5192768ugg.1176117848623;
        Mon, 09 Apr 2007 04:24:08 -0700 (PDT)
Received: from moonlight.home ( [80.246.71.156])
        by mx.google.com with ESMTP id b23sm8675494ugd.2007.04.09.04.24.07;
        Mon, 09 Apr 2007 04:24:08 -0700 (PDT)
Received: from moonlight.home (localhost.localdomain [127.0.0.1])
	by moonlight.home (Postfix) with ESMTP id A9C123A7C2;
	Mon,  9 Apr 2007 15:24:02 +0400 (MSD)
Received: (from tomash@localhost)
	by moonlight.home (8.13.1/8.13.1/Submit) id l39BO2iJ018546;
	Mon, 9 Apr 2007 15:24:02 +0400
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44050>

Unlike 'patch --fuzz=NUM', which specifies the number of lines allowed
to mismatch, 'git-apply -CNUM' requests the match of NUM lines of
context.  Omitting -C requests full context match, and that's what
should be used for cvsexportcommit -p.
---
 git-cvsexportcommit.perl |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 67224b4..6ed4719 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -124,12 +124,17 @@ close MSG;
 `git-diff-tree --binary -p $parent $commit >.cvsexportcommit.diff`;# || die "Cannot diff";
 
 ## apply non-binary changes
-my $fuzz = $opt_p ? 0 : 2;
+
+# In pedantic mode require all lines of context to match.  In normal
+# mode, be compatible with diff/patch: assume 3 lines of context and
+# require at least one line match, i.e. ignore at most 2 lines of
+# context, like diff/patch do by default.
+my $context = $opt_p ? '' : '-C1';
 
 print "Checking if patch will apply\n";
 
 my @stat;
-open APPLY, "GIT_DIR= git-apply -C$fuzz --binary --summary --numstat<.cvsexportcommit.diff|" || die "cannot patch";
+open APPLY, "GIT_DIR= git-apply $context --binary --summary --numstat<.cvsexportcommit.diff|" || die "cannot patch";
 @stat=<APPLY>;
 close APPLY || die "Cannot patch";
 my (@bfiles,@files,@afiles,@dfiles);
@@ -196,7 +201,7 @@ if ($dirty) {
 }
 
 print "Applying\n";
-`GIT_DIR= git-apply -C$fuzz --binary --summary --numstat --apply <.cvsexportcommit.diff` || die "cannot patch";
+`GIT_DIR= git-apply $context --binary --summary --numstat --apply <.cvsexportcommit.diff` || die "cannot patch";
 
 print "Patch applied successfully. Adding new files and directories to CVS\n";
 my $dirtypatch = 0;
-- 
1.5.1.82.g46af1-dirty
