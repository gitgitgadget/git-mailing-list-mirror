From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 14:25:42 -0700
Message-ID: <xmqqbn338nu1.fsf@gitster.mtv.corp.google.com>
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<20160614210038.31465-1-lfleischer@lfos.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Tue Jun 14 23:26:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCvqH-00038s-3N
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbcFNVZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 17:25:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751213AbcFNVZq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 17:25:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA7D225BD9;
	Tue, 14 Jun 2016 17:25:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HFzsuNUzaLU/3mPHiZ7+K9K/0mw=; b=WRzmQg
	D0RLaVa58JTGWdPbxExgaBWwTWJqSBxbgUtikTkCpPZDx5ZIeaPCouFA5plTz/Qd
	zxV9KaUvazyVwVbyqBAmAOKz5oLIEVW6ha4i9i7QIqghJGL7qtYT5letzdta0oWD
	tcZ8iKDdBONlFOQuSxtIcvCL4phmQu/WxjLvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X07M/Ia+3eE8sEpAGlymLRwLRN31/38J
	dfOpMXHnZSO6wsP175NkbVu+6GNR/Yhn8HLiEMgbMvAsMluPTjoDI50keo9PtU8n
	0hnMMqoViCVa0W2v9sf3zOEKMB2U2Of6MDmfdHk9lQ7B7vsk58Jp6Bgiitc6tfSs
	YidTYoca9Ig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A309C25BD8;
	Tue, 14 Jun 2016 17:25:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29F0025BD7;
	Tue, 14 Jun 2016 17:25:44 -0400 (EDT)
In-Reply-To: <20160614210038.31465-1-lfleischer@lfos.de> (Lukas Fleischer's
	message of "Tue, 14 Jun 2016 23:00:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8D6FF6EE-3276-11E6-A75A-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297332>

Lukas Fleischer <lfleischer@lfos.de> writes:

Lukas Fleischer <lfleischer@lfos.de> writes:

> Improve the readability of recv_sideband() significantly by replacing

s/significantly //; "making it readable" is already a subjective
goodness criterion, and you do not have to make it sound even more
subjective.  Let the updated result convince the reader that it is
vastly more readable.

> Also, reorganize the overall control flow, remove some superfluous
> variables and replace a custom implementation of strpbrk() with a call
> to the standard C library function.

I find that calling the loop "a custom implementation" is a bit
unfair.  The original tried to avoid looking beyond "len", but in
the updated code because you have buf[len] = '\0' to terminate the
line, and because you pass LARGE_PACKET_MAX to packet_read() while
your buf[] allocates one more byte, you can use strpbrk() here
safely. Which would mean "a custom implementation" was done for a
reason.

But that is a minor point.

I'll omit the preimage lines from the following.

>  int recv_sideband(const char *me, int in_stream, int out)
>  {
> +	const char *term, *suffix;
> +	char buf[LARGE_PACKET_MAX + 1];
> +	struct strbuf outbuf = STRBUF_INIT;
> +	const char *b, *brk;
>  
> +	strbuf_addf(&outbuf, "%s", PREFIX);

I highly suspect that you are better off without this line being
here.

> ...
>  	while (1) {
>  		int band, len;
> +		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
>  		if (len == 0)
>  			break;
>  		if (len < 1) {
>  			fprintf(stderr, "%s: protocol error: no band designator\n", me);
>  			return SIDEBAND_PROTOCOL_ERROR;
>  		}
> +		band = buf[0] & 0xff;
> +		buf[len] = '\0';
>  		len--;
>  		switch (band) {
>  		case 3:
> +			fprintf(stderr, "%s%s\n", PREFIX, buf + 1);
>  			return SIDEBAND_REMOTE_ERROR;

Two "return"s we see above will leak outbuf.buf that holds PREFIX.

>  		case 2:
> +			b = buf + 1;
>  
> +			/*
> +			 * Append a suffix to each nonempty line to clear the
> +			 * end of the screen line.
> +			 */
> +			while ((brk = strpbrk(b, "\n\r"))) {
> +				int linelen = brk - b;
>  
> +				if (linelen > 0) {
> +					strbuf_addf(&outbuf, "%.*s%s%c",
> +						    linelen, b, suffix, *brk);
>  				} else {
> +					strbuf_addf(&outbuf, "%c", *brk);
>  				}
> +				xwrite(STDERR_FILENO, outbuf.buf, outbuf.len);
> +				strbuf_reset(&outbuf);
> +				strbuf_addf(&outbuf, "%s", PREFIX);

Instead of doing "we assume outbuf already has PREFIX when we add
contents from buf[]", the code structure would be better if you:

 * make outbuf.buf contain PREFIX at the beginning of this innermost
   loop; lose the reset/addf from here.

 * move strbuf_reset(&outbuf) at the end of the next if (*b) block
   to just before "continue;"

perhaps?

> +				b = brk + 1;
> +			}
>  
> +			if (*b) {
> +				xwrite(STDERR_FILENO, outbuf.buf, outbuf.len);
> +				/* Incomplete line, skip the next prefix. */
> +				strbuf_reset(&outbuf);
> +			}
>  			continue;
>  		case 1:
> +			write_or_die(out, buf + 1, len);
>  			continue;
>  		default:
>  			fprintf(stderr, "%s: protocol error: bad band #%d\n",
