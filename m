From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pickaxe: use textconv for -S counting
Date: Tue, 13 Nov 2012 15:13:19 -0800
Message-ID: <7vk3tpcd0w.fsf@alter.siamese.dyndns.org>
References: <20121028124540.GF11434@sigill.intra.peff.net>
 <20121028124701.GB24548@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:13:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYPfm-0000wO-1c
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 00:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454Ab2KMXNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 18:13:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753945Ab2KMXNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 18:13:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38C5BA7DE;
	Tue, 13 Nov 2012 18:13:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vy+eyhP5r4M1VwmR/BftRxBSDZ8=; b=cief59
	7oYVUihc4cczKNPfVZzcu/gr/ePhz6M/BtYCRlO9wYF4XrgU4eNRRr/fE/YsyrL1
	8iX3kGIKT3HA4SJCl+4VOffKaIvvuOgEJwiFfHTfvUl6niaxhx6kJAK+o7r9xZlw
	7S/xCvo7667HZ8dsPXnLVczKnLJsPht+hY7r0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bPFeDJP3taFNHdiM2G/QFdhWijGuvWTG
	IxQDDA9zDsVvxkRvOMnkp/TudE04wt+cYI4botHi8glFsXzUspPExfYh95KbwUFV
	nGj96qn9mQKk42WjQJ12R4Pdzr/jHdKtrkeq2ctt1vcr4k+mhRfnjSqN/SJPv6xa
	a4pLE9P1vgE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2644FA7DD;
	Tue, 13 Nov 2012 18:13:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78F06A7DC; Tue, 13 Nov 2012
 18:13:21 -0500 (EST)
In-Reply-To: <20121028124701.GB24548@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 28 Oct 2012 08:47:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B79209F4-2DE7-11E2-87AC-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209683>

Jeff King <peff@peff.net> writes:

> We currently just look at raw blob data when using "-S" to
> pickaxe. This is mostly historical, as pickaxe predates the
> textconv feature. If the user has bothered to define a
> textconv filter, it is more likely that their search string will be
> on the textconv output, as that is what they will see in the
> diff (and we do not even provide a mechanism for them to
> search for binary needles that contain NUL characters).

Oookay, I suppose...

>  static int has_changes(struct diff_filepair *p, struct diff_options *o,
>  		       regex_t *regexp, kwset_t kws)
>  {
> +	struct userdiff_driver *textconv_one = get_textconv(p->one);
> +	struct userdiff_driver *textconv_two = get_textconv(p->two);
> +	mmfile_t mf1, mf2;
> +	int ret;
> +
>  	if (!o->pickaxe[0])
>  		return 0;
>  
> -	if (!DIFF_FILE_VALID(p->one)) {
> -		if (!DIFF_FILE_VALID(p->two))
> -			return 0; /* ignore unmerged */

What happened to this part that avoids showing nonsense for unmerged
paths?

> +	/*
> +	 * If we have an unmodified pair, we know that the count will be the
> +	 * same and don't even have to load the blobs. Unless textconv is in
> +	 * play, _and_ we are using two different textconv filters (e.g.,
> +	 * because a pair is an exact rename with different textconv attributes
> +	 * for each side, which might generate different content).
> +	 */
> +	if (textconv_one == textconv_two && diff_unmodified_pair(p))
> +		return 0;

I am not sure about this part that cares about the textconv.

Wouldn't the normal "git diff A B" skip the filepair that are
unmodified in the first place at the object name level without even
looking at the contents (see e.g. diff_flush_patch())?

Shouldn't this part of the code emulating that behaviour no matter
what textconv filter(s) are configured for these paths?
