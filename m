From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] fix clone guess_dir_name regression in v2.4.8
Date: Wed, 5 Aug 2015 04:35:26 -0400
Message-ID: <20150805083526.GA22325@sigill.intra.peff.net>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
 <0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
 <20150804043401.4494.43725@typhoon>
 <CAHGBnuMXkqhFUhen9tPfEsfFAHhbqMeFUxvePS_6A-TtMfZpzg@mail.gmail.com>
 <20150804224246.GA29051@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 10:35:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMuAt-0006jx-6N
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 10:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbbHEIfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 04:35:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:40983 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751294AbbHEIfb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 04:35:31 -0400
Received: (qmail 20978 invoked by uid 102); 5 Aug 2015 08:35:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 03:35:31 -0500
Received: (qmail 27219 invoked by uid 107); 5 Aug 2015 08:35:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 04:35:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2015 04:35:26 -0400
Content-Disposition: inline
In-Reply-To: <20150804224246.GA29051@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275353>

On Tue, Aug 04, 2015 at 06:42:46PM -0400, Jeff King wrote:

> > I did not intend this change in behavior, and I can confirm that
> > reverting my patch restores the original behavior. Thanks for bringing
> > this to my attention, I'll work on a patch.
> 
> I think this regression is in v2.4.8, as well. We should be able to use
> a running "len" instead of the "end" pointer in the earlier part, and
> then use strip_suffix_mem later (to strip from our already-reduced
> length, rather than the full NUL-terminated string). Like this:

Looks like "git clone --bare host:foo/.git" is broken, too. I've added
some tests to cover the recently broken cases, as well as some obvious
normal cases (which the patch I sent earlier break!). And as a bonus, we
can easily cover Patrick's root-repo problems (so people will actually
run the tests, unlike the stuff in t1509. :) ).

> @@ -167,14 +166,14 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
>  	 * the form  "remote.example.com:foo.git", i.e. no slash
>  	 * in the directory part.
>  	 */
> -	start = end;
> +	start = repo + len;
>  	while (repo < start && !is_dir_sep(start[-1]) && start[-1] != ':')
>  		start--;
>  
>  	/*
>  	 * Strip .{bundle,git}.
>  	 */
> -	strip_suffix(start, is_bundle ? ".bundle" : ".git" , &len);
> +	strip_suffix_mem(start, &len, is_bundle ? ".bundle" : ".git");

This is crap, of course. Our "len" variable is computed from the start
of "repo", of which "start" is a subset. So we are indexing way out of
bounds here.

As it turns out, this actually makes things simpler. We can stop using
"len" entirely in the early part, and leave it as-is with pointer math
(the patch I sent earlier did not really make anything simpler, anyway).
And then we can just compute the length of "start" here, minus
everything we've stripped off the end (i.e., "len = end - start").

Here are the patches.

  [1/2]: clone: add tests for output directory
  [2/2]: clone: use computed length in guess_dir_name

-Peff
