Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5D51F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 23:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756824AbcIYXev (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 19:34:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60452 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751950AbcIYXeu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 19:34:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5264740A33;
        Sun, 25 Sep 2016 19:34:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=qszJ2MxUV9uUWWtCEub0CK60lJE=; b=MI/BC/dvIwzXmDM+sEO2
        6HTg6iC9s4X9P9SKy/ZkUar+uQNXg0ub0SR0X9uy8jX+FHPZJp4dm0SO+Ic2CA18
        6AeB5LjenpQs2c/p985BWOk9S6SNB15Ux27il8f39xjKYy1bx7+n+g6BPcz+Epnk
        iZVadO88eONQiw9xSg6eJMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=nJX3hLpUvHN7rXhM+sPGexjKMYvTnUPPZgnmplL9gJCLyN
        U4+Mmf2TNNHO+zs5lVYbxqIgkbWkjKoUpZQ2PhoPt4F+K8mq8T/bIS+ZAytvxHAg
        6irydgx0FlC2YG0B5dKLyPaUMcTTi0dcy5KrF9zGKPPZeNxA6sI7IqKdaY9OY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A9EB40A32;
        Sun, 25 Sep 2016 19:34:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A20EF40A31;
        Sun, 25 Sep 2016 19:34:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3 v3] submodules: make submodule-prefix option an envvar
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <1474676014-134568-2-git-send-email-bmwill@google.com>
Date:   Sun, 25 Sep 2016 16:34:46 -0700
Message-ID: <xmqqintjwo2x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A610A9C0-8378-11E6-85DD-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Add a submodule-prefix enviorment variable

environment?

> 'GIT_INTERNAL_SUBMODULE_PREFIX' which can be used by commands which have
> --recurse-submodule options.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  cache.h       | 1 +
>  environment.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index 3556326..ae88a35 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -408,6 +408,7 @@ static inline enum object_type object_type(unsigned int mode)
>  #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
>  #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
>  #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
> +#define GIT_SUBMODULE_PREFIX_ENVIRONMENT "GIT_INTERNAL_SUBMODULE_PREFIX"
>  #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
>  #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
>  #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
> diff --git a/environment.c b/environment.c
> index ca72464..7380815 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -120,6 +120,7 @@ const char * const local_repo_env[] = {
>  	NO_REPLACE_OBJECTS_ENVIRONMENT,
>  	GIT_REPLACE_REF_BASE_ENVIRONMENT,
>  	GIT_PREFIX_ENVIRONMENT,
> +	GIT_SUBMODULE_PREFIX_ENVIRONMENT,
>  	GIT_SHALLOW_FILE_ENVIRONMENT,
>  	GIT_COMMON_DIR_ENVIRONMENT,
>  	NULL
