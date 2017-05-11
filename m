Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9851C1FF34
	for <e@80x24.org>; Thu, 11 May 2017 07:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbdEKHnD (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 03:43:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:49162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754826AbdEKHnC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 03:43:02 -0400
Received: (qmail 27573 invoked by uid 109); 11 May 2017 07:42:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 07:42:59 +0000
Received: (qmail 9719 invoked by uid 111); 11 May 2017 07:43:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 03:43:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 03:42:57 -0400
Date:   Thu, 11 May 2017 03:42:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Possible bug in includeIf / conditional includes
Message-ID: <20170511074257.xueofze3dv3xwrql@sigill.intra.peff.net>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
 <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com>
 <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
 <20170511062616.f7rg6f5cgrqeh7gf@sigill.intra.peff.net>
 <20170511062924.6euaynsbyocjcw3q@sigill.intra.peff.net>
 <CACBZZX4ob04fG9ZZtvbdcqrYOKijoZohVdUCNyeayHZtdtNyxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4ob04fG9ZZtvbdcqrYOKijoZohVdUCNyeayHZtdtNyxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 09:19:50AM +0200, Ævar Arnfjörð Bjarmason wrote:

> 1. It says "The included file is expanded immediately, as if its
> contents had been found at the location of the include directive.". At
> first I thought this referred to glob expansion, not
> s/expanded/interpolated/, the example section uses "expand" in the
> context of pathnames, which caused the confusion.

Perhaps it should say "The contents of the included file are expanded
immediately, as if they had been found at..."?

> Maybe this would make that less confusing by saying the same thing
> without using the same phrasing to mean completely different things:
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d51..49855353c7 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -167,8 +167,8 @@ Example
> 
>         [include]
>                 path = /path/to/foo.inc ; include by absolute path
> -               path = foo ; expand "foo" relative to the current file
> -               path = ~/foo ; expand "foo" in your `$HOME` directory
> +               path = foo ; find & include "foo" relative to the current file
> +               path = ~/foo ; find & include "foo" in your `$HOME` directory

Yeah, probably makes sense to use a different word than "expand" here.

> 2. There is no example of such expansion for IncludeIf, prose should
> always be backed up by examples for the lazy reader when possible:
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d51..fc4b87cd7e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -173,6 +173,8 @@ Example
>         ; include if $GIT_DIR is /path/to/foo/.git
>         [includeIf "gitdir:/path/to/foo/.git"]
>                 path = /path/to/foo.inc
> +               path = foo ; find & include "foo" relative to the current file
> +               path = ~/foo ; find & include "foo" in your `$HOME` directory
> 
>         ; include for all repositories inside /path/to/group
>         [includeIf "gitdir:/path/to/group/"]

Yeah, makes sense.

> 3. When I read reference docs I almost never start at the beginning &
> read it all the way through, in this case I thought I could help
> someone out by maybe answering a question on the ML quickly, so I went
> to the examples section, found no example (fixed above), then searched
> for "relative" or "path" in my pager and the only results were for the
> "Includes" section that has a paragraph that's only talking about
> "include.path".

I do, too. And I'm all in favor of structuring things to accommodate
that flow. But at some point we have to assume the user actually reads
the documentation. :)

> Of course we say "same rules apply" below, but I managed not to spot
> that. Maybe this:
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d51..b35d9a7b80 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -95,8 +95,11 @@ Conditional includes
> 
>  You can include a config file from another conditionally by setting a
>  `includeIf.<condition>.path` variable to the name of the file to be
> -included. The variable's value is treated the same way as
> -`include.path`. `includeIf.<condition>.path` can be given multiple times.
> +included.
> +
> +If variable's value is a relative path it's treated the same way as
> +`include.path`. `includeIf.<condition>.path` can also be given
> +multiple times.

I don't like this because it copies the rules for _one_ property to the
conditional section. What happens when you're looking for some other
property of include.path?

I think in your case you found the "relative" section in the earlier
paragraph, but there was no link there to the includeIf behavior. So
should that earlier paragraph just get the "includeIf.path behaves the
same way" mention?

I suspect that whole paragraph under Includes could be reworded to make
it clear that anything it is saying applies equally to include.$key and
includeIf.*.$key, and then that would future-proof us for other
modifications.

-Peff
