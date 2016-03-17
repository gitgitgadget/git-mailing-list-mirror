From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Wed, 16 Mar 2016 21:50:44 -0400
Message-ID: <20160317015044.GB12830@sigill.intra.peff.net>
References: <0102015381b7c7b5-5b57a780-369b-478b-94d2-7094f0befdad-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 02:50:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agN5Q-0007Uy-Ij
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 02:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbcCQBus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 21:50:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:33017 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752508AbcCQBur (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 21:50:47 -0400
Received: (qmail 5605 invoked by uid 102); 17 Mar 2016 01:50:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 21:50:47 -0400
Received: (qmail 23023 invoked by uid 107); 17 Mar 2016 01:51:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 21:51:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 21:50:44 -0400
Content-Disposition: inline
In-Reply-To: <0102015381b7c7b5-5b57a780-369b-478b-94d2-7094f0befdad-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289070>

On Wed, Mar 16, 2016 at 11:16:58PM +0000, Pranit Bauva wrote:

> The reason to make it consider negative values or more specifically
> "unspecified" values is to differentiate between the option passed
> once, multiple times or with --no-option. This makes the receiver
> know what actually happened with the arguments which is particularly
> required with option have multiple levels of that option.
> 
> Eg. :
> initialize verbose = -1
> `git commit` => verbose = -1
> `git commit -v` => verbose = 1
> `git commit -v -v` => verbose = 1
> `git commit --no-verbose` => verbose = 0

This second to last example would be 2, right?

That aside, this patch does mean that one can no longer use
OPT_COUNTUP() for negative values (i.e., the caller must start it at
either 0 or 1, and it must always go up from there).

And we would need to verify that all of the existing callers are OK with
this. Did you check that that (not rhetorical; I suspect they are all
OK, but somebody needs to check)?

We are also changing semantics without changing the interface, which
means any topics in flight (that you _cannot_ review, because you have
not seen them yet) may be subtly broken. To me that is not an absolute
deal-breaker, but something to weigh against the utility of the change.

When looking more carefully at builtin/commit.c for the other thread, it
occurred to me that OPT_BOOL might be a better fit for commit's "-v". It
really is a boolean "show the diff or not" and thus unlike the other
"make me more verbose". And OPT_BOOL already has the behavior you want,
I think.

-Peff
