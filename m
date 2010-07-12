From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/13] map/take range to parent
Date: Mon, 12 Jul 2010 14:52:11 -0700
Message-ID: <7vy6dg8j1w.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829141-11900-8-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 23:52:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYQvQ-0000lR-Tr
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 23:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab0GLVwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 17:52:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab0GLVwT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 17:52:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E6FBC331F;
	Mon, 12 Jul 2010 17:52:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=oG9M2eZF78DQy3/onAAXAEVhjoA=; b=d2+fG5xtKen2cn45Hvn+kqx
	K//1e9+fb9Z1IBQ96JgYvPgIBqNnsxbuXaVO+itnnlBQ1YEpS1DECwnuwhYppXAm
	5Rwk4i3kjiyZs98oE6A1dGDgDibNfY2GaHk3XlxH0BSEaoJxCbyqYEJrlXh1kdZC
	8DJ1UuD0Rgi1QPR72yS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=eMgrgNKPENGKQB5hdcyrCGSwqRbbCC6W2u+nbSx6laVeD9KLn
	S1qDYXQfxdJxetI4nJtMX9Nu6uHfIM3Wt11odt6Qw73aq79XKXoWt/0E/VJnh46F
	UwzxJZHq+b2Riwjhoy74IToq8fzcxkzVbRllXlep85msmDedxY9P9g+S+4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12DA4C331D;
	Mon, 12 Jul 2010 17:52:17 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0004EC3318; Mon, 12 Jul
 2010 17:52:12 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BCF103A8-8DFF-11DF-997C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150849>

Bo Yang <struggleyb.nku@gmail.com> writes:

> The interesting line range will be passed to all of its parents.

This needs too much context to understand what you are saying, doesn't it?
What is "it" (presumably "a commit" but that is merely a guess from the
use of word "parents" and in git the only thing that has parents are
commits)?  In what context is this "passing" happen (presumably while
digging the history with specific line ranges in mind, but the Subject
line does not even give any useful hint)?

> For non-merge commit, we just map_range the ranges. Generally, the
> algorithm do:

s/do//;

>
> 1. Run a diffcore_std to find out the pairs;

s/Run/Runs/; ( won't do any more language nitpicks from now on in this
message.

> 2. Run a xdi_diff_hunks on each interesting file pair;
> 3. The map_range_cb callback will be invoked for each diff hunk,
>    and in the function map_lines we will calculate the pre-image
>    range from the post-image range.
>
> For merge commit, another take_range pass will be done except the
> above normal map_range work. It is used to subtract each same
> part lines of the current range out. After this pass, if there is
> any line range left, this means the merge must be a non-trivial
> merge. This is how the non-trivial merge detect work.
>
> The algorithm that map lines from post-image to pre-image is in
> the function map_lines. Generally, we use simple line number
> calculation method to do the map.
>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> ---
>  line.c     |  453 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  revision.h |    5 +-
>  2 files changed, 457 insertions(+), 1 deletions(-)
>
> diff --git a/line.c b/line.c
> index ba96d7d..e1af2f6 100644
> --- a/line.c
> +++ b/line.c
> @@ -498,3 +498,456 @@ void setup_line(struct rev_info *rev, struct diff_line_range *r)
>  	diff_tree_release_paths(opt);
>  }
>  
> +struct take_range_cb_data {
> +	struct diff_line_range *interesting;
> +	struct diff_line_range *range;
> +	long plno, tlno;

What does "p" and "t" stand for?

> +	int diff;
> +};
> +
> +#define SCALE_FACTOR 4
> +void map_lines(long p_start, long p_end, long t_start, long t_end,
> +		long start, long end, long *o_start, long *o_end)

What does "p", "t", "o" and "" stand for?

> +{
> +	/*
> +	 * xdiff always assign 'same' with the last line number of two
> +	 * same ranges. When some lines are added from scratch,
> +	 * p_start = same + 1;
> +	 * p_end = same;
> +	 * so, we can understand the following condition.

Not me, sorry.

> +	 */
> +	if (p_start > p_end) {
> +		*o_start = *o_end = 0;
> +		return;
> +	}
> +	/* A deletion */
> +	if (t_start > t_end) {
> +		*o_start = p_start;
> +		*o_end = p_end;
> +		return;
> +	}
> +
> +	if (start == t_start && end == t_end) {
> +		*o_start = p_start;
> +		*o_end = p_end;
> +		return;
> +	}
> +
> +	/*
> +	 * A new strategy for lines mapping:

New compared to which old one?  I think s/strategy/heuristic/ might be a
better wording here.

> +	 * When the pre-image is no more than 1/4 of the post-image, it
> +	 * take no sense to say what the real pre-image is, wan can just
> +	 * treat all the post-image lines as added from scratch.

What kind of weird result would you get if you do not use this heuristic?
I am guessing the rationale is something like "If we consider too small
contributions from the preimage in a hunk, we end up splitting the hunk
into very many smaller pieces and will keep digging into older commits.
The result will show commits that add a line here and another line there
without a real impact to the resulting logic.  It is easier to read the
logic if we stop traversal at a commit that adds large material relative
to the original to a hunk." but it is unclear.

> +	 */
> +	if (SCALE_FACTOR * (p_end - p_start + 1) < (t_end - t_start + 1)) {
> +		*o_start = *o_end = 0;
> +		return;
> +	}
> ...
> +static void map_range(struct take_range_cb_data *data, int same,
> +		long p_start, long p_end, long t_start, long t_end)
> +{
> ...
> +		if (added) {
> +			/* Code movement/copy detect here */
This probably will not even compile.
> +		} else {
> ...

> +static void take_range_cb(void *data, long same, long p_next, long t_next)
> +{
> +	struct take_range_cb_data *d = data;
> +	long p_start = d->plno + 1, t_start = d->tlno + 1;
> +	long p_end = p_start + same - t_start, t_end = same;
> +
> +	/* If one file is added from scratch, this may confuse take_range */
> +	if (t_end >= t_start)
> +		take_range(d, p_start, p_end, t_start, t_end);

Is this a "FIXME" comment, or is it justifying the if statement?

> +static void assign_range_to_parent(struct rev_info *rev, struct commit *c,
> +		struct commit *p, struct diff_line_range *r,
> +		struct diff_options *opt, int map)
> +{
> ...
> +	xpp.flags = XDF_NEED_MINIMAL;

Do you need minimal?

> +		/*
> +		 * The remain part is the same part.
> +		 * Instead of calculating the true line number of the two files,
> +		 * use the biggest integer.
> +		 */
> +		if (map)
> +			map_range(&cb, 1, cb.plno + 1, 0x7FFFFFFF, cb.tlno + 1, 0x7FFFFFFF);
> +		else
> +			take_range(&cb, cb.plno + 1, 0x7FFFFFFF, cb.tlno + 1, 0x7FFFFFFF);
> +	}

Do you mean INT_MAX or something (I didn't bother to check the type you
are using)?

As there is no good explanation of parameters to map/take_range(), it is
hard to see if an arbitrary large number like this is correct, and if it
were correct, then perhaps it means the *_end paramters are not useful to
these functions?  I dunno.
