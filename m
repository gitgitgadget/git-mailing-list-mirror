Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AE41FA21
	for <e@80x24.org>; Sat,  7 Oct 2017 09:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbdJGJyy (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 05:54:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53978 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751759AbdJGJyx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 05:54:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 129F9B6A89;
        Sat,  7 Oct 2017 05:54:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zgdH52zvP4amaPqCpGAoCFd/i4M=; b=sXFmg8
        cy48Lttq3bIsvWKap7gEZU0pKHtXKUVPZt/X/6IM7JKlZwi1mDIlb/+lm3RXLsXn
        fqhEZ/ow83NRjv0Lk3Ov/k7/UMGXlpbXEir5mrGtwHdwR/kVAAxcNNrhCWCTsUSJ
        5lq2BiW+mNIvET43WfnKpGfkUlfJSiedPWkWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DySep16tazfPwj9ejTjL1KW9yKPbwSnc
        8Omu07u9xCstPazKymVWCa+t72mKInQEfhjuIh3D37h/uzltNKJdgtpwCkK0jVlK
        tfg/T8MmgSBkW41d3vbEA2PTQGWGybrCG4H8o9xkNJVvSa718E1a0tccMbNAsmK9
        ahgESNJPWwQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDD86B6A88;
        Sat,  7 Oct 2017 05:54:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 277ABB6A87;
        Sat,  7 Oct 2017 05:54:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 2/8] commit: move code to update HEAD to libgit
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20170925101041.18344-3-phillip.wood@talktalk.net>
Date:   Sat, 07 Oct 2017 18:54:49 +0900
In-Reply-To: <20170925101041.18344-3-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Mon, 25 Sep 2017 11:10:35 +0100")
Message-ID: <xmqqo9pjth92.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FCD1374-AB45-11E7-AC37-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

This seems to do a lot more than just moving code, most notably, it
uses setenv() to affect what happens in any subprocesses we may
spawn, and it is unclear if it was verified that this patch is free
of unwanted consequences due to that change (and any others I may
have missed while reading this patch, if any).

I suspect that it would be sufficient to make update_head() helper
function take the reflog action message as another parameter
instead to fix the above, but there may be other reasons why you
chose to do it this way---I cannot read it in your empty log
message, though.

