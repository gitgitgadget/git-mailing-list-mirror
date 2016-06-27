Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URI_TRY_3LD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7475B2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 19:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbcF0Td0 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 15:33:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:33629 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751639AbcF0TdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 15:33:25 -0400
Received: (qmail 4197 invoked by uid 102); 27 Jun 2016 19:33:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:33:25 -0400
Received: (qmail 12626 invoked by uid 107); 27 Jun 2016 19:33:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:33:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 15:33:23 -0400
Date:	Mon, 27 Jun 2016 15:33:23 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
Subject: Re: [PATCH] connect: read $GIT_SSH_COMMAND from config file
Message-ID: <20160627193322.GB10877@sigill.intra.peff.net>
References: <20160626111635.6809-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160626111635.6809-1-pclouds@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 26, 2016 at 01:16:35PM +0200, Nguyễn Thái Ngọc Duy wrote:

> Similar to $GIT_ASKPASS or $GIT_PROXY_COMMAND, we also read from
> config file first then fall back to $GIT_SSH_COMMAND.
> 
> This is useful for selecting different private keys targetting the
> same host (e.g. github)
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  core.gitProxy can also be used for my purpose (I need pushing, not
>  fetching though; the document says for fetching but I guess
>  core.gitProxy always works for pushing), but then the key file
>  is hidden behind the script. And writing a script for this seems a
>  bit overkill.

This patch makes sense to me. The way I have done this in the past is to
use ssh's config. So I set my remote in one repo to "foo:repo1.git" and
another to "bar:repo2.git", and then:

  Host foo
    Hostname actual-host.example.com
    SomeOption ...

  Host bar
    Hostname actual-host.example.com
    SomeOption ...

(or more likely, most repos are fine with the defaults, and you only
need one fake host block for the oddball repo).

But I think your solution is a more direct and less confusing way of
accomplishing the same thing.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 58673cf..3bf070c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -443,6 +443,13 @@ specify that no proxy be used for a given domain pattern.
>  This is useful for excluding servers inside a firewall from
>  proxy use, while defaulting to a common proxy for external domains.
>  
> +core.sshCommand::
> +	If this variable is set then 'git fetch' and 'git push' will

Probably s/set/set,/.

> +	use the specified command instead of 'ssh' when they need to
> +	connect to a remote system. The command is in the same form as
> +	'GIT_SSH_COMMAND' environment variable and is overriden when
> +	the environment variable is set.

Probably s/'GIT_SSH_COMMAND'/the &/.

Are we using backticks for typesetting environment variables now? That
has always been my preference, but I haven't kept up with the typography
patches that have been flying lately. +cc Matthieu.

(Similar question for commands like 'git fetch').

> diff --git a/connect.c b/connect.c
> index c53f3f1..722dc3f 100644
> --- a/connect.c
> +++ b/connect.c

The code itself looks obviously correct. :)

-Peff
