Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125F71FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 21:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759006AbcLPVzj (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 16:55:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54475 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758587AbcLPVzh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 16:55:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E995357DB9;
        Fri, 16 Dec 2016 16:55:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wNnR9q6j95YLB5iHVDzkdtwpOWA=; b=d+i8d0
        lbkLE3ODmyCyvN8Pm3yQcg6vBU8NtSSxYDnEO7MsKsS7E5EGYiTf0yRtKDGQrur3
        jfBXBuj2vKoH3kqSPgGbuMLZagAmaGFoCpuwS7Tt4fXPIpaiXVq+vuXndOJG8/y6
        ObF1bMkfE2SHpsIYUm2N4fbUh8+qqpzsYdhjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RQzCPydf/Avtz5jbwQw4N8YckeXi5ffB
        XW/0No7QHGT9ChLLo+cLD0Ab7HA9ZfIBoDJNPhr5PrCy8f2kQyRTeOspy4+/3mtA
        8JflVn0SgNQ9iSe4KWdVJm9csRpdMr8hrtm35mw4EFbBODOH3dsKVhYspjlDOkHt
        JrvtYRsB1ic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DEFD757DB8;
        Fri, 16 Dec 2016 16:55:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56DC157DB6;
        Fri, 16 Dec 2016 16:55:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: index-pack outside of repository?
References: <20161215204000.avlcfaqjwstkptu2@sigill.intra.peff.net>
        <xmqqshpou3wt.fsf@gitster.mtv.corp.google.com>
        <20161216013728.in2dazshtarrnnq3@sigill.intra.peff.net>
        <20161216022904.cjang6napnl2vkc6@sigill.intra.peff.net>
        <xmqqd1gru5fw.fsf@gitster.mtv.corp.google.com>
        <xmqq7f6zu55k.fsf@gitster.mtv.corp.google.com>
        <xmqq37hnu50y.fsf@gitster.mtv.corp.google.com>
        <20161216214322.xibllaw2iibhc5nv@sigill.intra.peff.net>
Date:   Fri, 16 Dec 2016 13:55:34 -0800
In-Reply-To: <20161216214322.xibllaw2iibhc5nv@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 16 Dec 2016 16:43:22 -0500")
Message-ID: <xmqqh963r12h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6015E726-C3DA-11E6-8168-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Ah, I only checked that it did not do anything terrible like write into
> ".git". But it looks like it still looks at the git_dir value as part of
> the collision check.
>
> Here's a patch, on top of the rest of the series.

Thanks for a quick turnaround, as always.

> -- >8 --
> Subject: [PATCH] index-pack: skip collision check when not in repository
>
> You can run "git index-pack path/to/foo.pack" outside of a
> repository to generate an index file, or just to verify the
> contents. There's no point in doing a collision check, since
> we obviously do not have any objects to collide with.
>
> The current code will blindly look in .git/objects based on
> the result of setup_git_env(). That effectively gives us the
> right answer (since we won't find any objects), but it's a
> waste of time, and it conflicts with our desire to
> eventually get rid of the "fallback to .git" behavior of
> setup_git_env().
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I didn't do a test, as this doesn't really have any user-visible
> behavior change.
>
> I guess technically if you had a non-repo with
> ".git/objects/12/3456..." in it we would erroneously read it, but that's
> kind of bizarre. The interesting test is that when merged with
> jk/no-looking-at-dotgit-outside-repo-final, the test in t5300 doesn't
> die.

Yes.

>
>  builtin/index-pack.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index d450a6ada2..f4b87c6c9f 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -787,13 +787,15 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>  			const unsigned char *sha1)
>  {
>  	void *new_data = NULL;
> -	int collision_test_needed;
> +	int collision_test_needed = 0;
>  
>  	assert(data || obj_entry);
>  
> -	read_lock();
> -	collision_test_needed = has_sha1_file_with_flags(sha1, HAS_SHA1_QUICK);
> -	read_unlock();
> +	if (startup_info->have_repository) {
> +		read_lock();
> +		collision_test_needed = has_sha1_file_with_flags(sha1, HAS_SHA1_QUICK);
> +		read_unlock();
> +	}
>  
>  	if (collision_test_needed && !data) {
>  		read_lock();
