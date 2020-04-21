Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4D5C2BA19
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 22:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B57206E9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 22:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDUW6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:58:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:35238 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725850AbgDUW6j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 18:58:39 -0400
Received: (qmail 31684 invoked by uid 109); 21 Apr 2020 22:58:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Apr 2020 22:58:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23047 invoked by uid 111); 21 Apr 2020 23:09:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Apr 2020 19:09:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Apr 2020 18:58:37 -0400
From:   Jeff King <peff@peff.net>
To:     Ilya Tretyakov <it@it3xl.ru>
Cc:     "brian m. carlson" <bk2204@github.com>, git@vger.kernel.org
Subject: Re: Credential helpers are no longer invoked in case of having
 sub-folder parts in a repository URL. Since 2.26.1 version
Message-ID: <20200421225837.GB3515235@coredump.intra.peff.net>
References: <CAOrRacVviJP3w98-=QpFKYp630cN3gZQYnvAWZXeKqZRk2UDXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOrRacVviJP3w98-=QpFKYp630cN3gZQYnvAWZXeKqZRk2UDXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 01:31:46AM +0300, Ilya Tretyakov wrote:

> Credential helpers are no longer invoked in case of having sub-folder
> parts in a repository URL.
> 
> For example, if we have a "/my-proj/" part in the repository URL.
> The following configuration doesn't invoke a credential helper script
> in 2.26.1 version of Git but invokes in 2.24.1.2.
> 
> [credential "https://git.exaple.com/my-proj/my-repo.git"]
>     helper = !'/c/some-path/bash-git-credential-helper/git-cred.sh'
> provide  repo_b

This is unrelated to the recent helper fixes in v2.26.x. Here's a simple
reproduction:

  url=https://git.example.com/my-proj/my-repo.git
  echo url=$url |
  GIT_TERMINAL_PROMPT=0 \
  ./git \
    -c credential.helper= \
    -c credential.$url.helper='!echo username=foo; echo password=bar;:' \
    credential fill

which should print a filled credential (with "foo/bar"), but will fail
with recent versions. It bisects to brian's 46fd7b3900 (credential:
allow wildcard patterns when matching config, 2020-02-20).

-Peff
