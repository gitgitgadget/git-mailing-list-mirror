From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] peel_ref: check object type before loading
Date: Thu, 04 Oct 2012 12:06:16 -0700
Message-ID: <7vbogiys47.fsf@alter.siamese.dyndns.org>
References: <20121004075609.GA1355@sigill.intra.peff.net>
 <20121004080253.GC31325@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:13:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtgA-00033L-5L
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201Ab2JDTGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 15:06:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab2JDTGU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 15:06:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 462F29860;
	Thu,  4 Oct 2012 15:06:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XH1saiojWSmM9eSMQtZYauh+UzI=; b=GErC1D
	x2Ix0lcc2srbHNkM6yVIZzZjvxU/hKFbDsI9HWmjKDxyCyTRTJcfKlgPKw3X8whr
	6WO+0yGXk3Dka6H69ycjXoKW9Tjr4uNbielUaL/8L2Sg9enL5mA8Wsf+VpnwVncr
	6rzW8iQip5PYCcq0Mw+cnBTXsdpiruQOSTeXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O03iWrey3/LXykoO/4ha2v4fWonfGZwg
	3RrHueFUAwBoAwzM1pVsLQAdSxMjBzdM4e6XKHMLRTBj5rsfmPlVzODUJZgG6ain
	TGeJIqm1UyuTiKxJCb8KY2MTCzc2sFVp0bm1wzD5SETGZu+qT2TQ+Bxl9tPxdaKm
	ALsOetOJJYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 333D4985E;
	Thu,  4 Oct 2012 15:06:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DFEA985A; Thu,  4 Oct 2012
 15:06:18 -0400 (EDT)
In-Reply-To: <20121004080253.GC31325@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Oct 2012 04:02:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93D2EC3C-0E56-11E2-8518-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207050>

Jeff King <peff@peff.net> writes:

> The point of peel_ref is to dereference tags; if the base
> object is not a tag, then we can return early without even
> loading the object into memory.
>
> This patch accomplishes that by checking sha1_object_info
> for the type. For a packed object, we can get away with just
> looking in the pack index. For a loose object, we only need
> to inflate the first couple of header bytes.

We look at the pack index and have to follow its delta chain down to
the base to find its type; if the object is deeply deltified, this
certainly is an overall loss.

The only case sha1_object_info() could work well for an object near
the tip of a deep delta chain is to find its size, as the diff-delta
encodes the size of the base and the size of the result of applying
the delta to the base, so you do not have to follow the chain when
you are only interested in the final size.

But alas nobody calls sha1_object_info() for only size but not type
(there are some callers that are interested in only type but not
size).

> This is a bit of a gamble; if we do find a tag object, then
> we will end up loading the content anyway, and the extra
> lookup will have been wasteful. However, if it is not a tag
> object, then we save loading the object entirely. Depending
> on the ratio of non-tags to tags in the input, this can be a
> minor win or minor loss.
>
> However, it does give us one potential major win: if a ref
> points to a large blob (e.g., via an unannotated tag), then
> we can avoid looking at it entirely.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This optimization is the one that gave me the most pause. While
> upload-pack does call peel_ref on everything, the other callers all
> constrain themselves to refs/tags/. So for many projects, we will be
> calling it mostly on annotated tags, and it may be a very small net
> loss. But in practice, it will not matter for most projects with a sane
> number of normal tags, and saving even one accidental giant blob load
> can have a huge impact.

I may be missing something, but the above description is not
convincing to me.  When was the last time you pointed a blob
directly with a ref, whether large or small, and whether within
refs/tags or outside?

>
>  refs.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index f672ad9..02e47b1 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1225,8 +1225,15 @@ fallback:
>  	}
>  
>  fallback:
> -	o = parse_object(base);
> -	if (o && o->type == OBJ_TAG) {
> +	o = lookup_unknown_object(base);
> +	if (o->type == OBJ_NONE) {
> +		int type = sha1_object_info(base, NULL);
> +		if (type < 0)
> +			return -1;
> +		o->type = type;
> +	}
> +
> +	if (o->type == OBJ_TAG) {
>  		o = deref_tag_noverify(o);
>  		if (o) {
>  			hashcpy(sha1, o->sha1);
