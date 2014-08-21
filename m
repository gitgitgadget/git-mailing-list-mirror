From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] teach fast-export an --anonymize option
Date: Thu, 21 Aug 2014 13:15:10 -0700
Message-ID: <xmqqmwaxr44x.fsf@gitster.dls.corp.google.com>
References: <20140821070130.GA15930@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:15:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKYla-000559-MS
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 22:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbaHUUPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 16:15:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64902 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbaHUUPW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 16:15:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BDDBF3470D;
	Thu, 21 Aug 2014 16:15:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hqVChnw7z7LGXoKRqN3zPjTHy9A=; b=l6fRrF
	4BiA6kw6KEW1UuT7lc/mpnfyE9iCDfGQjR4Bj7e7cwKXWgksM6ZFQAmaA+R0yhhO
	mpFWx71nTWtLmNeJ3H3vUvX6Sd7f6LlS9FnmjGX9cGTrZ7OaAtyiGIw3AQuzu2lB
	okAOUmjg+RHWozqsku8IPiz2HV0tzpJEmm83k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DOsGI/1NkeIZFJoTjNK9jyjk8W0KRtjg
	BM/gZAnW4psLlLfhhsW/aybqXlBGCMM/EPauwO6Y1AJ3aQBE845PvQsj6bqEnghf
	TJQByrh3QsaA4tlv4SPtFULXPNTnPsSvg6Rf8sBcn1PAVd4Pi/i7SolnmT7/bqBV
	1zFe2OFdDkk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FE8F3470B;
	Thu, 21 Aug 2014 16:15:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F25EB34703;
	Thu, 21 Aug 2014 16:15:11 -0400 (EDT)
In-Reply-To: <20140821070130.GA15930@peff.net> (Jeff King's message of "Thu,
	21 Aug 2014 03:01:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DAFC25B6-296F-11E4-81B9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255638>

Jeff King <peff@peff.net> writes:

> +/*
> + * We anonymize each component of a path individually,
> + * so that paths a/b and a/c will share a common root.
> + * The paths are cached via anonymize_mem so that repeated
> + * lookups for "a" will yield the same value.
> + */
> +static void anonymize_path(struct strbuf *out, const char *path,
> +			   struct hashmap *map,
> +			   char *(*generate)(const char *, size_t *))
> +{
> +	while (*path) {
> +		const char *end_of_component = strchrnul(path, '/');
> +		size_t len = end_of_component - path;
> +		const char *c = anonymize_mem(map, generate, path, &len);
> +		strbuf_add(out, c, len);
> +		path = end_of_component;
> +		if (*path)
> +			strbuf_addch(out, *path++);
> +	}
> +}

Do two paths sort the same way before and after anonymisation?  For
example, if generate() works as a simple substitution, it should map
a character that sorts before (or after) '/' with another that also
sorts before (or after) '/' for us to be able to diagnose an error
that comes from D/F sort order confusion.
