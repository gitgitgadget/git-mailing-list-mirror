Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7658920756
	for <e@80x24.org>; Fri, 13 Jan 2017 23:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbdAMXYa (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 18:24:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53546 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751350AbdAMXYa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 18:24:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5A595F81A;
        Fri, 13 Jan 2017 18:24:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dsc/V/fED0H7VLEtTf8lRZGXCxs=; b=R4EUlD
        XI8R51r+ap3le2u6VPNNRwvFNordx02twbJoILdXA5oRPHzG4r2J1u5V980+xjSi
        WvGTM9gKUuy89b26ZRnzwtJTg2LpxQDzlivFwusJlLRIryZcOW7YrUl/E8C3ccHT
        PBmtDZLdbhXsReKmbCs5P5eDe5g8Gf/sHCe3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T2rC8GojpPN+i3jDW6aKdDuedU6bDcje
        JzbBmagQqpxZVn9FdJbMLdjfkOmwMO98tf7dCZzRXdWcmDq07ZBqAj5HKmWajtXn
        DtQmgEauVxb97a18pNzLTpjuO5F9bEhDKvxWsJziU8eL31lSJkezRhmwEVHqRwTj
        +ujBxyRPy8E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCCB65F819;
        Fri, 13 Jan 2017 18:24:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 214195F818;
        Fri, 13 Jan 2017 18:24:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] diff --no-index: support reading from pipes
References: <20170113102021.6054-1-dennis@kaarsemaker.net>
        <20170113102021.6054-3-dennis@kaarsemaker.net>
Date:   Fri, 13 Jan 2017 15:24:26 -0800
In-Reply-To: <20170113102021.6054-3-dennis@kaarsemaker.net> (Dennis
        Kaarsemaker's message of "Fri, 13 Jan 2017 11:20:21 +0100")
Message-ID: <xmqqo9zaee6t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DA4284E-D9E7-11E6-8EC7-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> +	/*
> +	 * In --no-index mode, we support reading from pipes. canon_mode, called by
> +	 * fill_filespec, gets confused by this and thinks we now have subprojects.
> +	 * Detect this and tell the rest of the diff machinery to treat pipes as
> +	 * normal files.
> +	 */
> +	if (S_ISGITLINK(s->mode))
> +		s->mode = S_IFREG | ce_permissions(mode);

Hmph.  Pipes on your system may satisfy S_ISGITLINK() and confuse
later code, and this hack may work it around.  But a proper gitlink
that was thrown at this codepath (probably by mistake) will also be
caught and pretend as if it were a regular file.  Do we know for
certain that pipes everywhere will be munged to appear as
S_ISGITLINK()?  Is it possible to do the "are we looking at an end
of a pipe?" check _before_ canon_mode() munges and stores the result
in s->mode in diff-no-index.c somewhere, perhaps inside get_mode()?

> diff --git a/diff.c b/diff.c
> index 2fc0226338..bb04eab331 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2839,9 +2839,18 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>  		fd = open(s->path, O_RDONLY);
>  		if (fd < 0)
>  			goto err_empty;
> -		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
> +		if (!S_ISREG(st.st_mode)) {
> +			struct strbuf sb = STRBUF_INIT;
> +			strbuf_read(&sb, fd, 0);
> +			s->size = sb.len;
> +			s->data = strbuf_detach(&sb, NULL);
> +			s->should_free = 1;
> +		}
> +		else {
> +			s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
> +			s->should_munmap = 1;
> +		}
>  		close(fd);
> -		s->should_munmap = 1;

I like the fact that, by extending the !S_ISREG() check this patch
introduces, we can later use the new "do not mmap but allocate to
read" codepath for small files, which may be more efficient.  We may
want to have a small helper

	static int should_mmap_file_contents(struct stat *st)
	{
		return S_ISREG(st->st_mode);
	}

so that we can do such an enhancement later more easily.

So, I am skeptical with the "do we have pipe" check in the earlier
hunk, but otherwise I think what this patch wanted to solve is a
reasonable problem to tackle.

Thanks.
