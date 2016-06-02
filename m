From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] pathspec: allow escaped query values
Date: Thu, 02 Jun 2016 14:54:10 -0700
Message-ID: <xmqqr3cfs1dp.fsf@gitster.mtv.corp.google.com>
References: <20160602213015.21712-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, ramsay@ramsayjones.plus.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 23:54:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8aZI-0003qN-BK
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 23:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843AbcFBVyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 17:54:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932240AbcFBVyP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 17:54:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D555820D9C;
	Thu,  2 Jun 2016 17:54:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=267Q/saM6NE+rAmVNLGeZslYH0I=; b=N5A+fN
	T6xmL4C27l1TuwYFv7RzPaO5Azde3NFwg5Azt2IhKfhNt9pShwJsWu5doYe1U0om
	kV/I3Y7LV6TxcgYGqkCUQOFpz9zKLIK40zzsAkHdOEyRCyI3DUrt2fDVwPR1L8cj
	KR7LtHsXi6kJgh+mZUd6xbesrpseMvenZukEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NI4rBcOwsqCZGo1DCpOp5ulW/6prLaFF
	oFfVGArpF+kYYLHEDbmqMbDSEHUddlY8Vsm659LdGrjnPWKRdEEHT5UEPVIZhet4
	nUx1ptNC/FUAXdUGDKzGX77Jl8IW9bWWrqrt+JRg5QK7hYrXE8Fpb6haUyWUNA+T
	Zwn0W8qdtvo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC92220D9B;
	Thu,  2 Jun 2016 17:54:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4374720D9A;
	Thu,  2 Jun 2016 17:54:13 -0400 (EDT)
In-Reply-To: <20160602213015.21712-1-sbeller@google.com> (Stefan Beller's
	message of "Thu, 2 Jun 2016 14:30:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B2F6590-290C-11E6-A74D-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296244>

Stefan Beller <sbeller@google.com> writes:

> In our own .gitattributes file we have attributes such as:
>
>     *.[ch] whitespace=indent,trail,space
>
> When querying for attributes we want to be able to ask for the exact
> value, i.e.
>
>     git ls-files :(attr:whitespace=indent,trail,space)
>
> should work, but the commas are used in the attr magic to introduce
> the next attr, ...
> ...
> So here is the "escaping only, but escaping done right" version.
> (It goes on top of sb/pathspec-label)

The phrase "should work" is probably a bit too strong (I'd have said
"it would be nice if this worked"), as we do not have to even
support comma for our immediately expected use cases.  Allowing it
merely makes a casual test using our own .gitattributes easier.

> +static size_t strcspn_escaped(const char *s, const char *reject)

Perhaps s/reject/stop/?

> +{
> +	const char *i, *j;
> +
> +	for (i = s; *i; i++) {
> +		/* skip escaped the character */
> +		if (i[0] == '\\' && i[1]) {
> +			i++;
> +			continue;
> +		}
> +		/* see if any of the chars matches the current character */
> +		for (j = reject; *j; j++)
> +			if (!*i || *i == *j)
> +				return i - s;

I somehow doubt that *i can be NUL here.  In any case, this looks
more like

	/* is *i is one of the stop codon? */
        if (strchr(stop, *i))
		break;

> +	}
> +	return i - s;
> +}

> +static char *attr_value_unescape(const char *value)
> +{
> +	char *i, *ret = xstrdup(value);
> +
> +	for (i = ret; *i; i++) {
> +		if (i[0] == '\\') {
> +			if (!i[1])
> +				die(_("Escape character '\\' not allowed as "
> +				      "last character in attr value"));
> +
> +			/* remove the backslash */
> +			memmove(i, i + 1, strlen(i));
> +			/* and ignore the character after that */
> +			i++;
> +		}
> +	}
> +	return ret;
> +}
> +

Repeated memmove() and strlen() somehow bothers me.  Would there be
a more efficient and straight-forward way to do this, perhaps along
the lines of this instead?

	const char *src;
        char *dst, *ret;

	ret = xmalloc(strlen(value));
        for (src = value, dst = ret; *src; src++, dst++) {
		if (*src == '\\') {
                	if (!src[1])
                        	die();
			src++;
		}
		if (*src && invalid_value_char(*src))
			die("cannot use '%c' for value matching", *src)
                *dst = *src;
	}
        *dst = '\0'
        return ret;

Even though I earlier said "Now we have an unquote mechanism, we can
open the floodgate by lifting the "no backslash in value" check, I
now realize that we do want to keep some escape hatch for us to
extend the quoting syntax even more later, so perhaps with something
like this:

	static inline int invalid_value_char(const char ch)
        {
        	if (isalnum(ch) || strchr(",-_", ch))
                	return 0;
		return -1;
	}

Thanks.
