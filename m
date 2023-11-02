Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17722301
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mtRxifOg"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0D5187
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 14:32:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BD5661A494F;
	Thu,  2 Nov 2023 17:32:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/9VhPYkuh9Uq1T9oHeJbg+BY9IPhibHCnzfneN
	dIaDU=; b=mtRxifOgRhaTpE98C7wUzT8o4jjLbKgOmMWCGcq/VHrU3/uVT+s1Ih
	XwFesGr4L4AU4m76NElUDWqO+ZNqiUUpnFPHFRxwFKw5gDsiydqygVZuxp/ejO8Y
	k4O2KgSwjFSlojrDZx0sh6NKi+rnttysqgTXGV/5Kyx7Wj3eKWbwI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B5C651A494E;
	Thu,  2 Nov 2023 17:32:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 209BA1A494D;
	Thu,  2 Nov 2023 17:32:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] attr: enable attr pathspec magic for git-add and
 git-stash
In-Reply-To: <20231102175316.2229631-1-jojwang@google.com> (Joanna Wang's
	message of "Thu, 2 Nov 2023 17:53:15 +0000")
References: <xmqqfs1ooil2.fsf@gitster.g>
	<20231102175316.2229631-1-jojwang@google.com>
Date: Fri, 03 Nov 2023 06:32:13 +0900
Message-ID: <xmqqil6jlu3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4A90BAB6-79C7-11EE-A911-25B3960A682E-77302942!pb-smtp2.pobox.com

Joanna Wang <jojwang@google.com> writes:

>> Indeed, if you are going to pass the original "elt" string *anyway*,
>> you have all the info in there that you need.  I wonder if it makes
>> sense to get rid of the "unsigned magic" bitset from the parameter,
> This was my initial strategy but ran into trouble when the magic was
> in shorthand form. Upon closer look at how the shorthand works
> (e.g. shorthand and longhand can never mix so
> ':!/(attr:chicken)file' would make <(attr:chicken)file> the match string)
> I tried this again by processing the forms separately.
> It would still need both the element and element_magic, but I think it
> addresses the concerns with future changes where multiple magic match
> values could be allowed and the match values could be any string.

The "bits" were acceptable for things like "exclude" and "icase"
because it does not matter how many times you gave them and they do
not take any additional parameters, but attr is different in that it
takes a value, and multiple instances with different values can be
given.  It is lucky that we did not allow mixing the short and long
forms ;-)

> These changes would be fine as long as there is no overlap between
> magic that takes a user-supplied value and magic that can be
> expressed in shorthand.

Indeed.  Thanks for thinking this through.

> -static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
> +static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic, const char *element)
>  {
> -	int i;
> -	strbuf_addstr(sb, ":(");
> -	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++)
> -		if (magic & pathspec_magic[i].bit) {
> -			if (sb->buf[sb->len - 1] != '(')
> -				strbuf_addch(sb, ',');
> -			strbuf_addstr(sb, pathspec_magic[i].name);

At this point in the code, is it guaranteed that element[0] is ':'
and never a NUL?  Also is it guaranteed that element has ')'
somewhere later if element[1] is '('?

"Otherwise the caller would have failed to parse the pathspec magic
into the magic bits, and this helper function would not have been
called" is the answer I am expecting, but I didn't check if the
caller refrains from calling us.  It would be better to have a brief
comment explaining why a seemingly loose parsing of element[] string
is OK to save future readers from wondering the same thing as I did
here.

> +	if (element[1] != '(') {
> +		/* Process an element in shorthand form (e.g. ":!/<match>") */
> +		strbuf_addstr(sb, ":(");
> +		for (int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
> +			if ((magic & pathspec_magic[i].bit) && (pathspec_magic[i].mnemonic != '\0')) {
> +				if (sb->buf[sb->len - 1] != '(')
> +					strbuf_addch(sb, ',');
> +				strbuf_addstr(sb, pathspec_magic[i].name);
> +			}
>  		}
> +	} else {
> +		/* For an element in longhand form, we simply copy everything up to the final ')' */

A comment that is a bit on the overly-long side.

> +		int len = strchr(element, ')') - element;
> +		strbuf_add(sb, element, len);
> +	}
>  	strbuf_addf(sb, ",prefix:%d)", prefixlen);
>  }

Come to think of it, this part of the change could stand on its own
as an independent bugfix.  I wonder if this existing bug caused by
failing to copy the value of "attr:" is triggerable from a codepath
that already allows PATHSPEC_ATTR magic.  Not absolutely required
when the rest of the patch is in reasonably close to the finish
line, but it would narrow the scope of the new feature proper to
treat this as a separate and independent fix, on which the new
fature depends on.

Thanks for working on fixing this rather old bug.  I think we should
have noticed when we added the support for the "attr" magic to the
pathspec API.

