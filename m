From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 4/4] grep: obey --textconv for the case rev:path
Date: Thu, 7 Feb 2013 04:55:35 -0500
Message-ID: <20130207095533.GA17110@sigio.peff.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
 <a2808975f00bac5de0902e6830f254e4b064e8a5.1360162813.git.git@drmicha.warpmail.net>
 <20130206223656.GF27507@sigill.intra.peff.net>
 <51136E75.5060002@drmicha.warpmail.net>
 <20130207092640.GC15727@sigill.intra.peff.net>
 <5113784B.10103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:54:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3OBe-0002XI-S9
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 10:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633Ab3BGJyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 04:54:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38545 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756167Ab3BGJyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 04:54:09 -0500
Received: (qmail 17129 invoked by uid 1000); 7 Feb 2013 09:55:35 -0000
Content-Disposition: inline
In-Reply-To: <5113784B.10103@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215688>

On Thu, Feb 07, 2013 at 10:47:55AM +0100, Michael J Gruber wrote:

> > I'd be OK if we had an exterior object_context that could be handled
> > in the same way. But how do we tell setup_revisions that we are
> > interested in seeing the object_context from each parsed item, where
> > does the allocation come from (is it malloc'd by setup_revisions?), and
> > who is responsible for freeing it when we pop pending objects in
> > get_revisions and similar?
> 
> Do we really need all of tree, path and mode in object_context (I mean
> not just here, but other users), or only the path? I'd try and resurrect
> the virtual path name objects then, they would be just like "item"
> storage-wise.

We need at least mode, since that is how the mode parameter of
object_array_entry gets set. I do not know off-hand who uses "tree". I
suspect the intent was to do .gitattributes lookups inside that tree,
but I do not think we actually do in-tree lookups currently.

> > I don't think it's as clear cut.
> > 
> > I wonder, though...what we really care about here is just the pathname.
> > But if it is a pending object that comes from a blob revision argument,
> > won't it always be of the form "treeish:path"? Could we not even resolve
> > the sha1 again, but instead just parse out the ":path" bit?
> 
> Do we have that, and in what form (e.g. magic expanded etc.)?

Ah, I should have mentioned that. :) We should have the original rev
name in the object_array_entry's name field, shouldn't we? It's just a
matter of re-parsing it.

> Another thing I noted is that our path mangling at least for grep has
> some issues:
> 
> (cd t && git grep GET_SHA1_QUIETLY HEAD:../cache.h)
> ../HEAD:../cache.h:#define GET_SHA1_QUIETLY        01

Yuck.

-Peff
