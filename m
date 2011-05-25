From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Remove a dead assignment
Date: Wed, 25 May 2011 15:45:05 -0400
Message-ID: <20110525194505.GB27260@sigill.intra.peff.net>
References: <20110524210758.GH16052@localhost>
 <20110524224525.GI16052@localhost>
 <vpqfwo3ush3.fsf@bauges.imag.fr>
 <20110525150631.GA29161@localhost>
 <4DDD3A01.6040407@elegosoft.com>
 <20110525184514.GA20005@localhost>
 <7v4o4i4mte.fsf@alter.siamese.dyndns.org>
 <7vzkma37pb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Wilson <cwilson@vigilantsw.com>,
	Johannes Gilger <heipei@hackvalue.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 21:45:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPK16-0003b3-O2
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 21:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab1EYTpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 15:45:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41050
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420Ab1EYTpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 15:45:08 -0400
Received: (qmail 4616 invoked by uid 107); 25 May 2011 19:45:06 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 May 2011 15:45:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2011 15:45:05 -0400
Content-Disposition: inline
In-Reply-To: <7vzkma37pb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174454>

On Wed, May 25, 2011 at 12:23:44PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The if statement says "we might be passing NULL in fmt and in that case
> > please fall back to user_format" to human readers, but the compiler is too
> > stupid to infer such an intention, so you have to help it with your brain.
> > I have to wonder if the strbuf_expand() should be passing fmt instead of
> > user_format.  "git blame -L1082,+7 pretty.c" points at 5b16360 (pretty:
> > Initialize notes if %N is used, 2010-04-13).
> >
> > The only callsite that is introduced by that patch passes NULL to fmt, so
> > a better fix might be to do something like this instead.
> 
> If somebody cares about the reusability of the code for other callsites
> added in the future, we could do this instead.
> 
> I think this is what Johannes wanted to do from the beginning, and is a
> better fix than my previous one to remove the fmt parameter altogether.

Actually, I am to blame for this interface, see:

  http://article.gmane.org/gmane.comp.version-control.git/144650

and my response:

  http://article.gmane.org/gmane.comp.version-control.git/144715

The resulting patch definitely has a bug (albeit one that could not be
triggered by current users), and should have had this:

> -	strbuf_expand(&dummy, user_format, userformat_want_item, w);
> +	strbuf_expand(&dummy, fmt, userformat_want_item, w);

all along.

I'm also OK with just tightening the interface to always use
user_format, as no callers who wanted the extra parameter have come up
in the past year.

> Subject: userformat_find_requirements(): find requirement for the correct format
> 
> This function was introduced in 5b16360 (pretty: Initialize notes if %N is
> used, 2010-04-13) to check what kind of information the "log --format=..."
> user format string wants. The function can be passed a NULL instead of a
> format string to ask it to check user_format variable kept by an earlier
> call to save_user_format().
> 
> But it unconditionally checked user_format and not the string it was
> given.  The only caller introduced by the change passes NULL, which
> kept the bug unnoticed, until a new GCC noticed that there is an
> assignment to fmt that is never used.

Acked-by: Jeff King <peff@peff.net>

> Noticed-by: Chris Wilson's compiler

Heh.

-Peff
