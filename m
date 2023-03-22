Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DFAC6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjCVRUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCVRUb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:20:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D6361337
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:20:09 -0700 (PDT)
Received: (qmail 9895 invoked by uid 109); 22 Mar 2023 17:19:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Mar 2023 17:19:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15728 invoked by uid 111); 22 Mar 2023 17:19:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Mar 2023 13:19:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Mar 2023 13:19:52 -0400
From:   Jeff King <peff@peff.net>
To:     "Coirier, Emmanuel" <Emmanuel.Coirier@caissedesdepots.fr>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git credential doesn't honor git config precedence rules
Message-ID: <20230322171952.GB4296@coredump.intra.peff.net>
References: <PR2P264MB07999A445EAD2DB4BD48AD4CF4869@PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PR2P264MB07999A445EAD2DB4BD48AD4CF4869@PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2023 at 04:45:51PM +0000, Coirier, Emmanuel wrote:

> I think I found a bug with git credential: this tool doesn't call
> the configured credential helper following the configuration rules.
> 
> It calls the system configured credential helper (git config --system) even if another one
> is configured (ie: at the global level : git config --global).

That's because credential helpers are not a single variable where later
entries override earlier ones, but is actually a list of helpers to
execute. From "git help credentials":

  If there are multiple instances of the credential.helper configuration
  variable, each helper will be tried in turn, and may provide a
  username, password, or nothing. Once Git has acquired both a username
  and a password, no more helpers will be tried.

> The problem I encountered is that the configured system one (manager-core
> in my case) answers a wrong value instead of giving up. The globally
> configured (wincred in my case) is then not called at all and my
> authentication just fail without any way to manually enter login & pass.

If you want to clear any prior entries in the list, you can do that
explicitly. From the paragraph right below the one quoted above:

  If credential.helper is configured to the empty string, this resets
  the helper list to empty (so you may override a helper set by a
  lower-priority config file by configuring the empty-string helper,
  followed by whatever set of helpers you would like).

> > What's different between what you expected and what actually happened?
> 
> In this example, the "bla" credential helper is called
> even if the wincred should have been the only one to be
> called.
> 
> The result is OK since the "bla" credential returned a non
> zero return code, then the global credential helper (wincred) was called.

Right, this is the correct and documented behavior. You'd just want to
reset the list in your local config like:

  git config --global credential.helper ""
  git config --global --add credential.helper wincred

-Peff
