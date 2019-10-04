Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE8D1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 00:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbfJDAZv (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 20:25:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60048 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730956AbfJDAZv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 20:25:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A89A94AC5;
        Thu,  3 Oct 2019 20:25:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M1xscRq2HNdiT6R1qJ4RQAE6pCo=; b=iIsbXX
        AqBTUvKo6QjuyPGGUhhZvo+ERr5O3AhMWLL1KcGaJi9qbe9GufM3GQdrQgxomZdU
        7e84fuGJTPwDwsaIT6j8vwVeKxNKfIxE3KEAe/Dulv8pQR95WnzdrNuQV6htVLhA
        AWtpE13tXpAcimCpSqFzkgL7VL+DZZXynVEzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N8aJVA2QwXB5KnEIhqih+OiR7H8mZROv
        gNPl/L+BdKi8tUeijUoVcHF6srhEsUz33SHhoOA51Xizu1wixWHMYqXdsOkL+q4v
        SD8y+1rhMEBEbJt8HnON3stHrc5hvTXvJoxFv7/Gg3l4Lsm+mseMme/ESPO7mqMP
        KK/yWrx+F9U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42DBA94AC4;
        Thu,  3 Oct 2019 20:25:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 65F2D94AC3;
        Thu,  3 Oct 2019 20:25:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, stolee@gmail.com
Subject: Re: [PATCH v4 3/4] trace2: don't overload target directories
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
        <cover.1570144820.git.steadmon@google.com>
        <98a8440d3f0ef3cd3cdd0291051d976d4a659cc4.1570144820.git.steadmon@google.com>
Date:   Fri, 04 Oct 2019 09:25:44 +0900
In-Reply-To: <98a8440d3f0ef3cd3cdd0291051d976d4a659cc4.1570144820.git.steadmon@google.com>
        (Josh Steadmon's message of "Thu, 3 Oct 2019 16:32:58 -0700")
Message-ID: <xmqq1rvt9x13.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82433118-E63D-11E9-90C5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> trace2 can write files into a target directory. With heavy usage, this
> directory can fill up with files, causing difficulty for
> trace-processing systems.

Sorry for not mentioning this, but "don't overload" is a suboptimal
keyword for the entire topic and for this particular step for a few
reasons.  For one, "overload" is an overloaded verb that gives an
incorrect impression that the problem you are dealing with is that
the target directory you specify is (mis)used for other purposes,
which is not the case.  You instead refrain from creating too many
files.  The other (which is probably more serious) is that it is
unclear what approach you chose to solve the "directory ends up
holding too many files".  One could simply discard new traces to do
so, one could concatenate to existing files to avoid creating new
files, one could even cycle the directory (i.e. path/to/log may
become path/to/log.old.1 and path/to/log is recreated as an empty
directory when it gets a new file).

    trace2: discard new traces when a target directory has too many files

or something would convey the problem you are solving (i.e. "too
many files" implying negative performance and usability impact
coming from it) and solution (i.e. "discard new traces"), if it is
the approach you have chosen.

> +	/* check sentinel */
> +	strbuf_addbuf(&sentinel_path, &path);
> +	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
> +	if (!stat(sentinel_path.buf, &statbuf)) {
> +		ret = 1;
> +		goto cleanup;
> +	}
> +
> +	/* check file count */
> +	dirp = opendir(path.buf);
> +	while (file_count < tr2env_max_files && dirp && readdir(dirp))
> +		file_count++;
> +	if (dirp)
> +		closedir(dirp);

So, until we accumulate too many files in the directory, every
process when it starts tracing will scan the output directory.
Hopefully the max is not set to too large a value.
