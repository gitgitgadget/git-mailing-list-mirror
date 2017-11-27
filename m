Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EDF620A40
	for <e@80x24.org>; Mon, 27 Nov 2017 05:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbdK0FOo (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 00:14:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55390 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751197AbdK0FOn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 00:14:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84223BC3C0;
        Mon, 27 Nov 2017 00:14:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y+927m7FmjAknAfQFhnUvfSsiTs=; b=haZxDW
        9j8K5fn/MGgmXou9IM00q3DSRchTSvRLjWtosAUBaZ2rFS1b/SKoW6Qu1AggkJB3
        3yB9X8cgNS6tqxBFMnkTMIuIUzsW5gaslnorDVcL9XY51aQji4oc3xqPN0sRRFdR
        yFIza5la3S8CudP8+6yVRra9mGXQG0UpKHRTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fgd3n+tVbZ8Irrlz0FtmS6eyjRKXTrPI
        xqeFuusH9xdvaRzazdjweeRdlJy802KaSKBTzTWet9I+yaRtdBbQMdQTkgOBYHYV
        uIa+2t+Md3LU5+vC0NKReDOVt9kiT5xpUB2gOjMPTBt9QlKlUcVKaK90MXm1/WtL
        0ByzKYpdyWo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BF9BBC3BF;
        Mon, 27 Nov 2017 00:14:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F4125BC3BE;
        Mon, 27 Nov 2017 00:14:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com
Subject: Re: [PATCH 3/5] rebase -i: add exec commands via the rebase--helper
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171127045514.25647-4-liambeguin@gmail.com>
Date:   Mon, 27 Nov 2017 14:14:40 +0900
In-Reply-To: <20171127045514.25647-4-liambeguin@gmail.com> (Liam Beguin's
        message of "Sun, 26 Nov 2017 23:55:12 -0500")
Message-ID: <xmqq609we20v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFD3C41C-D331-11E7-92BC-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Liam Beguin <liambeguin@gmail.com> writes:

> diff --git a/sequencer.c b/sequencer.c
> index fa94ed652d2c..810b7850748e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2492,6 +2492,52 @@ int sequencer_make_script(int keep_empty, FILE *out,
>  	return 0;
>  }
>  
> +int add_exec_commands(const char *command)
> +{

As the name of a public function, it does not feel that this hints
it strongly enough that it is from and a part of sequencer.c API.

> +	const char *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	int fd, res, i, first = 1;
> +	FILE *out;

Having had to scan backwards while trying to see what the loop that
uses this variable is doing and if it gets affected by things that
happened before we entered the loop, I'd rather not to see 'first'
initialized here, left unused for quite some time until the loop is
entered.  It would make it a lot easier to follow if it is declared
and left uninitilized here, and set to 1 immediately before the
for() loop that uses it.

> +
> +	strbuf_reset(&todo_list.buf);
> +	fd = open(todo_file, O_RDONLY);
> +	if (fd < 0)
> +		return error_errno(_("could not open '%s'"), todo_file);
> +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> +		close(fd);
> +		return error(_("could not read '%s'."), todo_file);
> +	}
> +	close(fd);

Is this strbuf_read_file() written in longhand?

> +	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
> +	if (res) {
> +		todo_list_release(&todo_list);
> +		return error(_("unusable todo list: '%s'"), todo_file);
> +	}
> +
> +	out = fopen(todo_file, "w");
> +	if (!out) {
> +		todo_list_release(&todo_list);
> +		return error(_("unable to open '%s' for writing"), todo_file);
> +	}
> +	for (i = 0; i < todo_list.nr; i++) {
> +		struct todo_item *item = todo_list.items + i;
> +		int bol = item->offset_in_buf;
> +		const char *p = todo_list.buf.buf + bol;
> +		int eol = i + 1 < todo_list.nr ?
> +			todo_list.items[i + 1].offset_in_buf :
> +			todo_list.buf.len;

Should bol and eol be of type size_t instead?  The values that get
assigned to them from other structures are.
