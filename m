From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Funny error with git gc...
Date: Fri, 15 May 2009 21:18:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905152115220.26154@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302> <7vmy9etey8.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0905151128230.3343@localhost.localdomain> <alpine.DEB.1.00.0905152105340.26154@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0905152111140.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 15 21:18:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M52vA-00005y-CB
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 21:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbZEOTSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 15:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbZEOTSG
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 15:18:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:40375 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752736AbZEOTSE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 15:18:04 -0400
Received: (qmail invoked by alias); 15 May 2009 19:18:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 15 May 2009 21:18:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qLcFNuynq0WaAhJO9vEpP/mTkakmMbMlcSPw0fU
	SUdcxsAr2iM/17
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0905152111140.26154@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119285>

Hi,

On Fri, 15 May 2009, Johannes Schindelin wrote:

> On Fri, 15 May 2009, Johannes Schindelin wrote:
> 
> 
> > > 	[core]
> > > 		packedGitWindowSize = 16k
> > > 		packedGitLimit = 1M
> > > 
> > > you should hopefully be able to repack (slowly) even with a low file 
> > > descriptor limit, because of the total limit on the size.
> > 
> > I don't think so, because the window size has nothing to do with the 
> > amount of open windows, right?
> 
> Obviously I overlooked the "packedGitLimit" setting.  Still, just a 
> work-around, not a solution that tackles the problem heads-on.

But it worked with the work-around, and not with my heads-on approach.  
The problem is in xmkstemp(), but when I apply this patch on top of my 
MAKESHIFT PATCH:

-- snip --
diff --git a/wrapper.c b/wrapper.c
index d8efb13..47806ba 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -192,8 +192,13 @@ int xmkstemp(char *template)
 	int fd;
 
 	fd = mkstemp(template);
+	if (fd < 0) {
+		release_pack_memory((size_t)-1ll, -1);
+		fd = mkstemp(template);
+	}
 	if (fd < 0)
-		die("Unable to create temporary file: %s", strerror(errno));
+		die("Unable to create temporary file '%s': %s",
+				template, strerror(errno));
 	return fd;
 }
 
-- snap --

I get an even funnier error:

fatal: Unable to create temporary file '.git/objects/pack/tmp_pack_rvhvZb': Invalid argument
error: failed to run repack

Oh well, I'll let it sit over the weekend...

Ciao,
Dscho
