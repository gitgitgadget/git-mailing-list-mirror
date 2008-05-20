From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: builtin-clone does not fallback to copy when link fails
Date: Tue, 20 May 2008 14:16:56 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805201311180.19665@iabervon.org>
References: <oguFi9b5ZAq84dsDzWpm0tpI_xzucMxL23YhxIjDS5NTdpslAnzo6w@cipher.nrlssc.navy.mil> <C6tFzFdDycYRRcjxtVG00CVX-Nsu7-UblPCaZmTxmWIUTFAsgReYbQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue May 20 20:18:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyWPK-00064b-Fy
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 20:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328AbYETSRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 14:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039AbYETSRB
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 14:17:01 -0400
Received: from iabervon.org ([66.92.72.58]:57534 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984AbYETSRA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 14:17:00 -0400
Received: (qmail 26456 invoked by uid 1000); 20 May 2008 18:16:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 May 2008 18:16:56 -0000
In-Reply-To: <C6tFzFdDycYRRcjxtVG00CVX-Nsu7-UblPCaZmTxmWIUTFAsgReYbQ@cipher.nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82488>

On Tue, 20 May 2008, Brandon Casey wrote:

> Brandon Casey wrote:
> > 
> > When cloning with the new builtin-clone, if the src repo is not
> > on the same disk as the dest repo, cloning fails. This is because
> > hard linking does not fall back to copying like the shell version
> > did.
> > 
> > The shell version also made a distinction between defaulting to
> > hard linking and an explicit request to hard link. In the latter
> > case it would not fall back to copying, but would die.

I think that the shell version's behavior changed at some point, too. I 
think I tried at some point to figure out exactly what the specified 
behavior was, and couldn't come up with anything that entirely matched.

> Something like this (if not too ugly) might do the trick:

I think that's good behavior, but it's kind of ugly. How about:

-----
commit 83afef6a159365c1b9a7a1961cb4c95df24fbcac
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Tue May 20 14:15:14 2008 -0400

    Fall back to copying if hardlinking fails
    
    Note that it stops trying hardlinks if any fail.
    
    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

diff --git a/builtin-clone.c b/builtin-clone.c
index 8713128..42633ae 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -207,13 +207,15 @@ static void copy_or_link_directory(char *src, char *dest)
 
 		if (unlink(dest) && errno != ENOENT)
 			die("failed to unlink %s\n", dest);
-		if (option_no_hardlinks) {
-			if (copy_file(dest, src, 0666))
-				die("failed to copy file to %s\n", dest);
-		} else {
-			if (link(src, dest))
+		if (!option_no_hardlinks) {
+			if (!link(src, dest))
+				continue;
+			if (option_local)
 				die("failed to create link %s\n", dest);
+			option_no_hardlinks = 1;
 		}
+		if (copy_file(dest, src, 0666))
+			die("failed to copy file to %s\n", dest);
 	}
 }
 
