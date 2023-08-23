Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67340C3DA6F
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 19:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbjHWTWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 15:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbjHWTWL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 15:22:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C47BE6F
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 12:22:09 -0700 (PDT)
Received: (qmail 3063 invoked by uid 109); 23 Aug 2023 19:22:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Aug 2023 19:22:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11055 invoked by uid 111); 23 Aug 2023 19:22:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Aug 2023 15:22:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Aug 2023 15:22:07 -0400
From:   Jeff King <peff@peff.net>
To:     Gabriel =?utf-8?B?TsO8dHpp?= <gnuetzi@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git credential-cache manager is not treating `path=` correctly
Message-ID: <20230823192207.GC2355007@coredump.intra.peff.net>
References: <CAA9rTuccfyXO66YApDfss6JM9+JuUzZxDiYyfG_qShfehyAEsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA9rTuccfyXO66YApDfss6JM9+JuUzZxDiYyfG_qShfehyAEsQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2023 at 06:23:36PM +0200, Gabriel Nützi wrote:

> # Add 3 credentials, 2 specifics with `path=`
> # 1 with general host.
> {
>     echo "protocol=https"
>     echo "host=www.server.com"
>     echo "path=repos/1.git"
>     echo "username=banana"
>     echo "password=banana1"
> } | git credential approve
> 
> {
>     echo "protocol=https"
>     echo "host=www.server.com"
>     echo "path=repos/2.git"
>     echo "username=banana"
>     echo "password=banana2"
> } | git credential approve
> 
> {
>     echo "protocol=https"
>     echo "host=www.server.com"
>     echo "username=banana"
>     echo "password=general"
> } | git credential approve

I don't think we ever planned around this kind of "sometimes paths are
important, and sometimes not", and I'm not surprised it doesn't work.

The "useHTTPPath" flag is only read by the by the main Git side, and
just tells it whether to pass a "path" entry. On the helper side, any
omitted entry ("path" in the final case) means "match anything".

So that final command translates (from the helper's view) to "store
this, and delete any other credentials we have stored for
https://banana@www.server.com".

It might be possible to change the handling on the helper side to
distinguish between entries with no path and entries with a path, and
consider them separately. I don't know what gotchas we might see in that
case, though. I suspect at least in credential-store's on-disk format,
there is not really room to distinguish the empty-string path from "no
path given".

If you set credential.useHTTPPaths (so that it is applied consistently),
I think path-matching should work. But then you'd have to independently
store credentials for each path that could match the "generic" case.

As a workaround, you could use two different stores/caches. Something
like:

  [credential]
  # store most stuff here
  helper = store

  [credential "https://www.server.com/repos/1.git"]
  # turn off the main helper, and use a path-specific file instead
  helper =
  helper = store --file=$HOME/.git-credentials-path
  useHttpPath = true

-Peff
