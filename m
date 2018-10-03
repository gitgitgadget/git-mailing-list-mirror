Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA791F453
	for <e@80x24.org>; Wed,  3 Oct 2018 17:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeJDAAX (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 20:00:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:40064 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726862AbeJDAAW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 20:00:22 -0400
Received: (qmail 32635 invoked by uid 109); 3 Oct 2018 17:11:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 17:11:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14741 invoked by uid 111); 3 Oct 2018 17:10:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Oct 2018 13:10:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2018 13:11:05 -0400
Date:   Wed, 3 Oct 2018 13:11:05 -0400
From:   Jeff King <peff@peff.net>
To:     Dimitri Kopriwa <d.kopriwa@gmail.com>
Cc:     git-security@googlegroups.com, git@vger.kernel.org
Subject: Re: Fwd: Git credentials not working
Message-ID: <20181003171104.GA12200@sigill.intra.peff.net>
References: <a1ceb967-6020-6074-f504-c684242c79ab@gmail.com>
 <f4f7bd2c-4c48-e749-4df1-ddf05896b337@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4f7bd2c-4c48-e749-4df1-ddf05896b337@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 09:06:38PM +0700, Dimitri Kopriwa wrote:

> 18:25:52.940307 git.c:659               trace: exec: git-credential-store erase
> 18:25:52.940365 run-command.c:637       trace: run_command: git-credential-store erase
> remote: HTTP Basic: Access denied
> fatal: Authentication failed for
> 'https://git.example.com/example/some-project.git/'
> [...]
> 
> Can you please help me found why is git credential-store erase called ?

This is expected. We tried to use a credential that was rejected by the
server, so we told all of the helpers it was invalid. You can try
running GIT_TRACE_CURL=1 to see the HTTP conversation. There will be an
HTTP 401 with the authentication failure, though it may not tell you
anything more useful than that.

git-credential-store is meant to be used interactively, to insert and
erase credentials as they're grabbed from the terminal.

It sounds more like you want to just have a stored credential that you
try to use. You could do that with a custom helper. E.g., something like
this in your ~/.gitconfig:

  [credential "https://example.com"]
  helper = "!f() { test $1 = get && echo password=$(cat /path/with/password); }; f"

-Peff
