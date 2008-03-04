From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] git-pack-objects: Automatically pack annotated tags if object was packed
Date: Mon, 3 Mar 2008 22:06:31 -0500
Message-ID: <20080304030631.GN8410@spearce.org>
References: <20080304023607.GA16152@spearce.org> <alpine.LNX.1.00.0803032145480.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 04:07:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWNUz-0005BD-QB
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 04:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbYCDDGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 22:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbYCDDGt
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 22:06:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57118 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbYCDDGs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 22:06:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWNTx-0003NX-Nl; Mon, 03 Mar 2008 22:06:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8192E20FBAE; Mon,  3 Mar 2008 22:06:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0803032145480.19665@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76022>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Mon, 3 Mar 2008, Shawn O. Pearce wrote:
> 
> > +	if (auto_tags && nr_result)
> > +		for_each_ref(add_ref_tag, NULL);
> 
> There's for_each_tag_ref() that does the path-based filter internally, in 
> a possibly more efficient way, and avoids open-coding the test for whether 
> this is a tag sort of ref.

Yea, I know about that call, but I didn't use it because I was
trying to use peel_ref() for its optimized peeled caching in
a packed-refs file.

To use peel_ref() you have to pass the full ref name ("refs/tags/v1.0")
and not a partial ref name ("v1.0") such as for_each_tag_ref() will
return to the callback function.  So I'd have to actually do extra
work to reconstruct a ref name, and possibly an invalid ref name at
that if for_each_tag_ref() ever looked outside of the refs/tags/
namespace.

Today there is no performance benefit to for_each_tag_ref() over
for_each_ref(), but using for_each_ref() lets me use peel_ref(),
which is a performance improvement if the ref in question came from
the packed-refs file.

So.... do we keep things as-is or try to optimize peel_ref() (or
some new variant of it?!?) for use in for_each_tag_ref() just on
the off chance that we somehow can optimize for_each_tag_ref to
avoid scanning refs/heads/?  Note that I did look into trying to
do that optimization to for_each_tag_ref() earlier last week and
concluded it wasn't easily possible right now, and wasn't likely
to be worth the development costs.

-- 
Shawn.
