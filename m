Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61E911FAFB
	for <e@80x24.org>; Sun,  2 Apr 2017 07:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbdDBHi2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 03:38:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:55618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbdDBHi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 03:38:28 -0400
Received: (qmail 32061 invoked by uid 109); 2 Apr 2017 07:38:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Apr 2017 07:38:25 +0000
Received: (qmail 23091 invoked by uid 111); 2 Apr 2017 07:38:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Apr 2017 03:38:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Apr 2017 03:38:23 -0400
Date:   Sun, 2 Apr 2017 03:38:23 -0400
From:   Jeff King <peff@peff.net>
To:     Knut Omang <knut.omang@oracle.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: 'git config --local user.email=<alt.email>' fails silently?
Message-ID: <20170402073823.tudnfftbxaa6jdo5@sigill.intra.peff.net>
References: <1491112043.5830.11.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1491112043.5830.11.camel@oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 02, 2017 at 07:47:23AM +0200, Knut Omang wrote:

> From the documentation I would have expected 
> 
> git config --local user.email=alt.email@alt.domain
> 
> to create a section 
> 
> [user]
> 	email=alt.email@alt.domain
> 
> in the local .git/config.

When it sees one argument, git-config treats that argument as a key to
be retrieved. When given two, the second is a value to be set. E.g.:

  $ git config foo.bar
  $ git config foo.bar some-value
  $ git config foo.bar
  some-value

So your command was interpreted as a request to fetch the value, which
doesn't exist.

> Instead it returns status 1 with no error message.

Hopefully that explains the response you saw; we do not emit an error
message when a key isn't found, which makes it easy for scripts to do
things like:

  value=$(git config foo.bar || echo default-value)

without being unnecessarily noisy.

Usually we'd catch an error like yours and complain, because the key is
syntactically invalid ("=" is not generally allowed in key names):

  $ git config foo.bar=some-value
  error: invalid key: foo.bar=some-value

But your argument actually _is_ a syntactically valid key, because of
the dots. In a three-level key like "one.two.three", the second level
subsection is allowed to contain any character (including "=" and more
dots). So your "user.email=alt.email@alt.domain" tries to look up the
config represented by:

  [user "email=alt.email@alt"]
  domain

Which of course did not exist.

> Is this intentional?

Yes, everything is working as intended. The documentation in
git-config(1) seems to be quite poor at describing the various operating
modes, though.

-Peff
