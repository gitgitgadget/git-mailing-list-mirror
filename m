From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: teach "git -c" to recognize an empty string
Date: Mon, 04 Aug 2014 15:25:23 -0700
Message-ID: <xmqq61i7riy4.fsf@gitster.dls.corp.google.com>
References: <1407163275-3006-1-git-send-email-tanayabh@gmail.com>
	<vpqmwbki7h3.fsf@anie.imag.fr> <20140804203351.GA12898@peff.net>
	<vpqtx5s7yo4.fsf@anie.imag.fr> <20140804215644.GA21510@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 05 00:25:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEQhE-0001tz-D6
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 00:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbaHDWZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 18:25:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56515 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbaHDWZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 18:25:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 99A832F111;
	Mon,  4 Aug 2014 18:25:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DtFXtZUo3IUqpXvwg/xSAQGo7iE=; b=L/Nekb
	AVabREFFzwMC5LSE2Wp5YcyaCBtzRiHDVeTEr4xCohxaHVoBudlIICuLE40bd7v6
	Zp/sQoUUd3N0IGa1ZQUXkc25C9yWGFjED249IEgePT0LbrmaB02ckgIRDOTGdPIz
	zHp7JbQNEaY+b6MGyXd+KCft962wFqlMfaj8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B1p9ysJ8V6e6frZXOd4b48QPXPtOyVKp
	T9E4PT1YK7QU94Xa8u8ia01i0b7agv4pzCVuOAbK8hSfthDPJmu/OXVZANURFZhK
	CRfFjsoMkyxLedUY6VVoZhrE8Tetlc2zcfm/cbifvb2q+xSIQ716Oca4vejXbteL
	0CWyVr7Z36Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8F72D2F10F;
	Mon,  4 Aug 2014 18:25:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D32AE2F104;
	Mon,  4 Aug 2014 18:25:24 -0400 (EDT)
In-Reply-To: <20140804215644.GA21510@peff.net> (Jeff King's message of "Mon, 4
	Aug 2014 17:56:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3ACC3C9E-1C26-11E4-9D8A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254790>

Jeff King <peff@peff.net> writes:

> This is technically a backwards incompatibility, but I'd consider it a
> simple bugfix. The existing behavior was unintentional, made no sense,
> and was never documented.

Yeah, I tend to agree.  I actually would not shed any tears if the
breakage were that it was impossible to pass "NULL is true" boolean
via "git -c" interface, but it is the other way around.  It is much
more grave a problem that we cannot pass an empty string as a value,
and we should fix it.

> Looking over strbuf_split's interface, I think it's rather
> counter-intuitive, and I was tempted to change it. But there are several
> other callers that rely on it, and the chance for introducing a subtle
> bug is high. This is the least invasive fix (and it really is not any
> less readable than what was already there :) ).

;-)

> +# We just need a type-specifier here that cares about the
> +# distinction internally between a NULL boolean and a real
> +# string (because most of git's internal parsers do care).
> +# Using "--path" works, but we do not otherwise care about
> +# its semantics.
> +test_expect_success 'git -c can represent empty string' '
> +	echo >expect &&
> +	git -c foo.empty= config --path foo.empty >actual &&
> +	test_cmp expect actual
> +'

Another way may be "git config -l" and see if we see a = on the
entry for foo.empty, but I think the way you did this is nicer.

>  test_expect_success 'key sanity-checking' '
>  	test_must_fail git config foo=bar &&
>  	test_must_fail git config foo=.bar &&
