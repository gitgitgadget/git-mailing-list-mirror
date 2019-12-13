Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A58C00454
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B3724671
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j0EOfEyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfLMV1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:27:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59365 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMV1j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:27:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01158A8525;
        Fri, 13 Dec 2019 16:27:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=BUCxXGoaH/1R7THnwmKxeqyvvKo=; b=j0EOfE
        yjjW840JTBHT6tOxcQdYP5HmbfJA0T8NIVPZvjhZS7DXELxxumybyeZGcjjC8aJj
        40y4c4YbOwTn455KFYzrbNOXWDlfcFV1icAbGJiXwle4Os/CRpc6X1kjLvafeSOq
        Df68zPvJSxvbb/L28NL2IbxNkbNzNajeGUsOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O0ZCSIAKQIRiEiIUTzrms6FRdOiw4I6W
        E4PuTUzKpnvNWmIKojYAvBruHZvl6PtIZX6QMvsnlquVc/mlo1bNPwtHuB7NSErt
        EcyfpQ6J4kwVBvyCvTJe6026IFZ+g9uhUyaslTP8gcPcvMjlTN+DTWy5yO6purBj
        ST5iCtjC0aY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDD3EA8524;
        Fri, 13 Dec 2019 16:27:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D0E8A8523;
        Fri, 13 Dec 2019 16:27:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 07/15] bugreport: add curl version
In-Reply-To: <20191213004312.169753-8-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 12 Dec 2019 16:43:04 -0800")
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-8-emilyshaffer@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Fri, 13 Dec 2019 13:27:31 -0800
Message-ID: <xmqqd0crj4qk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 607BD1B8-1DEF-11EA-8DAF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> It's possible for git-http* to be built separately from git; in that
> case we want to know what version of cURL is used by git-http*, not
> necessarily which version was present at git-bugreport's build time.
> So instead, ask git-http-fetch for the version information it knows
> about.
>
> git-http-fetch was chosen as git-http-backend was described as a
> server-side implementation, and as an accidental fetch in case of
> problems was considered less harmful than an accidental push.
>
> Since it could have been built at a different time, also report the
> version and built-from commit of git-http-fetch alongside the cURL info.

One possible issue I have is that I was hoping that eventually we
can discard "git http-fetch" altogether sometime in the future.
Does anybody still use the dumb HTTP transport seriously?  

And the first move in that direction would be to allow the system be
built without http-fetch, even if git-remote-curl (and its aliases)
would still be built to access smart-http transports.

So, I am not sure.  This is just the matter of adding an out-of-line
hidden option used only for environment inspection, so if it can be
done to git-remote-curl, that would probably be much more future
proof.

> diff --git a/bugreport.c b/bugreport.c
> index af715dc157..f5598513d9 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -5,6 +5,18 @@
>  #include "time.h"
>  #include "help.h"
>  #include <gnu/libc-version.h>
> +#include "run-command.h"
> +
> +static void get_http_version_info(struct strbuf *http_info)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	argv_array_push(&cp.args, "git");
> +	argv_array_push(&cp.args, "http-fetch");
> +	argv_array_push(&cp.args, "-V");
> +	if (capture_command(&cp, http_info, 0))
> +	    strbuf_addstr(http_info, "'git-http-fetch -V' not supported\n");

OK.  We probably can also take the compile-time "NO_CURL" into account,
so that we can tell a misconfigured installation that wanted to have
CURL but failed to install a usable http-fetch and an installation
that deliberately omitted anything cURL?

>  static void get_system_info(struct strbuf *sys_info)
>  {
> @@ -32,6 +44,10 @@ static void get_system_info(struct strbuf *sys_info)
>  	strbuf_addstr(sys_info, "glibc version: ");
>  	strbuf_addstr(sys_info, gnu_get_libc_version());
>  	strbuf_complete_line(sys_info);
> +
> +	strbuf_addstr(sys_info, "git-http-fetch -V:\n");
> +	get_http_version_info(sys_info);
> +	strbuf_complete_line(sys_info);
>  }
>  
>  static const char * const bugreport_usage[] = {
> diff --git a/http-fetch.c b/http-fetch.c
> index a32ac118d9..31844812a1 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -3,9 +3,18 @@
>  #include "exec-cmd.h"
>  #include "http.h"
>  #include "walker.h"
> +#include "version.h"
>  
>  static const char http_fetch_usage[] = "git http-fetch "
> -"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
> +"[-c] [-t] [-a] [-v] [-V] [--recover] [-w ref] [--stdin] commit-id url";
> +
> +void NORETURN version_info()

void NORETURN version_info(void)


> +{
> +	printf("git-http-fetch version: %s\n", git_version_string);
> +	printf("built from commit: %s\n", git_built_from_commit_string);
> +	printf("curl version: %s\n", curl_version());
> +	exit(0);
> +}
>  
>  int cmd_main(int argc, const char **argv)
>  {
> @@ -26,6 +35,8 @@ int cmd_main(int argc, const char **argv)
>  		} else if (argv[arg][1] == 'a') {
>  		} else if (argv[arg][1] == 'v') {
>  			get_verbosely = 1;
> +		} else if (argv[arg][1] == 'V') {
> +			version_info();
>  		} else if (argv[arg][1] == 'w') {
>  			write_ref = &argv[arg + 1];
>  			arg++;
