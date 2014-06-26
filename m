From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] commit: provide a fast multi-tip contains function
Date: Thu, 26 Jun 2014 11:55:28 -0700
Message-ID: <xmqqtx774i1r.fsf@gitster.dls.corp.google.com>
References: <20140625233429.GA20457@sigill.intra.peff.net>
	<20140625234730.GF23146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 26 20:55:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Epk-0007dv-0i
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 20:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbaFZSzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 14:55:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55993 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbaFZSzi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 14:55:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 837002263C;
	Thu, 26 Jun 2014 14:55:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mhd+znNDFjTr8obmc22RJsqCeVc=; b=Fnzttr
	B6EQQ1vZSUmZhQbG3/Fs+sWVxeCoEwYz90cOGqTBpiwSROpLQkVPUaz9HjGlUp3q
	YSh5635w8TqZZiiZow3eunvaU9Z49qKHQCnVYtAEn38QU12qf0qmgUboo2axBsa4
	/jz99X55RAo/i6zcpKLTfNkj8raIoAaTCudZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u/fU0nt0tYu1neCWJ/sQAIegdamL3bUb
	3NDFYOtIj97Rx940XOUbOi8J0rj07IKHd5wq838x527wy8fGFt7PyklxIj0nC5UI
	r/yNFRQe7um5kEgJiznCSbOxW52QyV/u4jeTwj57a9nOlWfSEK59Nqs1oCNsCtoH
	Tsra2czxZKA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C12522263B;
	Thu, 26 Jun 2014 14:55:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 441D422630;
	Thu, 26 Jun 2014 14:55:24 -0400 (EDT)
In-Reply-To: <20140625234730.GF23146@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 25 Jun 2014 19:47:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6E275EA2-FD63-11E3-8610-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252515>

Jeff King <peff@peff.net> writes:

> I haven't quite convinced myself that the stale logic in the middle is
> right. The origin paint_down function checks "PARENT1 | PARENT2" to see
> if we found a merge base (even though PARENT2 may represent many tips).
> Here I check whether we have _any_ "left" parent flag and _any_ "right"
> parent flag. I'm not sure if I actually need to be finding the merge
> base of _all_ of the commits.

In the one-each-on-two-side case (i.e. the original algorithm), it
is "any commit we will encounter by digging further down from a
STALE one will all be reachable from a newer merge base (e.g. the
commit that caused it to be marked as STALE originally).  It will
never be a useful merge base, so let's mark it as STALE.  Even if a
future traversal that comes from sideways (i.e. not passing the
commit that caused it to be marked as STALE) reach this STALE one,
digging further from there won't give us anything new."

If you see a commit can be reached from L1 and R2, the only thing
you know is that its parents can also be reached from L1 and R2, but
it does not tell you if it is reachable from other tips, e.g. L2 or
R1.  When a traversal reaches such a node from sideways, trying to
paint it with L2 for example, you do need to continue digging.

I think the traversal optimization based on the STALE bit is merely
a halfway optimization to cull obvious duplicates.  See how
get_merge_bases_many() needs to clean up redundant ones in the
result of merge_bases_many(), the latter of which does use the STALE
bit to remove obvious duplicates, in order to make sure it won't
include a commit in the result that can be reached from another
commit in the result, without having to resort to the SLOP trick.

Because your end-goal is to tell if Ln is reachable from Rm (for
number of n's and m's), coming up with the independent/non-redundant
set of merge-bases is not necessary, I think.  I suspect that you do
not need the STALE half-optimization in the first place.

The only time you can say "Ah, we've seen this one and no need to
dig further" is when you are propagating a colour C and the parent
in question is already painted in C (it is OK to be painted as
reachable from more tips), I would think, so shouldn't the loop be
more like, after painting each tip and placing it in the queue:

 * Dequeue one, check the L/R bits in it and call that C

 * Iterate over its parents P:

   * check the L/R bits in P and call that Cp.

   * If Cp is already a superset of C, there is no point putting P
     to the queue to be processed.

   * If Cp is not a superset of C, then update L/R bits in P to mark
     it reachable from tips represented by C and put P to the queue.

until you ran out of queue?




> +void commit_contains(const struct commit_list *left,
> +		     const struct commit_list *right,
> +		     unsigned char *left_contains,
> +		     unsigned char *right_contains)
> +{
> +	struct prio_queue queue = { compare_commits_by_commit_date };
> +	struct bit_slab left_bits, right_bits, stale_bits;
> +	int left_nr, right_nr;
> +
> +	left_nr = init_contains_bits(left, &left_bits, &queue);
> +	right_nr = init_contains_bits(right, &right_bits, &queue);
> +	init_bit_slab(&stale_bits);
> +
> +	while (queue_has_nonstale_bits(&queue, &stale_bits)) {
> +		struct commit *commit = prio_queue_get(&queue);
> +		struct commit_list *parents;
> +		unsigned char *c_left, *c_right, *c_stale;
> +
> +		c_left = bit_slab_at(&left_bits, commit);
> +		c_right = bit_slab_at(&right_bits, commit);
> +		c_stale = bit_slab_at(&stale_bits, commit);
> +
> +		if (!bitset_empty(c_left, left_nr) &&
> +		    !bitset_empty(c_right, right_nr))
> +			*c_stale = 1;

Hmph, is this one-char-a bit?
