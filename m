From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: allow detached checkout when --branch takes a tag
Date: Thu, 5 Jan 2012 09:18:44 -0500
Message-ID: <20120105141844.GA26771@sigill.intra.peff.net>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 15:18:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rio9c-0007g2-Ul
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 15:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441Ab2AEOSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 09:18:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58198
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932412Ab2AEOSr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 09:18:47 -0500
Received: (qmail 26968 invoked by uid 107); 5 Jan 2012 14:25:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Jan 2012 09:25:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jan 2012 09:18:44 -0500
Content-Disposition: inline
In-Reply-To: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187978>

On Thu, Jan 05, 2012 at 08:49:40PM +0700, Nguyen Thai Ngoc Duy wrote:

> This allows you to do "git clone --branch=v1.7.8 git.git" and work
> right away from there. No big deal, just one more convenient step, I
> think. --branch taking a tag may be confusing though.
> 
> We can still have master in this case instead of detached HEAD, which
> may make more sense because we use --branch. I don't care much which
> way should be used.
> 
> Like? Dislike?

Seems like a reasonable goal to me. I agree that "--branch=v1.7.8" is a
little confusing, but not the end of the world. If we were designing it
from scratch, I might call it "--head" or "--checkout" or something to
indicate that it is what we are putting in HEAD. But I don't know that
it is worth renaming the option or adding a new option.

> @@ -721,6 +722,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			strbuf_release(&head);
>  
>  			if (!our_head_points_at) {
> +				strbuf_addstr(&head, "refs/tags/");
> +				strbuf_addstr(&head, option_branch);
> +				our_head_points_at =
> +					find_ref_by_name(mapped_refs, head.buf);
> +				strbuf_release(&head);
> +			}
> +
> +			if (!our_head_points_at) {

Hmm. The context just above your patch that got snipped does this:

    strbuf_addstr(&head, src_ref_prefix);
    strbuf_addstr(&head, option_branch);
    our_head_points_at =
        find_ref_by_name(mapped_refs, head.buf);

where src_ref_prefix typically is "refs/heads/", and clearly you are
meaning to do the same thing for tags. But the use of "src_ref_prefix"
is interesting.

It is always "refs/heads/" unless we are cloning into a bare mirror, in
which case it is "refs/". So with your patch in the non-mirror case,
doing "--branch=foo" would try "refs/heads/foo" followed by
"refs/tags/foo". Which makes sense. But in the mirror case, it will try
"refs/foo" followed by "refs/tags/foo", which is kind of odd.

I wonder, though, if the original code makes any sense. By using
"refs/", I would have to say "--branch=heads/foo", which is kind of
weird and undocumented. I think it should probably always be
"refs/heads/", no matter if we are mirroring or not.

> @@ -750,7 +759,16 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			      reflog_msg.buf);
>  	}
>  
> -	if (our_head_points_at) {
> +	if (our_head_points_at &&
> +	    !prefixcmp(our_head_points_at->name, "refs/tags/")) {

I think I would prefer this check to be:

  prefixcmp(our_head_points_at->name, "refs/heads/")

which more closely matches the rules for what is allowed to go in HEAD
as a symbolic ref. It's pretty hard to get something other than heads or
tags, but you can do it with "git clone --bare --mirror --branch=foo/bar".
I did argue above for doing away with that "feature", but I still think
it future-proofs this section of code to handle anything.

> +		const struct ref *ref = our_head_points_at;
> +		struct object *o;
> +
> +		/* Detached HEAD */
> +		o = deref_tag(parse_object(ref->old_sha1), NULL, 0);
> +		update_ref(reflog_msg.buf, "HEAD", o->sha1, NULL,
> +			   REF_NODEREF, DIE_ON_ERR);

It's unlikely, but deref_tag can return NULL, in which case this will
segfault (ditto with parse_object, I think). I suspect that is a problem
in lots of places, though. I wonder if deref_tag should simply die if we
have a missing object (and we can add a _gently form for things like
fsck which want to handle the error condition).

Also, any reason the "warn" flag to deref_tag should not be 1?


Other than those minor complaints, the patch looks good to me.

-Peff
