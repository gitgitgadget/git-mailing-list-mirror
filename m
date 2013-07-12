From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0008: avoid SIGPIPE race condition on fifo
Date: Fri, 12 Jul 2013 09:23:54 -0700
Message-ID: <7vbo67oig5.fsf@alter.siamese.dyndns.org>
References: <6050FACA-CAD4-4E41-B7DC-D7A2036AA233@gernhardtsoftware.com>
	<20130711133414.GF6015@sigill.intra.peff.net>
	<7vli5drsbw.fsf@alter.siamese.dyndns.org>
	<20130712103522.GA4750@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 12 18:24:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxg8X-0007ok-K3
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 18:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933294Ab3GLQX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 12:23:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39230 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932612Ab3GLQX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 12:23:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C9EC30A32;
	Fri, 12 Jul 2013 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dovfy45veV/sGYwUEemyt/igL/8=; b=nqKZFR
	rCXKbHhWAgVxE357EDjj1dWff5g4y9MmDv4fKspNoXNHyv7ilwTR7pvTAbrFsh22
	XgGx5l1ZMcuDBWUsKy9Izw0HZ5woy36hRu3esf9tvbYA4Nv/Woze2oUS2Djtde6A
	jee20FgPHiHWAJwPguRl98luc0N48RKDsfa2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gBMpWaYztD9ovq/8ekPeo6a9HM5Mkm94
	NYP6kPHSpWAiiJirywl9N6b4j9f/5L889AkWNVDmGSSrtR87ApXv3F6pqIzISY9f
	ANzlDmCHoDYiR1Bn/Jmh8b/VWeuB/xNEiCpx3q/iL3tPSS/6zllgpl8IfyS6g2/4
	hPWmDj0DS4c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63E7E30A31;
	Fri, 12 Jul 2013 16:23:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DBCE30A2E;
	Fri, 12 Jul 2013 16:23:55 +0000 (UTC)
In-Reply-To: <20130712103522.GA4750@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 12 Jul 2013 06:35:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72B2FF7E-EB0F-11E2-AE7D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230203>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] t0008: avoid SIGPIPE race condition on fifo
>
> To test check-ignore's --stdin feature, we use two fifos to
> send and receive data. We carefully keep a descriptor to its
> input open so that it does not receive EOF between input
> lines. However, we do not do the same for its output. That
> means there is a potential race condition in which
> check-ignore has opened the output pipe once (when we read
> the first line), and then writes the second line before we
> have re-opened the pipe.
>
> In that case, check-ignore gets a SIGPIPE and dies. The
> outer shell then tries to open the output fifo but blocks
> indefinitely, because there is no writer.  We can fix it by
> keeping a descriptor open through the whole procedure.

Ahh, figures.

I wish I were smart enough to figure that out immediately after
seeing the test that does funny things to "in" with "9".

Thanks.

> This should also help if check-ignore dies for any other
> reason (we would already have opened the fifo and would
> therefore not block, but just get EOF on read).
>
> However, we are technically still susceptible to
> check-ignore dying early, before we have opened the fifo.
> This is an unlikely race and shouldn't generally happen in
> practice, though, so we can hopefully ignore it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t0008-ignores.sh | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index a56db80..c29342d 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -697,13 +697,21 @@ test_expect_success PIPE 'streaming support for --stdin' '
>  	# shell, and then echo to the fd. We make sure to close it at
>  	# the end, so that the subprocess does get EOF and dies
>  	# properly.
> +	#
> +	# Similarly, we must keep "out" open so that check-ignore does
> +	# not ever get SIGPIPE trying to write to us. Not only would that
> +	# produce incorrect results, but then there would be no writer on the
> +	# other end of the pipe, and we would potentially block forever trying
> +	# to open it.
>  	exec 9>in &&
> +	exec 8<out &&
>  	test_when_finished "exec 9>&-" &&
> +	test_when_finished "exec 8<&-" &&
>  	echo >&9 one &&
> -	read response <out &&
> +	read response <&8 &&
>  	echo "$response" | grep "^\.gitignore:1:one	one" &&
>  	echo >&9 two &&
> -	read response <out &&
> +	read response <&8 &&
>  	echo "$response" | grep "^::	two"
>  '
