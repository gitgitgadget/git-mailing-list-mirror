Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A5D209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 21:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbcLMVl6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 16:41:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63452 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753651AbcLMVl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 16:41:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66F3556CC1;
        Tue, 13 Dec 2016 16:35:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dQc8iUDAoHHzn7Opu6n6vcuKEzE=; b=DEBvqs
        D8u9i6+0Yntu6ZbRx77gg1p4oQo+GEB0V1ZhQ4d22tKur85CUy4K2mlexeKFyfKy
        EL2Ajg55l+U2QqJchYireYYQBkPQLjibv0HencRTRPis7XfvcbSRtYOdVb8zI++I
        raZcHycke6AVAfdjIKqWjJh7kG0ZZAo7B9Tys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VYR0AU4BS2E1Q9JnN0DpcYcLahbpvSXA
        aIWm6vyh9mpxYwG/ltgibNl6/Y5rKjgpvdNnPq88a62g9zOrsxKXrS0QUH6+mD7S
        mAGT0/A3HXtY5FebAxk2SaeadxMze3bmqkk6klBaKP6lzgJ8gHuHFQCym8V2rT75
        cAjlLRXeuuM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E83156CC0;
        Tue, 13 Dec 2016 16:35:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C998B56CBF;
        Tue, 13 Dec 2016 16:35:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 04/34] sequencer (rebase -i): implement the 'exec' command
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <54d4e8d3673662d1ec806f3f4a779a17effbdaf2.1481642927.git.johannes.schindelin@gmx.de>
Date:   Tue, 13 Dec 2016 13:35:07 -0800
In-Reply-To: <54d4e8d3673662d1ec806f3f4a779a17effbdaf2.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:29:49 +0100
        (CET)")
Message-ID: <xmqq7f731pis.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 052E8418-C17C-11E6-9AE9-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +static int do_exec(const char *command_line)
> +{
> +	const char *child_argv[] = { NULL, NULL };
> +	int dirty, status;
> +
> +	fprintf(stderr, "Executing: %s\n", command_line);
> +	child_argv[0] = command_line;
> +	status = run_command_v_opt(child_argv, RUN_USING_SHELL);
> +
> +	/* force re-reading of the cache */
> +	if (discard_cache() < 0 || read_cache() < 0)
> +		return error(_("could not read index"));
> +
> +	dirty = require_clean_work_tree("rebase", NULL, 1, 1);
> +
> +	if (status) {
> +		warning(_("execution failed: %s\n%s"
> +			  "You can fix the problem, and then run\n"
> +			  "\n"
> +			  "  git rebase --continue\n"
> +			  "\n"),
> +			command_line,
> +			dirty ? N_("and made changes to the index and/or the "
> +				"working tree\n") : "");
> +		if (status == 127)
> +			/* command not found */
> +			status = 1;
> +	}
> +	else if (dirty) {
> +		warning(_("execution succeeded: %s\nbut "
> +			  "left changes to the index and/or the working tree\n"
> +			  "Commit or stash your changes, and then run\n"
> +			  "\n"
> +			  "  git rebase --continue\n"
> +			  "\n"), command_line);
> +		status = 1;
> +	}
> +
> +	return status;
> +}

OK, this looks like a faithful reproduction of what the scripted
version does inside do_next() helper function.

Please have "else if" on the same line as "}" that closes the
"if (...) {" in the same if/else if/else cascade.
