From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 01/15] test: add test cases for relative_path
Date: Tue, 21 May 2013 13:37:01 -0700
Message-ID: <7vhahwm5n6.fsf@alter.siamese.dyndns.org>
References: <cover.1368846844.git.worldhello.net@gmail.com>
	<cover.1368782129.git.worldhello.net@gmail.com>
	<cover.1368846844.git.worldhello.net@gmail.com>
	<ea0e3b1148ba1614916a8b1cca8d2d046acd047c.1368846844.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 22:37:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UetJ2-0005DB-MU
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 22:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429Ab3EUUhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 16:37:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755Ab3EUUhE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 16:37:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9869D2185D;
	Tue, 21 May 2013 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tAEaUYz5Dc6kMSaLeyBemVMLjjA=; b=mwmS+1
	32mldRZ4BqSahji4EIl08FtzrlIK7ylJRF9xIJxVuWMcz2GQL61HE/GRL0u0m5Ks
	nWFOWKyb0nKNfpWUcsEJPL02kQn6KLMXU6it868pL85FdsggkJnUoc9qkbRu5HCG
	5SZ6FEe2sg8kyBviKXr4WAZmkEXXk9WpLSyus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LDeEsNlTzCO2ka1HEOYjATfuyVLYwdeB
	DwOEboO1obp1L4C002rWt2eKV2yiIfedk0p7TV9HPpELvjgmkJByGD5eWtM0WMz/
	No1rIKSzUi/p2aWDp6z0dwNHdGESUf/4ioOT9M7Jeq7T/+kdgPcXxLuh/DvZsB3p
	A8FfN/vt+fs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D5052185C;
	Tue, 21 May 2013 20:37:03 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA20E2185B;
	Tue, 21 May 2013 20:37:02 +0000 (UTC)
In-Reply-To: <ea0e3b1148ba1614916a8b1cca8d2d046acd047c.1368846844.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Sat, 18 May 2013 11:18:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 319A2CE2-C256-11E2-BA81-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225075>

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/test-path-utils.c b/test-path-utils.c
> index 0092cb..18267 100644
> --- a/test-path-utils.c
> +++ b/test-path-utils.c
> @@ -1,6 +1,19 @@
>  #include "cache.h"
>  #include "string-list.h"
>  
> +#define PARSE_ARGV_STRING(var, input) do { \
> +	if (!strcmp(input, "<null>")) { \
> +		var = NULL; \
> +	} else if (!strcmp(input, "<empty>")) { \
> +		var = ""; \
> +	} else if (*input == '<' || *input == '(') { \
> +		fprintf(stderr, "Bad value: %s\n", input); \
> +		return 1; \
> +	} else { \
> +		var = input; \
> +	} \
> +} while (0)

Yuck. Why does it have to be a macro like this?  I do not think
"because we may return" justifies it.

>  /*
>   * A "string_list_each_func_t" function that normalizes an entry from
>   * GIT_CEILING_DIRECTORIES.  If the path is unusable for some reason,
> @@ -103,6 +116,18 @@ int main(int argc, char **argv)
>  		return 0;
>  	}
>  
> +	if (argc == 4 && !strcmp(argv[1], "relative_path")) {
> +		const char *abs, *base, *rel;
> +		PARSE_ARGV_STRING(abs, argv[2]);
> +		PARSE_ARGV_STRING(base, argv[3]);
> +		rel = relative_path(abs, base);
> +		if (!rel)
> +			puts("(null)");
> +		else
> +			puts(strlen(rel) > 0 ? rel : "(empty)");
> +		return 0;
> +	}
> +
>  	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
>  		argv[1] ? argv[1] : "(there was none)");
>  	return 1;
