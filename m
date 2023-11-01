Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373815A8
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 04:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dy+Ighni"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B47DF
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 21:14:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A73561C40B5;
	Wed,  1 Nov 2023 00:14:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=teDakmgpABmD/sowvfh1zqMLOTRAexXf0FT1NE
	JUCoI=; b=dy+IghniH0oDN6hlkReEprBwI2HivggoZOu4yynIwimh529s/hGQUj
	FvIn9sfDLt6mMiC+8E1C1UxUdfFY0oRD+waK0x14q/tKa257Y/4Xu9n34fjd58n/
	zt6TG4O7qg2q4KRtgUr0XLJsxqdjhvCw5Yhi/3PL6MMxex/sbTevQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EC601C40B4;
	Wed,  1 Nov 2023 00:14:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0AF151C40B3;
	Wed,  1 Nov 2023 00:14:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  Dragan Simic <dsimic@manjaro.org>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/4] strbuf: make add_lines() public
In-Reply-To: <283f502acb68910cb43d6077eef99d6345aaea4b.1698791220.git.jonathantanmy@google.com>
	(Jonathan Tan's message of "Tue, 31 Oct 2023 15:28:32 -0700")
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com>
	<cover.1698791220.git.jonathantanmy@google.com>
	<283f502acb68910cb43d6077eef99d6345aaea4b.1698791220.git.jonathantanmy@google.com>
Date: Wed, 01 Nov 2023 13:14:29 +0900
Message-ID: <xmqq5y2mun2y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 27DCF832-786D-11EE-AAE9-25B3960A682E-77302942!pb-smtp2.pobox.com

Jonathan Tan <jonathantanmy@google.com> writes:

> -static void add_lines(struct strbuf *out,
> -			const char *prefix1,
> -			const char *prefix2,
> -			const char *buf, size_t size)
> +void strbuf_add_lines_varied_prefix(struct strbuf *sb,
> +				    const char *default_prefix,
> +				    const char *tab_nl_prefix,
> +				    const char *buf, size_t size)
>  {
>  	while (size) {
>  		const char *prefix;
>  		const char *next = memchr(buf, '\n', size);
>  		next = next ? (next + 1) : (buf + size);
>  
> -		prefix = ((prefix2 && (buf[0] == '\n' || buf[0] == '\t'))
> -			  ? prefix2 : prefix1);
> -		strbuf_addstr(out, prefix);
> -		strbuf_add(out, buf, next - buf);
> +		prefix = (buf[0] == '\n' || buf[0] == '\t')
> +			  ? tab_nl_prefix : default_prefix;
> +		strbuf_addstr(sb, prefix);
> +		strbuf_add(sb, buf, next - buf);

The original allowed callers to pass NULL for the second prefix when
they want to use the same prefix, even for commenting out an empty
line or a line that begins with a tab.  The new one does not allow
the callers to do so.  As long as updating the existing callers are
done carefully, the difference would not matter, but would it help
new callers in the future to rid the usability feature like this
patch does while performing a refactoring?  The loss of feature is
not even documented, by the way.

While "tab_nl" sound a bit more specific than "2", I am not sure if
we made it better.  It does not make it clear why it makes sense to
(and it is necessary to) special case HT and LF.  A developer who is
writing a new caller would not know why there are two prefixes
supported, or why the function is named "varied prefix", with these
names.

Giving a name that explains the reason might help the readability.
I've been thinking what the best name for this function would be but
not successfully.

It may be that we shouldn't take two prefixes in the first place.
The ONLY case callers want to pass prefix2 that is different from
prefix1 is when prefix1 ends with a space, and prefix2 is identical
to prefix1 without the trailing space.  The reason they use such a
pair of prefixes is to avoid leaving a trailing whitespace (when
buf[0] == '\n') or having a space before tab (when buf[0] == '\t')
on the generated lines.

So eventually we may want to have something like this as the final
interface given to the public callers, simply because ...

    strbuf_add_lines_as_comments(struct strbuf *sb,
			         const char *comment_prefix,
				 const char *buf, size_t size)
    {
	while (size) {
            const char *next = memchr(buf, '\n', size);
	    next = next ? (next + 1) : (buf + size);
	    strbuf_addstr(sb, comment_prefix);
	    /* avoid trailing-whitespace and space-before-tab */
	    if (buf[0] != '\n' && buf[0] != '\t')
 		strbuf_addch(sb, ' ');
	    strbuf_add(sb, buf, next - buf);
	    ... loop control ...
	}
        ... strbuf completion ...
    }

... there is no need for totally unrelated two prefix variants.  And
both the function name and the parameter name would be a bit easier
to understand than your version (and far easier than the original).
The function is about commenting out all the lines in buf with the
comment prefix, and most of the time we add a space between the
comment character and the commented out text, but in some cases we
do not want to add the space.

But as I said already, I'd prefer to see a patch that claims to be a
refactoring to do as little as necessary.  Giving it a name better
than add_lines() is inevitable, because you are making it extern.
But I'd prefer to see the parameter naems and the function body left
untouched and kept the same as the original.  It should be left to a
separate step to improve the interface and the implementation.

Thanks.


