From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 08/18] map/take range to the parent of commits
Date: Thu, 5 Aug 2010 23:32:37 +0200
Message-ID: <201008052332.37435.trast@student.ethz.ch>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com> <1281024717-7855-9-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <Jens.Lehmann@web.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 23:34:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh84o-0002wc-NX
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 23:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693Ab0HEVeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 17:34:05 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:32845 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772Ab0HEVeD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 17:34:03 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 5 Aug
 2010 23:34:01 +0200
Received: from thomas.site (84.74.100.241) by cas10.d.ethz.ch (172.31.38.210)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 5 Aug 2010 23:33:39
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <1281024717-7855-9-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152722>

Bo Yang wrote:
> The algorithm that maps lines from post-image to pre-image is in
> the function map_lines. Generally, we use simple line number
> calculation method to do the map.

> +#define SCALE_FACTOR 4
> +/*
> + * [p_start, p_end] represents the pre-image of current diff hunk,
> + * [t_start, t_end] represnets the post-image of the current diff hunk,
                            ^^
Typo here ------------------/

> + * [start, end] represents the currently interesting line range in
> + * post-image,
> + * [o_start, o_end] represents the original line range that coresponds
> + * to current line range.
> + */
> +void map_lines(long p_start, long p_end, long t_start, long t_end,
> +		long start, long end, long *o_start, long *o_end)
> +{
[...]
> +	/*
> +	 * A heuristic for lines mapping:
> +	 *
> +	 * When the pre-image is no more than 1/4 of the post-image,
> +	 * there is no effective way to find out which part of pre-image
> +	 * corresponds to the currently interesting range of post-image.
> +	 * And we are in the danger of tracking totally useless lines.
> +	 * So, we just treat all the post-image lines as added from scratch.
> +	 */
> +	if (SCALE_FACTOR * (p_end - p_start + 1) < (t_end - t_start + 1)) {

So that's what SCALE_FACTOR is good for (and the comment should
probably say 1/SCALE_FACTOR instead).

Out of curiosity, did you come up with 4 randomly or by experimentation?

> +/*
> + * When same == 1:
> + * [p_start, p_end] represents the diff hunk line range of pre-image,
> + * [t_start, t_end] represents the diff hunk line range of post-image.
> + * When same == 0, they represents a range of idnetical lines between

+ * When same == 0, they represent a range of identical lines between

> + * two images.
> + *
> + * This function find out the corresponding line ranges of currently
> + * interesting ranges which this diff hunk touches.
> + */
> +static void map_range(struct take_range_cb_data *data, int same,
> +		long p_start, long p_end, long t_start, long t_end)

You took some time to comment map_lines, but not this one, sadly.

I gather it works as

  assign_parents_range
  -> assign_range_to_parent once with map=1, once with map=0
  -> either map_range_cb or take_range_cb
  -> either map_range or take_range

but there are few comments on where the decisions should be obvious
and where they are just heuristics.  Can you add some more comments to
enlighten us?

> +		if (map)
> +			map_range(&cb, 1, cb.plno + 1, 0x7FFFFFFF, cb.tlno + 1, 0x7FFFFFFF);
> +		else
> +			take_range(&cb, cb.plno + 1, 0x7FFFFFFF, cb.tlno + 1, 0x7FFFFFFF);

Use INT_MAX from limits.h (and besides, you're not guaranteed to have
32 bits).

> +	/*
> +	 * Loop on the parents and assign the ranges to different
> +	 * parents, if there is any range left, this commit must
> +	 * be an evil merge.
> +	 */
> +	copy = diff_line_range_clone_deeply(r);
> +	parents = commit->parents;
> +	while (parents) {
> +		struct commit *p = parents->item;

> +		assign_range_to_parent(rev, commit, p, r, &rev->diffopt, 1);

IIUC, the latter line is

  /* assign to the parent what we can */

and the next one

> +		assign_range_to_parent(rev, commit, p, copy, &rev->diffopt, 0);

  /* and remove it from our to-be-printed range */

right?

If so, please rename the 'copy' variable since its purpose is not to
be a copy, but to hold entirely different data.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
