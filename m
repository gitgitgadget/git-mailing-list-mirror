Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6AB1FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 19:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758312AbcLPTiy (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:38:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57388 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754199AbcLPTiw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:38:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F18B56265;
        Fri, 16 Dec 2016 14:38:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QwtPAX2JWtVFPnaj2/K8wYPe9j4=; b=QSag4z
        A165DmAoGG1tfdAD2AgQpzgfxFb9YGq/WYND3I5yr/R3kb4A6x5r90V7r9BABsgh
        Ngm4kQjrxUFqmQnDD0bzJJrnlg4X8q6xuaoIZeu4UOb7qyYiDjIvlGjHgpauSoLv
        1YQ1j5gmmdKwH9rZoNpIrEphxjkESouMK61W4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DOhqjMH2EyAIOppU8cNGi22IZwu+zGsY
        DFqmmXBWDsmGJE8HYyiNTD3szoFmXPoIZLT9VsyOo+VunaulVbJ8ZqFf+oVpZnlu
        gogh+zA9azbf37xlHSqfxPgBtelYMfWT5cYl+3Z6lCH6rIBkYKz9rvOQHvF2/P4y
        SOSjPvyLmf0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1866C56263;
        Fri, 16 Dec 2016 14:38:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B3AB56261;
        Fri, 16 Dec 2016 14:38:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 20/34] sequencer (rebase -i): copy commit notes at end
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <a2ea8bd57461fe0969f3df09a0374005f12ac6c7.1481642927.git.johannes.schindelin@gmx.de>
Date:   Fri, 16 Dec 2016 11:38:50 -0800
In-Reply-To: <a2ea8bd57461fe0969f3df09a0374005f12ac6c7.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:31:29 +0100
        (CET)")
Message-ID: <xmqqvaujr7ed.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45A72D7C-C3C7-11E6-A32B-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +static void flush_rewritten_pending(void) {
> +	struct strbuf buf = STRBUF_INIT;
> +	unsigned char newsha1[20];
> +	FILE *out;
> +
> +	if (strbuf_read_file(&buf, rebase_path_rewritten_pending(), 82) > 0 &&
> +			!get_sha1("HEAD", newsha1) &&
> +			(out = fopen(rebase_path_rewritten_list(), "a"))) {

An error in fopen() here ...

> + ...
> +	}
> +	strbuf_release(&buf);
> +}
> +
> +static void record_in_rewritten(struct object_id *oid,
> +		enum todo_command next_command) {
> +	FILE *out = fopen(rebase_path_rewritten_pending(), "a");
> +
> +	if (!out)
> +		return;

... and here are ignored as an insignificant error in the scripted
version, and this one does the same.  

> +
> +	fprintf(out, "%s\n", oid_to_hex(oid));
> +	fclose(out);
> +
> +	if (!is_fixup(next_command))
> +		flush_rewritten_pending();
> +}
> +
>  static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		struct replay_opts *opts, int final_fixup)
>  {
> @@ -1750,6 +1797,17 @@ static int is_final_fixup(struct todo_list *todo_list)
>  	return 1;
>  }
>  
> +static enum todo_command peek_command(struct todo_list *todo_list, int offset)
> +{
> +	int i;
> +
> +	for (i = todo_list->current + offset; i < todo_list->nr; i++)
> +		if (todo_list->items[i].command != TODO_NOOP)
> +			return todo_list->items[i].command;

Makes me wonder, after having commented on 07/34 regarding the fact
that in the end you would end up having three variants of no-op
(i.e. NOOP, DROP and COMMENT), what definition of a "command" this
function uses to return its result, when asked to "peek".  I suspect
that this will be updated in a later patch to do "< TODO_NOOP"
instead?  If so, then that answers one question in my comment on
07/34, i.e.

    If a check for "is it one of the no-op commands?" appears only
    here, a single liner comment may be sufficient (but necessary)
    to help readers.  Otherwise a single-liner helper function
    (similar to is_fixup() you have) with a descriptive name would
    be better than a single liner comment.

The answer is "no, it is not just there" hence the conclusion is "we
want a helper with a descriptive name".
