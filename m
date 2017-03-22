Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FAF320323
	for <e@80x24.org>; Wed, 22 Mar 2017 18:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965514AbdCVSVd (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:21:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62781 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935839AbdCVSVb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 14:21:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E90637A570;
        Wed, 22 Mar 2017 14:21:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wI9Jltn/RR0fMcyoXrjC7ocC57A=; b=yWsUc2
        EMxU6KKT2NkPTVnNUf377GtuAh7ThI1pE5h0nTrNMUy/+4/HlUg6xXyrPdJIOM5F
        1Sttvzj4xKG4LUH7sjVYGxbP8/Naf/7jAW/TQQYi4Y3z59ADpBQ+Im7Ci+wOe4NS
        C8OCrMdA8hoDyztXsKqKZbXm4kn7yEUVB/lj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vPdZinOrtQEA//kNajAc0HJ2J20a4Wk/
        xGS3WMdE/UZVN8MxLl5F351XAodh1wCrBvmLU/9e+46S5q/KlUwwAgMUq3xzNslz
        1z6lSYwJyDPcyAkkpv6U7f7If3NwJsZy7/rRNsmgkjCDAnfYFsAaNrm+pLR78Mes
        geFnrqOpnRw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E169F7A56F;
        Wed, 22 Mar 2017 14:21:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 588A77A56E;
        Wed, 22 Mar 2017 14:21:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/3] sequencer: make commit options more extensible
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
        <c0c836e1f1739af25ad875419ee6125b53ac6a1a.1490194846.git.johannes.schindelin@gmx.de>
Date:   Wed, 22 Mar 2017 11:21:28 -0700
In-Reply-To: <c0c836e1f1739af25ad875419ee6125b53ac6a1a.1490194846.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 22 Mar 2017 16:01:53 +0100
        (CET)")
Message-ID: <xmqqa88dkw9j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E55C350-0F2C-11E7-88C0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +#define ALLOW_EMPTY (1<<0)
> +#define EDIT_MSG    (1<<1)
> +#define AMEND_MSG   (1<<2)
> +#define CLEANUP_MSG (1<<3)

These being bits makes it clear that they can be independently set
and unset.

> @@ -615,8 +620,7 @@ N_("you have staged changes in your working tree\n"
>   * author metadata.
>   */
>  static int run_git_commit(const char *defmsg, struct replay_opts *opts,
> -			  int allow_empty, int edit, int amend,
> -			  int cleanup_commit_message)
> +			  int flags)

Use "unsigned" not signed integer for a collection of bits (see
e.g. GSoC microproject ideas page).

> @@ -1123,11 +1127,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	if (allow < 0) {
>  		res = allow;
>  		goto leave;
> -	}
> +	} else if (allow)
> +		flags |= ALLOW_EMPTY;

;-)  Much more descriptive than just "allow".

>  static int commit_staged_changes(struct replay_opts *opts)
>  {
> -	int amend = 0;
> +	int flags = ALLOW_EMPTY | EDIT_MSG;
>  
>  	if (has_unstaged_changes(1))
>  		return error(_("cannot rebase: You have unstaged changes."));
> @@ -2184,10 +2188,10 @@ static int commit_staged_changes(struct replay_opts *opts)
>  				       "--continue' again."));
>  
>  		strbuf_release(&rev);
> -		amend = 1;
> +		flags |= AMEND_MSG;
>  	}
>  
> -	if (run_git_commit(rebase_path_message(), opts, 1, 1, amend, 0))
> +	if (run_git_commit(rebase_path_message(), opts, flags))

OK, the initialization of "flags" corresponds to these "1, 1" in the
original.

Overall, much easier to understand (and to extend).  Good
maintaintability clean-up.

Thanks.
