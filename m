From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/10] color: delay auto-color decision until point of use
Date: Thu, 18 Aug 2011 15:28:18 -0700
Message-ID: <20110818222817.GA8668@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
 <20110818050421.GG2889@sigill.intra.peff.net>
 <7vvctu7402.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:28:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuB4d-0004x9-0m
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141Ab1HRW2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:28:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34769
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754351Ab1HRW2V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:28:21 -0400
Received: (qmail 26203 invoked by uid 107); 18 Aug 2011 22:29:01 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 18:29:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2011 15:28:18 -0700
Content-Disposition: inline
In-Reply-To: <7vvctu7402.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179645>

On Thu, Aug 18, 2011 at 02:59:37PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/color.h b/color.h
> > index a190a25..d715fd5 100644
> > --- a/color.h
> > +++ b/color.h
> > @@ -49,6 +49,16 @@ struct strbuf;
> >  #define GIT_COLOR_NIL "NIL"
> >  
> >  /*
> > + * The first three are chosen to match common usage in the code, and what is
> > + * returned from git_config_colorbool. The "auto" value can be returned from
> > + * config_colorbool, and will be converted by want_color() into either 0 or 1.
> > + */
> > +#define GIT_COLOR_UNKNOWN -1
> > +#define GIT_COLOR_ALWAYS 0
> > +#define GIT_COLOR_NEVER  1
> > +#define GIT_COLOR_AUTO   2
> 
> The ALWAYS/NEVER somehow go against my intuition. Let me trace one
> codepath starting from git_branch_config().
> 
>     branch_use_color is set from git_config_colorbool("color.branch");
>     -> given "never", git_config_colorbool() returns 0;
>     branch_get_color() asks want_color(branch_use_color);
>     -> want_color() returns if the given value is positive.
> 
> Because git_config_colorbool() does not use the above symbolic constants,
> everything goes well, but aren't these two swapped?

Oooops. Yes, they are completely swapped and I'm an idiot. But as you
noticed, we don't actually _use_ them anywhere. I started on replacing
every "0" with NEVER, every "1" with ALWAYS, and every "-1" with
UNKNOWN. But it really bloated the patch, and didn't actually make the
code any more readable.

The only symbolic constant that is really necessary is the AUTO one. I
just felt odd randomly defining "2" as GIT_COLOR_AUTO, but not defining
the other possible values of the enumeration. So definitely they should
be swapped. I'm also fine with just dropping all of them except AUTO.

-Peff
