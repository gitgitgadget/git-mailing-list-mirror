Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4014020372
	for <e@80x24.org>; Tue, 10 Oct 2017 00:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755506AbdJJADj (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 20:03:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61347 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751274AbdJJADi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 20:03:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63188B203C;
        Mon,  9 Oct 2017 20:03:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y3COL8TCmYs3ZDQ5AvKneXkil9A=; b=ROKkoZ
        rLERsWRW6ec5JsKH/y6gtTawF+xvw6BqYph+tCoORw7AAPXSA7eo0vrrYI0y5K+R
        v8TUIYuAFz3DdrZ5S1ihubLLRJY939ECzvur4iYFadtFox0Uxs3y7ES9nGrGqN7c
        xSOXYmHkbZ8uYxBWalNKe3xvBoSRsuAJx9ziU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PEVPyEMJR6Dx4xe/cHKw7RgW2UUC6tkw
        nULHB9yE68Oy4Y7BFcEjgJZKYl82bMCy2rjnW2c/MqlJETX6ky3hFAkenZvW4q0E
        8nQcCAgmbM0pXlFrwyJ84hDFbDNk54WfBkIC+evJpNsKsqbTnguYcVF3ngr/pfqn
        sWkzxQOrBLQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5940BB203A;
        Mon,  9 Oct 2017 20:03:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9826B2039;
        Mon,  9 Oct 2017 20:03:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] write_entry: untangle symlink and regular-file cases
References: <20171009174715.a6wziu6w535u6rd2@sigill.intra.peff.net>
        <20171009175004.75hlgsfyvupe5z3p@sigill.intra.peff.net>
Date:   Tue, 10 Oct 2017 09:03:36 +0900
In-Reply-To: <20171009175004.75hlgsfyvupe5z3p@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 9 Oct 2017 13:50:05 -0400")
Message-ID: <xmqqy3ojrhrb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 773E76DA-AD4E-11E7-BD02-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The write_entry() function switches on the mode of the entry
> we're going to write out. The cases for S_IFLNK and S_IFREG
> are lumped together. In earlier versions of the code, this
> made some sense. They have a shared preamble (which reads
> the blob content), a short type-specific body, and a shared
> conclusion (which writes out the file contents; always for
> S_IFREG and only sometimes for S_IFLNK).
>
> But over time this has grown to make less sense. The preamble
> now has conditional bits for each type, and the S_IFREG body
> has grown a lot more complicated. It's hard to follow the
> logic of which code is running for which mode.

Nicely done and looks correct.  Thanks.

>
> Let's give each mode its own case arm. We will still share
> the conclusion code, which means we now jump to it with a
> goto. Ideally we'd pull that shared code into its own
> function, but it touches so much internal state in the
> write_entry() function that the end result is actually
> harder to follow than the goto.

>
> While we're here, we'll touch up a few bits of whitespace to
> make the beginning and endings of the cases easier to read.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  entry.c | 71 +++++++++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 40 insertions(+), 31 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index bec51e37a2..206363fd15 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -260,13 +260,31 @@ static int write_entry(struct cache_entry *ce,
>  	}
>  
>  	switch (ce_mode_s_ifmt) {
> -	case S_IFREG:
>  	case S_IFLNK:
> +		new = read_blob_entry(ce, &size);
> +		if (!new)
> +			return error("unable to read sha1 file of %s (%s)",
> +				     path, oid_to_hex(&ce->oid));
> +
> +		/*
> +		 * We can't make a real symlink; write out a regular file entry
> +		 * with the symlink destination as its contents.
> +		 */
> +		if (!has_symlinks || to_tempfile)
> +			goto write_file_entry;
> +
> +		ret = symlink(new, path);
> +		free(new);
> +		if (ret)
> +			return error_errno("unable to create symlink %s", path);
> +		break;
> +
> +	case S_IFREG:
>  		/*
>  		 * We do not send the blob in case of a retry, so do not
>  		 * bother reading it at all.
>  		 */
> -		if (ce_mode_s_ifmt == S_IFREG && dco && dco->state == CE_RETRY) {
> +		if (dco && dco->state == CE_RETRY) {
>  			new = NULL;
>  			size = 0;
>  		} else {
> @@ -276,42 +294,31 @@ static int write_entry(struct cache_entry *ce,
>  					     path, oid_to_hex(&ce->oid));
>  		}
>  
> -		if (ce_mode_s_ifmt == S_IFLNK && has_symlinks && !to_tempfile) {
> -			ret = symlink(new, path);
> -			free(new);
> -			if (ret)
> -				return error_errno("unable to create symlink %s",
> -						   path);
> -			break;
> -		}
> -
>  		/*
>  		 * Convert from git internal format to working tree format
>  		 */
> -		if (ce_mode_s_ifmt == S_IFREG) {
> -			if (dco && dco->state != CE_NO_DELAY) {
> -				ret = async_convert_to_working_tree(
> -					ce->name, new, size, &buf, dco);
> -				if (ret && string_list_has_string(&dco->paths, ce->name)) {
> -					free(new);
> -					goto delayed;
> -				}
> -			} else
> -				ret = convert_to_working_tree(
> -					ce->name, new, size, &buf);
> -
> -			if (ret) {
> +		if (dco && dco->state != CE_NO_DELAY) {
> +			ret = async_convert_to_working_tree(ce->name, new,
> +							    size, &buf, dco);
> +			if (ret && string_list_has_string(&dco->paths, ce->name)) {
>  				free(new);
> -				new = strbuf_detach(&buf, &newsize);
> -				size = newsize;
> +				goto delayed;
>  			}
> -			/*
> -			 * No "else" here as errors from convert are OK at this
> -			 * point. If the error would have been fatal (e.g.
> -			 * filter is required), then we would have died already.
> -			 */
> +		} else
> +			ret = convert_to_working_tree(ce->name, new, size, &buf);
> +
> +		if (ret) {
> +			free(new);
> +			new = strbuf_detach(&buf, &newsize);
> +			size = newsize;
>  		}
> +		/*
> +		 * No "else" here as errors from convert are OK at this
> +		 * point. If the error would have been fatal (e.g.
> +		 * filter is required), then we would have died already.
> +		 */
>  
> +	write_file_entry:
>  		fd = open_output_fd(path, ce, to_tempfile);
>  		if (fd < 0) {
>  			free(new);
> @@ -326,6 +333,7 @@ static int write_entry(struct cache_entry *ce,
>  		if (wrote != size)
>  			return error("unable to write file %s", path);
>  		break;
> +
>  	case S_IFGITLINK:
>  		if (to_tempfile)
>  			return error("cannot create temporary submodule %s", path);
> @@ -337,6 +345,7 @@ static int write_entry(struct cache_entry *ce,
>  				NULL, oid_to_hex(&ce->oid),
>  				state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
>  		break;
> +
>  	default:
>  		return error("unknown file mode for %s in index", path);
>  	}
