Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940C1CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 12:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjIYMJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 08:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjIYMJn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 08:09:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B7BA3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 05:09:36 -0700 (PDT)
Received: (qmail 4953 invoked by uid 109); 25 Sep 2023 12:09:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Sep 2023 12:09:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12641 invoked by uid 111); 25 Sep 2023 12:09:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Sep 2023 08:09:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Sep 2023 08:09:35 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/6] ci: add a GitHub workflow to submit Coverity scans
Message-ID: <20230925120935.GA1623701@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <8cb92968c5ebd38f328ed325ddf7f2e531dc9190.1695379323.git.gitgitgadget@gmail.com>
 <20230923064948.GB1469941@coredump.intra.peff.net>
 <d4dc96a9-fd5a-8238-e411-edd605d415f3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4dc96a9-fd5a-8238-e411-edd605d415f3@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 01:52:34PM +0200, Johannes Schindelin wrote:

> > You might want "--fail" or "--fail-with-body" here. I think any
> > server-side errors (like a missing or invalid token or project name)
> > will result in a 401.
> 
> Sadly, https://curl.se/docs/manpage.html#-f says this:
> 
> 	This method is not fail-safe and there are occasions where
> 	non-successful response codes slip through, especially when
> 	authentication is involved (response codes 401 and 407).
> 
> 401 is the precise case we're hitting when the token or the project name
> are incorrect.
>
> Having said that, I just tested with this particular host, and `curl -f`
> does fail with [exit code 22](https://curl.se/docs/manpage.html#22) as one
> would desire. So I will make that change.

The manpage is rather vague about what those "occasions" are, but I
think we are probably OK since we are not sending HTTP-level
credentials, according to:

  https://github.com/curl/curl/commit/cde5e35d9b046b224c64936c432d67c9de8bcc9e

At any rate, even if this did not catch every failure, I think we are
better off catching more rather than fewer.

> As to `--fail-with-body`: it is too new to use (it was [introduced in cURL
> v7.76.0](https://curl.se/docs/manpage.html#--fail-with-body) and Ubuntu
> v20.04 [comes with
> v7.68.0](https://packages.ubuntu.com/search?suite=focal&searchon=names&keywords=curl),
> i.e. is missing that option).
> 
> In any case, in my tests, `--fail-with-body` did not show anything more
> than `--fail` in this instance. Maybe for you it is different?

No, I don't think it's worth worrying about here. It could help with
debugging if their server returns something generic like a 500 code
along with a more detailed reason (we do something similar in
git-remote-curl to show failed bodies). But if it's at all more hassle
than typing "--with-body" it is not worth the effort.

> > I notice you put the "project" variable in the query string. Can it be
> > a --form, too, for symmetry?
> 
> The instructions at https://scan.coverity.com/projects/git/builds/new (in
> the "Automation" section) are very clear that `project` should be passed
> as a GET variable.
> 
> Even if using a POST variable would work, I'd rather stay with the
> officially-documented way.

That seems like good reasoning to me.

-Peff
