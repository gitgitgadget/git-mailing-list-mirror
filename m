Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06204C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1325610A3
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbhIIRaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 13:30:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56060 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhIIRaC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 13:30:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3A44DE24B;
        Thu,  9 Sep 2021 13:28:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VQl9/fMcyMAwT9nOG/gM22nbwfYPzePpkjPYzj
        OMT5s=; b=c1SUrd7QcRzO8T+lKAQXa9eyt/16DYxUvjPkKycBj5M09jJhVFjce4
        7gP8zGHKBwwKa7lewIzwpP3cEmm/vEUMg+uH3VsYUt4coQcF256fdo2v5PbawmH6
        W/dw8xsMFtEQatBJ6FwQfmRDn7jRJ8Dbgi8CCbFJCaX/OkLpJ7M98=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8F66DE24A;
        Thu,  9 Sep 2021 13:28:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E9ACDE249;
        Thu,  9 Sep 2021 13:28:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
        <YTOW352xtsbvJcKy@coredump.intra.peff.net>
        <20210907211128.mauwgxupbredgx7w@meerkat.local>
        <YTiVDo4m5B5RcfCg@coredump.intra.peff.net>
        <YTiXEEEs36NCEr9S@coredump.intra.peff.net>
Date:   Thu, 09 Sep 2021 10:28:50 -0700
In-Reply-To: <YTiXEEEs36NCEr9S@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Sep 2021 06:57:20 -0400")
Message-ID: <xmqqee9x1wvh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66280C14-1193-11EC-8AA5-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 08, 2021 at 06:48:47AM -0400, Jeff King wrote:
>
>> Both of the included examples here have been tested to work. The one for
>> lighttpd is a little less direct than I'd like, but I couldn't find a
>> way to directly set an environment variable to the value of a request
>> header. From my reading of the documentation, lighttpd will set
>> HTTP_GIT_PROTOCOL automatically, but git-http-backend looks only at
>> GIT_PROTOCOL. Arguably http-backend should do this translation itself.

Nice.

These headers get HTTP_* prefixed as a security measure when servers
expose them to their configuration mechanisms because these names
are attacker controlled.  I had a flawed mental model in which the
servers' configuration controls which one of these resulting HTTP_*
headers are passed to CGI and externals selectively, but if servers
pass all HTTP_* environment variables to CGI and externals without
any filtering, the patch you gave here is the most logical solution.

Will queue.

> -- >8 --
> Subject: [PATCH] http-backend: handle HTTP_GIT_PROTOCOL CGI variable
>
> When a client requests the v2 protocol over HTTP, they set the
> Git-Protocol header. Webservers will generaly make that available to our
> CGI as HTTP_GIT_PROTOCOL in the environment. However, that's not
> sufficient for upload-pack, etc, to respect it; they look in
> GIT_PROTOCOL (without the HTTP_ prefix).
>
> Either the webserver or the CGI is responsible for relaying that HTTP
> header into the GIT_PROTOCOL variable. Traditionally, our tests have
> configured the webserver to do so, but that's a burden on the server
> admin. We can make this work out of the box by having the http-backend
> CGI copy the contents.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http-backend.c          | 4 ++++
>  t/lib-httpd/apache.conf | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/http-backend.c b/http-backend.c
> index b329bf63f0..2f4b4c11de 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -739,6 +739,7 @@ static int bad_request(struct strbuf *hdr, const struct service_cmd *c)
>  int cmd_main(int argc, const char **argv)
>  {
>  	char *method = getenv("REQUEST_METHOD");
> +	const char *proto_header;
>  	char *dir;
>  	struct service_cmd *cmd = NULL;
>  	char *cmd_arg = NULL;
> @@ -789,6 +790,9 @@ int cmd_main(int argc, const char **argv)
>  	http_config();
>  	max_request_buffer = git_env_ulong("GIT_HTTP_MAX_REQUEST_BUFFER",
>  					   max_request_buffer);
> +	proto_header = getenv("HTTP_GIT_PROTOCOL");
> +	if (proto_header)
> +		setenv(GIT_PROTOCOL_ENVIRONMENT, proto_header, 1);
>  
>  	cmd->imp(&hdr, cmd_arg);
>  	return 0;
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index afa91e38b0..71761e3299 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -81,8 +81,6 @@ PassEnv GIT_TRACE
>  PassEnv GIT_CONFIG_NOSYSTEM
>  PassEnv GIT_TEST_SIDEBAND_ALL
>  
> -SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
> -
>  Alias /dumb/ www/
>  Alias /auth/dumb/ www/auth/dumb/
