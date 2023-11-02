Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD731C20
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 05:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ubmFYFzH"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68515102
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 22:00:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 10CB81CD5DD;
	Thu,  2 Nov 2023 01:00:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2b0h0G6nhmb75Aly2DWL89RM5VYKUZB6hc9Wgk
	Wt7ts=; b=ubmFYFzH4yPmx1q3iTVDofgWUnbx4ZIhZPaSu4YmQL1SdNHQmIZIzp
	1k8dmE0QuOORYBRwbA0CpmwrOgnnpqLtsSbFOFLtFcqgeZ1whWZBik1mwtjBY7uw
	WlIh/dxmm4U4EZ42pK0vHJF2Gm99voYjdDDiG6KRkIGw2TvgfzRLs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 07E701CD5DC;
	Thu,  2 Nov 2023 01:00:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59BA71CD5DB;
	Thu,  2 Nov 2023 01:00:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] attr: enable attr pathspec magic for git-add and
 git-stash
In-Reply-To: <20231102015554.34089-1-jojwang@google.com> (Joanna Wang's
	message of "Thu, 2 Nov 2023 01:55:53 +0000")
References: <20231011202008.609921-1-jojwang@google.com>
	<20231102015554.34089-1-jojwang@google.com>
Date: Thu, 02 Nov 2023 14:00:25 +0900
Message-ID: <xmqqfs1ooil2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BC9395CE-793C-11EE-BA65-25B3960A682E-77302942!pb-smtp2.pobox.com

Joanna Wang <jojwang@google.com> writes:

> I've updated this to include the fix for git-stash. I was
> initially going to fix this bug [1] separately, but I thought it
> would make more sense to put everything in one patch so attr could
> be enabled for both git-add and git-stash and tested.

I think that is perfectly fine, as long as it is described well in
the proposed log message what is done in the patch, and how two
seemingly different things done in the patch are so closely linked
that it makes sense to do so in a single patch.

Will queue.

Thanks.

> diff --git a/pathspec.c b/pathspec.c
> index bb1efe1f39..40bd8a8819 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -109,7 +109,7 @@ static struct pathspec_magic {
>  	{ PATHSPEC_ATTR,    '\0', "attr" },
>  };
>  
> -static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
> +static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic, const char *element)
>  {
>  	int i;
>  	strbuf_addstr(sb, ":(");
> @@ -118,6 +118,13 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
>  			if (sb->buf[sb->len - 1] != '(')
>  				strbuf_addch(sb, ',');
>  			strbuf_addstr(sb, pathspec_magic[i].name);
> +			if (pathspec_magic[i].bit & PATHSPEC_ATTR) {
> +				/* extract and insert the attr magic value */
> +				char* p = strstr(element, "attr:");

In our codebase, the asterisk sticks to the variable, not to the
type, i.e.

				char *p = strstr(element, "attr:");

> +				char buff[128];

Will this fixed-size buffer make an inviting target for script
kiddies, as pathspec often come from the command line and under
control by whoever is making a request?

Aren't we going to copy what is in the elt literally from where
attr: appears up to the next delimiter like ',', ')'?  I am not sure
if we need a separate buffer.  Would something along this line work?

				strbuf_add(sb, p, strcspn(p, ",)");

I am unsure if this "unparsing" is the way we want to go.  For one,
just like %(attr:foo) can take an arbitrary end-user supplied string
in the "foo" part, we can have new pathspec magic in the future that
will take an arbitrary end-user supplied string as its value.  And the
above unparsing code will be utterly confused when that value
happens to contain "attr:" as its substring, e.g., 

    $ git add . ":(exclude,frotz:diattr:0,attr:submodule)"

Also, do we (and if not right now, then do we want to) support
giving more than one attribute?

    $ git add ":(attr:text,attr:small)*.py"

Not supporting multiple attributes would be OK for now, but when it
becomes needed, the "unparse using the bits in the element_magic"
does not look like the right approach.

Indeed, if you are going to pass the original "elt" string *anyway*,
you have all the info in there that you need.  I wonder if it makes
sense to get rid of the "unsigned magic" bitset from the parameter,
and discard the loop over the pathspec_magic[] array and do
something like:

    - if the original "elt" already has some magic (i.e., begins
      with ":(" and not in the literal mode), then copy them
      literally and textually from ":(" up to the closing ")", but
      also insert the necessary "prefix:<num>" magic;

    - otherwise, give ":(prefix:<num>)" magic.

without even attempting to unparse the bits in "element_magic"?

Thanks.
