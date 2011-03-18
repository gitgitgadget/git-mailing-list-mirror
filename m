From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] revision.c: introduce --min-parents and --max-parents
Date: Fri, 18 Mar 2011 15:34:02 -0400
Message-ID: <20110318193401.GA27825@sigill.intra.peff.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net>
 <7f2a7d979cd8f6b9fce577994c82f50421575d58.1300459017.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 20:34:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0fR8-0008Ig-TH
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 20:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756898Ab1CRTeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 15:34:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43680
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756818Ab1CRTeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 15:34:07 -0400
Received: (qmail 5322 invoked by uid 107); 18 Mar 2011 19:34:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Mar 2011 15:34:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2011 15:34:02 -0400
Content-Disposition: inline
In-Reply-To: <7f2a7d979cd8f6b9fce577994c82f50421575d58.1300459017.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169348>

On Fri, Mar 18, 2011 at 03:50:23PM +0100, Michael J Gruber wrote:

> Introduce --min-parents and --max-parents which take values 0,...,7 and
> limit the revisions to those commits which have at least resp. at most
> that many commits, where --max-parents=8 denotes --max-parents=infinity
> (i.e. no upper limit). In fact, 7 (or any negative number) does, but 8
> is infinity sideways 8-)

In practice, I don't think anybody is all that interested in
differentiating octopus merges by their numbers of parents. But the
choice of "7" as a maximum seems kind of arbitrary. There are commits in
linux-2.6 with up to 31 parents (once upon a time we had an arbitrary
limit of 16 parents, but that was lifted in v1.6.0).

You mention below that this fits in three 3 bits in rev_info. I don't
think bits are precious in rev_info, though, as they are in other
revision-related structs. We only have one such struct per walk.

If it were just an implementation issue, I would say fine, we can tweak
it later if somebody really cares. But we are cementing "7" as the value
for infinity in the user-facing interface. Wouldn't a value like "-1" or
"infinity" be more appropriate?

> In particular:
> 
> --max-parents=1: no merges
> --min-parents=2: merges only
> --max-parents=0: only roots
> --min-parents=3: only octopusses
> 
> --min-parents=n --max-parents=m with n>m gives you what you ask for
> (nothing) just like --merges --no-merges does, but at least for an
> obvious reason.

I like this. It's much more natural than the list syntax I suggested
earlier, and it handles ranges in an obvious way. It doesn't allow
selecting, e.g., root commits and merges, but not regular commits. But I
really don't see the point in supporting that.

> @@ -2029,10 +2033,15 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
>  		return commit_ignore;
>  	if (revs->min_age != -1 && (commit->date > revs->min_age))
>  		return commit_ignore;
> -	if (revs->no_merges && commit->parents && commit->parents->next)
> -		return commit_ignore;
> -	if (revs->merges_only && !(commit->parents && commit->parents->next))
> -		return commit_ignore;
> +	if (revs->min_parents || revs->max_parents) {
> +		int n = 0;
> +		struct commit_list *p;
> +		for (p = commit->parents; p; p = p->next)
> +			n++;
> +		if ((MIN_PARENTS(n) < revs->min_parents) ||
> +		    (MAX_PARENTS(n) < revs->max_parents)) /* max is inv. */
> +			return commit_ignore;
> +	}

You did the obvious optimization not to count parents if we don't care
about min/max. You could also do something like:

  switch (revs->max_parents) {
  case 0:
          if (commit->parents)
                  return commit_ignore;
          break;
  case 1:
          if (commit->parents && commit->parents->next)
                  return commit_ignore;
          break;
  default:
          if (count_parents(commit) > commit->max_parents)
                  return commit_ignore;
          break;
  }

which more closely matches the original code (you would also need to do
the same for min_parents, and obviously this code ignores the
max-parents-is-inverted thing).

I'm not sure it would buy much in practice, though. Commits with more
than 2 parents are rare, so unnecessarily counting all of them just to
find out something is a merge is probably not going to create a
measurable slowdown.

> +/* limit to used range */
> +#define MIN_PARENTS(m)	({ unsigned int __n = (m); (__n < 0) ? 0 : (__n > 7) ? 7 : __n; })
> +/* invert fox MAX so that default = 0 -> infinity */
> +#define MAX_PARENTS(m)	({ unsigned int __n = (m); (__n < 0) ? 7 : (__n > 7) ? 0 : 7 - __n;})

Hmm. You assign the input to an unsigned int, and then compare it to 0.
Won't that always be false?

The inversion trick is clever to make a bzero'd rev_info work, but I
think the code would be more obvious without it. And you really have to
call init_revisions() anyway, so initializing it to a maximum there (or
-1) would be acceptable (e.g., see how max_age and min_age work).

-Peff
