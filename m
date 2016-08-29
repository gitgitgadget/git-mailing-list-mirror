Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB0C61FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 20:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbcH2Uq4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 16:46:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57057 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751950AbcH2Uqz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 16:46:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC81A378C9;
        Mon, 29 Aug 2016 16:46:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3t+Re5XrV5PZmqCE1c0tlOBdWmA=; b=ccjnOf
        sR71Pl16mGXDshDAvYYdpTrXTX7qYfDXxcpKJrsnwmMmVAGVhJmSlc+5h23AvQLP
        hKfbAVf/j28v0TKp2sPx4BQkwQkKqu0sTdymZKD2khFzsF41/D/NYI2T8c5Y2YwF
        vm1fmckRGAi3zBJ4zK2aIbaxEyOdVIgGZXJpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QQKa/Wtfq5uzmhjHmSOLX9R9UvaC6LyQ
        VWpwggTBAp+ZsdyUaTWj9dXPaehNfWzAOvMe9Qz/Z5PzWR34e/oHYo8wZ+teVv0F
        YJeCdkVZZ4pIjQclyYmxiz8CC6wl+boFMd4RU+QKW9cQhi5OskkwM3PpZ8sqydnf
        o2fZBINo4fs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C52F6378C8;
        Mon, 29 Aug 2016 16:46:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E96D378C6;
        Mon, 29 Aug 2016 16:46:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 10/14] sequencer: lib'ify read_populate_opts()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <cover.1472219214.git.johannes.schindelin@gmx.de>
        <0fde7522953f71bd07e6aa7a15081dbf069aa6b6.1472219214.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 Aug 2016 13:46:51 -0700
In-Reply-To: <0fde7522953f71bd07e6aa7a15081dbf069aa6b6.1472219214.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 26 Aug 2016 15:47:56 +0200
        (CEST)")
Message-ID: <xmqq37ln9ubo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B78A0D9A-6E29-11E6-A27C-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Instead of dying there, let the caller high up in the callchain notice
> the error and handle it (by dying, still).
>
> The only caller of read_populate_opts(), sequencer_continue() can
> already return errors, so its caller must be already prepared to
> handle error returns, and with this step, we make it notice an error
> return from this function.
>
> So this is a safe conversion to make read_populate_opts() callable
> from new callers that want it not to die, without changing the
> external behaviour of anything existing.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index e11b24f..be6020a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -808,12 +808,14 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  	return 0;
>  }
>  
> -static void read_populate_opts(struct replay_opts **opts_ptr)
> +static int read_populate_opts(struct replay_opts **opts)
>  {
>  	if (!file_exists(git_path_opts_file()))
> -		return;
> -	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts_ptr) < 0)
> -		die(_("Malformed options sheet: %s"), git_path_opts_file());
> +		return 0;
> +	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
> +		return error(_("Malformed options sheet: %s"),
> +			git_path_opts_file());
> +	return 0;

As discussed, perhaps have a comment immediately before calling
config-from-file that says that the call could die when it is fed a
syntactically broken file, but we ignore it for now because we will
be writing the file we have written, or something?

>  }
>  
>  static int walk_revs_populate_todo(struct commit_list **todo_list,
> @@ -1021,8 +1023,8 @@ static int sequencer_continue(struct replay_opts *opts)
>  
>  	if (!file_exists(git_path_todo_file()))
>  		return continue_single_pick();
> -	read_populate_opts(&opts);
> -	if (read_populate_todo(&todo_list, opts))
> +	if (read_populate_opts(&opts) ||
> +			read_populate_todo(&todo_list, opts))
>  		return -1;
>  
>  	/* Verify that the conflict has been resolved */
