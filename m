Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024A81F859
	for <e@80x24.org>; Thu, 25 Aug 2016 23:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755308AbcHYXFL (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 19:05:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63765 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754176AbcHYXFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 19:05:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE0AA344FE;
        Thu, 25 Aug 2016 18:59:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W4VdzzglPBkFY8YX8H2fSol6FXc=; b=TQVRqi
        vNoE4YuKk1Ome3hOGoM95l/k09B3YvBoAyLRRmLWNHWpe3LMLRJjprUUrffPBBH9
        wYHrTV2KnGWEnmRkwolw5EmKCZE9coRlFWVmTCZ2Xcc1Xlv/UWZzl9yc6TulvqKV
        bg/MJ59yBl3Ex6AFDVtZYtpq+H2s1trLKloJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HChLSV6q6DHimX9lTGRq2Wqy1K4H5X7q
        DN5+xSO7t5ajwrtsRD1dt2bcDXEfXn2wl4xXRmXof7Hq5vsPXj7n4rxblvlDWWyz
        CtoVMu/pSYKZrZ5OiQfue1txeNxnYCSYZ0fY7j/dGva5WFNgdfzvdsSYoVOVTNBP
        aZKo52iQnuc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D73D8344FD;
        Thu, 25 Aug 2016 18:59:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5054D344FC;
        Thu, 25 Aug 2016 18:59:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/15] sequencer: lib'ify read_populate_todo()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <0de75bbce8ade0c6e5cf87d3647faa71a89c6275.1471968378.git.johannes.schindelin@gmx.de>
Date:   Thu, 25 Aug 2016 15:59:09 -0700
In-Reply-To: <0de75bbce8ade0c6e5cf87d3647faa71a89c6275.1471968378.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 23 Aug 2016 18:07:11 +0200
        (CEST)")
Message-ID: <xmqqeg5cjw02.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 894E901E-6B17-11E6-941F-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> To be truly useful, the sequencer should never die() but always return
> an error.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Instead of dying there, you let the caller high up in the callchain
to notice the error and handle it (by dying).

The only caller of read_populate_todo(), sequencer_continue() can
already return errors, so its caller must be already prepared to
handle error returns, and with this step, you make it notice an
error return from this function.  So this is a safe conversion to
make read_populate_todo() callable from new callers that want it not
to die, without changing the external behaviour of anything
existing.

Good.

By the way, I am writing these as review comments because I do not
want to keep repeating this kind of analysis as a reviewer.  I am
demonstrating what should have been in the commit log message
instead, so that the reviewer does not have to spend extra time, if
the reviewer trusts the author's diligence well enough, to see if
the conversion makes sense.

Please follow the example when/if you have to reroll.  I want the
patches to show the evidence of careful analysis to reviewers so
that they can gauge the trustworthiness of the patches.  With this
round of patches, honestly, I cannot tell if it is a mechanical
substitution alone, or such a substitution followed by a careful
verification of the callers.

> diff --git a/sequencer.c b/sequencer.c
> index a8c3a48..5f6b020 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -746,7 +746,7 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
>  	return 0;
>  }
>  
> -static void read_populate_todo(struct commit_list **todo_list,
> +static int read_populate_todo(struct commit_list **todo_list,
>  			struct replay_opts *opts)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> @@ -754,18 +754,21 @@ static void read_populate_todo(struct commit_list **todo_list,
>  
>  	fd = open(git_path_todo_file(), O_RDONLY);
>  	if (fd < 0)
> -		die_errno(_("Could not open %s"), git_path_todo_file());
> +		return error(_("Could not open %s (%s)"),
> +			git_path_todo_file(), strerror(errno));
>  	if (strbuf_read(&buf, fd, 0) < 0) {
>  		close(fd);
>  		strbuf_release(&buf);
> -		die(_("Could not read %s."), git_path_todo_file());
> +		return error(_("Could not read %s."), git_path_todo_file());
>  	}
>  	close(fd);
>  
>  	res = parse_insn_buffer(buf.buf, todo_list, opts);
>  	strbuf_release(&buf);
>  	if (res)
> -		die(_("Unusable instruction sheet: %s"), git_path_todo_file());
> +		return error(_("Unusable instruction sheet: %s"),
> +			git_path_todo_file());
> +	return 0;
>  }
>  
>  static int populate_opts_cb(const char *key, const char *value, void *data)
> @@ -1015,7 +1018,8 @@ static int sequencer_continue(struct replay_opts *opts)
>  	if (!file_exists(git_path_todo_file()))
>  		return continue_single_pick();
>  	read_populate_opts(&opts);
> -	read_populate_todo(&todo_list, opts);
> +	if (read_populate_todo(&todo_list, opts))
> +		return -1;
>  
>  	/* Verify that the conflict has been resolved */
>  	if (file_exists(git_path_cherry_pick_head()) ||
