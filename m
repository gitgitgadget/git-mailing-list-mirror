From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/21] rev-parse: add '--absolute-git-dir' option
Date: Tue, 26 Apr 2016 01:35:22 -0400
Message-ID: <20160426053522.GA23949@sigill.intra.peff.net>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
 <1456440650-32623-14-git-send-email-szeder@ira.uka.de>
 <CANoM8SXO_Rz_CVOz9ptsaVCzcQ2D1FQrSuFFW4vZ4SdRYMzD=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 07:35:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auvek-0007rh-IS
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 07:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbcDZFf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 01:35:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:56331 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751082AbcDZFfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 01:35:25 -0400
Received: (qmail 32630 invoked by uid 102); 26 Apr 2016 05:35:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Apr 2016 01:35:25 -0400
Received: (qmail 11313 invoked by uid 107); 26 Apr 2016 05:35:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Apr 2016 01:35:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Apr 2016 01:35:22 -0400
Content-Disposition: inline
In-Reply-To: <CANoM8SXO_Rz_CVOz9ptsaVCzcQ2D1FQrSuFFW4vZ4SdRYMzD=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292586>

On Mon, Apr 25, 2016 at 10:33:13PM -0400, Mike Rappazzo wrote:

> I propose that it might make more sense to use something like
> `--abs-path` to indicate
> that the result should include an absolute path (or we could also just spell out
> `--absolute-path`).  That way we don't have to add additional options
> for any other type
> that might want an absolute path.
> 
>     git rev-parse --git-dir --abs-path
>     git rev-parse --git-common-dir --absolute-path
> 
> I do understand that this might be more work than is necessary for the
> completion series
> here.  Would it be unreasonable to suggest a partial implementation
> that, for now, only
> works with `--git-dir`?

I do like the concept of keeping "--absolute-path" orthogonal. The only
trick is that we need to either support it for all appropriate options,
or document which options it _does_ work with. Otherwise, we're going to
get bug reports when somebody tries "--absolute-path --git-common-dir".

It would be cleaner to provide a separate option to let people compose
the options, like:

  git rev-parse --git-dir | git rev-parse --realpath

but that's a lot less efficient.

> > +                                       if (gitdir) {
> > +                                               char absolute_path[PATH_MAX];
> > +                                               if (!realpath(gitdir, absolute_path))
> > +                                                       die_errno(_("unable to get absolute path"));
> > +                                               puts(absolute_path);
> > +                                               continue;
> > +                                       }

I don't recall if this came up in earlier review, but I happened to
notice the use of realpath() here. We should be using our custom
real_path() instead. There are some platforms without realpath(), I
think, and our real_path() is not limited to the static PATH_MAX (which
is too small on some platforms).

-Peff
