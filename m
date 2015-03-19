From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] refs: introduce a "ref paranoia" flag
Date: Thu, 19 Mar 2015 17:51:14 -0400
Message-ID: <20150319215114.GB8680@peff.net>
References: <20150317072750.GA22155@peff.net>
 <20150317072957.GB25191@peff.net>
 <xmqqbnjoiw4m.fsf@gitster.dls.corp.google.com>
 <20150319210019.GB7775@peff.net>
 <xmqqpp84hdxg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:51:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYiLf-0008Ut-Hj
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbbCSVvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:51:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:35500 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751619AbbCSVvR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:51:17 -0400
Received: (qmail 6744 invoked by uid 102); 19 Mar 2015 21:51:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 16:51:16 -0500
Received: (qmail 17964 invoked by uid 107); 19 Mar 2015 21:51:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 17:51:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 17:51:14 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpp84hdxg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265842>

On Thu, Mar 19, 2015 at 02:31:39PM -0700, Junio C Hamano wrote:

> > We do have to have this variable cross some process boundaries. Only
> > "repack" knows whether to turn on paranoia, but "pack-objects" is the
> > one that must act on it.
> >
> > Or is there something else I'm missing?
> 
> In general, I do not like the pattern of program A setting an
> environment only because it wants to tell program B it spawns
> something, because we cannot tell program B that the environment
> should be dropped when it calls something else (e.g. user defined
> hooks, merge drivers, textconvs, etc.) to prevent end user
> invocation of Git commands from honoring it.  Setting GIT_DIR or
> GIT_WORK_TREE and having to know when to drop them is not very
> pleasant, for example.
> 
> I think the use of this pattern is OK in this codepath in which
> repack calls pack-objects, and I think I can be persuaded to buy an
> argument that there is no harm, or it may even be a good thing, to
> run such an end-user program under paranoia mode, if pack-objects
> wants to spawn one.

Ah, I see. Yeah, I consider that to be a _feature_ for REF_PARANOIA
here. If you are running receive-pack under REF_PARANOIA, for example,
you would want your pre-receive hooks to use the same rules as the rest
of receive-pack.

If there is a misfeature, it is that we turn on REF_PARANOIA
automatically behind the user's back in some cases, which could surprise
them if we call through to custom code. But as you note, I think this
code path is OK, because we don't spawn anything else from pack-objects
(and if we did, arguably it is OK because our caller told us we are
doing something dangerous; but we would have to evaluate that
case-by-case, I would think).

-Peff
