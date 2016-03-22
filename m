From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC_PATCHv4 3/7] submodule-config: add method to check for being labeled
Date: Tue, 22 Mar 2016 15:30:04 -0700
Message-ID: <xmqqegb2f8nn.fsf@gitster.mtv.corp.google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens.Lehmann@web.de, sschuberth@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:30:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiUoj-0000N7-L4
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbcCVWaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 18:30:18 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752715AbcCVWaK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 18:30:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA3714E989;
	Tue, 22 Mar 2016 18:30:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1UTqn1oVIKPUN7iv5sawGP8erHA=; b=bewnqT
	zSyd3b0Moe/sP5eUd501Rge4oGANx4kbwXs3SOY+eQ+aepa100sYq8zXpHHY1X64
	j3pxXSkvcD8GE7pUhRYLy6BDP8UQnJbKzyOWMdiKvpPxHVQ26MlqESY87if/z6lb
	15OB1qe6n4/UEgW3yg6mZv5xsZLloZTsKbCYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x3H/gXOexB6bMxARpTUpgWVD7Rttdc9g
	DCveeeHKYIb1HcYNITPcztewu6QZ65K4CLH3N2b86UJFtNRkclaTEE9WBOOwuqTw
	1FJ/IAXA+eQCYXFyXCIJ3wXGzxLM+swK/1pRRqp5unUPsZC9WwK7LYfrR50CGy6n
	bZ+74QUoR3Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE7DC4E987;
	Tue, 22 Mar 2016 18:30:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 904FD4E982;
	Tue, 22 Mar 2016 18:30:06 -0400 (EDT)
In-Reply-To: <1458612372-10966-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 21 Mar 2016 19:06:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A0EC4C62-F07D-11E5-B47C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289580>

Stefan Beller <sbeller@google.com> writes:

> In later patches we need to tell if a submodule is labeled by
> the given labels.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Hmph, I would have expected that something like this would touch the
module_list() implementation.  Probably that would happen in future
steps, I guess?

>  submodule-config.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  submodule-config.h |  3 +++
>  2 files changed, 51 insertions(+)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 7b48e59..b10a773 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -493,3 +493,51 @@ void submodule_free(void)
>  	cache_free(&cache);
>  	is_cache_init = 0;
>  }
> +
> +int submodule_applicable_by_labels(const struct string_list *list,
> +				   const struct submodule *sub)
> +{
> +	int label_apply = 0;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (!list)
> +		return 1;
> +
> +	if (sub->labels) {
> +		struct string_list_item *item;
> +		for_each_string_list_item(item, sub->labels) {
> +			strbuf_reset(&sb);
> +			strbuf_addf(&sb, "*%s", item->string);
> +			if (string_list_has_string(list, sb.buf)) {
> +				label_apply = 1;
> +				break;
> +			}
> +		}
> +	}
> +	if (sub->path) {
> +		/*
> +		 * NEEDSWORK: This currently works only for
> +		 * exact paths, but we want to enable
> +		 * inexact matches such wildcards.
> +		 */
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "./%s", sub->path);
> +		if (string_list_has_string(list, sb.buf)) {
> +			label_apply = 1;
> +		}
> +	}
> +	if (sub->name) {
> +		/*
> +		 * NEEDSWORK: Same as with path. Do we want to
> +		 * support wildcards or such?
> +		 */
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, ":%s", sub->name);
> +		if (string_list_has_string(list, sb.buf)) {
> +			label_apply = 1;
> +		}
> +	}
> +	strbuf_release(&sb);
> +
> +	return label_apply;
> +}
> diff --git a/submodule-config.h b/submodule-config.h
> index 8d61df3..d67f666 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -30,4 +30,7 @@ const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
>  		const char *path);
>  void submodule_free(void);
>  
> +int submodule_applicable_by_labels(const struct string_list *list,
> +				   const struct submodule *sub);
> +
>  #endif /* SUBMODULE_CONFIG_H */
