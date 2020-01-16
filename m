Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D5AC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818A920684
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iGsZBAyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406704AbgAPSYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:24:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54663 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406518AbgAPSYH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 13:24:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3C6094956;
        Thu, 16 Jan 2020 13:24:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UyofWcRckVXK8ufhjWCSOLkpnU0=; b=iGsZBA
        yOrMfh7vVA81jiiWeuxdlXZVzbCMOsoVatoR+1Ae0VIDISum45H4NPzsScmWVtq8
        kbcScmhqZECPDv55qKUD7zDtXU+3QUxLipFsTSExzfEMFhowZeL2+8ilsJEScDuh
        sHAj5pISr57wl4Krc+9l1YSbJ5hA9aBF39/R4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ibLyq8MtxQqDiOXGgKab+W2/p3XWAJC4
        EoKJdg6Y5jDr9xcoqsidJDDNEHkspBjIZlQOSzYH3wmsw2ifmsIlQdL4+9prKXRt
        /uaiwlkFY6FRlj1Nspa0SDe0TD8ey8oO8mW2J9c/5Wm+uaWXm54xba3/plT56SM7
        JtGfJj7deQk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC11D94955;
        Thu, 16 Jan 2020 13:24:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 186AD94951;
        Thu, 16 Jan 2020 13:24:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fetch: emphasize failure during submodule fetch
References: <20200116025948.136479-1-emilyshaffer@google.com>
Date:   Thu, 16 Jan 2020 10:23:58 -0800
In-Reply-To: <20200116025948.136479-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 15 Jan 2020 18:59:48 -0800")
Message-ID: <xmqq1rrzi7k1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E41AFF4-388D-11EA-A2CC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> @@ -1280,10 +1280,13 @@ struct submodule_parallel_fetch {
>  	/* Pending fetches by OIDs */
>  	struct fetch_task **oid_fetch_tasks;
>  	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;
> +
> +	struct strbuf submodules_with_errors;
> +	pthread_mutex_t submodule_errors_mutex;

Hmph, it is kind of surprising that we need a new mutex for this.

Isn't the task_finish handler, which is what accesses the
with_errors field this patch adds, called by pp_collect_finished()
one at a time, is it?

It seems oid_fetch_tasks[] array is also a shared resource in this
structure among the parallel fetch tasks, but there is no protection
against simultaneous access to it.  Am I missing what makes the new
field different?  Somewhat puzzled...

Other than that, I think this is a vast improvement relative to the
initial round.  I wonder if we want to _("i18n/l10n") the message,
though.

Thanks.


>  #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
>  		  STRING_LIST_INIT_DUP, \
> -		  NULL, 0, 0}
> +		  NULL, 0, 0, STRBUF_INIT, PTHREAD_MUTEX_INITIALIZER}
>  
>  static int get_fetch_recurse_config(const struct submodule *submodule,
>  				    struct submodule_parallel_fetch *spf)
> @@ -1547,7 +1550,10 @@ static int fetch_finish(int retvalue, struct strbuf *err,
>  	struct string_list_item *it;
>  	struct oid_array *commits;
>  
> -	if (retvalue)
> +	if (!task || !task->sub)
> +		BUG("callback cookie bogus");
> +
> +	if (retvalue) {
>  		/*
>  		 * NEEDSWORK: This indicates that the overall fetch
>  		 * failed, even though there may be a subsequent fetch
> @@ -1557,8 +1563,11 @@ static int fetch_finish(int retvalue, struct strbuf *err,
>  		 */
>  		spf->result = 1;
>  
> -	if (!task || !task->sub)
> -		BUG("callback cookie bogus");
> +		pthread_mutex_lock(&spf->submodule_errors_mutex);
> +		strbuf_addf(&spf->submodules_with_errors, "\t%s\n",
> +			    task->sub->name);
> +		pthread_mutex_unlock(&spf->submodule_errors_mutex);
> +	}
>  
>  	/* Is this the second time we process this submodule? */
>  	if (task->commits)
> @@ -1627,6 +1636,11 @@ int fetch_populated_submodules(struct repository *r,
>  				   &spf,
>  				   "submodule", "parallel/fetch");
>  
> +	if (spf.submodules_with_errors.len > 0)
> +		fprintf(stderr, "Errors during submodule fetch:\n%s",
> +			spf.submodules_with_errors.buf);
> +
> +
>  	argv_array_clear(&spf.args);
>  out:
>  	free_submodules_oids(&spf.changed_submodule_names);
