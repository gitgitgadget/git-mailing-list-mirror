From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] apply: fix memory leak in prefix_one()
Date: Tue, 20 Feb 2007 03:45:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702200345070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <20070217233203.GA6014@coredump.intra.peff.net>
 <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
 <7vodnp68p8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
 <7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
 <7vps854qf8.fsf@assigned-by-dhcp.cox.net> <7vr6sl381i.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702200332090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqjp3630.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 03:46:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJL11-000542-9r
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 03:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965589AbXBTCpw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 21:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932812AbXBTCpw
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 21:45:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:48737 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932806AbXBTCpw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 21:45:52 -0500
Received: (qmail invoked by alias); 20 Feb 2007 02:45:50 -0000
X-Provags-ID: V01U2FsdGVkX1/zvTQT1azztbQuG6WF8Nn78Cf/YX46CILfFW4t7b
	pEfQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vbqjp3630.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40202>

Hi,

On Mon, 19 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	This is on top of them.
> 
> I am not sure if this is correct.  Don't we do some point
> new_name = old_name = blah?

Yes, you're right. I missed that. The change is in the last hunk:

--

[PATCH] apply: fix memory leak in prefix_one()

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-apply.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index e01969f..2a23138 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2516,11 +2516,13 @@ static int use_patch(struct patch *p)
 	return 1;
 }
 
-static char *prefix_one(char *name)
+static void prefix_one(char **name)
 {
-	if (!name)
-		return name;
-	return xstrdup(prefix_filename(prefix, prefix_length, name));
+	char *old_name = *name;
+	if (!old_name)
+		return;
+	*name = xstrdup(prefix_filename(prefix, prefix_length, *name));
+	free(old_name);
 }
 
 static void prefix_patches(struct patch *p)
@@ -2528,8 +2530,9 @@ static void prefix_patches(struct patch *p)
 	if (!prefix)
 		return;
 	for ( ; p; p = p->next) {
-		p->new_name = prefix_one(p->new_name);
-		p->old_name = prefix_one(p->old_name);
+		if (p->new_name != p->old_name)
+			prefix_one(&p->new_name);
+		prefix_one(&p->old_name);
 	}
 }
 
-- 
1.5.0.1.2141.gc066
