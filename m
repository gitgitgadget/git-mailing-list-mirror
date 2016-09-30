Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41458207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 21:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932908AbcI3VZs (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 17:25:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52140 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932382AbcI3VZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 17:25:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 902E3408C5;
        Fri, 30 Sep 2016 17:25:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=atZNNZaBULzY4l1h49kZzi1EaLw=; b=AQ3Hja
        auaJkmR3Ti8tRKncCT/aSDxa3eopGnNkPH+fxqac/KTkhCHVEItjs32rSzNS4lVW
        UrFraPWefnchA2sfe8mQIDlTKeINGj9CeUkDH87wTkCE+1U6DBpAf3/l5fReAaey
        fKCF5JanZeMrxTKD410CQ0Vk7hTyV5MSEa3ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ngZxxYpXVsci0hlb86YqzurqUYZhxTHD
        njd7bSr33hACEYbwFjSZJ0Tv1E/PA152XFxQwmw3n7SftGK8N0X8O29+JjRqRvz4
        k5AVLQwe6BcpW+K/Kt95wsSpd9oxOtzJYJhXmmfdXuQ/THu3OO/U+U42F700htC5
        xH1wTcvpjik=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88AF3408C4;
        Fri, 30 Sep 2016 17:25:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 086C1408C1;
        Fri, 30 Sep 2016 17:25:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 3/6] tmp-objdir: introduce API for temporary object directories
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
        <20160930193613.dwpjiw5xps6a3wgj@sigill.intra.peff.net>
Date:   Fri, 30 Sep 2016 14:25:43 -0700
In-Reply-To: <20160930193613.dwpjiw5xps6a3wgj@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 30 Sep 2016 15:36:13 -0400")
Message-ID: <xmqqponl84h4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7290EA58-8754-11E6-89B1-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/sha1_file.c b/sha1_file.c
> index 9a79c19..65deaf9 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -421,6 +421,12 @@ void add_to_alternates_file(const char *reference)
>  	free(alts);
>  }
>  
> +void add_to_alternates_internal(const char *reference)
> +{
> +	prepare_alt_odb();
> +	link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
> +}
> +

A function _internal being extern felt a bit funny.  We are only
appending so the first one does not have to be reprepare.

> +static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
> +{
> +	int err;
> +
> +	if (!t)
> +		return 0;
> +
> +	if (t == the_tmp_objdir)
> +		the_tmp_objdir = NULL;
> +
> +	/*
> +	 * This may use malloc via strbuf_grow(), but we should
> +	 * have pre-grown t->path sufficiently so that this
> +	 * doesn't happen in practice.
> +	 */
> +	err = remove_dir_recursively(&t->path, 0);
> +
> +	/*
> +	 * When we are cleaning up due to a signal, we won't bother
> +	 * freeing memory; it may cause a deadlock if the signal
> +	 * arrived while libc's allocator lock is held.
> +	 */
> +	if (!on_signal)
> +		tmp_objdir_free(t);
> +	return err;
> +}
> +
> +int tmp_objdir_destroy(struct tmp_objdir *t)
> +{
> +	return tmp_objdir_destroy_1(t, 0);
> +}

Looks sensible.

> +	t = xmalloc(sizeof(*t));
> +	strbuf_init(&t->path, 0);
> +	argv_array_init(&t->env);
> +
> +	strbuf_addf(&t->path, "%s/incoming-XXXXXX", get_object_directory());

I was wondering where you would put this in.  Inside .git/objects/
sounds good.

> +/*
> + * Make sure we copy packfiles and their associated metafiles in the correct
> + * order. All of these ends_with checks are slightly expensive to do in
> + * the midst of a sorting routine, but in practice it shouldn't matter.
> + * We will have a relatively small number of packfiles to order, and loose
> + * objects exit early in the first line.
> + */
> +static int pack_copy_priority(const char *name)
> +{
> +	if (!starts_with(name, "pack"))
> +		return 0;
> +	if (ends_with(name, ".keep"))
> +		return 1;
> +	if (ends_with(name, ".pack"))
> +		return 2;
> +	if (ends_with(name, ".idx"))
> +		return 3;
> +	return 4;
> +}

Thanks for being careful.  A blind "cp -r" would have ruined the
day.

We do not do bitmaps upon receiving, I guess.

> + *	struct tmp_objdir *t = tmp_objdir_create();
> + *	if (!run_command_v_opt_cd_env(cmd, 0, NULL, tmp_objdir_env(t)) &&
> + *	    !tmp_objdir_migrate(t))
> + *		printf("success!\n");
> + *	else
> + *		die("failed...tmp_objdir will clean up for us");

Made me briefly wonder if a caller might want to use appropriate
environment to use the tmp-objdir given by the API in addition to
its own, but then such a caller just needs to prepare its own argv-array
and concatenate tmp_objdir_env() before making the opt_cd_env call,
so this is perfectly fine.

