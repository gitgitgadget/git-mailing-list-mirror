X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] avoid accessing _all_ loose refs in git-show-ref
Date: Sat, 16 Dec 2006 15:20:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612161518070.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612161335140.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk60sf0hr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 16 Dec 2006 14:21:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vk60sf0hr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34620>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvaPP-00008b-VK for gcvg-git@gmane.org; Sat, 16 Dec
 2006 15:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965047AbWLPOU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 09:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965437AbWLPOU7
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 09:20:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:47410 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S965047AbWLPOU7
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 09:20:59 -0500
Received: (qmail invoked by alias); 16 Dec 2006 14:20:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp001) with SMTP; 16 Dec 2006 15:20:57 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Sat, 16 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	This is kind of quick and dirty.
> 
> Maybe I am blind, but why don't you just do a resolve_ref()
> regardless of packedness?  It only builds the packed refs list
> when it is not found as a loose ref, and never builds the loose
> refs list.  You probably would want to reject the ones that says
> REF_ISSYMREF.

But of course!

> > 	An alternative would be to pack the tags _per default_. I once
> > 	argued for that, but it appears nobody liked that idea. I even
> > 	proposed to pack _all_ refs, and I still think this would be
> > 	a good idea.
> 
> I do not think packing all refs is such a good idea.  Branches
> are meant to be worked on and extended so the packed ones
> would become stale quickly.

My idea would have been to edit them in-place. Since the hashes all take 
the same amount of bytes, it could be done by seeking around in the file.

>  Packing all tags by default is something we would want when everybody 
> knows how to handle them.

You mean all the scripts? Because if you make it the default, you could 
hide that implementation detail away from the user.

> > 	Isn't it a bug that --verify succeeds, if only _one_ ref passed to 
> > 	the command exists?
> 
> I think --verify should insist a single parameter, just like
> rev-parse.
> 
> So wouldn't the code be like:
> 
> 	if (verify) {
> 		int flag;
>         	if (pattern[1])
>                 	die("Eh?");
> 		if (resolve_ref(pattern[0], sha1, 1, &flag) &&
>                 	(flag & REF_ISSYMREF) == 0) {
>                 		printf("%s %s\n",
>                                 	sha1_to_hex(sha1), pattern[0]);
> 				exit(0);
> 		} else
>                 	die("no match");
> 	}
> 
> ???

Ack. Scrap my patch.

Ciao,
Dscho
