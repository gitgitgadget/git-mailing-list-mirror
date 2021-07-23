Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F446C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1222860EE2
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhGWG0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:26:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:55344 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234152AbhGWG03 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 02:26:29 -0400
Received: (qmail 10087 invoked by uid 109); 23 Jul 2021 07:07:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 07:07:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22660 invoked by uid 111); 23 Jul 2021 07:07:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 03:07:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 03:07:02 -0400
From:   Jeff King <peff@peff.net>
To:     Oliver Niebuhr <oliver.niebuhr@oliverniebuhr.de>
Cc:     git@vger.kernel.org
Subject: Re: [Bug Report] Git does not push signingkey ID to GPG
Message-ID: <YPpqlnuGrk8Gunep@coredump.intra.peff.net>
References: <dfeebef5-6f48-082d-f49d-832863ff62a8@oliverniebuhr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfeebef5-6f48-082d-f49d-832863ff62a8@oliverniebuhr.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 01:42:20AM +0200, Oliver Niebuhr wrote:

> I have edit the .gitconfig File accordingly and added
> 
> [user]
> signingkey = NNN
> [commit]
> gpgsign = true
> [alias]
> amend = commit -S -s --amend
> cm = commit -S -s
> commit = commit -S -s
> tag = tag -S -s
> [gpg]
> program = C:\\Program Files (x86)\\GnuPG\\bin\\gpg.exe
> 
> The Git User Name and eMail Address are the same which are set in the used
> GPG Certificate.
> 
> Using '-S' from the Windows CMD Shell and Git Bash leads to an error.
> Neither typing the command manually or using it through an alias works.
> 
> When I switch '-S' with '--gpg-sign=NNN' everything works as it should from
> CMD Line - but not when I use for example SmartGit and enable 'Sign all
> Commits'. After countless hours looking through the Web, I am not out of
> Ideas.

This works fine for me. I get:

  $ GIT_TRACE=1 git -c user.signingkey=1234abcd commit -S --amend --no-edit
  03:03:26.487264 [pid=1285432] git.c:455           trace: built-in: git commit -S --amend --no-edit
  03:03:26.491963 [pid=1285432] run-command.c:666   trace: run_command: gpg --status-fd=2 -bsau 1234abcd
  error: gpg failed to sign the data
  fatal: failed to write commit object

In your trace, the key parameter that's passed is the empty string:

> 00:30:45.064284 run-command.c:667       trace: run_command: 'C:\Program
> Files (x86)\GnuPG\bin\gpg.exe' -bsau ''
> gpg: skipped "": Invalid user ID
> gpg: signing failed: Invalid user ID

You showed config with user.signingkey set. Is it possible that you have
other config (say, in the repo config file), that is taking precedence?

What does:

  git config --show-origin --get-all user.signingkey

say when run inside the repository?

-Peff
