From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] list-objects: only look at cmdline trees with edge_hint
Date: Tue, 21 Jan 2014 14:49:06 -0800
Message-ID: <xmqq8uu9t0gt.fsf@gitster.dls.corp.google.com>
References: <20140121022431.GA4614@sigill.intra.peff.net>
	<20140121022540.GB4672@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 21 23:49:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5k8F-0008TW-VM
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 23:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbaAUWtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 17:49:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbaAUWtP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 17:49:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2E5565591;
	Tue, 21 Jan 2014 17:49:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JYIJJhf3ci9PBp5oorybSSxQnYI=; b=U4nbRn
	le+rsOWGaIZBRxTlvKvpx2CoQT1mhj81zC0b37AJbgJ4YC6CzbNRDs0ytssn22oW
	9UT4LNKsvVkeOY+zzvXnUWdCWIfstiGhFB1Itq2EhuZ+OE0iufDggpAa60IlmqRP
	mZ1Zp3oVN1Jqni6jU+EpBbogdT4xdhizBeySI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rZkeiIuNSY/gG5gnb5gKV0km3gB0Oixj
	SGG7tKNGfv8kb48qQSezbnTYqKV/cEJnOzkTg34tzC7Y2BRekcqGuxuKDi8Bew9P
	36JQuQCbEVB8qOXZIHBAVKAo9bSEm5xCYIKp4vhfN79ARQnlvV+gTuFusnZJ4Po3
	J7hy6RGBsCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA5B965590;
	Tue, 21 Jan 2014 17:49:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE9556558E;
	Tue, 21 Jan 2014 17:49:11 -0500 (EST)
In-Reply-To: <20140121022540.GB4672@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 20 Jan 2014 21:25:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3EC11486-82EE-11E3-BFF8-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240784>

Jeff King <peff@peff.net> writes:

> This tradeoff probably makes sense in the context of
> pack-objects, where we have set revs->edge_hint to have the
> traversal feed us the set of boundary objects.  For a
> regular rev-list, though, it is probably not a good
> tradeoff. It is true that it makes our list slightly closer
> to a true set difference, but it is a rare case where this
> is important. And because we do not have revs->edge_hint
> set, we do nothing useful with the larger set of boundary
> objects.
>
> This patch therefore ties the extra tree examination to the
> revs->edge_hint flag; it is the presence of that flag that
> makes the tradeoff worthwhile.

Makes sense.  Thanks.  Will queue.

>
> Here is output from the p0001-rev-list showing the
> improvement in performance:
>
> Test                                             HEAD^             HEAD
> -----------------------------------------------------------------------------------------
> 0001.1: rev-list --all                           0.69(0.65+0.02)   0.69(0.66+0.02) +0.0%
> 0001.2: rev-list --all --objects                 3.22(3.19+0.03)   3.23(3.20+0.03) +0.3%
> 0001.4: rev-list $commit --not --all             0.04(0.04+0.00)   0.04(0.04+0.00) +0.0%
> 0001.5: rev-list --objects $commit --not --all   0.27(0.26+0.01)   0.04(0.04+0.00) -85.2%
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  list-objects.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/list-objects.c b/list-objects.c
> index 6cbedf0..206816f 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -162,15 +162,17 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
>  		}
>  		mark_edge_parents_uninteresting(commit, revs, show_edge);
>  	}
> -	for (i = 0; i < revs->cmdline.nr; i++) {
> -		struct object *obj = revs->cmdline.rev[i].item;
> -		struct commit *commit = (struct commit *)obj;
> -		if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
> -			continue;
> -		mark_tree_uninteresting(commit->tree);
> -		if (revs->edge_hint && !(obj->flags & SHOWN)) {
> -			obj->flags |= SHOWN;
> -			show_edge(commit);
> +	if (revs->edge_hint) {
> +		for (i = 0; i < revs->cmdline.nr; i++) {
> +			struct object *obj = revs->cmdline.rev[i].item;
> +			struct commit *commit = (struct commit *)obj;
> +			if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
> +				continue;
> +			mark_tree_uninteresting(commit->tree);
> +			if (!(obj->flags & SHOWN)) {
> +				obj->flags |= SHOWN;
> +				show_edge(commit);
> +			}
>  		}
>  	}
>  }
