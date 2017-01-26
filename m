Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F721F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 23:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753555AbdAZXks (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 18:40:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61960 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753232AbdAZXkj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 18:40:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22A68643AE;
        Thu, 26 Jan 2017 18:39:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cdR0OdBhEYDi/sjyes8ILaH6Wq0=; b=k05sSI
        LdydYn85hu+EZ2a6wTaZ1kXTLj8qF+wjUrpcPeZTo/eziDn50hkbmyfVXAeT4czf
        h0AGwmZHv0UZMJ2z9fDENZPmOheE27e4ueJKIfUj5SdO3FoQaDF2NjT9IxzfVycz
        1rUuFLfXc4fSWp/E5Mp2e5DP4hmJiWnJZByhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uVVOjD2QawwrXrmdP1SrAIsBZtkEh3s2
        erZVYS+V0CEpxfXcievQUUvaKHEaFockkxJ/pltc1pbyURhwzgm4Tet1YPWpmuA8
        0GD8Ny6cUp7jFr/HwxoAb4UoRCWkTCOSQk+ti6rvU2dwWVdovIgC++nZDmHc4z+B
        SEEb2P1GC6U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BC31643AD;
        Thu, 26 Jan 2017 18:39:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F26A643AC;
        Thu, 26 Jan 2017 18:39:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     cornelius.weig@tngtech.com
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] refs: add option core.logAllRefUpdates = always
References: <20170126033547.7bszipvkpi2jb4ad@sigill.intra.peff.net>
        <20170126223159.16439-1-cornelius.weig@tngtech.com>
        <20170126223159.16439-2-cornelius.weig@tngtech.com>
Date:   Thu, 26 Jan 2017 15:39:37 -0800
In-Reply-To: <20170126223159.16439-2-cornelius.weig@tngtech.com> (cornelius
        weig's message of "Thu, 26 Jan 2017 23:31:58 +0100")
Message-ID: <xmqqr33p1jd2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B40AD8E4-E420-11E6-9376-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cornelius.weig@tngtech.com writes:

> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> When core.logallrefupdates is true, we only create a new reflog for refs
> that are under certain well-known hierarchies. The reason is that we
> know that some hierarchies (like refs/tags) do not typically change, and

s/do not typically/are not meant to/;

> that unknown hierarchies might not want reflogs at all (e.g., a
> hypothetical refs/foo might be meant to change often and drop old
> history immediately).
>
> However, sometimes it is useful to override this decision and simply log
> for all refs, because the safety and audit trail is more important than
> the performance implications of keeping the log around.
>
> This patch introduces a new "always" mode for the core.logallrefupdates
> option which will log updates to everything under refs/, regardless
> where in the hierarchy it is (we still will not log things like
> ORIG_HEAD and FETCH_HEAD, which are known to be transient).

OK.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 3cd8030..2117616 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -522,6 +522,8 @@ core.logAllRefUpdates::
>  	refs/heads/), remote refs (i.e. under refs/remotes/),
>  	`refs/heads/`), remote refs (i.e. under `refs/remotes/`),

Ahh, the answer to my question on 1/3 is "no, the commit that the
patch was taken out of was already wrong, still having the old line
in front of its rewrite".

>  	note refs (i.e. under `refs/notes/`), and the symbolic ref `HEAD`.
> +	If it is set to `always`, then a missing reflog is automatically
> +	created for any ref under `refs/`.
>  +

OK.

> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 5055a96..2ac25a9 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -150,7 +150,8 @@ This option is only applicable when listing tags without annotation lines.
>  	'strip' removes both whitespace and commentary.
>  
>  --create-reflog::
> -	Create a reflog for the tag.
> +	Create a reflog for the tag. To globally enable reflogs for tags, see
> +	`core.logAllRefUpdates` in linkgit:git-config[1].

OK.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index bfe685c..1db0b44 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -612,7 +612,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  	const char *old_desc, *reflog_msg;
>  	if (opts->new_branch) {
>  		if (opts->new_orphan_branch) {
> -			if (opts->new_branch_log && !log_all_ref_updates) {
> +			if (opts->new_branch_log && should_autocreate_reflog("refs/heads/")) {

This is inviting a maintenance nightmare.  The helper function is
defined to take the final refname, not a leading directory name.
That is why you named the parameter "refname" in your patch like
this:

    --- a/refs.h
    +++ b/refs.h
    @@ -64,6 +64,8 @@ int read_ref(const char *refname, unsigned char *sha1);

     int ref_exists(const char *refname);

    +int should_autocreate_reflog(const char *refname);
    +
     int is_branch(const char *refname);

The callers are not supposed to know that its current implementation
happens to only use the leading prefix.  When the definition of this
helper function is changed (e.g. imagine a future where this
"log.allrefupdate" is further enhanced to take glob patterns to
match the refname against), this may break and nobody would notice
for a few weeks, and we will get a regression report after a release
is made.

Don't we have the refname for the branch already in this codepath?

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index d4fb977..b9084ca 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -93,6 +93,42 @@ test_expect_success 'update-ref creates reflogs with --create-reflog' '
>  	git reflog exists $outside
>  '
>  
> +test_expect_success 'core.logAllRefUpdates=true does not create reflog by default' '
> +	test_config core.logAllRefUpdates true &&
> +	test_when_finished "git update-ref -d $outside" &&
> +	git update-ref $outside $A &&
> +	git rev-parse $A >expect &&
> +	git rev-parse $outside >actual &&
> +	test_cmp expect actual &&
> +	test_must_fail git reflog exists $outside
> +'
> +
> +test_expect_success 'core.logAllRefUpdates=always creates reflog by default' '
> +	test_config core.logAllRefUpdates always &&
> +	test_when_finished "git update-ref -d $outside" &&
> +	git update-ref $outside $A &&
> +	git rev-parse $A >expect &&
> +	git rev-parse $outside >actual &&
> +	test_cmp expect actual &&
> +	git reflog exists $outside
> +'

You might want to add two tests for your original motivation, i.e.

	test_config core.logAllRefUpdates always &&
	git tag a-tag &&
	git reflog exists refs/tags/a-tag

and the other one that does not give reflog for a tag.

Other than that, looks good to me.
