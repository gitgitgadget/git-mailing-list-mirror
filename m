From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Thu, 21 Sep 2006 02:07:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609210206320.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060920234548.GA20461@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 21 02:07:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQC6A-0003vM-Kr
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 02:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWIUAHX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 20:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWIUAHX
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 20:07:23 -0400
Received: from mail.gmx.de ([213.165.64.20]:39389 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750799AbWIUAHW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 20:07:22 -0400
Received: (qmail invoked by alias); 21 Sep 2006 00:07:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 21 Sep 2006 02:07:21 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jeff King <peff@peff.net>
In-Reply-To: <20060920234548.GA20461@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27438>



On Wed, 20 Sep 2006, Jeff King wrote:

> On Thu, Sep 21, 2006 at 01:07:54AM +0200, Johannes Schindelin wrote:
> 
> > +	if (deny_non_fast_forwards && !is_null_sha1(old_sha1)) {
> > +		struct commit *old_commit, *new_commit;
> > +		struct commit_list *bases;
> > +
> > +		old_commit = (struct commit *)parse_object(old_sha1);
> > +		new_commit = (struct commit *)parse_object(new_sha1);
> > +		for (bases = get_merge_bases(old_commit, new_commit, 1);
> > +				bases; bases = bases->next)
> > +			if (!hashcmp(old_sha1, bases->item->object.sha1))
> > +				break;
> > +		if (!bases)
> > +			return error("denying non-fast forward;"
> > +					" you should pull first");
> > +	}
> 
> Memory leak on 'bases'. It shouldn't matter much because the program is
> short-lived, but I couldn't remember if we have a policy on such things
> with increasing lib-ification.

True. How about this:

-- snip --

---
 receive-pack.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index a6ec9f9..d84fc2c 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -131,17 +131,19 @@ static int update(struct command *cmd)
 	}
 	if (deny_non_fast_forwards && !is_null_sha1(old_sha1)) {
 		struct commit *old_commit, *new_commit;
-		struct commit_list *bases;
+		struct commit_list *bases, *backup;
 
 		old_commit = (struct commit *)parse_object(old_sha1);
 		new_commit = (struct commit *)parse_object(new_sha1);
-		for (bases = get_merge_bases(old_commit, new_commit, 1);
+		backup = get_merge_bases(old_commit, new_commit, 1);
+		for (bases = backup;
 				bases; bases = bases->next)
 			if (!hashcmp(old_sha1, bases->item->object.sha1))
 				break;
 		if (!bases)
 			return error("denying non-fast forward;"
 					" you should pull first");
+		free_commit_list(backup);
 	}
 	safe_create_leading_directories(lock_name);
 
-- 
1.4.2.1.g6ad2-dirty
