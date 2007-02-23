From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle: assorted fixes
Date: Fri, 23 Feb 2007 03:17:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702230316570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702221913250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45DE4507.7090206@verizon.net> <Pine.LNX.4.63.0702230249340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45DE4D85.3000906@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net, Nicolas Pitre <nico@cam.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 03:18:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKQ0b-0004op-AN
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 03:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbXBWCRy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 21:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbXBWCRy
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 21:17:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:58272 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752130AbXBWCRx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 21:17:53 -0500
Received: (qmail invoked by alias); 23 Feb 2007 02:17:53 -0000
X-Provags-ID: V01U2FsdGVkX18g2xYlpF0gS9cbA6AhmkyksZyTCfngp9p9+/3VYg
	wnWw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45DE4D85.3000906@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40409>



On Thu, 22 Feb 2007, Mark Levedahl wrote:

> Johannes Schindelin wrote:
>
> > Mark wrote:
> >
> > > 2) git bundle verify reports only a single sha1 if prerequisites are 
> > > not met.
> > 
> > With the two follow-up patches I sent, this issue should be resolved, 
> > no?
> > 
>   I missed one of your patches, adding that, the problem is incompletely 
> fixed: all missing commits are shown, but only as raw hashes (e.g., the 
> 1-line commit message is not there to describe what is missing).

Okay, how about this on top:

-- snipsnap --

 builtin-bundle.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 4ac06f9..d11435b 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -267,7 +267,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv)
 {
 	int bundle_fd = -1;
-	const char **argv_boundary = xmalloc((argc + 3) * sizeof(const char *));
+	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
 	const char **argv_pack = xmalloc(4 * sizeof(const char *));
 	int pid, in, out, i, status;
 	char buffer[1024];
@@ -282,10 +282,11 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
 
 	/* write prerequisites */
-	memcpy(argv_boundary + 2, argv + 1, argc * sizeof(const char *));
+	memcpy(argv_boundary + 3, argv + 1, argc * sizeof(const char *));
 	argv_boundary[0] = "rev-list";
 	argv_boundary[1] = "--boundary";
-	argv_boundary[argc + 1] = NULL;
+	argv_boundary[2] = "--pretty=oneline";
+	argv_boundary[argc + 2] = NULL;
 	out = -1;
 	pid = fork_with_pipe(argv_boundary, NULL, &out);
 	if (pid < 0)
