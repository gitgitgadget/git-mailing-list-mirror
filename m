From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] refs: introduce a "ref paranoia" flag
Date: Thu, 19 Mar 2015 17:00:19 -0400
Message-ID: <20150319210019.GB7775@peff.net>
References: <20150317072750.GA22155@peff.net>
 <20150317072957.GB25191@peff.net>
 <xmqqbnjoiw4m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:00:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYhYM-0000i9-72
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbbCSVAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:00:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:35444 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751439AbbCSVAW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:00:22 -0400
Received: (qmail 4575 invoked by uid 102); 19 Mar 2015 21:00:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 16:00:21 -0500
Received: (qmail 17385 invoked by uid 107); 19 Mar 2015 21:00:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 17:00:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 17:00:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnjoiw4m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265831>

On Thu, Mar 19, 2015 at 01:13:13PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/refs.c b/refs.c
> > index e23542b..7f0e7be 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1934,6 +1934,11 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
> >  	data.fn = fn;
> >  	data.cb_data = cb_data;
> >  
> > +	if (ref_paranoia < 0)
> > +		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
> > +	if (ref_paranoia)
> > +		data.flags |= DO_FOR_EACH_INCLUDE_BROKEN;
> 
> I am not a big fan of proliferation of interfaces based on
> environment variables, but hopefully this is isolated enough to
> become an issue in the future.

I'm not sure which part you don't like.

We do have to have this variable cross some process boundaries. Only
"repack" knows whether to turn on paranoia, but "pack-objects" is the
one that must act on it. For that case, we could add a "--ref-paranoia"
flag to pack-objects.

But there are also other cases where the _user_ might want to tell us to
be paranoid (e.g., the upload-pack example I gave earlier). Adding
--paranoia options to every command that might iterate, along with
support for other programs that call them to pass the option through,
seems like a large amount of maintenance burden for little benefit.

We could add a git-global "git --ref-paranoia <cmd>" option and leave
the environment variable as an implementation detail. That makes it hard
to turn on for server-side operations, though. git-daemon runs
git-upload-pack without room for options, though I suppose you could run
"git --ref-paranoia daemon". Smart-http is harder. I'm not sure Apache
lets you add random arguments to CGI programs.

Or is there something else I'm missing?

-Peff
