Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49272C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF49611AB
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhDOIaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:30:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:53056 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbhDOI37 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 04:29:59 -0400
Received: (qmail 9531 invoked by uid 109); 15 Apr 2021 08:29:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 08:29:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14039 invoked by uid 111); 15 Apr 2021 08:29:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 04:29:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 04:29:34 -0400
From:   Jeff King <peff@peff.net>
To:     "Simon, Martin (Digiteq Automotive)" 
        <Martin.Simon@digiteqautomotive.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: possible race condition (fetch-pack: unexpected disconnect while
 reading sideband packet)
Message-ID: <YHf5bkiE7SVPTBvU@coredump.intra.peff.net>
References: <df13300936784af7bb6c23f9fe0465c9@digiteqautomotive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df13300936784af7bb6c23f9fe0465c9@digiteqautomotive.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 10:12:44AM +0000, Simon, Martin (Digiteq Automotive) wrote:

> Actual result (when failed):
> Cloning into 'local-repo-name'...
> remote: Enumerating objects: 237, done.
> remote: Counting objects: 100% (237/237), done.
> remote: Compressing objects: 100% (129/129), done.
> fetch-pack: unexpected disconnect while reading sideband packet
> fatal: early EOF
> fatal: fetch-pack: invalid index-pack output

This could be many things. A bug or race on the client side is possible,
but it could also be that the network session really _is_ being
disconnected. This could be something in the network stack itself
terminating the connection, or it could be a bug or other error on the
server.

Some things to consider/try:

  - you can run with GIT_TRACE_PACKET=1 set in the environment, which
    will dump the protocol messages that Git sees (this may not be
    enlightening since the problem case seems to be a hangup, but
    perhaps the moment it happens will be relevant)

  - you didn't say which protocol you're using. If it's http, try
    setting GIT_TRACE_CURL, too, and it will dump debugging data about
    the http session

  - if possible, try a different protocol (like ssh) and see if the
    problem continues to show up

  - look at server-side logs to see how the server perceives the
    sessions. Does it report any errors that might cause it to hang up?
    Does it see a client-side hangup (which might be indicative of
    something flaky in the network)?

-Peff
