Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E7FC43332
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8425D65016
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhCLKXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:23:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52607 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhCLKXl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 05:23:41 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CCD8A9E53;
        Fri, 12 Mar 2021 05:23:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=RU9N3JBsxAKUsVR8bwRJe8/SOCc=; b=efCarnzKjYAdg0YFlX5m
        qW8ddCapJN+iqI62YPQ7BnwY2/G0XQgMRaruLd+rNENG4CvTkhwIHK8vjy8ZRaQg
        6mdMknpfa9F7w5llbJ6e8KiR1glsMb3Uz+zMxk7WVWJxcpUR46GvxlbKN+f4xgLk
        cDIDJYbnC34RVinfF1Cvu5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=KN2nnxLRjuDW8AdZwJYyWB/vQmVaKm/EXlbn9Q4PDnMChd
        lG/IEF2Ahg/PM/3zL2PaO6pST950BMKlrWZ9Rr1SOugrNqCD0mcvsYuWbLyl2+30
        xrAmi5h0GARpY2lxtCnYgbWsCWfQ4l4nvixZYdpDQC8ISCg2OK76+BmIK186w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74595A9E52;
        Fri, 12 Mar 2021 05:23:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6E14A9E51;
        Fri, 12 Mar 2021 05:23:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 19/37] am: convert applypatch hooks to use config
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-20-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 02:23:39 -0800
Message-ID: <xmqqy2es7jro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 036BACE8-831D-11EB-9AC9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> @@ -1558,8 +1563,10 @@ static void do_commit(const struct am_state *state)
>  	struct commit_list *parents = NULL;
>  	const char *reflog_msg, *author, *committer = NULL;
>  	struct strbuf sb = STRBUF_INIT;
> +	struct run_hooks_opt hook_opt;
> +	run_hooks_opt_init_async(&hook_opt);
>  
> -	if (run_hook_le(NULL, "pre-applypatch", NULL))
> +	if (run_hooks("pre-applypatch", &hook_opt))
>  		exit(1);
>  
>  	if (write_cache_as_tree(&tree, 0, NULL))
> @@ -1611,8 +1618,9 @@ static void do_commit(const struct am_state *state)
>  		fclose(fp);
>  	}
>  
> -	run_hook_le(NULL, "post-applypatch", NULL);
> +	run_hooks("post-applypatch", &hook_opt);
>  
> +	run_hooks_opt_clear(&hook_opt);
>  	strbuf_release(&sb);
>  }

This one does opt_init(), run_hooks(), and another run_hooks() and
then opt_clear().  If run_hooks() is a read-only operation on the
hook_opt, then that would be alright, but it just smells iffy that
it is not done as two separate opt_init(), run_hooks(), opt_clear()
sequences for two separate run_hooks() invocations.  The same worry
about future safety I meantioned elsewhere in the series also
applies.

Thanks.


