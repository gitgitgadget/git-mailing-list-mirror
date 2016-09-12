Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00BA207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 18:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932105AbcILS40 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 14:56:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52198 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753444AbcILS40 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 14:56:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C4993D604;
        Mon, 12 Sep 2016 14:56:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3uGjW7kXwqttjuiT+ub+J6zcMnQ=; b=YnIavc
        sqm+WBi8ephorkEyeKz5toG+7hx7YXY4IBk8U1Qz8qGpPGXMvyU9jGp37pww67IG
        dqjaS5OOXzvkEx9akXy53QOXCjHZrdNrLZQiW6aMEiA03dzL10+v8gOpyhZH1efL
        WZPSkeSG2qHkpkfwHAeJV6TLzT1o6tuACksUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ojugFUZN+ow3wQMjgMczgSWwTF+TDTWn
        11jQyycC0GFf5xduclaZB5lM9YmyuDjrtoMMgnVCM0Z0wbxn64Gl9q8KChnREobH
        K5n7y3lYKFPLTRt8FPdLaM1UxkMg4/NtiTfmXzdgA6XKF/TrKA5ktGAtI1EDfaxJ
        U5PJAjqKl6w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45A9E3D603;
        Mon, 12 Sep 2016 14:56:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC6123D602;
        Mon, 12 Sep 2016 14:56:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/5] pull: make code more similar to the shell script again
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
        <cover.1473580914.git.johannes.schindelin@gmx.de>
        <c448851c24599d73143bce90984b9efc43d4a7aa.1473580914.git.johannes.schindelin@gmx.de>
Date:   Mon, 12 Sep 2016 11:56:21 -0700
In-Reply-To: <c448851c24599d73143bce90984b9efc43d4a7aa.1473580914.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 10:02:23 +0200
        (CEST)")
Message-ID: <xmqqtwdl2bhm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99CCE90C-791A-11E6-8AC8-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When converting the pull command to a builtin, the
> require_clean_work_tree() function was renamed and the pull-specific
> parts hard-coded.
>
> This makes it impossible to reuse the code, so let's modify the code to
> make it more similar to the original shell script again.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/pull.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index d4bd635..a3ed054 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -365,10 +365,11 @@ static int has_uncommitted_changes(void)
>   * If the work tree has unstaged or uncommitted changes, dies with the
>   * appropriate message.
>   */
> -static void die_on_unclean_work_tree(void)
> +static int require_clean_work_tree(const char *action, const char *hint,
> +		int gently)
>  {
>  	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
> -	int do_die = 0;
> +	int err = 0;
>  
>  	hold_locked_index(lock_file, 0);
>  	refresh_cache(REFRESH_QUIET);
> @@ -376,20 +377,27 @@ static void die_on_unclean_work_tree(void)
>  	rollback_lock_file(lock_file);
>  
>  	if (has_unstaged_changes()) {
> -		error(_("Cannot pull with rebase: You have unstaged changes."));
> -		do_die = 1;
> +		error(_("Cannot %s: You have unstaged changes."), _(action));
> +		err = 1;
>  	}
> ...
> +			error(_("Cannot %s: Your index contains uncommitted changes."),
> +			      _(action));
> +		err = 1;

These are much better than the one in v1.

Depending on the target language, the translators may have to phrase
these not like "Cannot <verb>:" but "Cannot perform <noun>:" where
the "<noun>" is for "the act of doing <verb>", if the "cannot" part
in their language needs to change shape depending on the verb.
Hence, I think the translators need a /* TRANSLATORS: ... */ comment
that tells them what is interpolated here are their translations for
phrases like "pull with rebase".  You do not have to be exhausitive
in the comment; a representative example would help the translators
see the message in context.

Other than that (and the need to further clean-up error() and die()
to begin with lower-case to match the modern practice in a separate
follow-up series), this looks ready to be queued.

Thanks.

