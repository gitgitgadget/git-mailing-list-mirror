Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB0E1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 18:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754346AbcLNSj7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 13:39:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54067 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754336AbcLNSj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 13:39:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BC0155FA2;
        Wed, 14 Dec 2016 13:39:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WIp8T2PWK7TQwKGXxcdunOLfnE0=; b=SjnYJW
        LlsFmQ9WBZ2LLAXW0wYttIMAi1fdLkUGnZktauXzEZZctL9CDSa+L9TBU224QVxt
        FZqVwR7GEUbZPRPryMWwco+HfFFmNbFJNQfLWiFNWWmUmbNNln8qa8RdipTKjF6I
        miacX6aZmTamrbv7DLnM3d1A92aurfG6yTr10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oygvHTnJnKR5cS+VRLLvbLXfkL+HwBJY
        LRHmVx82dXgUi+pii+XjMVbgSKoHzruOlyu3I9d1e++uP8t3BjY0wr7VRtDKuUrT
        cExqK6R3vVB3ZF8ZFxFPcpkwlWQJ07A6IClSUfYKCtfNVjye/MBbOEjq9AbKL1by
        ut9PfdjPvlo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 119AD55FA1;
        Wed, 14 Dec 2016 13:39:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83F0955FA0;
        Wed, 14 Dec 2016 13:39:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCHv2 2/5] submodule: modernize ok_to_remove_submodule to use argv_array
References: <20161213205622.841-1-sbeller@google.com>
        <20161213205622.841-3-sbeller@google.com>
Date:   Wed, 14 Dec 2016 10:39:14 -0800
In-Reply-To: <20161213205622.841-3-sbeller@google.com> (Stefan Beller's
        message of "Tue, 13 Dec 2016 12:56:19 -0800")
Message-ID: <xmqqfulqxsml.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D58D33C-C22C-11E6-B441-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Instead of constructing the NULL terminated array ourselves, we
> should make use of the argv_array infrastructure.
>
> While at it, adapt the error messages to reflect the actual invocation.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Looks good.

>
> diff --git a/submodule.c b/submodule.c
> index 45ccfb7ab4..9f0b544ebe 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1023,13 +1023,6 @@ int ok_to_remove_submodule(const char *path)
>  {
>  	ssize_t len;
>  	struct child_process cp = CHILD_PROCESS_INIT;
> -	const char *argv[] = {
> -		"status",
> -		"--porcelain",
> -		"-u",
> -		"--ignore-submodules=none",
> -		NULL,
> -	};
>  	struct strbuf buf = STRBUF_INIT;
>  	int ok_to_remove = 1;
>  
> @@ -1039,14 +1032,15 @@ int ok_to_remove_submodule(const char *path)
>  	if (!submodule_uses_gitfile(path))
>  		return 0;
>  
> -	cp.argv = argv;
> +	argv_array_pushl(&cp.args, "status", "--porcelain", "-u",
> +				   "--ignore-submodules=none", NULL);
>  	prepare_submodule_repo_env(&cp.env_array);
>  	cp.git_cmd = 1;
>  	cp.no_stdin = 1;
>  	cp.out = -1;
>  	cp.dir = path;
>  	if (start_command(&cp))
> -		die("Could not run 'git status --porcelain -uall --ignore-submodules=none' in submodule %s", path);
> +		die(_("could not run 'git status --porcelain -u --ignore-submodules=none' in submodule %s"), path);
>  
>  	len = strbuf_read(&buf, cp.out, 1024);
>  	if (len > 2)
> @@ -1054,7 +1048,7 @@ int ok_to_remove_submodule(const char *path)
>  	close(cp.out);
>  
>  	if (finish_command(&cp))
> -		die("'git status --porcelain -uall --ignore-submodules=none' failed in submodule %s", path);
> +		die(_("'git status --porcelain -u --ignore-submodules=none' failed in submodule %s"), path);
>  
>  	strbuf_release(&buf);
>  	return ok_to_remove;
