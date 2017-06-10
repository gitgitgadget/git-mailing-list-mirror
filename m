Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7321F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 06:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbdFJGHQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 02:07:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:37423 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbdFJGHP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 02:07:15 -0400
Received: (qmail 27036 invoked by uid 109); 10 Jun 2017 06:07:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 06:07:15 +0000
Received: (qmail 28663 invoked by uid 111); 10 Jun 2017 06:07:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 02:07:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 02:07:12 -0400
Date:   Sat, 10 Jun 2017 02:07:12 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v2 00/32] repository object
Message-ID: <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
 <20170609174034.61889ae8@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170609174034.61889ae8@twelve2.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 09, 2017 at 05:40:34PM -0700, Jonathan Tan wrote:

> Before I get into the details, I have some questions:
> 
> 1. I am concerned that "struct repository" will end up growing without
> bounds as we store more and more repo-specific concerns in it. Could it
> be restricted to just the fields populated by repo_init()?
> repo_read_index() will then return the index itself, instead of using
> "struct repository" as a cache. This means that code using
> repo_read_index() will need to maintain its own variable holding the
> returned index, but that is likely a positive - it's better for code to
> just pass around the specific thing needed between functions anyway, as
> opposed to passing a giant "struct repository" (which partially defeats
> the purpose of eliminating the usage of globals).

I think the repository object has to become a kitchen sink of sorts,
because we have tons of global variables representing repo-wide config.
ls-files doesn't respect a lot of config, but what should, e.g.:

  git config core.quotepath true
  git -C submodule config core.quotepath false
  git ls-files --recurse-submodules

do?  Right now, with a separate process, we respect the submodule
version of the config. But in a single process[1] we'd need one copy of
the quote_path_fully variable for each repo object. It's tempting for
this case to say that core.quotepath from the super-project should just
take precedence, as that's where the command is issued from (and why the
heck would anybody have per-repo settings for this anyway?). But I
suspect as we get into more complicated commands that there are likely
to be config variables that are important to match to each repo.

I do agree that "pass just what the sub-function needs" is a good rule
of thumb. But the reason that these are globals in the first place is
that there are a ton of them, and they are used at the lowest levels of
call chains. So I have a feeling that we're always going to need some
big object to hold all that context when doing multi-repo operations in
a single process.

For config, in theory that could be a big "config_set" object, but
that's not quite how we treat our config. We usually parse it once into
actual variables. So really you end up with a big parsed-config object
that gets passed around, I'd think.

-Peff

[1] I wanted to see how Brandon's series behaved for this quotepath
    case, but unfortunately I couldn't get it to work in even a simple
    case.  :(

      $ git ls-files --recurse-submodules
      fatal: index file corrupt