I will not give line-by-line style nitpick but in general we do not
leave a SP between function name and the open parenthesis that
starts its argument list.  New code in this patch seems to use
mixture of styles.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0b8c1ef6f57cfed328d12255e6834adb4bda4137..497778ba2c02afdd4a337969a27ca781e8389040 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1578,13 +1578,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	struct strbuf sb = STRBUF_INIT;
>  	struct strbuf author_ident = STRBUF_INIT;
>  	const char *index_file, *reflog_msg;
> -	char *nl;
>  	struct object_id oid;
>  	struct commit_list *parents = NULL;
>  	struct stat statbuf;
>  	struct commit *current_head = NULL;
>  	struct commit_extra_header *extra = NULL;
> -	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
>  
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
> @@ -1625,10 +1623,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	reflog_msg = getenv("GIT_REFLOG_ACTION");
>  	if (!current_head) {
>  		if (!reflog_msg)
> -			reflog_msg = "commit (initial)";
> +			setenv ("GIT_REFLOG_ACTION", "commit (initial)", 1);
>  	} else if (amend) {
>  		if (!reflog_msg)
> -			reflog_msg = "commit (amend)";
> +			setenv("GIT_REFLOG_ACTION", "commit (amend)", 1);
>  		parents = copy_commit_list(current_head->parents);
>  	} else if (whence == FROM_MERGE) {
>  		struct strbuf m = STRBUF_INIT;
> @@ -1637,7 +1635,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		struct commit_list **pptr = &parents;
>  
>  		if (!reflog_msg)
> -			reflog_msg = "commit (merge)";
> +			setenv("GIT_REFLOG_ACTION", "commit (merge)", 1);
>  		pptr = commit_list_append(current_head, pptr);
>  		fp = xfopen(git_path_merge_head(), "r");
>  		while (strbuf_getline_lf(&m, fp) != EOF) {
> @@ -1660,9 +1658,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  			parents = reduce_heads(parents);
>  	} else {
>  		if (!reflog_msg)
> -			reflog_msg = (whence == FROM_CHERRY_PICK)
> -					? "commit (cherry-pick)"
> -					: "commit";
> +			setenv("GIT_REFLOG_ACTION", (whence == FROM_CHERRY_PICK)
> +						? "commit (cherry-pick)"
> +						: "commit", 1);
>  		commit_list_insert(current_head, &parents);
>  	}
>  
> @@ -1707,25 +1705,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
> -
> -	transaction = ref_transaction_begin(&err);
> -	if (!transaction ||
> -	    ref_transaction_update(transaction, "HEAD", oid.hash,
> -				   current_head
> -				   ? current_head->object.oid.hash : null_sha1,
> -				   0, sb.buf, &err) ||
> -	    ref_transaction_commit(transaction, &err)) {
> +	if (update_head (current_head, &oid, &sb, &err)) {
>  		rollback_index_files();
>  		die("%s", err.buf);
>  	}
> -	ref_transaction_free(transaction);
>  
>  	unlink(git_path_cherry_pick_head());
>  	unlink(git_path_revert_head());
> diff --git a/sequencer.c b/sequencer.c
> index 319208afb3de36c97b6c62d4ecf6e641245e7a54..917ad4a16216b30adb2c2c9650217926d8db8ba7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1,10 +1,10 @@
>  #include "cache.h"
>  #include "config.h"
>  #include "lockfile.h"
> -#include "sequencer.h"
>  #include "dir.h"
>  #include "object.h"
>  #include "commit.h"
> +#include "sequencer.h"
>  #include "tag.h"
>  #include "run-command.h"
>  #include "exec_cmd.h"
> @@ -750,6 +750,43 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
>  	return rest_is_empty(sb, start - sb->buf);
>  }
>  
> +int update_head(const struct commit *old_head, const struct object_id *new_head,
> +		const struct strbuf *msg, struct strbuf *err)
> +{
> +	struct ref_transaction *transaction;
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *nl, *reflog_msg;
> +	int ret = 0;
> +
> +	reflog_msg = getenv("GIT_REFLOG_ACTION");
> +	if (!reflog_msg)
> +		reflog_msg="";
> +
> +	nl = strchr(msg->buf, '\n');
> +	if (nl) {
> +		strbuf_add(&sb, msg->buf, nl + 1 - msg->buf);
> +	} else {
> +		strbuf_addbuf(&sb, msg);
> +		strbuf_addch(&sb, '\n');
> +	}
> +	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
> +	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
> +
> +	transaction = ref_transaction_begin(err);
> +	if (!transaction ||
> +	    ref_transaction_update(transaction, "HEAD", new_head->hash,
> +				   old_head
> +				   ? old_head->object.oid.hash : null_sha1,
> +				   0, sb.buf, err) ||
> +	    ref_transaction_commit(transaction, err)) {
> +		ret = -1;
> +	}
> +	ref_transaction_free(transaction);
> +	strbuf_release(&sb);
> +
> +	return ret;
> +}
> +
>  static int is_original_commit_empty(struct commit *commit)
>  {
>  	const struct object_id *ptree_oid;
> diff --git a/sequencer.h b/sequencer.h
> index dd071cfcd82d165bd23726814b74cbf3384e1a17..87edf40e5274d59f48d5af57678100ea220d2c8a 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -60,4 +60,6 @@ enum cleanup_mode {
>  int message_is_empty(const struct strbuf *sb, enum cleanup_mode cleanup_mode);
>  int template_untouched(const struct strbuf *sb, const char *template_file,
>  		       enum cleanup_mode cleanup_mode);
> +int update_head(const struct commit *old_head, const struct object_id *new_head,
> +		const struct strbuf *msg, struct strbuf *err);
>  #endif
