From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Mon, 17 Jun 2013 09:18:54 -0700
Message-ID: <7vzjuog175.fsf@alter.siamese.dyndns.org>
References: <7vhah35jn8.fsf@alter.siamese.dyndns.org>
	<1371301305-30160-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 18:19:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoc92-0002wP-Kz
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 18:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576Ab3FQQTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 12:19:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328Ab3FQQS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 12:18:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9445728B1E;
	Mon, 17 Jun 2013 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QRPqwC/9SE5rX+MemCpX0FQmagk=; b=JHt8sL
	GJ5V0VRi8eI9fKrk+PGPaTgdvXK543wK1NRWv3y7M7S6/7PnVc1opJaoIpW5XeJ4
	6AzJtsh/1GWj5rcAOrh/y+v9s/a9RVru0NTWk16vYZaPELh22UgnngFh3GfnHk8+
	05yksBlflFHkLR0ioNp+z1DpxBSys+Deb5+wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ix+ZVfyNnG+PZerEXhlZAbxdWR+mLr+0
	mx5FVv6R6IMWAU3jm4xVeqQpdC3HMvYTzZIw9SjqfI/ZbcfevWTudGAlCORIdi9X
	sm8OFoLlKvD7TjKLxBkq8v4VAdq4RwL0icNrManUOeTpUgXaxCV7uH+uHNNb64C2
	BdM0wy6OOIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8918528B1B;
	Mon, 17 Jun 2013 16:18:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA2DF28B13;
	Mon, 17 Jun 2013 16:18:55 +0000 (UTC)
In-Reply-To: <1371301305-30160-1-git-send-email-apelisse@gmail.com> (Antoine
	Pelisse's message of "Sat, 15 Jun 2013 15:01:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BB4C3DA-D769-11E2-A754-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228079>

Antoine Pelisse <apelisse@gmail.com> writes:

> So here is a more thorough description of the option:

> - real changes are interesting

OK, I think I can understand it.

> - blank lines that are close enough (less than context size) to
>   interesting changes are considered interesting (recursive definition)

OK.

> - "context" lines are used around each hunk of interesting changes

OK.

> - If two hunks are separated by less than "inter-hunk-context", they
>   will be merged into one.

Makes sense.

> The current implementation does the "interesting changes selection" in a
> single pass.

"current" meaning "the code after this patch is applied"?  Is there
a possible future enhancement hinted here?

> +xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg)
> +{
> +	xdchange_t *xch, *xchp, *lxch;
>  	long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
> +	long max_ignorable = xecfg->ctxlen;
> +	unsigned long changes = ULONG_MAX;
> +
> +	/* remove ignorable changes that are too far before other changes */
> +	for (xchp = *xscr; xchp && xchp->ignore; xchp = xchp->next) {
> +		xch = xchp->next;
> +
> +		if (xch == NULL ||
> +		    xch->i1 - (xchp->i1 + xchp->chg1) >= max_ignorable)
> +			*xscr = xch;
> +	}

This strips leading ignorable ones away until we see an unignorable
one.  Looks sane.

> +	if (*xscr == NULL)
> +		return NULL;
> +
> +	lxch = *xscr;

"lxch" remembers the last one that is "interesting".

> +	for (xchp = *xscr, xch = xchp->next; xch; xchp = xch, xch = xch->next) {
> +		long distance = xch->i1 - (xchp->i1 + xchp->chg1);
> +		if (distance > max_common)
>  			break;

If we see large-enough gap, the one we processed last (in xchp) is
the end of the current hunk.  Looks sane.

> +		if (distance < max_ignorable &&
> +		    (!xch->ignore || changes == ULONG_MAX)) {
> +			lxch = xch;
> +			changes = ULONG_MAX;

The current one is made into the "last interesting one we have seen"
and the hunk continues, if either (1) the current one is interesting
by itself, or (2) the last one we saw does not match some
unexplainable criteria to cause changes set to not ULONG_MAX.

Puzzling.

> +		} else if (changes != ULONG_MAX &&
> +			   xch->i1 + changes - (lxch->i1 + lxch->chg1) > max_common) {
> +			break;

If the last one we saw does not match some unexplainable criteria to
cause changes set to not ULONG_MAX, and the distance between this
one and the last "intersting" one is further than the context, this
one will not be a part of the current hunk.

Puzzling.

Could you add comment to the "changes" variable and explain what the
variable means?

> +		} else if (!xch->ignore) {
> +			lxch = xch;
> +			changes = ULONG_MAX;

When this change by itself is interesting, it becomes the "last
interesting one" and the hunk continues.

> +		} else {
> +			if (changes == ULONG_MAX)
> +				changes = 0;
> +			changes += xch->chg2;

Puzzled beyond guessing.  Also it is curious why here and only here
we look at chg2 side of the things, not i1/chg1 in this whole thing.
