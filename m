From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: tracking repository
Date: Sun, 16 Mar 2008 17:28:36 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803161716470.19665@iabervon.org>
References: <frh8dg$t9j$1@ger.gmane.org> <7vabkzmltc.fsf@gitster.siamese.dyndns.org> <1205697779.12760.20.camel@duo> <7vwso2ieuu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, kenneth johansson <ken@kenjo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 22:29:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb0Px-0002rM-DL
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 22:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbYCPV2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 17:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbYCPV2l
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 17:28:41 -0400
Received: from iabervon.org ([66.92.72.58]:58130 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632AbYCPV2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 17:28:41 -0400
Received: (qmail 11060 invoked by uid 1000); 16 Mar 2008 21:28:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Mar 2008 21:28:36 -0000
In-Reply-To: <7vwso2ieuu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77389>

On Sun, 16 Mar 2008, Junio C Hamano wrote:

> kenneth johansson <ken@kenjo.org> writes:
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> > 	fetch = +refs/heads/*:refs/heads/*
> > [remote "stable_2.6.12"]
> > 	url =
> > git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.12.y.git
> > 	fetch = +refs/heads/*:refs/heads/stable_2.6.12_*
> 
> Daniel, I think we are looking at a regression.  The latter style, * at
> the end but not immediately following a slash, should never have worked.
> Wildcard expansion function should be erroring out when it sees something
> like this.

I'm not sure any older code actually enforced this, either

We don't currently have any concept of an invalid refspec; we just have 
things that fall back to not being patterns and not being possible to 
match (due to one or the other side being invalid as a ref name).

Here's a patch to make the pattern logic require a slash before the *:
---------
commit 7aa15c359bcfc7a3c87345435b81ef41e1f59800
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Sun Mar 16 17:26:41 2008 -0400

    Require / before * in pattern refspecs
    
    We don't want to have "+refs/heads/*:refs/heads/something_*" match
    "refs/heads/master" to "refs/heads/something_master".
    
    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

diff --git a/remote.c b/remote.c
index f3f7375..fffde34 100644
--- a/remote.c
+++ b/remote.c
@@ -404,18 +404,17 @@ struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
 			rs[i].force = 1;
 			sp++;
 		}
-		gp = strchr(sp, '*');
+		gp = strstr(sp, "/*");
 		ep = strchr(sp, ':');
 		if (gp && ep && gp > ep)
 			gp = NULL;
 		if (ep) {
 			if (ep[1]) {
-				const char *glob = strchr(ep + 1, '*');
+				const char *glob = strstr(ep + 1, "/*");
 				if (!glob)
 					gp = NULL;
 				if (gp)
-					rs[i].dst = xstrndup(ep + 1,
-							     glob - ep - 1);
+					rs[i].dst = xstrndup(ep + 1, glob - ep);
 				else
 					rs[i].dst = xstrdup(ep + 1);
 			}
@@ -424,7 +423,7 @@ struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
 		}
 		if (gp) {
 			rs[i].pattern = 1;
-			ep = gp;
+			ep = gp + 1;
 		}
 		rs[i].src = xstrndup(sp, ep - sp);
 	}
