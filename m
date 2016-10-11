Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409A61F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 19:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbcJKTRu (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 15:17:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58251 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751503AbcJKTRt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 15:17:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AC4042620;
        Tue, 11 Oct 2016 15:17:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y/XUxcOx9IrVGe85Z+XuU3wW4hk=; b=tNtlwv
        s5p9hCpynb7WdmHLiyGqE+sH1S8nousxHF0AWpCqevHX5nhKdmmOBL3tEamZcCny
        sV6xDt6SjO6/dtx7P58ZaFKczu+6/RyXHgjebdSqsHNgBgnp6IInB8MVWYI37nEq
        1aOftg24Zz1j5A35R+Z+O0hD2upQ+rjkrlD7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=twqif/xdB0VYCHdyDkWgIf1/nnm1J4vL
        +YjijathXxhYQ8droSFnxMz+WIWrbXSwzBxPy5WEruCNMM9voU2lz1lokgwB08sF
        9KQl/37nQcu72J/P/HX8CajkdlwM0xLwL3nihYpdrqFCq1WNOx8dP44sqC2CjTXg
        x3H42CbXQCc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53DDB4261F;
        Tue, 11 Oct 2016 15:17:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7C504261C;
        Tue, 11 Oct 2016 15:17:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 13/25] sequencer: prepare for rebase -i's commit functionality
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <9b2782e64f678ab2d261042b63fafc3e4a519295.1476120229.git.johannes.schindelin@gmx.de>
Date:   Tue, 11 Oct 2016 12:17:45 -0700
In-Reply-To: <9b2782e64f678ab2d261042b63fafc3e4a519295.1476120229.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 10 Oct 2016 19:25:44 +0200
        (CEST)")
Message-ID: <xmqqwphe8zl2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6521C5D6-8FE7-11E6-A914-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -370,19 +383,79 @@ static int is_index_unchanged(void)
>  }
>  
>  /*
> + * Read the author-script file into an environment block, ready for use in
> + * run_command(), that can be free()d afterwards.
> + */
> +static char **read_author_script(void)
> +{
> +	struct strbuf script = STRBUF_INIT;
> +	int i, count = 0;
> +	char *p, *p2, **env;
> +	size_t env_size;
> +
> +	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
> +		return NULL;
> +
> +	for (p = script.buf; *p; p++)
> +		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
> +			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
> +		else if (*p == '\'')
> +			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
> +		else if (*p == '\n') {
> +			*p = '\0';
> +			count++;
> +		}

Hmph, didn't we recently add parse_key_value_squoted() to build
read_author_script() in builtin/am.c on top of it, so that this
piece of code can also take advantage of and share the parser?

> +/*

Offtopic: this line and the beginning of the new comment block that
begins with "Read the author-script" above show a suboptimal marking
of what is added and what is left.  I wonder "diff-indent-heuristic"
topic by Michael can help to make it look better.

>   * If we are cherry-pick, and if the merge did not result in
>   * hand-editing, we will hit this commit and inherit the original
>   * author date and name.
> + *
>   * If we are revert, or if our cherry-pick results in a hand merge,
>   * we had better say that the current user is responsible for that.
> + *
> + * An exception is when run_git_commit() is called during an
> + * interactive rebase: in that case, we will want to retain the
> + * author metadata.
>   */
