From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Wed, 14 Aug 2013 03:40:35 -0400
Message-ID: <20130814074035.GB5095@sigill.intra.peff.net>
References: <52060EF9.2040504@alum.mit.edu>
 <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
 <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
 <20130812123921.GA16088@sigill.intra.peff.net>
 <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
 <20130812154520.GA18215@sigill.intra.peff.net>
 <CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
 <20130813114635.GA16506@sigill.intra.peff.net>
 <7vsiydy2i1.fsf@alter.siamese.dyndns.org>
 <vpqsiycn33b.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 14 09:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9VhC-0007dT-O2
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 09:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759359Ab3HNHki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 03:40:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:35518 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759199Ab3HNHkh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 03:40:37 -0400
Received: (qmail 5558 invoked by uid 102); 14 Aug 2013 07:40:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Aug 2013 02:40:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Aug 2013 03:40:35 -0400
Content-Disposition: inline
In-Reply-To: <vpqsiycn33b.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232270>

On Wed, Aug 14, 2013 at 09:28:24AM +0200, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> I guess we could do something like:
> >>
> >>   [include "repo:...your regex here..."]
> >>     path = .gitconfig-only-for-some-repos
> >>   [include "env:USE_MY_MAGIC_CONFIG"]
> >>     path = .gitconfig-only-when-magic-env-set
> >
> > I am not sure if "env" is very useful, but there certainly are other
> > possibilities (e.g. apply this only on this host, only for members
> > of this UNIX group, etc.)
> 
> I have already wished I had "git version >= XXX" here (but that's tricky
> to implement).

I assume it is "because version XXX understands config option Y, but
older versions do not"[1]. Rather than ask for version XXX, then, you
could ask for

  [include "option:Y"]
    path = ...

and versions which understand Y (which happens to be XXX or greater)
would internally know that and consider the conditional true.

This whole discussion is basically implementing conditional config. In
my patch, the conditional is limited only to including other config. But
if you have many such conditions (and especially if each one only has
one varying config key), the result can be unwieldy. Another way of
doing this would be to introduce a conditional syntax to ignore or
respect some part of the file. The problem is that it would be tricky to
do in a backwards-compatible way.

-Peff

[1] I used to run into this with pager.*, which originally could only be
    a bool, but later learned to take custom pagers. I solved it with:

      git config --file .gitconfig-pager pager.diff ...
      git config --global include.path .gitconfig-pager

    which does not need a version or option conditional, because the
    option was added _before_ the include feature. IOW, older versions
    of git ignore it, and any which actually respect the include will
    know how to handle custom pagers. But that does not work with
    changes that came after the include feature was added. :)
