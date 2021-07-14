Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9866C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98B3613B6
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhGNSNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:13:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:49756 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhGNSNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 14:13:47 -0400
Received: (qmail 30099 invoked by uid 109); 14 Jul 2021 18:10:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 18:10:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26803 invoked by uid 111); 14 Jul 2021 18:10:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 14:10:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 14:10:53 -0400
From:   Jeff King <peff@peff.net>
To:     German Lashevich <german.lashevich@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report: GIT_CONFIG and user.email/name
Message-ID: <YO8ordiN18sNP6tA@coredump.intra.peff.net>
References: <1C6C1E49-5EC1-420D-A72A-8C50BD1931A2@getmailspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1C6C1E49-5EC1-420D-A72A-8C50BD1931A2@getmailspring.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 07:10:27PM +0200, German Lashevich wrote:

> I've faced an issue while trying to use a non-default .gitconfig file
> via specifying
> GIT_CONFIG environment variable.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> ```
> # use custom .gitconfig via GIT_CONFIG envvar:
> mkdir -p /tmp/git-test/repo
> cat <<EOT > /tmp/git-test/.gitconfig
> [user]
>     name = John Doe
>     email = john@doe.me
> EOT
> cd /tmp/git-test/repo
> git init
> export GIT_CONFIG=/tmp/git-test/.gitconfig
> echo Hi > readme.txt
> git add readme.txt
> git commit -m 'Initial commit'
> ```

The GIT_CONFIG variable doesn't work that way. It is not a general
mechanism used by all of Git, but rather a specific feature of the
git-config program (and even there it is a historical wart; you should
use "git config --file" instead).

One of these variables is probably more helpful:

  $ man git | sed -n '/GLOBAL/,/^$/p'
  GIT_CONFIG_GLOBAL, GIT_CONFIG_SYSTEM
    Take the configuration from the given files instead from global or
    system-level configuration files. If GIT_CONFIG_SYSTEM is set, the
    system config file defined at build time (usually /etc/gitconfig)
    will not be read. Likewise, if GIT_CONFIG_GLOBAL is set, neither
    $HOME/.gitconfig nor $XDG_CONFIG_HOME/git/config will be read. Can
    be set to /dev/null to skip reading configuration files of the
    respective level.

Note that they're new in v2.32.0.

-Peff
