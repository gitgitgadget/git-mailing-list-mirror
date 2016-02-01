From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] checkout-index: disallow "--no-stage" option
Date: Sun, 31 Jan 2016 18:18:39 -0800
Message-ID: <xmqqvb69w4u8.fsf@gitster.mtv.corp.google.com>
References: <20160131112215.GA4589@sigill.intra.peff.net>
	<20160131113029.GE5116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 03:18:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ44k-00046N-6j
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 03:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933634AbcBACSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 21:18:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933557AbcBACSl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 21:18:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC54C4195B;
	Sun, 31 Jan 2016 21:18:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/OWkQguC4LR5uhjbYZZI314K3HM=; b=OlVWOg
	+ZB4im+wYUD16rBQTxIlLW7b27qZBWJS357hieJQiOh5MXv4spNahZHYDHq9fFj+
	8L+mI7SuCx+Pm1+LY12aPWh+qdO1Vn2fe8+3Mn/dbgzs7JGBd5Nn2Tsdf+J+NlEG
	NYyY/d53ccqiWcJWLRn5A8EzGZ4xfBFj3MbBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OF1Gts986MIw63HF6HsG1Ktc3phw+5Ma
	gTXC1CEBGLyCeKwZjNrLYyOQz2Gyi2z83iowxDtm7L1hlF/BleINtBhmcoDzDvp1
	Mx/FwNBsgwQLjrAFNInJhuuBVIr/IpFMCjoe/V/mKajc8EeHa990wy5MOCw7ndQ2
	hVmaiCNci2M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B3E1A4195A;
	Sun, 31 Jan 2016 21:18:40 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 303B741959;
	Sun, 31 Jan 2016 21:18:40 -0500 (EST)
In-Reply-To: <20160131113029.GE5116@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 31 Jan 2016 06:30:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1BCC6AD2-C88A-11E5-A5E4-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285178>

Jeff King <peff@peff.net> writes:

> We do not really expect people to use "--no-stage", but if
> they do, git currently segfaults. We could instead have it
> undo the effects of a previous "--stage", but this gets
> tricky around the "to_tempfile" flag. We cannot simply reset
> it to 0, because we don't know if it was set by a previous
> "--stage=all" or an explicit "--temp" option.
>
> We could solve this by setting a flag and resolving
> to_tempfile later, but it's not worth the effort. Nobody
> actually wants to use "--no-stage"; we are just trying to
> fix a potential segfault here.
>
> While we're in the area adding a translated string, let's
> mark the other possible error message in this function as
> translatable.

Thanks.  That's worth fixing and I agree with the decision that it
is the best way to go to not support '--no-stage'.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/checkout-index.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index f8179a7..7a9b561 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -133,6 +133,8 @@ static struct lock_file lock_file;
>  static int option_parse_stage(const struct option *opt,
>  			      const char *arg, int unset)
>  {
> +	if (unset)
> +		return error(_("--stage cannot be negated"));

Hmm, it is surprising that there is no parse-options flag that says
"this cannot be negated".

>  	if (!strcmp(arg, "all")) {
>  		to_tempfile = 1;
>  		checkout_stage = CHECKOUT_ALL;
> @@ -141,7 +143,7 @@ static int option_parse_stage(const struct option *opt,
>  		if ('1' <= ch && ch <= '3')
>  			checkout_stage = arg[0] - '0';
>  		else
> -			die("stage should be between 1 and 3 or all");
> +			die(_("stage should be between 1 and 3 or all"));
>  	}
>  	return 0;
>  }
