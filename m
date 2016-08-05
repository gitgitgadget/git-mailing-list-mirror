Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1D52018E
	for <e@80x24.org>; Fri,  5 Aug 2016 17:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760039AbcHERBN (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 13:01:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759851AbcHERBL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 13:01:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F8B72F8B9;
	Fri,  5 Aug 2016 13:01:09 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hz7An9YAjxe/Wolx60Md4RSuvlA=; b=WxgI8Q
	4CEcoTmxy6xzPH53Ge4kACGy1+2DAnxIp2/H+yu7fkAsJhG7JVjBl7V9Qz+qV4i7
	zU2OmRWve9LBMfSX/k9CLPyo9rJcrwohrlFHG1WirUxyL0HoqxULgPn8V3ucWfgw
	8DQcGC+1ZYLF0lg2HUy+YvyOhyIC1SnK8qpac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YTyvzjUw0HSF48WxwEryun43eiizYTHp
	qepfoDlrvcE7cG/4yXYt8KasMCweE+tmXMEiStcGLXubZOWtZLlUcMNtOejRRuCu
	gyznJZNyd1C/Anm0eCFWbfhbEGJhn6omZuNNq8ryC/3HAePtz8y9OmS0sVpmcHjl
	/2uYOkzg+Vg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 636572F8B8;
	Fri,  5 Aug 2016 13:01:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD7DF2F8B6;
	Fri,  5 Aug 2016 13:01:08 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 6/8] status: print branch info with --porcelain=v2 --branch
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
	<1470147137-17498-7-git-send-email-git@jeffhostetler.com>
Date:	Fri, 05 Aug 2016 10:01:06 -0700
In-Reply-To: <1470147137-17498-7-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Tue, 2 Aug 2016 10:12:15 -0400")
Message-ID: <xmqqd1lnxi99.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 347C1D5C-5B2E-11E6-A59B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>  /*
> + * Print branch information for porcelain v2 output.  These lines
> + * are printed when the '--branch' parameter is given.
> + *
> + *    # branch.oid <commit><eol>
> + *    # branch.head <head><eol>

Just bikeshedding, but ...

> +	if (!s->branch)
> +		fprintf(s->fp, "# branch.head %s%c", "(unknown)", eol);
> +	else {
> +		if (!strcmp(s->branch, "HEAD")) {
> +			fprintf(s->fp, "# branch.head %s%c", "(detached)", eol);
> +
> +			if (state.rebase_in_progress || state.rebase_interactive_in_progress)
> +				branch_name = state.onto;
> +			else if (state.detached_from)
> +				branch_name = state.detached_from;
> +			else
> +				branch_name = "";
> +		} else {
> +			branch_name = NULL;
> +			skip_prefix(s->branch, "refs/heads/", &branch_name);
> +
> +			fprintf(s->fp, "# branch.head %s%c", branch_name, eol);

... given that we are showing branch name, perhaps "branch.name"
instead of "branch.head" is more appropriate?

I wondered if "# " prefix before these lines is useful, by the way,
and initially thought that the fact that these lines begin with
"branch." and not with the "1/2/u $key" sufficient clue for whoever
reads them, but the reader can tell which kind of record it is by
reading the first two characters of each line (i.e. if "# " that is
not the usual "change info for a single file"), so it is actually a
good idea.

Thanks.
