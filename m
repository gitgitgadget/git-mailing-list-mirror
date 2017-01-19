Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B31220A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbdASVbE (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:31:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:41794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbdASVbD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:31:03 -0500
Received: (qmail 15472 invoked by uid 109); 19 Jan 2017 21:31:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 21:31:03 +0000
Received: (qmail 9356 invoked by uid 111); 19 Jan 2017 21:31:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 16:31:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 16:31:01 -0500
Date:   Thu, 19 Jan 2017 16:31:01 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH v2 2/2] Be more careful when determining whether a remote
 was configured
Message-ID: <20170119213100.g72ml7r2khu7bvey@sigill.intra.peff.net>
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
 <cover.1484860744.git.johannes.schindelin@gmx.de>
 <1605031b76025f4bd0e485705c34a25557bb75a1.1484860744.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1605031b76025f4bd0e485705c34a25557bb75a1.1484860744.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 10:20:02PM +0100, Johannes Schindelin wrote:

> There is only one caller of remote_is_configured() (in `git fetch`) that
> may want to take remotes into account even if they were configured
> outside the repository config; all other callers essentially try to
> prevent the Git command from overwriting settings in the repository
> config.
> 
> To accommodate that fact, the remote_is_configured() function now
> requires a parameter that states whether the caller is interested in all
> remotes, or only in those that were configured in the repository config.

Just to make sure I understand the issue, the problem is that:

  git config --global remote.foo.url whatever
  git fetch --multiple foo bar

would not work without this part of the patch?

I'm trying to figure out why "fetch --multiple" wouldn't just take a url
in the first place. I guess it is because multiple fetch is useless
without refspecs (since otherwise you're just writing to FETCH_HEAD,
which gets immediately overwritten). I wonder if that test really should
be:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c85f3471d..9024cfffa 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1014,9 +1014,9 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 	git_config(get_remote_group, &g);
 	if (list->nr == prev_nr) {
 		struct remote *remote;
-		if (!remote_is_configured(name))
-			return 0;
 		remote = remote_get(name);
+		if (!remote->fetch_refspec_nr)
+			return 0;
 		string_list_append(list, remote->name);
 	}
 	return 1;

It's outside the scope of your patches, so I think we are OK to just
ignore it. But if you want to pursue it, it avoids having to add the
extra parameter to remote_is_configured().

> Many thanks to Jeff King whose tireless review helped with settling for
> nothing less than the current strategy.

Just how I wanted to be immortalized in git's commit history. ;)

>  builtin/fetch.c   |  2 +-
>  builtin/remote.c  | 14 +++++++-------
>  remote.c          | 12 ++++++++++--
>  remote.h          |  4 ++--
>  t/t5505-remote.sh |  2 +-
>  5 files changed, 21 insertions(+), 13 deletions(-)

Patch itself looks OK to me.

-Peff
