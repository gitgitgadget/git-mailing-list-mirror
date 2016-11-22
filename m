Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73BCE1FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 03:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755045AbcKVDkJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 22:40:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54650 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754871AbcKVDkI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 22:40:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7543B5323E;
        Mon, 21 Nov 2016 22:40:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RZJlVUEnUpL1ubCcZfAmDVUfZ1c=; b=ycxGIl
        3TLaUF/oRSYIYgcLoryqzhVJi10gBYtUlOpgOWnWLSQNKqJthsFTvk1Eg0MAIP+W
        UM7AxeW4zYHGO19KvC0QijdLKF6QJ+I11bG3FyJJ29EVWYo8JTon+TPAtw00BmqH
        sSGwQGKQdnByB33ZV3OGxeRaoCeGJwooY1xDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kpqaRf5muzML/a/Gl5ma42yK4CNE0a8U
        ZBvXJX+pHLB8NFlBKP2RGQqESTjgtT5QaQbFpV2766SRO8wV4OZ4HkFVptKZ0daN
        q4MEi/GzmfJyKPD+hfRQJM4qfUMGJqIiR7GJMDV53awLhYJiIeHloyRA87XJLz+H
        bSyb4XhGAdY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 541375323B;
        Mon, 21 Nov 2016 22:40:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4F9353239;
        Mon, 21 Nov 2016 22:40:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/7] setup_git_env: avoid blind fall-back to ".git"
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
        <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
        <20161122004421.GA12263@google.com>
Date:   Mon, 21 Nov 2016 19:40:05 -0800
In-Reply-To: <20161122004421.GA12263@google.com> (Jonathan Nieder's message of
        "Mon, 21 Nov 2016 16:44:21 -0800")
Message-ID: <xmqq4m30gp2i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C4EF214-B065-11E6-84E9-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> This trips reproducibly for
>
>   git ls-remote https://kernel.googlesource.com/pub/scm/git/git
>
> when run outside of a git repository.
>
> Backtrace:
>
>   #0  setup_git_env () at environment.c:172
>   #1  get_git_dir () at environment.c:214
>   #2  get_helper at transport-helper.c:127
>   #3  get_refs_list (for_push=0) at transport-helper.c:1038
>   #4  transport_get_remote_refs at transport.c:1076
>   #5  cmd_ls_remote at builtin/ls-remote.c:97
>
> transport-helper.c:127 is
>
> 	argv_array_pushf(&helper->env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
> 			 get_git_dir());
>
> That code is pretty clearly wrong.  Should it be made conditional
> on have_git_dir(), like this?

Looks good and I agree with Peff's analysis.  Care to wrap it in a
patch with a log message?

Thanks.

>
> Thanks,
> Jonathan
>
>  transport-helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 91aed35..e4fd982 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -124,8 +124,9 @@ static struct child_process *get_helper(struct transport *transport)
>  	helper->git_cmd = 0;
>  	helper->silent_exec_failure = 1;
>  
> -	argv_array_pushf(&helper->env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
> -			 get_git_dir());
> +	if (have_git_dir())
> +		argv_array_pushf(&helper->env_array, "%s=%s",
> +				 GIT_DIR_ENVIRONMENT, get_git_dir());
>  
>  	code = start_command(helper);
>  	if (code < 0 && errno == ENOENT)
