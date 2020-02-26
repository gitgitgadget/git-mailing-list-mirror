Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BACBC4BA0D
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 03:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DA32067C
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 03:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgBZDrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:47:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:54494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726024AbgBZDrc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 22:47:32 -0500
Received: (qmail 17039 invoked by uid 109); 26 Feb 2020 03:47:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Feb 2020 03:47:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22721 invoked by uid 111); 26 Feb 2020 03:56:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2020 22:56:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Feb 2020 22:47:31 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Chris Jerdonek <chris.jerdonek@gmail.com>, git@vger.kernel.org
Subject: Re: create reflog for reflog-less ref
Message-ID: <20200226034731.GA2915944@coredump.intra.peff.net>
References: <CAOTb1wc2uMSyc7DMau2cWrWtk=_Z94+CCovORj1dGCrwgJhL=w@mail.gmail.com>
 <20200226023909.GC7911@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200226023909.GC7911@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 02:39:09AM +0000, brian m. carlson wrote:

> There is the option core.logAllRefUpdates, which has the value "always"
> in more modern versions of Git.  The documentation says,
> 
>   If [the option is set to always, then a missing reflog is
>   automatically created for any ref under refs/.
> 
> Now, that assumes that you want reflogs for all your refs, but there's
> really not much downside to having a reflog and not using it.

The current rule is actually to append to any reflog that already
exists, or to consult core.logAllRefUpdates when deciding whether to
create one that doesn't exist. So I think setting a one-shot config
variable like:

  git -c core.logAllRefUpdates=always update-ref refs/foo/bar ...

would create the reflog, and then any subsequent updates (even without
that config set) would append to it.

You can also do this:

  mkdir -p .git/logs/refs/foo/
  touch .git/logs/refs/foo/bar
  git update-ref refs/foo/bar ...

but I wouldn't recommend it. When we eventually move to supporting other
ref backend formats, they won't necessarily store the logs in the same
way.

-Peff
