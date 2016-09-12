Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00BC9207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 21:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbcILVgq (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 17:36:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64617 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755872AbcILVgk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 17:36:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60E573EA42;
        Mon, 12 Sep 2016 17:36:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eeZHIDPsVB+GshNW0UaNnTllrCc=; b=jbfnJW
        BTQSG1K5sq6SIMPSwDl98Ak/Sz4jLYEU1kigrf7njUu6ZkBDywYe82BGMCiiJUnG
        HgWQxxivF/KSqsQRw/rfS3Vm9l8cKHt7QpYWqqSx0G7af2vbqCzq6e9bcwn6f/W3
        4rU4WXs31umFuu3NglbybpqHcusPpUKYUauK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LiWUzdXCR8B8Qy3MtdIv+ycGqHbUJpE6
        63Gp56aIKIiAfgPhSY2zzAflVsR3/sRDYA6MlmBzwS9lU/hrDxqzvR29qO8Y6rur
        FQa7cHXMWX8Rml7NdrDdwt6A/Jcg/yZI/tinOx7LsVoA+DU2dJr/YB4EsjZe+KsV
        1GjV1UBM3XI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59A413EA41;
        Mon, 12 Sep 2016 17:36:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6E813EA40;
        Mon, 12 Sep 2016 17:36:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 17/25] sequencer: support amending commits
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <68f995eaaad2448f5793f0030f96aa501b985ed5.1473590966.git.johannes.schindelin@gmx.de>
Date:   Mon, 12 Sep 2016 14:36:30 -0700
In-Reply-To: <68f995eaaad2448f5793f0030f96aa501b985ed5.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:55:02 +0200
        (CEST)")
Message-ID: <xmqq8tuwztpd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F946C87E-7930-11E6-A4BC-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This teaches the sequencer_commit() function to take an argument that
> will allow us to implement "todo" commands that need to amend the commit
> messages ("fixup", "squash" and "reword").
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 6 ++++--
>  sequencer.h | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 6e9732c..60b522e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -485,7 +485,7 @@ static char **read_author_script(void)
>   * author metadata.
>   */
>  int sequencer_commit(const char *defmsg, struct replay_opts *opts,
> -			  int allow_empty, int edit)
> +			  int allow_empty, int edit, int amend)
>  {
>  	char **env = NULL;
>  	struct argv_array array;
> @@ -514,6 +514,8 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
>  	argv_array_push(&array, "commit");
>  	argv_array_push(&array, "-n");
>  
> +	if (amend)
> +		argv_array_push(&array, "--amend");
>  	if (opts->gpg_sign)
>  		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
>  	if (opts->signoff)
> @@ -786,7 +788,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	}
>  	if (!opts->no_commit)
>  		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
> -			opts, allow, opts->edit);
> +			opts, allow, opts->edit, 0);
>  
>  leave:
>  	free_message(commit, &msg);

Hmm, this is more about a comment on 18/25, but I suspect that
"amend" or any opportunity given to the user to futz with the
contents in the editor invites a wish for the result to be treated
with stripspace.

No existing callers use "amend" to call this function, so there is
no change in behaviour, but at the same time, we do not have enough
information to see if 'amend' should by default toggle cleanup.


> diff --git a/sequencer.h b/sequencer.h
> index 7f5222f..c45f5c4 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -54,7 +54,7 @@ int sequencer_rollback(struct replay_opts *opts);
>  int sequencer_remove_state(struct replay_opts *opts);
>  
>  int sequencer_commit(const char *defmsg, struct replay_opts *opts,
> -			  int allow_empty, int edit);
> +			  int allow_empty, int edit, int amend);
>  
>  extern const char sign_off_header[];
