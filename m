Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E27F21FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 23:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbcLFXoV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 18:44:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56679 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750960AbcLFXoU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 18:44:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6F8355FA4;
        Tue,  6 Dec 2016 18:44:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xNzBebhsyKSSZjCq009cSu9XJDU=; b=eMOtkS
        QVk6z1iHoe0I4Czby+ixfruqsPfA7mbl9ycnFRUoxL0cmHUJh/ejddxkwjlX+52l
        VUPeol7g1GZdp/HFhvcGr3dORpw28l0n3aECSh8egXUl0nWY8cY7FRObhHrXcOuK
        JPKtsfgez/2p0KpSvfsNrZnyd57cmJyUO/dSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bFTZ8jN8vEqnyF6Ci4F6IVQMiTf29V77
        gBIRea5nQgJYHaJs2UXFWj1qc/mDUOdwz0/jCQPP6t+FZSa8TlIKIxRcO60nm9xO
        WpubwxI9hrMpZ8d8ixf/5e6HcFQo4+jwEIdwDb5d5AkZSUYzEJxXiErvIoRHxemA
        pdJ52+HYo8U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE71255FA3;
        Tue,  6 Dec 2016 18:44:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3ADBF55FA2;
        Tue,  6 Dec 2016 18:44:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com
Subject: Re: [PATCH] real_path: make real_path thread-safe
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
        <1480964316-99305-2-git-send-email-bmwill@google.com>
Date:   Tue, 06 Dec 2016 15:44:17 -0800
In-Reply-To: <1480964316-99305-2-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 5 Dec 2016 10:58:36 -0800")
Message-ID: <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E74D7F26-BC0D-11E6-B283-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +/* removes the last path component from 'path' except if 'path' is root */
> +static void strip_last_component(struct strbuf *path)
> +{
> +	if (path->len > 1) {
> +		char *last_slash = find_last_dir_sep(path->buf);
> +		strbuf_setlen(path, last_slash - path->buf);
> +	}
> +}

You use find_last_dir_sep() which takes care of "Windows uses
backslash" issue.  Is this function expected to be fed something
like "C:\My Files\foo.txt" and more importantly "C:\My Files"?  Or
is that handled by a lot higher level up in the callchain?  I am
reacting the comparison of path->len and 1 here.

Also is the input expected to be normalized?  Are we expected to be
fed something like "/a//b/./c/../d/e" and react sensibly, or is that
handled by a lot higher level up in the callchain?

> +/* gets the next component in 'remaining' and places it in 'next' */
> +static void get_next_component(struct strbuf *next, struct strbuf *remaining)
> +{
> +	char *start = NULL;
> +	char *end = NULL;
> +
> +	strbuf_reset(next);
> +
> +	/* look for the next component */
> +	/* Skip sequences of multiple path-separators */
> +	for (start = remaining->buf; is_dir_sep(*start); start++)
> +		/* nothing */;

Style:
		; /* nothing */

> +	/* Find end of the path component */
> +	for (end = start; *end && !is_dir_sep(*end); end++)
> +		/* nothing */;
> +
> +	strbuf_add(next, start, end - start);

OK, so this was given "///foo/bar" in "remaining" and appended
'foo/' to "next".  I.e. deduping of slashes is handled here.

POSIX cares about treating "//" at the very beginning of the path
specially.  Is that supposed to be handled here, or by a lot higher
level up in the callchain?

> +	/* remove the component from 'remaining' */
> +	strbuf_remove(remaining, 0, end - remaining->buf);
> +}
> +
>  /* We allow "recursive" symbolic links. Only within reason, though. */
> -#define MAXDEPTH 5
> +#define MAXSYMLINKS 5
>  
>  /*
>   * Return the real path (i.e., absolute path, with symlinks resolved
> @@ -21,7 +51,6 @@ int is_directory(const char *path)
>   * absolute_path().)  The return value is a pointer to a static
>   * buffer.
>   *
>   * The directory part of path (i.e., everything up to the last
>   * dir_sep) must denote a valid, existing directory, but the last
>   * component need not exist.  If die_on_error is set, then die with an
> @@ -33,22 +62,16 @@ int is_directory(const char *path)
>   */
>  static const char *real_path_internal(const char *path, int die_on_error)
>  {
> +	static struct strbuf resolved = STRBUF_INIT;

This being 'static' would probably mean that this is not reentrant,
which goes against the title of the patch.
