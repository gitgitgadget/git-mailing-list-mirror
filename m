Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2542320A10
	for <e@80x24.org>; Tue,  7 Nov 2017 02:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753930AbdKGC41 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 21:56:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56354 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750941AbdKGC40 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 21:56:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F22C0A6967;
        Mon,  6 Nov 2017 21:56:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EQ40Y6eBeHmWBZDqJHH8+ILPgVc=; b=xtbzOn
        cyRk20+PWi0Q5YJgyDq9nnPENA00lkcPfqJZBPhCM4R4ptE2wju6E8GHUTpo+LGH
        egXfzjDXYNh4MeDNejAO/oWChMtz+L2LVbNIWzCDwq719E/dI+dJBpV4Awco5mCM
        LpqyO+rIbWdQ1bS4TJnJUvKAl517dZ72gqniQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DwSE2+5KYq5Pz8+3Uh2/T97dqhuvxV+L
        jk3cV7yea9x1G22HA2VdpiofM3/pCHVHcSObUEv1Dt4AfJWnDgeU+XcK3OsUcKrg
        h8s7jqjC9SwUIDWeE4YUiFM278Ammfx0uBEhvZMu8zgm0Lne2mD59ckajW57nlfq
        luD8CW1L8oY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EAA04A6966;
        Mon,  6 Nov 2017 21:56:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C67CA6965;
        Mon,  6 Nov 2017 21:56:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 2/8] Add a function to update HEAD after creating a commit
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171106112709.2121-1-phillip.wood@talktalk.net>
        <20171106112709.2121-3-phillip.wood@talktalk.net>
Date:   Tue, 07 Nov 2017 11:56:23 +0900
In-Reply-To: <20171106112709.2121-3-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Mon, 6 Nov 2017 11:27:03 +0000")
Message-ID: <xmqqtvy6g5k8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DD623AA-C367-11E7-AFC5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> @@ -1735,25 +1733,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	strbuf_release(&author_ident);
>  	free_commit_extra_headers(extra);
>  
> -	nl = strchr(sb.buf, '\n');
> -	if (nl)
> -		strbuf_setlen(&sb, nl + 1 - sb.buf);
> -	else
> -		strbuf_addch(&sb, '\n');
> -	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
> -	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);

The old code treated sb (which has the log message we gave to
commit_tree_extended() to create the commit) as expendable at this
point and (1) truncated it to the title line, and (2) prepended the
reflog action prefix, so that it can pass it to the ref transaction
code to use it as the reflog message.

Which was quite ugly X-<.

> -	transaction = ref_transaction_begin(&err);
> -	if (!transaction ||
> -	    ref_transaction_update(transaction, "HEAD", &oid,
> -				   current_head
> -				   ? &current_head->object.oid : &null_oid,
> -				   0, sb.buf, &err) ||
> -	    ref_transaction_commit(transaction, &err)) {
> +	if (update_head(current_head, &oid, reflog_msg, &sb, &err)) {
>  		rollback_index_files();
>  		die("%s", err.buf);
>  	}

> @@ -751,6 +751,42 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
>  	return rest_is_empty(sb, start - sb->buf);
>  }
>  
> +int update_head(const struct commit *old_head, const struct object_id *new_head,
> +		const char *action, const struct strbuf *msg,
> +		struct strbuf *err)
> +{
> +	struct ref_transaction *transaction;
> +	struct strbuf sb = STRBUF_INIT;

It no longer is necessary to call this variable "sb"; the original
had a single instance of strbuf that was reused for different
purposes and could not give it a more specific name, but we can
afford to call this one reflog_message or something.

> +	const char *nl;
> +	int ret = 0;
> +
> +	if (action) {
> +		strbuf_addstr(&sb, action);
> +		strbuf_addstr(&sb, ": ");
> +	}
> +
> +	nl = strchr(msg->buf, '\n');
> +	if (nl) {
> +		strbuf_add(&sb, msg->buf, nl + 1 - msg->buf);
> +	} else {
> +		strbuf_addbuf(&sb, msg);
> +		strbuf_addch(&sb, '\n');
> +	}

The updated code is a lot more natural and straight-forward.  I
quite like it.

I however do not think update_head() is such a good name for a
helper function in the global scope.  builtin/clone.c has a static
one that has quite different semantics with the same name (I am not
saying that builtin/clone.c will in the future start including the
sequencer.h header file; I am pointing out that update_head() is not
a good global name that will be understood by everybody).

> diff --git a/sequencer.h b/sequencer.h
> index 65a4b0c25185d7ad5115035abb766d1b95df9a62..1db06caea35bed556dfaabca1c6be8a80857ed5e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -68,4 +68,7 @@ enum cleanup_mode {
>  int message_is_empty(const struct strbuf *sb, enum cleanup_mode cleanup_mode);
>  int template_untouched(const struct strbuf *sb, const char *template_file,
>  		       enum cleanup_mode cleanup_mode);
> +int update_head(const struct commit *old_head, const struct object_id *new_head,
> +		const char* action, const struct strbuf *msg,
> +		struct strbuf *err);
>  #endif
