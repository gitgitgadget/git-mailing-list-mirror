Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED045C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 10:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240669AbjELKYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 06:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbjELKYU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 06:24:20 -0400
X-Greylist: delayed 823 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 03:24:18 PDT
Received: from out-54.mta1.migadu.com (out-54.mta1.migadu.com [95.215.58.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8391BF
        for <git@vger.kernel.org>; Fri, 12 May 2023 03:24:18 -0700 (PDT)
References: <xmqqilfhctrr.fsf@gitster.g>
 <20230510190116.795641-1-toon@iotcl.com>
 <20230510190116.795641-2-toon@iotcl.com> <xmqqpm782be6.fsf@gitster.g>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
        t=1683885639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gSiel6UfsKsJEy+vs/IhwtE9h7TzPehylpm4b5c/VFA=;
        b=xk+ip4yUgCfJz9T9D5qv/QDmJilCdAKIMfYj1J2L/LTQQ3Mh0vQByArYNDv43X82lZYhkk
        vLZb78fCYaNsGB9n+B8eFjvcK/0N5a3ukfw6VEqKPtpRam9B9kkxQqDCfI4cZPGe+ucOqL
        CKtOHJizMsoPnAK5tPNefUH21kwmaaE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Toon Claes <toon@iotcl.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 1/1] cat-file: quote-format name in error when using -z
Date:   Fri, 12 May 2023 10:54:20 +0200
In-reply-to: <xmqqpm782be6.fsf@gitster.g>
Message-ID: <87h6sh6f81.fsf@iotcl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> Since it's supported to have NUL-delimited input, introduced in
>> db9d67f2e9 (builtin/cat-file.c: support NUL-delimited input with `-z`,
>> 2022-07-22), it's possible to pass paths that contain newlines.
>
> It has been a while since I saw this patch the last time, and it did
> not immediately click to me how "pass paths" relates to passing
> object names, which is what "--batch-check" takes.  Perhaps
>
>     "cat-file --batch-check" may be fed object names of blobs and
>     trees as "<commit>:<path>", and with its "-z" option, it is
>     possible to feed <commit> or <path> with newlines in it.
>
> or something?

Good suggestion.

>> This
>> works great when the object is found, but when it's not, the input path
>> is returned in the error message. Because this can contain newlines, the
>> error message might get spread over multiple lines, making it harder to
>> machine-parse this error message.
>
> Good description.  I may suggest
>
>     "the input path is returned" -> "the input is shown verbatim"
>
> because <path> is not the only thing that can contain LF.  E.g.
>
>     $ git show -s 'HEAD^{/introduced in
>     > db9d67}'
>
> can find the commit resulting from this patch, so
>
>     $ printf "%s\0" 'HEAD^{/introduced in
>     > db9d67}:builtin/cat-file.cc' |
>     > git cat-file --batch-check -z

Thanks for that thorough explanation, makes a lot of sense.

>
> would be an input record with newline in it, that has no newline in
> the path.
>
>> With this change, the input is quote-formatted in the error message, if
>> needed. This ensures the error message is always on a single line and
>> makes parsing the error more straightforward.
>
> Drop "With this change, ..." and give a command to the codebase to
> c-quote the object name in the output, e.g.
>
>     C-quote the object name from the input in the error message as
>     needed, to ensure that the error message is on a single line and
>     ...

Sure, I'll update the commit message accordingly.

> The other side of the coin, however, is that an existing project
> that is sane enough not to have a path with LF in it, but is not
> sane enough to avoid a path with double-quote in it, would now stop
> being able to parse the error message for a missing path.

Ah interesting, this is not a case I did consider before.

> It is a regression, and we may argue that it is not a large enough
> regression to block progress given by this patch, but if it is not
> common enough to have funny characters in the paths then we wouldn't
> be seeing this patch in the first place.  So I would prefer to see
> that we at least admit that we are deliberately making this change
> with a known regression.  Perhaps add something like
>
>     Note that if a project already parses the error message
>     correctly because it does not have paths with newlines, this is
>     a breaking change if it has paths with characters that need
>     c-quoting (like double quotes and backslashes) that are not
>     newlines.  We consider that this is a small enough price to pay
>     to allow newlines in paths because ...
>
> and fill the "because ..." part is sensible.  I am not filling the
> "because" part, simply because I do not offhand see any good excuse
> to rob Peter to pay Paul in this case.

I intended to finalize this patch sooner, but other priorities popped
up. The -z flag was added in v2.38 and it would have been nice to have
the patch in v2.40, this would reduce the number of Peters affected. Now
we're a couple months and yet another release further between
introduction of the flag and making the regression, so I feel your
sentiment.

I previous conversations[1] we've been talking about making the output
NUL-terminated as well. We agreed on the cquote fix because the -z flag
was still fresh, but maybe at this time we need to revisit this.

Ideally the output should be NUL-terminated if -z is used. This was also
suggested[2] when the flag was introduced. Obviously we cannot change
this now, because it would break behavior for *everyone* using -z, not
only when funny names are used. So if we want to go this route, we
should only do so with another flag (e.g. `--null-output`) or a config
option.

But I was looking at the git-config(1) documentation:

> core.quotePath::
> 	Commands that output paths (e.g. 'ls-files', 'diff'), will
> 	quote "unusual" characters in the pathname by enclosing the
> 	pathname in double-quotes and escaping those characters with
> 	backslashes in the same way C escapes control characters (e.g.
> 	`\t` for TAB, `\n` for LF, `\\` for backslash) or bytes with
> 	values larger than 0x80 (e.g. octal `\302\265` for "micro" in
> 	UTF-8).  If this variable is set to false, bytes higher than
> 	0x80 are not considered "unusual" any more. Double-quotes,
> 	backslash and control characters are always escaped regardless
> 	of the setting of this variable.  A simple space character is
> 	not considered "unusual".  Many commands can output pathnames
> 	completely verbatim using the `-z` option. The default value
> 	is true.

If you read this, the changes of this patch fully contradict this. Also
documentation on other commands (e.g. git-check-ignore(1)) using `-z`
will mention the verbatim output. So at the moment I'm leaning toward
another solution. I'm looping in Taylor as he added the flag initially,
so he might have some insights how they are using it and how they expect
it to work.

-- Toon

[1]: https://lore.kernel.org/git/xmqq5yekyvrh.fsf@gitster.g/
[2]: https://lore.kernel.org/git/66b71194-ad0e-18d0-e43b-71e5c47ba111@gmail.com/
