X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] allow cloning a repository "shallowly"
Date: Wed, 15 Nov 2006 11:57:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611151153490.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0610302009160.26682@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pt21oe9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611141145390.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vpsbpzzse.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 10:57:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vpsbpzzse.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31436>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkISe-0007ZW-GA for gcvg-git@gmane.org; Wed, 15 Nov
 2006 11:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966784AbWKOK5l (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 05:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966785AbWKOK5l
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 05:57:41 -0500
Received: from mail.gmx.de ([213.165.64.20]:40390 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S966784AbWKOK5k (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 05:57:40 -0500
Received: (qmail invoked by alias); 15 Nov 2006 10:57:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp046) with SMTP; 15 Nov 2006 11:57:39 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 14 Nov 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I understand "no need making it shallow", but I am not sure if a
> >> non-NULL return from lookup_object() tells us that.
> >
> > You are probably right, how about has_sha1_file()?
> >
> >> I think register_shallow() can take commits that are already shallow() 
> >> so maybe we can remove this "if() continue"?
> >
> > Yes, it can, but that is not necessarily correct: since .git/shallow is 
> > constructed from the registered shallow commits, we would make a commit 
> > shallow which is really not shallow.
> >
> > So, how about
> >
> >> > +				if (lookup_object(sha1) || has_sha1_file(sha1))
> >> > +					continue;
> 
> If I understand the code correctly, this loop is reading what
> the other side thinks your shallows should be (based on your
> earlier "deepen" request or if this is initial fetch based on
> your depth).  Even if we already have that object, if that
> object _is_ shallow on our end, don't we need to keep it marked
> as shallow?  Will we get ancestors of this commit from the other
> end (and "shallow" lines for some of them to properly cauterize
> the chain)?

My thinking was: if we have that object already, and it is _not_ marked as 
shallow, we probably have either all its ancestors, or at least all 
ancestors up until shallow commit(s).

Thinking about it again, it seems very fragile: on purpose, we only trust 
to have the objects which are reachable by at least one ref, so that an 
interrupted fetch does not corrupt the repository.

So yes, I agree, that "if() continue;" should go away. Even if all of a 
sudden, commits we already have are no longer reachable.

Ciao,
Dscho
