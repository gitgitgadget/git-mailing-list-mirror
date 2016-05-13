From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] pathspec: move prefix check out of the inner loop
Date: Thu, 12 May 2016 21:43:15 -0700
Message-ID: <xmqqbn4abmak.fsf@gitster.mtv.corp.google.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<20160513001936.7623-4-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, Jens.Lehmann@web.de
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri May 13 06:43:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b14wh-0005Vj-8k
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 06:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbcEMEnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 00:43:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751095AbcEMEnU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 00:43:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 931A91B3EB;
	Fri, 13 May 2016 00:43:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8jn++KHox+2wwI2EnWNfgIrn2eE=; b=c8Hi1l
	mN8PfQe791HqQs5CyQKSNq+nDyiqQQof3fsV9jZimP6uUvDBZrct7E8w5U4PE2n8
	zKKfcl+t7+9Bt0ZQ9d39stK5UyiiQNvRCbDuFhSk1ojCV/LhStUFmy6mZZTMr2hB
	h5Vh/GXTFHPMaSwKXVS1ohV2cutCqAfnPydKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s/+xR/VZpOvbD2J7bRf5SwFoqWeg+xem
	wpOmAaF05ry5Ow3xLHlOoUfBB7hJq0FR3FgaQFhLYptcbJshG5ahg5O7jgilLiCn
	VNOEqsoceOt9WzFser6A2ndHQVQNleiKPiv9ZMCnijjSSLRctGjM4yZIaNWSXcYo
	Qh1CQT5RrSg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BCC21B3EA;
	Fri, 13 May 2016 00:43:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08D221B3E9;
	Fri, 13 May 2016 00:43:17 -0400 (EDT)
In-Reply-To: <20160513001936.7623-4-sbeller@google.com> (Stefan Beller's
	message of "Thu, 12 May 2016 17:19:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 36548AB6-18C5-11E6-A71F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294499>

Stefan Beller <sbeller@google.com> writes:

> The prefix check is not related the check of pathspec magic; also there
> is no code that is relevant after we'd break the loop on a match for
> "prefix:". So move the check before the loop and shortcircuit the outer
> loop.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

What were we thinking back when we added this in the middle of the
loop at 233c3e6c (parse_pathspec: preserve prefix length via
PATHSPEC_PREFIX_ORIGIN, 2013-07-14)?  I am a bit embarrassed.

>  pathspec.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index eba37c2..4dff252 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -107,21 +107,22 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
>  			nextat = copyfrom + len;
>  		if (!len)
>  			continue;
> +
> +		if (starts_with(copyfrom, "prefix:")) {
> +			char *endptr;
> +			*pathspec_prefix = strtol(copyfrom + 7,
> +						  &endptr, 10);
> +			if (endptr - copyfrom != len)
> +				die(_("invalid parameter for pathspec magic 'prefix'"));
> +			continue;
> +		}
> +
>  		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
>  			if (strlen(pathspec_magic[i].name) == len &&
>  			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
>  				*magic |= pathspec_magic[i].bit;
>  				break;
>  			}
> -			if (starts_with(copyfrom, "prefix:")) {
> -				char *endptr;
> -				*pathspec_prefix = strtol(copyfrom + 7,
> -							  &endptr, 10);
> -				if (endptr - copyfrom != len)
> -					die(_("invalid parameter for pathspec magic 'prefix'"));
> -				/* "i" would be wrong, but it does not matter */
> -				break;
> -			}
>  		}
>  		if (ARRAY_SIZE(pathspec_magic) <= i)
>  			die(_("Invalid pathspec magic '%.*s' in '%s'"),
