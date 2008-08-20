From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Extend "checkout --track" DWIM to support more cases
Date: Wed, 20 Aug 2008 22:16:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808202213340.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080820185028.GA16626@blimp.local> <alpine.DEB.1.00.0808202151320.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080820200440.GF16626@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:12:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVu2i-0007T0-5T
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbYHTUL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755215AbYHTUL2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:11:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:59060 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755034AbYHTUL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:11:27 -0400
Received: (qmail invoked by alias); 20 Aug 2008 20:11:26 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 20 Aug 2008 22:11:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VchddpX+Verpm8zfTaNr+7Su+/N9Lo6bmBn7k/Q
	94xb9K4X4vBKlR
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080820200440.GF16626@blimp.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93029>

Hi,

On Wed, 20 Aug 2008, Alex Riesen wrote:

> Johannes Schindelin, Wed, Aug 20, 2008 21:52:23 +0200:
> > On Wed, 20 Aug 2008, Alex Riesen wrote:
> > > -		slash = strchr(argv[0], '/');
> > > -		if (slash && !prefixcmp(argv[0], "refs/"))
> > > -			slash = strchr(slash + 1, '/');
> > > -		if (slash && !prefixcmp(argv[0], "remotes/"))
> > > -			slash = strchr(slash + 1, '/');
> > 
> > Why is this not enough?  It strips refs/ if there is one, and remotes/ if 
> > there is one (possibly after stripping refs/).  No?
> > 
> 
> No. It strips refs/ OR remotes/ (because of prefixcmp with argv[0]).
> And I still wanted refs/<namespace>/something...

Yes, you are correct.  However, to fix my thinko, I deem this preferable:

-- snipsnap --

 builtin-checkout.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index e95eab9..2a076cf 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -448,8 +448,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		if (!argc || !strcmp(argv[0], "--"))
 			die ("--track needs a branch name");
 		slash = strchr(argv[0], '/');
-		if (slash && !prefixcmp(argv[0], "refs/"))
-			slash = strchr(slash + 1, '/');
+		if (slash && !prefixcmp(argv[0], "refs/")) {
+			argv[0] = slash + 1;
+			slash = strchr(argv[0], '/');
+		}
 		if (slash && !prefixcmp(argv[0], "remotes/"))
 			slash = strchr(slash + 1, '/');
 		if (!slash || !slash[1])
