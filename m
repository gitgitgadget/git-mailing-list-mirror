From: Jeff King <peff@peff.net>
Subject: Re: cvsimport and branches with "(" in the name
Date: Tue, 29 Apr 2008 11:52:38 -0400
Message-ID: <20080429155238.GA18494@sigill.intra.peff.net>
References: <320075ff0804290022r56c9f4efx74a13d3502be212@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 17:53:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqs93-0008JD-Fu
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 17:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbYD2Pwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 11:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753959AbYD2Pwl
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 11:52:41 -0400
Received: from peff.net ([208.65.91.99]:3300 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753914AbYD2Pwk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 11:52:40 -0400
Received: (qmail 26041 invoked by uid 111); 29 Apr 2008 15:52:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Apr 2008 11:52:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2008 11:52:38 -0400
Content-Disposition: inline
In-Reply-To: <320075ff0804290022r56c9f4efx74a13d3502be212@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80693>

On Tue, Apr 29, 2008 at 08:22:02AM +0100, Nigel Magnay wrote:

> git 1.5.4.4 on ubuntu, I cvsimport a repository that has an oddly
> named branch - I get
> 
> sh: Syntax error: "(" unexpected
> Cannot write branch ChapelHill_3_0(iteration2)_esap_demo for update:
> Bad file descriptor

Looks like cvsimport is handing something as an argument to a git
command, but we accidentally involve the shell. Maybe here:

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 95c5eec..bdac5d5 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -772,7 +772,7 @@ sub commit {
 	waitpid($pid,0);
 	die "Error running git-commit-tree: $?\n" if $?;
 
-	system("git-update-ref $remote/$branch $cid") == 0
+	system('git-update-ref', "$remote/$branch", $cid) == 0
 		or die "Cannot write branch $branch for update: $!\n";
 
 	if ($tag) {

Does that fix it?

> Any ideas on how to diagnose / fix it further ?

If that doesn't work, you might try running with GIT_TRACE=1, and then
you can see which commands are being run when the error occurs.

-Peff
