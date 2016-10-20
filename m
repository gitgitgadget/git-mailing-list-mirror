Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EE7E1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 20:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbcJTUGY (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 16:06:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64716 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752387AbcJTUGX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 16:06:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C35748EF8;
        Thu, 20 Oct 2016 16:06:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qh6h3YDdOahmsRjyp79FcimBJ9U=; b=BB7ggI
        QAoKwYdGewvY3jDX2u0pccEbb9wBGHkhcw4PoT41w47zukU+rLw8mfGqdREspRDv
        nu+pJzzO21nvJtV0i6sJS4ceurLjurqYTwkmTr8B0uq+JBMaV/Th21/POj9vwLha
        l08jKI5sPK12bhEOcpuzLfxP03xXnePjXtDcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V7EWWJSTNlpHaZXHdWra156RU1XldOsn
        TidiB148Fc9wO5b35Bab90/c52ld9eN3bfqIJRVR0jBzjJXcNai4/oJcAVfr9D29
        PKk1lsiE6Ex2bR8eAfO6XrYjmVMJKV1vALWBiNzUzo1fwmpaCBHJa9krtzUjCpLQ
        URhluOdnZE0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14D6F48EF7;
        Thu, 20 Oct 2016 16:06:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E79748EF3;
        Thu, 20 Oct 2016 16:06:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 17/25] sequencer: support cleaning up commit messages
References: <cover.1476120229.git.johannes.schindelin@gmx.de>
        <cover.1476450940.git.johannes.schindelin@gmx.de>
        <4173eb7716e8f4fbd083961a05dc4329686a9912.1476450940.git.johannes.schindelin@gmx.de>
Date:   Thu, 20 Oct 2016 13:06:19 -0700
In-Reply-To: <4173eb7716e8f4fbd083961a05dc4329686a9912.1476450940.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 14 Oct 2016 15:18:28 +0200
        (CEST)")
Message-ID: <xmqqr37ag4zo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB979FCA-9700-11E6-BE52-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The run_git_commit() function already knows how to amend commits, and
> with this new option, it can also clean up commit messages (i.e. strip
> out commented lines). This is needed to implement rebase -i's 'fixup'
> and 'squash' commands as sequencer commands.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index fa77c82..cbc3742 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -481,7 +481,8 @@ static char **read_author_script(void)
>   * author metadata.
>   */
>  static int run_git_commit(const char *defmsg, struct replay_opts *opts,
> -			  int allow_empty, int edit, int amend)
> +			  int allow_empty, int edit, int amend,
> +			  int cleanup_commit_message)
>  {
>  	char **env = NULL;
>  	struct argv_array array;

Looks OK to me.  

This starts to look like calling for a single flag word even more,
but it is a file-local helper so we can clean it up if it becomes
necessary without affecting too many things later.

> @@ -518,9 +519,12 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  		argv_array_push(&array, "-s");
>  	if (defmsg)
>  		argv_array_pushl(&array, "-F", defmsg, NULL);
> +	if (cleanup_commit_message)
> +		argv_array_push(&array, "--cleanup=strip");
>  	if (edit)
>  		argv_array_push(&array, "-e");
> -	else if (!opts->signoff && !opts->record_origin &&
> +	else if (!cleanup_commit_message &&
> +		 !opts->signoff && !opts->record_origin &&
>  		 git_config_get_value("commit.cleanup", &value))
>  		argv_array_push(&array, "--cleanup=verbatim");
>  
> @@ -785,7 +789,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	}
>  	if (!opts->no_commit)
>  		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
> -				     opts, allow, opts->edit, 0);
> +				     opts, allow, opts->edit, 0, 0);
>  
>  leave:
>  	free_message(commit, &msg);
