Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCC9C2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB8F2228A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgDFNF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:05:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:34228 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728077AbgDFNFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 09:05:25 -0400
Received: (qmail 23361 invoked by uid 109); 6 Apr 2020 13:05:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Apr 2020 13:05:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9787 invoked by uid 111); 6 Apr 2020 13:15:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Apr 2020 09:15:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Apr 2020 09:05:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?VG9tw6HFoSBQcm9jaMOhemth?= <tomas.prochazka5d@gmail.com>
Cc:     git@vger.kernel.org, tomas.volf@showmax.com
Subject: Re: Fwd: Q: use '-C' flag with 'git config --global'
Message-ID: <20200406130524.GA1276@coredump.intra.peff.net>
References: <CA+Sgv42V+xfoJVoFpPkWREXT0yuKZDeMDEGa3y8NDVU-4D1iYA@mail.gmail.com>
 <CA+Sgv42bOAaRBX99EpgpnSkGXFCWFpED7hwdwkWmPSOKuL1VBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+Sgv42bOAaRBX99EpgpnSkGXFCWFpED7hwdwkWmPSOKuL1VBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 10:48:06AM +0200, Tomáš Procházka wrote:

> [includeIf "gitdir:~/Workspace/Showmax/"]
>    path = ~/Workspace/Showmax/.gitconfig
> [...]
> I get correct email setting if I run command without `--global` flag.
> But What I understand from the [`git-config`
> docs](https://git-scm.com/docs/git-config#_description) if no flag is
> passed the values are read from system, global and local.

Right, I'd expect that to work, but...

> If I run commands one by one, No returns the ~correct~ expected email:
> 
> ~ $ git -C <pwd/to/showmax/project> config --system user.email
> ~ $ git -C <pwd/to/showmax/project> config --global user.email
> tomas.prochazka5d@gmail.com
> ~ $ git -C <pwd/to/showmax/project> config --local user.email

There's another difference when asking to read from a specific file:
includes are not turned on by default. Try

  git -C ... config --global --includes user.email

This is covered briefly in git-config(1):

  --[no-]includes
    Respect include.* directives in config files when looking up values.
    Defaults to off when a specific file is given (e.g., using --file,
    --global, etc) and on when searching all config files.

This can be confusing, but was necessary to keep compatibility with
scripted manipulations of those files when includes were introduced.

-Peff
