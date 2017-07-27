Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075F420899
	for <e@80x24.org>; Thu, 27 Jul 2017 19:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdG0S76 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 14:59:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61470 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751458AbdG0S75 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 14:59:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 992F79F9E7;
        Thu, 27 Jul 2017 14:59:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hloGSrwUasefLv0DtriZLaYBtqo=; b=jIo1Xd
        6fmO62lqDBaC/MjAQiuYvSfTfH1f2pKxgYXLz7P7rRhHjBZf+J8ckEZqkho6HzrX
        EVGLWamrYijwCQMxWd6OpOE7dFA7b4283iqcjwSR3ULTSfMyFOQ2B4ZUsAgPvAsr
        ASjdTByrV7GQg7R/CurPFbIJV7EHNpLjWU0Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=veWcePhn99IbiPsqRkflYm6ew9+3OcWY
        ycs1QAxgvLD/0w/4NMMSrnm7whKUiQt43UOdPwE4WKc1SOEvO/lwYG4dbJOHndd7
        PGITXGP19VxtorxGHkyRMyJC5Xz/bWo2H6Rj9jUkfQvwXqq6YrdClLWrQzdxeAcM
        AwLQ0Ju1LTw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 926779F9E6;
        Thu, 27 Jul 2017 14:59:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F1A249F9E5;
        Thu, 27 Jul 2017 14:59:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [RFC PATCH 2/4] fsck: support refs pointing to lazy objects
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501111615.git.jonathantanmy@google.com>
        <4c8bc7ab543d8d0d60719f65bd8a150c66123056.1501111615.git.jonathantanmy@google.com>
Date:   Thu, 27 Jul 2017 11:59:47 -0700
In-Reply-To: <4c8bc7ab543d8d0d60719f65bd8a150c66123056.1501111615.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 26 Jul 2017 16:30:00 -0700")
Message-ID: <xmqqvamdn1ss.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C37BBD2C-72FD-11E7-9A5A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Teach fsck to not treat refs with missing targets as an error when
> extensions.lazyobject is set.
>
> For the purposes of warning about no default refs, such refs are still
> treated as legitimate refs.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/fsck.c         |  8 ++++++++
>  t/t0410-lazy-object.sh | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 1cfb8d98c..e29ff760b 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -438,6 +438,14 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
>  
>  	obj = parse_object(oid);
>  	if (!obj) {
> +		if (repository_format_lazy_object) {
> +			/*
> +			 * Increment default_refs anyway, because this is a
> +			 * valid ref.
> +			 */
> +			default_refs++;
> +			return 0;
> +		}
>  		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
>  		errors_found |= ERROR_REACHABLE;

At this point, do we know (or can we tell) if this is a missing
object or a file exists as a loose object but is corrupt?  If we
could, it would be nice to do this only for the former to avoid
sweeping a real corruption that is unrelated to the lazy fetch under
the rug.

> +test_expect_success 'fsck fails on lazy object pointed to by ref' '
> +	rm -rf repo &&
> +	test_create_repo repo &&
> +	test_commit -C repo 1 &&
> +
> +	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
> +
> +	# Reference $A only from ref, and delete it
> +	git -C repo branch mybranch "$A" &&
> +	delete_object repo "$A" &&
> +
> +	test_must_fail git -C repo fsck
> +'

And a new test that uses a helper different from delete_object
(perhaps call it corrupt_object?) can be used to make sure that we
complain in that case here.

> +test_expect_success '...but succeeds if lazyobject is set' '
> +	git -C repo config core.repositoryformatversion 1 &&
> +	git -C repo config extensions.lazyobject "arbitrary string" &&
> +	git -C repo fsck
> +'
> +
>  test_done
