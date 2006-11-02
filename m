X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problem with git-push
Date: Thu, 2 Nov 2006 10:29:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611021018040.1670@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1162306098.41547.4.camel@mayday.esat.net>
 <7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611011205340.1670@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk62f2l46.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 2 Nov 2006 09:29:31 +0000 (UTC)
Cc: Florent Thoumie <flz@xbsd.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vk62f2l46.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30697>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfYsw-000077-J2 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 10:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752769AbWKBJ3P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 04:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbWKBJ3P
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 04:29:15 -0500
Received: from mail.gmx.de ([213.165.64.20]:30694 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1752769AbWKBJ3N (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 04:29:13 -0500
Received: (qmail invoked by alias); 02 Nov 2006 09:29:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp046) with SMTP; 02 Nov 2006 10:29:12 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 1 Nov 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > How about this instead:
> >
> > -		mkdir(filename, 0777);
> > -		if (adjust_shared_perm(filename))
> > +		if (!mkdir(filename, 0777) && adjust_shared_perm(filename)) {
> > +			*dir = '/';
> >  			return -2;
> > +		}
> 
> Not really.  See the comment above the code you just touched.

 /*
  * Try to mkdir the last path component if that failed.
  *
  * Re-try the "link()" regardless of whether the mkdir
  * succeeds, since a race might mean that somebody
  * else succeeded.
  */

What I proposed does not break that. It only means that you only try to 
adjust the permissions if the mkdir succeeded. If somebody else created 
the directory in the mean time, it is not our job to adjust the 
permissions. Worse, if the other mkdir was run by a different user, the 
permission adjusting _cannot_ succeed, like you pointed out.

So I think that my patch is correct, but does not matter very much.

The other thing you asked for: adjust_shared_permissions should only try 
to adjust the permissions only if they are not already correct. Here is my 
attempt to implement that:

Totally untested.

Ciao,
Dscho

-- snip --
adjust_shared_perm(): Avoid unnecessary chmod()s

Sighed-off-by: Johannes E. Schindelin <johannes.schindelin@gmx.de>
---
diff --git a/path.c b/path.c
index bb89fb0..0a2bc51 100644
--- a/path.c
+++ b/path.c
@@ -279,7 +279,7 @@ int adjust_shared_perm(const char *path)
 			    : 0));
 	if (S_ISDIR(mode))
 		mode |= S_ISGID;
-	if (chmod(path, mode) < 0)
+	if ((mode & st.st_mode != mode) && chmod(path, mode) < 0)
 		return -2;
 	return 0;
 }
