From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] handle arbitrary ints in git_config_maybe_bool
Date: Mon, 20 Dec 2010 16:49:00 -0800
Message-ID: <7vfwtsar2b.fsf@alter.siamese.dyndns.org>
References: <20101219033640.GA6889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 21 01:49:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUqPk-00021J-AT
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 01:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933137Ab0LUAtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 19:49:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757288Ab0LUAtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 19:49:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A1AEB375F;
	Mon, 20 Dec 2010 19:49:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=aHpB8AD8mDgPkYjWRoh4SaWbFzQ=; b=wvgXQggGrL1avnTlkR2mVPM
	d+dT7klAYzI2qukiOC5A8gmrYs4UVChIaGPpOQhnYecuteQ4bMBXPUco4FLKAqJw
	r7eGt723MrqEFjM5b54di22ZrLz5qfe+ZQeAShdCz5uxphaoHgtmokmtQM8s7F91
	nvIXlOC8rloWkAKEYY6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OVWqPmnvE4twQqX2RdASNBsVwPc95L2r5SaHFMhZZODF/yc3K
	N9sjhiuvi0BnePIPNPWeYs92C/JDS/qqB7R6FYWq+tCDhYit72fvBRjUJ0a5xO+P
	06Ki5k76Btq80r6ES2SRnbvYND5sFpS33VfuWYsBf1yGIv8BiAZmDowaYE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D22E375C;
	Mon, 20 Dec 2010 19:49:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2EB9C3759; Mon, 20 Dec 2010
 19:49:29 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2D4060DE-0C9C-11E0-B731-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164021>

Jeff King <peff@peff.net> writes:

> This function recently gained the ability to recognize the
> documented "0" and "1" values as false/true. However, unlike
> regular git_config_bool, it did not treat arbitrary numbers
> as true. While this is undocumented and probably ridiculous
> for somebody to rely on, it is safer to behave exactly as
> git_config_bool would. Because git_config_maybe_bool can be
> used to retrofit new non-bool values onto existing bool
> options, not behaving in exactly the same way is technically
> a regression.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This was posted earlier as part of the command-specific pager topic; you
> ended up splitting part of that out into jk/maint-decorate-01-bool. This
> should logically go on top of that (b2be2f6).
>
> It probably doesn't make a difference in the real world, but I think it
> is safer (as described above), and the code is a little cleaner. I
> should have just done it this way in the first place.

I'd reword "arbitrary numbers" to "arbitrary non-zero numbers".
Other than that, thanks for your attention to the details.

Will apply.

>  config.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/config.c b/config.c
> index 32c0b2c..d73b090 100644
> --- a/config.c
> +++ b/config.c
> @@ -429,13 +429,11 @@ static int git_config_maybe_bool_text(const char *name, const char *value)
>  
>  int git_config_maybe_bool(const char *name, const char *value)
>  {
> -	int v = git_config_maybe_bool_text(name, value);
> +	long v = git_config_maybe_bool_text(name, value);
>  	if (0 <= v)
>  		return v;
> -	if (!strcmp(value, "0"))
> -		return 0;
> -	if (!strcmp(value, "1"))
> -		return 1;
> +	if (git_parse_long(value, &v))
> +		return !!v;
>  	return -1;
>  }
>  
> -- 
> 1.7.3.4.761.g98ad5
