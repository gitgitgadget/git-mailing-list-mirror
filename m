From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/11] sequencer.c: teach append_signoff how to detect
 duplicate s-o-b
Date: Wed, 28 Nov 2012 16:35:39 -0800
Message-ID: <7vzk21s0tg.fsf@alter.siamese.dyndns.org>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
 <1353894359-6733-7-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 01:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tds6k-0001DG-HZ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 01:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800Ab2K2Afo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 19:35:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932614Ab2K2Afn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 19:35:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D248A502;
	Wed, 28 Nov 2012 19:35:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CipZ6agkZTbKD8Qq2aDUui3xQkM=; b=uUFOZX
	v19uyZN38ftnz/cA7EwRitl/gIOFUXrWD7ueLdMOi0KxP2jsiTsSsehEvXU9pPnI
	oHbCRAMtVgVu4T9H2tWWrYrYUQlufwKRPb3OC2ewW9wqW6iK5g7v0F2dXKapFLNK
	9FvRSeLndm0oC9/fmXNoyclFC8O55FPTkdXVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T1zcZhBFTu0rYdE4yP1sSZAuMqTMQRyg
	wRX87IQi+a1Ow8IruoiBPgvJpBrv8E79dZ9N1u5xc0ZUY93v0muOM96MnEiK1CHV
	HhB4g0Xt8gQoitGNSritI7/i2wp+kx1E1doSJqhHMMt+v+MzZgLtMAaNtfDujQFE
	fhHb23ySz/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59B01A501;
	Wed, 28 Nov 2012 19:35:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79F0CA500; Wed, 28 Nov 2012
 19:35:41 -0500 (EST)
In-Reply-To: <1353894359-6733-7-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Sun, 25 Nov 2012 17:45:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B43D309A-39BC-11E2-92E5-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210803>

Brandon Casey <drafnel@gmail.com> writes:

> +/* Returns 0 for non-conforming footer

Please format it like this:

/*
 * Returns 0 for ...

> + * Returns 1 for conforming footer
> + * Returns 2 when sob exists within conforming footer
> + * Returns 3 when sob exists within conforming footer as last entry
> + */
> +static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
> +	int ignore_footer)
>  {
>  	int hit = 0;
> -	int i, k;
> +	int i, k = 0;

This is not wrong per-se, but I do not think it is necessary ('k' is
always initialized at least to 'i' before it gets used).  If we need
to do this, I'd prefer to see it done in 1/11 that cleaned up the
containing function as a preparation for this series.

>  	int len = sb->len - ignore_footer;
>  	const char *buf = sb->buf;
> +	int found_sob = 0;
>  
>  	for (i = len - 1; i > 0; i--) {
>  		if (hit && buf[i] == '\n')
> @@ -63,14 +70,24 @@ static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
>  		i++;
>  
>  	for (; i < len; i = k) {
> +		int found_rfc2822;
> +
>  		for (k = i; k < len && buf[k] != '\n'; k++)
>  			; /* do nothing */
>  		k++;
>  
> -		if (!(is_rfc2822_line(buf+i, k-i) ||
> -			is_cherry_pick_from_line(buf+i, k-i)))
> +		found_rfc2822 = is_rfc2822_line(buf+i, k-i);

Not limited to this place but please have SP around binary operators, i.e.

		found_rfc2822 = is_rfc2822_line(buf + i, k - i);

> +		if (found_rfc2822 && sob &&
> +			!strncasecmp(buf+i, sob->buf, sob->len))
> +			found_sob = k;

Are we sure we want strncasecmp() here?  I *think* you are trying to
catch "signed-off-By:" and other misspellings, and even though I
know in practice we know "Brandon Casey" and "brandon casey" are the
same person, it still feels somewhat sloppy.  Perhaps it is just me.

> +
> +		if (!(found_rfc2822 || is_cherry_pick_from_line(buf+i, k-i)))
>  			return 0;
>  	}
> +	if (found_sob == i)
> +		return 3;
> +	if (found_sob)
> +		return 2;
>  	return 1;
>  }
>  
> @@ -291,7 +308,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  	rollback_lock_file(&index_lock);
>  
>  	if (opts->signoff)
> -		append_signoff(msgbuf, 0);
> +		append_signoff(msgbuf, 0, 0);
>  
>  	if (!clean) {
>  		int i;
> @@ -547,7 +564,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		}
>  
>  		if (opts->record_origin) {
> -			if (!has_conforming_footer(&msgbuf, 0))
> +			if (!has_conforming_footer(&msgbuf, NULL, 0))
>  				strbuf_addch(&msgbuf, '\n');
>  			strbuf_addstr(&msgbuf, cherry_picked_prefix);
>  			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
> @@ -1074,9 +1091,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  	return pick_commits(todo_list, opts);
>  }
>  
> -void append_signoff(struct strbuf *msgbuf, int ignore_footer)
> +void append_signoff(struct strbuf *msgbuf, int ignore_footer, int no_dup_sob)
>  {
>  	struct strbuf sob = STRBUF_INIT;
> +	int has_footer = 0;
>  	int i;
>  
>  	strbuf_addstr(&sob, sign_off_header);
> @@ -1085,10 +1103,11 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer)
>  	strbuf_addch(&sob, '\n');
>  	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
>  		; /* do nothing */
> -	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
> -		if (!i || !has_conforming_footer(msgbuf, ignore_footer))
> -			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
> -		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.len);
> -	}
> +	if (!i || !(has_footer =
> +		has_conforming_footer(msgbuf, &sob, ignore_footer)))
> +		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
> +	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
> +		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
> +				sob.buf, sob.len);

Avoid assignment inside if () conditional.  It is not immediately
obvious what value is compared against 3 in the second one, as the
above makes it appear as if has_footer is uninitialized when i is
zero.

Thanks.
