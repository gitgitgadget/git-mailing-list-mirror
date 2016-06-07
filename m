From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 7 Jun 2016 17:17:07 -0400
Message-ID: <20160607211707.GA7981@sigill.intra.peff.net>
References: <20160607195608.16643-1-santiago@nyu.edu>
 <xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: santiago@nyu.edu, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 23:17:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAON9-00014O-E7
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 23:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933178AbcFGVRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 17:17:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:50802 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932773AbcFGVRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 17:17:10 -0400
Received: (qmail 8639 invoked by uid 102); 7 Jun 2016 21:17:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 17:17:09 -0400
Received: (qmail 1681 invoked by uid 107); 7 Jun 2016 21:17:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 17:17:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2016 17:17:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296725>

On Tue, Jun 07, 2016 at 02:05:20PM -0700, Junio C Hamano wrote:

> It is true that "git cat-file tag v1.4.11" lets you examine all
> lines of a given tag object, but the calling program needs to pick
> pieces apart with something like:
> 
> 	git cat-file tag v1.4.11 | sed -e '/^$/q' -e 's/^tag //p'
> 
> which may be cumbersome.  Perhaps, just like "git tag -v v1.4.11" is
> a way to see if the contents of the tag is signed properly, if you
> add "git tag --show-tagname v1.4.11" that does the above pipeline,
> these package managers and other tools can be updated to
> 
> 	tag="$1"
> -	if ! git tag -v "$tag"
> +	if ! git tag -v "$tag" ||
> +	   test "$tag" != "$(git tag --show-tagname $tag)"
>         then
> 		echo >&2 "Bad tag."
>                 exit 1
> 	fi
> 	make dest=/usr/local/$package/$tag install

That is much more flexible, as they could even do some more complicated
matching than a single string (though in practice, for security things,
I think simpler is better).

I think this option is going to become a blueprint for other "extended"
checks, too. E.g., you might also want to check that the tagger ident
matches the uid on the signing key.

My main worry is that we'll accrue a whole bunch of such logic. And even
though each one is relatively simple, it would be nice for callers to be
able to ask us to just do the standard safety checks.

If we do go with the "print it out and let the caller do their own
checks" strategy, I think I'd prefer rather than "--show-tagname" to
just respect the "--format" we use for tag-listing. That would let you
do:

  git tag -v --format='%(tag)%n%(tagger)'

or similar. In fact you can already do that with a separate step (modulo
%n, which we do not seem to understand here), but like your example:

> Or it could even do this:
> 
> 	tag="$1"
> 	if ! git tag -v "$tag"
> 	if ! git tag -v "$tag"
>         then
> 		echo >&2 "Bad tag."
>                 exit 1
> 	fi
> +	tag=$(git tag --show-tagname $tag)
> 	make dest=/usr/local/$package/$tag install

It is racy. That probably doesn't matter for most callers, but it would
be nice to be able to get a custom format out of the "-v" invocation.

-Peff
