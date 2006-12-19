X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on many
 OSes other than Linux
Date: Tue, 19 Dec 2006 14:14:55 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612191409500.18171@xanadu.home>
References: <86y7p57y05.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
 <86r6uw9azn.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
 <86hcvs984c.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
 <8664c896xv.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612181906450.18171@xanadu.home>
 <20061219051108.GA29405@thunk.org>
 <Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
 <Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612191027270.18171@xanadu.home>
 <7vk60npv7x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 19 Dec 2006 19:15:28 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vk60npv7x.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34843>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwkQj-0000qP-9K for gcvg-git@gmane.org; Tue, 19 Dec
 2006 20:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932904AbWLSTO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 14:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932909AbWLSTO6
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 14:14:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62875 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932908AbWLSTO5 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 14:14:57 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAJ00LJWC4VDX61@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Tue,
 19 Dec 2006 14:14:56 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, 19 Dec 2006, Junio C Hamano wrote:

> > diff --git a/index-pack.c b/index-pack.c
> > index 6d6c92b..e08a687 100644
> > --- a/index-pack.c
> > +++ b/index-pack.c
> > @@ -1,3 +1,8 @@
> > +#define _XOPEN_SOURCE 500
> > +#include <unistd.h>
> > +#include <sys/time.h>
> > +#include <signal.h>
> > +
> >  #include "cache.h"
> >  #include "delta.h"
> >  #include "pack.h"
> > @@ -6,8 +11,6 @@
> >  #include "commit.h"
> >  #include "tag.h"
> >  #include "tree.h"
> > -#include <sys/time.h>
> > -#include <signal.h>
> 
> Most of the rest of the sources seem to do our includes first
> and source-file specific system includes at the end.  What's the
> rationale for this change?

Because _XOPEN_SOURCE must be defined before including unistd.h 
otherwise pread is not declared and a warning is issued.

> Do we need _XOPEN_SOURCE=500 because pread() is XSI?

The pread man page says Unix98.

> Also nobody other than convert-objects.c has _XOPEN_SOURCE level
> specified.  If _XOPEN_SOURCE matters I wonder if we should do so
> in some central place to make it consistent across source files?

Your call I guess.


