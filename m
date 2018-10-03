Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F27B21F453
	for <e@80x24.org>; Wed,  3 Oct 2018 20:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJDDdN (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 23:33:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:40528 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726969AbeJDDdM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 23:33:12 -0400
Received: (qmail 8997 invoked by uid 109); 3 Oct 2018 20:43:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 20:43:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17591 invoked by uid 111); 3 Oct 2018 20:42:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Oct 2018 16:42:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2018 16:43:12 -0400
Date:   Wed, 3 Oct 2018 16:43:12 -0400
From:   Jeff King <peff@peff.net>
To:     Dimitri Kopriwa <d.kopriwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: Git credentials not working
Message-ID: <20181003204312.GC20709@sigill.intra.peff.net>
References: <a1ceb967-6020-6074-f504-c684242c79ab@gmail.com>
 <f4f7bd2c-4c48-e749-4df1-ddf05896b337@gmail.com>
 <20181003171104.GA12200@sigill.intra.peff.net>
 <89f60502-c67d-83b6-593b-a0e6d8567183@gmail.com>
 <20181003182409.GA14848@sigill.intra.peff.net>
 <84e704e0-fbf9-230f-459c-2927dea19a03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84e704e0-fbf9-230f-459c-2927dea19a03@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 04, 2018 at 02:34:17AM +0700, Dimitri Kopriwa wrote:

> I have replaced the way I fill the git credentials store, I have verify
> ~/.git-credentials and information are there, the ~/.gitconfig look fine
> too.
> 
> I still have 401 error when reading from that file.
> 
> This is the paste log : https://paste.gnome.org/pmntlkdw0
> 
> Now that I use git approve, I dont think that I need a custom helper.
> 
> Any idea why I still can't log in using git-credential?

Looking at your pastebin, it looks like the server sometimes takes it
and sometimes not. E.g., piping the log through:

  egrep '(Send|Recv) header:' |
  perl -lpe 's/^.*?(=>|<=) //'

I see:

  Send header: GET /example-keys/sample-project.git/info/refs?service=git-upload-pack HTTP/1.1
  Send header: User-Agent: git/2.19.0
  ...
  Recv header: HTTP/1.1 401 Unauthorized
  Recv header: WWW-Authenticate: Basic realm="GitLab"
  ...
  Send header: GET /example-keys/sample-project.git/info/refs?service=git-upload-pack HTTP/1.1
  Send header: Authorization: Basic <redacted>
  Send header: User-Agent: git/2.19.0
  ...
  Recv header: HTTP/1.1 200 OK

So that works. But then later we get:

  Send header: GET /example-keys/sample-project.git/info/refs?service=git-upload-pack HTTP/1.1
  Send header: User-Agent: git/2.19.0
  ...
  Recv header: HTTP/1.1 401 Unauthorized
  Recv header: WWW-Authenticate: Basic realm="GitLab"
  ...
  Send header: GET /example-keys/sample-project.git/info/refs?service=git-upload-pack HTTP/1.1
  Send header: Authorization: Basic <redacted>
  Send header: User-Agent: git/2.19.0
  ...
  Recv header: HTTP/1.1 401 Unauthorized

And then that causes credential-store to delete the non-working entry,
after which all of them must fail (because you have no working
credential, and presumably no terminal to prompt the user).

I have no idea why the same request would sometimes be allowed and
sometimes not. It's possible the <redacted> data is different in those
two times, but I don't know why that would be. It's also possible you're
hitting different load-balancing servers that behave differently.

-Peff
