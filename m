Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEFC21F462
	for <e@80x24.org>; Tue, 11 Jun 2019 21:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407627AbfFKVZp (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 17:25:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51676 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391155AbfFKVZp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 17:25:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5755B14AC16;
        Tue, 11 Jun 2019 17:25:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XOcuzjKkrIqx072Z7sujjuKvMYg=; b=u3hbhG
        BSAn8lAmlRyZFdSg/+nrg2SB4j83p3Wu+b7hJxJ6vYREdfWM/ovx8sUnSxkJ8GPn
        XksO8K+NitqS8LeSjLUqQoz4/hIwJacUrkjwZ92CYh6OHNm+V3UmmF8485uHxSuW
        xIj1GOqAqB3KCuafZeXseF7Gf/jgf4J5cVVt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OYFOe8btnhkbfgSPudlzyoUH4IahSH2i
        d8w64KFXEVrd7JPRRVNDJ697MrCKDMO2ztLMN/FyBTsuGGXFtYokx41QCQvYePmJ
        XcsY4b4DL3KIP4ekDf0eMjGcqhSY8zMSoaTKIzpcABe5VN5t+Jx/v4bdtHsvwZZz
        1ZjB74KOIAg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E91314AC15;
        Tue, 11 Jun 2019 17:25:43 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACA6014AC14;
        Tue, 11 Jun 2019 17:25:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [GSoC][PATCH v2 1/3] sequencer: add advice for revert
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
        <20190611073152.12214-1-rohit.ashiwal265@gmail.com>
        <20190611073152.12214-2-rohit.ashiwal265@gmail.com>
Date:   Tue, 11 Jun 2019 14:25:41 -0700
In-Reply-To: <20190611073152.12214-2-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Tue, 11 Jun 2019 13:01:50 +0530")
Message-ID: <xmqqr27zke5m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77A7FD22-8C8F-11E9-8EF9-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> -static int create_seq_dir(void)
> +static int create_seq_dir(struct repository *r)
>  {
> -	if (file_exists(git_path_seq_dir())) {
> -		error(_("a cherry-pick or revert is already in progress"));
> -		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
> -		return -1;
> -	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
> +	enum replay_action action;
> +
> +	if (!sequencer_get_last_command(r, &action)) {
> +		switch (action) {
> +		case REPLAY_REVERT:
> +		case REPLAY_PICK:
> +			error(_("a %s is already in progress"),
> +				 action == REPLAY_REVERT ?
> +				 "revert" : "cherry-pick");

I wonder if this poses a challenge to translators (imagine an
alternate world, in which the name of one of these subcommands began
with a vowel---your "a %s is already ..." would not be correct even
without localization).

The same comment applies to the other one, too.

> +			advise(_("try \"git %s (--continue | "
> +				 "--quit | --abort)\""),
> +				 action == REPLAY_REVERT ?
> +				 "revert" : "cherry-pick");

This is horrible but it is not a fault of yours---you merely
inherited it.  A call to advise() that is not behind any "advise.*"
configuration variable like this one should be cleaned up before
we do anything else.

The obvious and straight-forward way to deal with it is to do

	const char *in_progress_error;
        const char *in_progress_advice;

	if (action == REPLAY_REVERT) {
		in_progress_error = _("a revert is already in progress");
		in_progress_advise = _("try ...");
	} else if (action == REPLAY_PICK) {
		... likewise ...
	} else {
		BUG("should not come here");
	}

and then do

	error(in_progress_error);
	if (advise_verbosely_how_to_continue_sequencing)
		advise(in_progress_advise);



> +			return -1;
> +	if (mkdir(git_path_seq_dir(), 0777) < 0)
>  		return error_errno(_("could not create sequencer directory '%s'"),
>  				   git_path_seq_dir());
> +
>  	return 0;
>  }
>  
> @@ -4237,7 +4252,7 @@ int sequencer_pick_revisions(struct repository *r,
>  	 */
>  
>  	if (walk_revs_populate_todo(&todo_list, opts) ||
> -			create_seq_dir() < 0)
> +			create_seq_dir(r) < 0)
>  		return -1;
>  	if (get_oid("HEAD", &oid) && (opts->action == REPLAY_REVERT))
>  		return error(_("can't revert as initial commit"));
