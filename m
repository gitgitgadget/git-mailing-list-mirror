From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] oneway_merge(): only lstat() when told to update
 worktree
Date: Thu, 20 Dec 2012 12:02:53 -0800
Message-ID: <7vk3sc4hle.fsf@alter.siamese.dyndns.org>
References: <1356025067-5396-1-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 21:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlmKo-00019M-MK
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 21:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab2LTUC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 15:02:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab2LTUC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 15:02:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F164A761;
	Thu, 20 Dec 2012 15:02:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w6SZeGXDrK3Wj6MGAhcnV4mXag4=; b=qa+ZUp
	rUtNSUX1+1tp9URA0q6NugysIfuyJPwp8uazYQgHAXonDabfXAMZl4ka8zVjIIIn
	ZFJK6sLA/FE/2odacY0qzG2S3IFYfAytTPhWLX37hc3nvjr0/fri49DOZdW5nfrL
	Uzl8nuR4OGjhBI+ozilWe2O2MBNdQYZnSs+EA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OfW1ap5dJA76QHCYqEloqBvMPHXICkzQ
	Pb25yCcwRBb1+N7rqGL+9Ah4A4ONnycLnMU8mbJwjNejXecfATQclXVc+8wQP3Vd
	4QtNMOuAn9UIhTpuCZQC0zydOyz8mRkFOwxO5CtV61kKHlbN9GH9rAWyQVcQ+jan
	emAycE7mF8g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF69EA760;
	Thu, 20 Dec 2012 15:02:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FC79A758; Thu, 20 Dec 2012
 15:02:55 -0500 (EST)
In-Reply-To: <1356025067-5396-1-git-send-email-martinvonz@gmail.com> (Martin
 von Zweigbergk's message of "Thu, 20 Dec 2012 09:37:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E53C652-4AE0-11E2-B060-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211924>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> Although the subject line of 613f027 (read-tree -u one-way merge fix
> to check out locally modified paths., 2006-05-15) mentions "read-tree
> -u", it did not seem to check whether -u was in effect. Not checking
> whether -u is in effect makes e.g. "read-tree --reset" lstat() the
> worktree, even though the worktree stat should not matter for that
> operation.
>
> This speeds up e.g. "git reset" a little on the linux-2.6 repo (best
> of five, warm cache):
>
>         Before      After
> real    0m0.288s    0m0.233s
> user    0m0.190s    0m0.150s
> sys     0m0.090s    0m0.080s
> ---

Sign-off?

I briefly discussed this with Martin in person and came to the same
conclusion. To me this looks like an obvious performance fix, but an
independent code audit catches our mistakes is of course welcomed.

Thanks.

> I am very unfamiliar with this part of git, so my attempt at a
> motivation may be totally off.
>
> I have another twenty-or-so patches to reset.c coming up that take the
> timings down to around 90 ms, but this patch was quite unrelated to
> that. Those other patches actually make this patch pointless for "git
> reset" (it takes another path), but I hope this is still a good change
> for other operations that use oneway_merge.
>
>  unpack-trees.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 6d96366..61acc5e 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1834,7 +1834,7 @@ int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o)
>  
>  	if (old && same(old, a)) {
>  		int update = 0;
> -		if (o->reset && !ce_uptodate(old) && !ce_skip_worktree(old)) {
> +		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
>  			struct stat st;
>  			if (lstat(old->name, &st) ||
>  			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
