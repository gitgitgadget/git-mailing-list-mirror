From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: dereference tags with
 --ignore-if-in-upstream
Date: Mon, 1 Jun 2015 06:20:46 -0400
Message-ID: <20150601102046.GA31792@peff.net>
References: <CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
 <1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 12:20:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzMpy-0006G2-NP
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 12:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbbFAKUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 06:20:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:38697 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750820AbbFAKUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 06:20:49 -0400
Received: (qmail 25886 invoked by uid 102); 1 Jun 2015 10:20:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 05:20:49 -0500
Received: (qmail 28044 invoked by uid 107); 1 Jun 2015 10:20:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 06:20:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 06:20:46 -0400
Content-Disposition: inline
In-Reply-To: <1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270393>

On Mon, Jun 01, 2015 at 01:03:13AM +0000, brian m. carlson wrote:

> format-patch would segfault if provided a tag as one of the range
> endpoints in conjunction with --ignore-if-in-upstream, as it assumed the
> object was a commit and attempted to cast it to struct commit.
> Dereference the tag as soon as possible to prevent this, but not until
> after copying the necessary flags.

I bisected Bruce's case earlier to 895c5ba (revision: do not peel tags
used in range notation, 2013-09-19). This is an obvious fallout from
that commit; unlike most traversals which read from rev->commits, we
read straight from rev->pending here. So I wondered briefly if that
commit was not being sufficiently careful.

But as it turns out, this code was buggy long before then. 895c5ba only
changed the range notation. Even before then, if you did:

  git format-patch --ignore-if-in-upstream ^v2.2.0 v2.2.1

we would segfault. Anybody reading from rev->pending should be ready to
handle any kind of object.

Which also makes me wonder about...

> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..e0465ba 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -807,6 +807,12 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
>  	o2 = rev->pending.objects[1].item;
>  	flags2 = o2->flags;
>  
> +	o1 = deref_tag(o1, NULL, 0);
> +	o2 = deref_tag(o2, NULL, 0);
> +
> +	if (!o1 || !o2)
> +		die(_("Invalid tag."));

This will dereference tags, but it won't help at all with:

  git format-patch --ignore-if-in-upstream ^HEAD:Makefile HEAD:Documentation

where we end up with blobs. That is ridiculous, of course, but we should
complain, not segfault.

So I think what you really want is lookup_commit_reference. And the
error message is really not "invalid tag", but "not a commit". I think
you can just use lookup_commit_or_die.

>  	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
>  		die(_("Not a range."));

As an aside, now that we are dereferencing, these flags are from the
wrong object. They _should_ be the same (we mark the tag as
UNINTERESTING, too), but it's a little weird that at the end of the
function we restore the saved flags from the tag object onto the commit.
Just bumping the assignment of flags{1,2} would work (or just bump up
the lookup_commit_or_die call to where we assign to o{1,2}).

> +test_expect_success "format-patch --ignore-if-in-upstream handles tags" '
> +
> +	git tag -a v1 -m tag side &&
> +	git format-patch --stdout \
> +		--ignore-if-in-upstream master..v1 >patch1 &&
> +	cnt=$(grep "^From " patch1 | wc -l) &&
> +	test $cnt = 2

I think this avoids the usual "wc" whitespace pitfall because you don't
use double-quotes. But maybe:

  grep "^From " patch1 >count &&
  test_line_count = 2 patch1

would be more idiomatic.

-Peff
