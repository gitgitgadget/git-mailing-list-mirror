From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] cvsimport: introduce -L<imit> option to workaround memory
 leaks
Date: Mon, 22 May 2006 19:28:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605221926270.3697@g5.osdl.org>
References: <11482978883713-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Johannes.Schindelin@gmx.de,
	spyderous@gentoo.org, smurf@smurf.noris.de
X-From: git-owner@vger.kernel.org Tue May 23 04:29:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiMe6-0005dm-CV
	for gcvg-git@gmane.org; Tue, 23 May 2006 04:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWEWC3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 22:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWEWC3O
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 22:29:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18873 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751261AbWEWC3N (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 22:29:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4N2SdtH011675
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 May 2006 19:28:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4N2Sb1N022546;
	Mon, 22 May 2006 19:28:38 -0700
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <11482978883713-git-send-email-martin@catalyst.net.nz>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20561>



This stupid patch on top of yours seems to make git happier. It's 
disgusting, I know, but it just repacks things every kilo-commit.

I actually think that I found a real ext3 performance bug from trying to 
determine why git sometimes slows down ridiculously when the tree has been 
allowed to go too long without a repack.

		Linus

---
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index fb56278..c141f5e 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -853,10 +853,14 @@ #	VERSION:1.96->1.96.2.1
 	} elsif($state == 9 and /^\s*$/) {
 		$state = 10;
 	} elsif(($state == 9 or $state == 10) and /^-+$/) {
-		if ($opt_L && $commitcount++ >= $opt_L) {
+		$commitcount++;
+		if ($opt_L && $commitcount > $opt_L) {
 			last;
 		}
 		commit();
+		if (($commitcount & 1023) == 0) {
+			system("git repack -a -d");
+		}
 		$state = 1;
 	} elsif($state == 11 and /^-+$/) {
 		$state = 1;
