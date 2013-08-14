From: Jeff King <peff@peff.net>
Subject: conditional config syntax
Date: Wed, 14 Aug 2013 10:08:53 -0400
Message-ID: <20130814140853.GA32605@sigill.intra.peff.net>
References: <20130812123921.GA16088@sigill.intra.peff.net>
 <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
 <20130812154520.GA18215@sigill.intra.peff.net>
 <CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
 <20130813114635.GA16506@sigill.intra.peff.net>
 <7vsiydy2i1.fsf@alter.siamese.dyndns.org>
 <vpqsiycn33b.fsf@anie.imag.fr>
 <20130814074035.GB5095@sigill.intra.peff.net>
 <vpq38qcmzw1.fsf@anie.imag.fr>
 <CAPc5daWqzTkMFkecrAjMCmxwZZrgUtB-FVKrjsmfvpgwPgF8AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 16:09:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9bkz-0002Qk-3x
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 16:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759770Ab3HNOI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 10:08:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:38061 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755934Ab3HNOI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 10:08:56 -0400
Received: (qmail 23736 invoked by uid 102); 14 Aug 2013 14:08:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Aug 2013 09:08:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Aug 2013 10:08:53 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daWqzTkMFkecrAjMCmxwZZrgUtB-FVKrjsmfvpgwPgF8AA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232285>

[updated subject, as we are very far off the original topic]

On Wed, Aug 14, 2013 at 07:00:58AM -0700, Junio C Hamano wrote:

> > > This whole discussion is basically implementing conditional config.
> > > [...] The problem is that it would be tricky to do in a
> > > backwards-compatible way.
> >
> > That could be done with "conditional comments" like
> >
> > # if <some-condition> then
> > [core]
> >         pager = less
> > # endif
> >
> > That's rather ugly, and the implementation would be even more ugly, but
> > backward-compatible.
> 
> I highly doubt that you would want to be "backward compatible" in this
> case, though.  The section of the configuration you are enclosing the
> new if/endif syntax may be understood only by newer Git (e.g. imagine
> core.pager is still bool-only today), and older Git that do not
> understand if/endif syntax will happily read that section and choke on
> it, no?

I would think the ideal behavior would be for existing implementations
to just not include the conditional section.

If we take the conditional by default in existing versions of git (i.e.,
the behavior of Matthieu's proposal), then any "do this only if version
X or greater" conditional is going to be inconsistent (it will be true
for old versions, not true for versions which understand conditionals
but pre-date X, and then true again for the actual versions you want).

Likewise, if we introduce some new non-backwards-compatible syntax that
existing Git chokes on, then you have created a new compatibility
problem. You cannot use older versions of git, which is the exact
problem a version conditional is trying to solve.

That is one of the reasons that include.path is designed as it is; old
versions accept it and do nothing (unless you specifically ask for it as
a value). And likewise, include.*.path will do nothing for existing
versions of git.

Or hmm. Maybe that is what you mean by "choke on it". Choke on the
invalid config, not on the new syntax.

-Peff
