From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH/RFT] cvsserver: only allow checkout of branches
Date: Thu, 4 Oct 2007 16:29:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710041622070.4174@racer.site>
References: <200710031348.50800.wielemak@science.uva.nl>
 <46823.146.50.26.20.1191496739.squirrel@webmail.science.uva.nl>
 <Pine.LNX.4.64.0710041352480.4174@racer.site> <200710041506.13154.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Thu Oct 04 17:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdSTu-0007FF-Jb
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 17:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757243AbXJDPTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 11:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757268AbXJDPTA
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 11:19:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:58137 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756954AbXJDPS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 11:18:59 -0400
Received: (qmail invoked by alias); 04 Oct 2007 15:18:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 04 Oct 2007 17:18:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kvOMHdHwkMLjH61DCeljnaaLlsVckYS2L0bxhJ3
	f9H1By+xiQV9zw
X-X-Sender: gene099@racer.site
In-Reply-To: <200710041506.13154.wielemak@science.uva.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59963>


It does not make sense to check out tags or "HEAD".

Noticed by Jan Wielemaker.

---

	On Thu, 4 Oct 2007, Jan Wielemaker wrote:

	> On Thursday 04 October 2007 14:56, Johannes Schindelin wrote:
	>
	> > Ah!  Did you do "CVSROOT=:ext:blablub cvs co HEAD"?
	> 
	> Yip ...
	> 
	> > You should "co master".  The branches in git are the modules 
	> > in cvs.
	> >
	> > HEAD is too volatile, you cannot make a proper module from it 
	> > (imagine for example "git checkout next" where "next" is a 
	> > branch, followed by "git checkout html", where "html" is 
	> > another branch).
	> 
	> Ok.  Pretty sure I got literal HEAD from one of the examples 
	> somewhere ... Or, I've been blind all along.  Anyway, the 
	> maintainer may consider giving an error when trying to access 
	> HEAD as a module.  Would have saved about 2 days work and its 
	> unlikely I'm the last victim :-(

	This patch is completely untested.  Could you try it, please?

	If it works:
	Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

	Cc'ed Frank, who is de-facto maintainer (according to shortlog) 
	and Martin, who started it all IIRC.

 git-cvsserver.perl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 13dbd27..869690c 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -770,6 +770,14 @@ sub req_co
 
     $log->debug("req_co : " . ( defined($data) ? $data : "[NULL]" ) );
 
+    if( system("git", "rev-parse", "--verify", "refs/heads/$module" ) != 0 )
+    {
+	$log->warn("Checkout failed: $module is not a branch");
+	print "error 1 Checkout failed: $module is not a branch\n";
+	chdir "/";
+	exit;
+    }
+
     $log->info("Checking out module '$module' ($state->{CVSROOT}) to '$checkout_path'");
 
     $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
