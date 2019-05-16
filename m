Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C205F1F461
	for <e@80x24.org>; Thu, 16 May 2019 03:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEPDHT (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 23:07:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53476 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEPDHT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 23:07:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 751B871F49;
        Wed, 15 May 2019 23:07:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iorh6gLbBfJun1rWYccubGIIUNM=; b=K5edom
        mFFeBpodLGllwmoILoIm+4gql5g+x1DLB39g8xvHTcZvgccPhEBTt6TLR2H5VGd+
        jdDH7YGuVTEzBLkYlXL2egWLmlz3FXCCqHNulpX8fKCa9IQUkt2p0f9wWyD7L+lg
        6vQKXSxNUWiDFPX3XQFIHyIul0BDpM+cIIlC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=exd+4foPEm1QjyRoJ0QyKsAW2dYWaPF5
        PqO6lchUoYkxE2I9S2CdS7dPLRna2gl3IkJ3x+bb+9NR1BII1fnlZ4KwAikQi+WK
        IZWEIwoAOB2QfOnnnzMgwLnevhcpPWWg9YrYiYmvaFelSlW30DFCSfgBJRDgmKSu
        P5mgNbt1I7g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 59FBF71F48;
        Wed, 15 May 2019 23:07:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A1BA71F45;
        Wed, 15 May 2019 23:07:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, jrn@google.com
Subject: Re: [RFC PATCH] grep: provide sane default to grep_source struct
References: <20190516020023.61161-1-emilyshaffer@google.com>
Date:   Thu, 16 May 2019 12:07:12 +0900
In-Reply-To: <20190516020023.61161-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Wed, 15 May 2019 19:00:23 -0700")
Message-ID: <xmqqy3373xnj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B48FAD2E-7787-11E9-9C28-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I don't know if adding a placeholder name is the right answer (hence RFC
> patch).
>
> Jonathan Nieder proposed alternatively adding some check to grep_source()
> to ensure that if opt->status_only is unset, gs->name must be non-NULL
> (and yell about it if not), as well as some extra comments indicating
> what assumptions are made about the data coming into functions like
> grep_source(). I'm fine with that as well (although I'm not sure it

That's an interesting problem.

Currently the only use of the function is to see if the log message
matches with the given pattern (yes/no), but it is conceivable that
new callers may want to prepare in-core data and use it to see if
that matches the pattern, or even to _show_ the lines that match the
pattern (possibly with its own .output callback).  Such a caller may
even make repeated calls to the function, and want to give hint in
the output to help users identify which in-core data produced hits,
which implies that a hardcoded "(in core)" is not such a great idea.
In a future where we support such a caller, the function signature
of grep_buffer() would change to include the name, and you would be
passing that to grep_source_init().

Until that happens, it would be OK to use a hardcoded "in-core"
constant here, but to futureproof for such a future, I think it
makes sense to have a check for a BUG() suggested by jrn---that
would become useful once callers of grep_buffer() can give names
prevent them from passing NULL when it later would be used.

> makes sense semantically to require a name which the user probably can't
> easily set, or else ban the user from printing LOC during grep). Mostly
> I'm happy with any solution besides a segfault with no error logging :)
>
> Thanks in advance for everyone's thoughts.
> Emily
>
>
>  grep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/grep.c b/grep.c
> index 0d50598acd..fd84454faf 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -2045,7 +2045,7 @@ int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
>  	struct grep_source gs;
>  	int r;
>  
> -	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL, NULL);
> +	grep_source_init(&gs, GREP_SOURCE_BUF, _("(in memory)"), NULL, NULL);
>  	gs.buf = buf;
>  	gs.size = size;
