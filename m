Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36A81F462
	for <e@80x24.org>; Mon, 17 Jun 2019 22:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfFQWcl (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 18:32:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59610 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFQWcl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 18:32:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BA117E4D4;
        Mon, 17 Jun 2019 18:32:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TzO0qoViaiREpyCi8FH4rcAZh/o=; b=hAW8Bc
        dMx8+/pQGtb2m1VRNhhqHg614d7kn76ybblJ1wbxYMmat5cLi5R2/EYqBa2s1NPm
        6gFTcsiqsUNuQA/UWyBX4W98NC/pd08sjD8elutQVmdix/lvwSVn2iaRta1bjbBD
        9WdlAs22PGDsSnDeQow9Ij5j589+ed6IcW5eE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bVMKxs081naOOplHKusefUdJTnLtZqzE
        rmYAMt7Gato8R6htR3i0UJZVezDi0sdYZibLlWn1+GI+eQbSyNEdD6Vqa0OT3rAH
        +GwG9VoN+wuGnSoxIGd06beHW31xDbreNzaKw5mBpnDTI+DkfV/ca4rlx4uTlJyZ
        DfDlfHGp3qk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42DA17E4D3;
        Mon, 17 Jun 2019 18:32:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1FE4F7E4D0;
        Mon, 17 Jun 2019 18:32:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] rev-list: teach --no-object-names to enable piping
References: <20190614234855.257318-1-emilyshaffer@google.com>
Date:   Mon, 17 Jun 2019 15:32:34 -0700
In-Reply-To: <20190614234855.257318-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Fri, 14 Jun 2019 16:48:55 -0700")
Message-ID: <xmqqk1djsv0d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEEB2752-914F-11E9-B64B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Allow easier parsing by cat-file by giving rev-list an option to print
> only the OID of a non-commit object without any additional information.
> This is a short-term shim; later on, rev-list should be taught how to
> print the types of objects it finds in a format similar to cat-file's.
>
> Before this commit, the output from rev-list needed to be massaged
> before being piped to cat-file, like so:
>
>   git rev-list --objects HEAD | cut -f 1 -d ' ' \
>     | git cat-file --batch-check

Write this with '|' at the end of the first line; that way the shell
knows you haven't finished your sentence without any backslash.

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 660172b014..7e2598fd22 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -49,6 +49,7 @@ static const char rev_list_usage[] =
>  "    --objects | --objects-edge\n"
>  "    --unpacked\n"
>  "    --header | --pretty\n"
> +"    --no-object-names\n"

Ideally, this should be "--[no-]object-names", i.e. --object-names
which may be the default when using --objects could be tweaked with
--no-object-names and then again turned on with a --object-names
later on the command line, following the usual "last one wins".

> @@ -75,6 +76,9 @@ enum missing_action {
>  };
>  static enum missing_action arg_missing_action;
>  
> +/* display only the oid of each object encountered */
> +static int arg_no_object_names;

And this would become

    static int show_object_names = 1;

that can be turned off via --no-object-names (and --object-names
would flip it on).  It would reduce the double negation brain
twister, hopefully.

