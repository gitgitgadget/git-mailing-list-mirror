Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07849C43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 17:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB612465E
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 17:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfLORTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:19:08 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:43300 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbfLORTH (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Dec 2019 12:19:07 -0500
Received: from app10-neu.ox.hosteurope.de ([92.51.170.144]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1igXXt-0006MX-BA; Sun, 15 Dec 2019 18:19:05 +0100
Date:   Sun, 15 Dec 2019 18:19:05 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Message-ID: <264571040.270538.1576430345179@ox.hosteurope.de>
In-Reply-To: <b7d5a758-9753-bb8b-f66e-6435fb19046b@gmail.com>
References: <492636883.190386.1576264842701@ox.hosteurope.de>
 <bdb9201f-b77f-ab3c-251f-d902c76fa9bc@gmail.com>
 <20191213195215.GA862734@coredump.intra.peff.net>
 <b7d5a758-9753-bb8b-f66e-6435fb19046b@gmail.com>
Subject: Re: Parallel fetch and commit graph writing results in locking
 failure (even on linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev64
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1576430347;f830f7ac;
X-HE-SMSGID: 1igXXt-0006MX-BA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Derrick Stolee <stolee@gmail.com> hat am 13. Dezember 2019 um 20:58 geschrieben:
> 
> 
> On 12/13/2019 2:52 PM, Jeff King wrote:
> > On Fri, Dec 13, 2019 at 02:35:47PM -0500, Derrick Stolee wrote:
> > 
> >> I don't think so. I think you just found a bug where the
> >> fetch.writeCommitGraph logic doesn't work with parallel fetch
> >> jobs (only one can write at a time).
> >>
> >> I believe the fix would be to write the commit-graph after
> >> all of the jobs have completed, which should mean we need to
> >> move the call to write_commit_graph_reachable() somewhere else
> >> inside builtin/fetch.c.
> > 
> > This should be fixed in master by bcb06e204c (Merge branch
> > 'js/fetch-multi-lockfix', 2019-12-01), I think.
> 
> Thanks, Peff. That exactly looks like the right fix. The
> actual commit is 7d8e72b9 ("fetch: avoid locking issues between
> fetch.jobs/fetch.writeCommitGraph" 2019-11-03). I had forgotten
> that this was already fixed.

Thanks Stolee and Peff, I'll update to a version with that fix. And in the unlikely case this does not resolve my issue, report back.
 
> Here is the diff, for reference:
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 8d27f8abb7..20bcda09c4 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1602,7 +1602,8 @@ static int fetch_multiple(struct string_list *list, int max_children)
>                         return errcode;
>         }
>  
> -       argv_array_pushl(&argv, "fetch", "--append", "--no-auto-gc", NULL);
> +       argv_array_pushl(&argv, "fetch", "--append", "--no-auto-gc",
> +                       "--no-write-commit-graph", NULL);
>         add_options_to_argv(&argv);
>  
>         if (max_children != 1 && list->nr != 1) {
> 
> -Stolee
>
