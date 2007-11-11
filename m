From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 06/11] git-fetch: Release objects used by a prior transport
Date: Sun, 11 Nov 2007 00:29:49 -0500
Message-ID: <20071111052949.GU14735@spearce.org>
References: <20071109110626.GF19368@spearce.org> <7vve8bqcke.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 06:30:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir5Ob-0002L8-F5
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 06:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbXKKF3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 00:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbXKKF3y
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 00:29:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38483 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbXKKF3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 00:29:53 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ir5OK-0005hQ-PU; Sun, 11 Nov 2007 00:29:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BA42220FBAE; Sun, 11 Nov 2007 00:29:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vve8bqcke.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64402>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > diff --git a/builtin-fetch.c b/builtin-fetch.c
> > index 847db73..18f123e 100644
> > --- a/builtin-fetch.c
> > +++ b/builtin-fetch.c
> > @@ -337,7 +337,10 @@ static void store_updated_refs(const char *url, struct ref *ref_map)
> >  
> >  static int fetch_refs(struct transport *transport, struct ref *ref_map)
> >  {
> > -	int ret = transport_fetch_refs(transport, ref_map);
> > +	int ret;
> > +
> > +	free_all_objects();
> > +	ret = transport_fetch_refs(transport, ref_map);
> >  	if (!ret)
> >  		store_updated_refs(transport->url, ref_map);
> >  	transport_unlock_pack(transport);
> 
> This sounds a very heavy-handed approach.
> 
> Is it the callers responsibility to know what function does call
> free_all_objects() and makes sure there is no pointer to objects
> obtained before the call that is used after the call returns?

Yea, I guess it is.  That's part of the reason why this usage was
put here in a static function of builtin-fetch.  Its high enough
up in the call stack that nobody above it cares.  Where we would
run into trouble would be if a transport decided to hang onto any
pointers in its data structure between calls to the transport.

Lets just say we don't free the objects; the flags are still all
messed up from any prior user.  Its tricky to reuse the objects
because we don't know what state an object is left in by someone
that ran before us (e.g. an internal call to fetch-pack!).  Its
also tricky when they free the parent list but leave parsed=1;
we can't rebuild the parent pointers!

-- 
Shawn.
