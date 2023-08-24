Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE921C7EE2C
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 14:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbjHXOo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 10:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241530AbjHXOoo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 10:44:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7501F1BE
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 07:44:40 -0700 (PDT)
Received: (qmail 13245 invoked by uid 109); 24 Aug 2023 14:44:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Aug 2023 14:44:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19514 invoked by uid 111); 24 Aug 2023 14:44:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Aug 2023 10:44:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Aug 2023 10:44:39 -0400
From:   Jeff King <peff@peff.net>
To:     Ganriel =?utf-8?B?TsO8dHpp?= <gnuetzi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git credential-cache manager is not treating `path=` correctly
Message-ID: <20230824144439.GB3108100@coredump.intra.peff.net>
References: <20230823192207.GC2355007@coredump.intra.peff.net>
 <14F3D856-6A3B-45F8-B5FD-9CD5D0CB7C47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14F3D856-6A3B-45F8-B5FD-9CD5D0CB7C47@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2023 at 11:02:44PM +0200, Ganriel Nützi wrote:

> What I did not get from the documentation ist that a “store” of a
> generic (without path) credential , e.g https://www.server.com will
> just overwrite the more specific ones already in there. (So that is
> the case in my test, right? And the prompt happens in the first fill
> because useHttpPath=true but there is nomore any credential entry in
> the cache which would match (only the generic but that does not
> match), right?)

Right, exactly. It's possible that other helpers may behave differently
here, but certainly the scheme used by both "store" and "cache" is to
delete/replace anything that matches with the new credential.

> I am not sure but I thought that using cache is safer than store
> because i generally dont want to have credentials on a disk.

It is safer. I used the "store" one while testing because it is easy to
look at its internal state at any point with "cat ~/.git-credentials". :)

But the same logic should apply to "cache", and my "use two helpers"
trick should work by giving it a separate socket, like:

  [credential]
  helper = cache

  [credential "https://www.server.com/repos/1.git"]
  # separate socket/daemon for path-respecting entries
  helper =
  helper = credential --socket=$HOME/.git-credential-cache/socket-path
  useHttpPath = true

-Peff
