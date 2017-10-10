Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF36220372
	for <e@80x24.org>; Tue, 10 Oct 2017 00:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755605AbdJJAAe (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 20:00:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62216 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755195AbdJJAAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 20:00:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9232BA7ACB;
        Mon,  9 Oct 2017 20:00:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WuTEU+9bqA5S9J0M52986Zh28sg=; b=uTtUBc
        +WURyjAg6aDVRp2kI41U7/tr5Uvwo0zILFY/CaA8Ihhuyz9HUOmPMt+uF8yFYku5
        QkJFSAOUrqqTelL2Mw1V+Od9/3nfJNCkyuaQt/ZCevHhlq1X7fiDvRIjfnJjc4Aq
        loAl+fW5pfrqCC4SumBBvqRa75gxWX18c4gKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qQjFEHxsB0V4aPxDw4oSMmGow/zGqq9V
        dWEWhGi5G0FzMPCXhp+w0kvd+w6OyNpMFLC+HdmEg5DMM/ty361fm84qI19DqLDx
        WEwwalEpIRX0dvJeXYGZpiygzF6+mccBK+hH5CzKmsjoJ2d+3hQpYZZ2ZLJ1FTMN
        VuSNaWdXnAQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89B58A7ACA;
        Mon,  9 Oct 2017 20:00:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E02E7A7AC1;
        Mon,  9 Oct 2017 20:00:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] write_entry: avoid reading blobs in CE_RETRY case
References: <20171009174715.a6wziu6w535u6rd2@sigill.intra.peff.net>
        <20171009174852.32dpy5xh3w3bfn6t@sigill.intra.peff.net>
Date:   Tue, 10 Oct 2017 09:00:26 +0900
In-Reply-To: <20171009174852.32dpy5xh3w3bfn6t@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 9 Oct 2017 13:48:52 -0400")
Message-ID: <xmqq376rswh1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0617A670-AD4E-11E7-94AD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When retrying a delayed filter-process request, we don't
> need to send the blob to the filter a second time. However,
> we read it unconditionally into a buffer, only to later
> throw away that buffer. We can make this more efficient by
> skipping the read in the first place when it isn't
> necessary.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  entry.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Again, looks obviously correct.  Thanks.

>
> diff --git a/entry.c b/entry.c
> index 637c5958b0..bec51e37a2 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -240,6 +240,7 @@ static int write_entry(struct cache_entry *ce,
>  		       char *path, const struct checkout *state, int to_tempfile)
>  {
>  	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
> +	struct delayed_checkout *dco = state->delayed_checkout;
>  	int fd, ret, fstat_done = 0;
>  	char *new;
>  	struct strbuf buf = STRBUF_INIT;
> @@ -261,10 +262,19 @@ static int write_entry(struct cache_entry *ce,
>  	switch (ce_mode_s_ifmt) {
>  	case S_IFREG:
>  	case S_IFLNK:
> -		new = read_blob_entry(ce, &size);
> -		if (!new)
> -			return error("unable to read sha1 file of %s (%s)",
> -				path, oid_to_hex(&ce->oid));
> +		/*
> +		 * We do not send the blob in case of a retry, so do not
> +		 * bother reading it at all.
> +		 */
> +		if (ce_mode_s_ifmt == S_IFREG && dco && dco->state == CE_RETRY) {
> +			new = NULL;
> +			size = 0;
> +		} else {
> +			new = read_blob_entry(ce, &size);
> +			if (!new)
> +				return error("unable to read sha1 file of %s (%s)",
> +					     path, oid_to_hex(&ce->oid));
> +		}
>  
>  		if (ce_mode_s_ifmt == S_IFLNK && has_symlinks && !to_tempfile) {
>  			ret = symlink(new, path);
> @@ -279,14 +289,7 @@ static int write_entry(struct cache_entry *ce,
>  		 * Convert from git internal format to working tree format
>  		 */
>  		if (ce_mode_s_ifmt == S_IFREG) {
> -			struct delayed_checkout *dco = state->delayed_checkout;
>  			if (dco && dco->state != CE_NO_DELAY) {
> -				/* Do not send the blob in case of a retry. */
> -				if (dco->state == CE_RETRY) {
> -					free(new);
> -					new = NULL;
> -					size = 0;
> -				}
>  				ret = async_convert_to_working_tree(
>  					ce->name, new, size, &buf, dco);
>  				if (ret && string_list_has_string(&dco->paths, ce->name)) {
