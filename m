From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length
 of string parameters
Date: Fri, 29 Mar 2013 13:04:59 -0400
Message-ID: <20130329170459.GB3552@sigill.intra.peff.net>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328214821.GD10936@sigill.intra.peff.net>
 <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com>
 <20130329120539.GA20711@sigill.intra.peff.net>
 <20130329130230.GA25861@lanh>
 <7vli96p34f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 18:05:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULck9-0003mq-Vc
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 18:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617Ab3C2RFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 13:05:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48437 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253Ab3C2RFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 13:05:01 -0400
Received: (qmail 7123 invoked by uid 107); 29 Mar 2013 17:06:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Mar 2013 13:06:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Mar 2013 13:04:59 -0400
Content-Disposition: inline
In-Reply-To: <7vli96p34f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219508>

On Fri, Mar 29, 2013 at 09:44:32AM -0700, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> >> So we would want to do any adjustment to the fix when we merge up to
> >> maint.
> >
> > OK. Then Junio, you may need to resolve the conflict with something
> > like this. Originally match_basename uses fnmatch, not wildmatch. But
> > using wildmatch there too should be fine, now that both
> > match_{base,path}name share fnmatch_icase_mem().
> 
> Thanks.
> 
> The result still smells somewhat funny, though.
> 
> fnmatch_icase_mem() is meant to be a wrapper of fnmatch_icase() for
> counted strings and its matching semantics should be the same as
> fnmatch_icase().
> 
> With the merge-fix, fnmatch_icase_mem() calls into wildmatch(), but
> fnmatch_icase() still calls into fnmatch().
> 
> The latter's flags are meant to be taken from FNM_* family, but the
> former takes flags from WM_* family of bits, no?

Yeah, that does not seem right. If match_pathname has learned to call
into wildmatch instead of fnmatch_icase in the interim, then the right
resolution is to convert its call to fnmatch_icase_mem to a new
wildmatch_mem.  Presumably that can be done by either tweaking
fnmatch_icase_mem, or, if wildmatch is ready to take counted strings,
calling into it with the right options.

> I think you are running with USE_WILDMATCH which may make the
> differences harder to notice, but the name fnmatch_icase_mem() that is
> not in the same family as fnmatch but is from the wildmatch() family
> smells like an accident waiting to happen.

Agreed.

> I tend to think in the longer term it may be a good idea to build with
> USE_WILDMATCH unconditionally (we can lose compat/fnmatch), so in the
> end this may not matter that much

Yeah, I think that is a sane long-term goal.

-Peff
