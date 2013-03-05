From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push: --follow-tag
Date: Tue, 5 Mar 2013 03:22:04 -0500
Message-ID: <20130305082204.GB13552@sigill.intra.peff.net>
References: <7vd2vewu24.fsf@alter.siamese.dyndns.org>
 <7v6216wtrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 09:22:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCn95-0006sD-6o
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 09:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab3CEIWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 03:22:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35173 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900Ab3CEIWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 03:22:06 -0500
Received: (qmail 12199 invoked by uid 107); 5 Mar 2013 08:23:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Mar 2013 03:23:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2013 03:22:04 -0500
Content-Disposition: inline
In-Reply-To: <7v6216wtrk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217436>

On Mon, Mar 04, 2013 at 04:54:39PM -0800, Junio C Hamano wrote:

>    This is primarily to scratch my own itch; after tagging an rc or
>    final release, I've been doing
> 
>    	git push k.org v1.8.2
>         git push k.org
> 
>    and the first step can easily be forgotten.  With
> 
> 	git push k.org --follow-tag
> 
>    I no longer should have to worry about that.  It will push out
>    whatever would be pushed out without --follow-tag, and also tags
>    that are missing from my k.org repository that point into the
>    history being pushed out.

I've run into the same problem. It's a minor annoyance, but your patch
should make it smoother.

Should this be called "--follow-tags"? That makes more sense to me, as
you are catching all tags. For consistency, should this match the naming
of git-fetch's options (or vice versa)? There we have:

  <default>: auto-follow tags

  --tags: fetch all of refs/heads/tags

  --no-tags: do not auto-follow

I think that naming has caused some confusion in the past. And there is
no way to explicitly specify the default behavior. I wonder if both
should support:

  --follow-tags: auto-follow tags

  --no-follow-tags: do not auto-follow tags

  --tags: fetch/push all of refs/heads/tags

  --no-tags: turn off auto-following, and cancel any previous --tags

The default for push should probably keep auto-follow off, though.

> +--follow-tag::
> +	Push all the refs that would be pushed without this option,
> +	and also push the refs under `refs/tags` that are missing
> +	from the remote but are reachable from the refs that would
> +	be pushed without this option.
> +

This reads OK to me, though it is a little confusing in that there are
two sets of refs being discussed, and "the refs that would be pushed
without this option" is quite a long noun phrase (that gets used twice).

You also don't define "reachable" here. Being familiar with git, I
assume it is "the commit that the refs/tag entry peels to is an ancestor
of a commit that is at the tip of a pushed ref".  Maybe that is obvious
enough that it doesn't need to be spelled out.

I think you could just drop the second "refs that would be pushed
without this option", and just say "pushed refs". That is ambiguous (is
it all pushed refs, or refs that would be pushed without this option?),
but since reachability is transitive, they are the same set (i.e., if we
add a ref due to this option, then its ancestors are already candidates,
and it does not affect the outcome).

Maybe:

  In addition to any refs that would be pushed without this option,
  also push any refs under `refs/tags` that are missing from the remote
  but are reachable from the pushed refs.

I dunno. I don't really like that version much, either.

> +	/*
> +	 * At this point, src_tag lists tags that are missing from
> +	 * dst, and sent_tips lists the tips we are pushing (or those
> +	 * that we know they already have). An element in the src_tag
> +	 * that is not an ancestor of any of the sent_tips need to be
> +	 * sent to the other side.
> +	 */
> +	if (sent_tips.nr) {
> +		for_each_string_list_item(item, &src_tag) {
> +			struct ref *ref = item->util;
> +			struct ref *dst_ref;
> +			struct commit *commit;
> +
> +			if (is_null_sha1(ref->new_sha1))
> +				continue;
> +			commit = lookup_commit_reference_gently(ref->new_sha1, 1);
> +			if (!commit)
> +				/* not pushing a commit, which is not an error */
> +				continue;

This will find anything under refs/tags, including annotated and
non-annotated tags. I wonder if it is worth making a distinction. In
many workflows, unannotated tags should not be leaked out to public
repos. But because this feature finds any reachable tags, it will push a
tag you made a long time ago as a bookmarker on some part of the history
unrelated to the release you are making now.

One obvious alternative is only to push annotated tags with this
feature. That has the downside of not matching fetch's behavior, as well
as withholding the feature from people whose workflow uses only
unannotated tags.

Another alternative would be to change the inclusion rule from
"reachable" to "points at the tip of something being sent". But then we
lose the feature that it would backfill any old tags the remote happens
to be missing.

-Peff
