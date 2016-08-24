Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D42E1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 21:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754417AbcHXVMi (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 17:12:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64623 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751227AbcHXVMh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 17:12:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5199C37435;
        Wed, 24 Aug 2016 17:12:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d+AFhboOMXK1Lz3g11I3XMtclHI=; b=AMkp8b
        XOOK4SSaJcb46/1grtSPwEUm0JA/U/9BKyMRYBH/hDyL40m5XhIBqAEjq4amldsW
        1Y90GOU3FlaKnOe8wwWbw2ZG0bleGsuqPSWsXxkpUKmZiMunO31CijdjThn2jkL8
        kxexLJY/nm80WwhSCzRsLecIsSwNb8CYkjIs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ePENxN6RHvmv53ezgkhM5wzBOVIN2030
        GZZzhKLQTLnQCmdTGsFGKne6xfK/D5/b0Byh3tTIdhTmmp7h3JTOjyxXv/n2fI+q
        Fc09RDD19GvZGVvkSDDHSjal/fCk66ix6l6zZMZPZE5sO7ub32kG5lhayOt+TuKJ
        eEwgtCnhfVg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B47D37433;
        Wed, 24 Aug 2016 17:12:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6A4237431;
        Wed, 24 Aug 2016 17:12:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 07/27] bisect--helper: `bisect_reset` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe69a-13136cfb-4daa-4f5d-9b56-537adf2c6942-000000@eu-west-1.amazonses.com>
Date:   Wed, 24 Aug 2016 14:12:33 -0700
In-Reply-To: <01020156b73fe69a-13136cfb-4daa-4f5d-9b56-537adf2c6942-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 23 Aug 2016 11:53:53 +0000")
Message-ID: <xmqq4m69q3b2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7ADE9D40-6A3F-11E6-A4E2-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int bisect_reset(const char *commit)
> +{
> +	struct strbuf branch = STRBUF_INIT;
> +
> +	if (!commit) {
> +		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {

Hmm, tricky but correct to do the "< 1" comparison.  If the file
does not exist, you'd get -1; if it fails to read it, you'd get -1;
if it turns out to be empty, you'd get 0.

> +			printf("We are not bisecting.\n");
> +			return 0;
> +		}
> +		strbuf_rtrim(&branch);
> +	} else {
> +		struct object_id oid;
> +		if (get_oid(commit, &oid))
> +			return error(_("'%s' is not a valid commit"), commit);

The original is

	rev-parse --quiet --verify "$1^{commit}"

Unless the caller of this function already appended "^{commit}" to
whatever the user gave "bisect--helper bisect-reset", this
conversion is not equivalent.  If you said

    git bisect reset HEAD:

get_oid() would tell you that the top-level tree object of the
current commit exists in the object store, but the original is
meant to catch "That's not a commit, it's a tree!" before attempting
to run "git checkout" on it.

I think get_sha1_committish() is what you want to use here.

> +		strbuf_addstr(&branch, commit);
> +	}

Also this version fails to catch "bisect reset a b c" as an error, I
suspect.

> @@ -627,7 +603,7 @@ case "$#" in
>  	visualize|view)
>  		bisect_visualize "$@" ;;
>  	reset)
> -		bisect_reset "$@" ;;
> +		git bisect--helper --bisect-reset "$@" ;;
>  	replay)
>  		bisect_replay "$@" ;;
>  	log)
>
> --
> https://github.com/git/git/pull/287
