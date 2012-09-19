From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-blame.txt: --follow is a NO-OP
Date: Wed, 19 Sep 2012 15:42:13 -0400
Message-ID: <20120919194213.GB21950@sigill.intra.peff.net>
References: <20120906151317.GB7407@sigill.intra.peff.net>
 <1348022905-10048-1-git-send-email-n1xim.email@gmail.com>
 <7v627aiq47.fsf@alter.siamese.dyndns.org>
 <20120919182715.GF11699@sigill.intra.peff.net>
 <7vzk4lg5yf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Drew Northup <n1xim.email@gmail.com>,
	gitList <git@vger.kernel.org>, Matthieu.Moy@imag.fr,
	andy@aeruder.net, chriscool@tuxfamily.org,
	dmellor@whistlingcat.com, dpmcgee@gmail.com, fonseca@diku.dk,
	freku045@student.liu.se, kevin@sb.org, marius@trolltech.com,
	namhyung@gmail.com, rene.scharfe@lsrfire.ath.cx, s-beyer@gmx.net,
	trast@inf.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:42:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQAC-0001MR-RV
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 21:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011Ab2ISTmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 15:42:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49918 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab2ISTmP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 15:42:15 -0400
Received: (qmail 4504 invoked by uid 107); 19 Sep 2012 19:42:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 15:42:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 15:42:13 -0400
Content-Disposition: inline
In-Reply-To: <7vzk4lg5yf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205984>

On Wed, Sep 19, 2012 at 12:36:56PM -0700, Junio C Hamano wrote:

> > Like this (totally untested) patch:
> >
> > diff --git a/builtin/blame.c b/builtin/blame.c
> > index 0e102bf..412d6dd 100644
> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -2365,6 +2365,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
> >  			ctx.argv[0] = "--children";
> >  			reverse = 1;
> >  		}
> > +		else if (!strcmp(ctx.argv[0], "--follow")) {
> > +			error("unknown option `--follow`");
> > +			usage_with_options(blame_opt_usage, options);
> > +		}
> >  		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
> >  	}
> >  parse_done:
> 
> This patch would not hurt existing users very much; blame is an
> unlikely thing to run in scripts, and it is easy to remove the
> misguided --follow from them.

I would not worry about such users. I am of the opinion that their
scripts are buggy for calling a useless and undocumented option that
just happened to not complain.

> So I am in general OK with it, but if we are to go that route, we
> should make sure that the documentation makes it clear that blame
> follows whole-file renames without any special instruction before
> doing so.  Otherwise, it again will send the same wrong message to
> people who try to use the "--follow" from their experience with
> "log", no?

I guess it depends on your perspective. I can see the argument that
blame is already doing what --follow would ask for, and thus it is a
no-op. I think of it more as --follow is nonsensical for blame. But I
do not think either is wrong per se, and there is no reason not to help
people who come to git thinking the former. So yes, I think
documentation in either case is probably a good thing.

I am a little lukewarm on my patch if only because of the precedent it
sets.  There are a trillion options that revision.c parses that are not
necessarily meaningful or implemented for sub-commands that piggy-back
on its option parser. I'm not sure we want to get into manually
detecting and disallowing each one in every caller.

-Peff
