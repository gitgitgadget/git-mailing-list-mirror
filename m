Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07EB91F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 03:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKODtm (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 22:49:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:47998 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726549AbfKODtm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 22:49:42 -0500
Received: (qmail 25363 invoked by uid 109); 15 Nov 2019 03:49:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Nov 2019 03:49:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9916 invoked by uid 111); 15 Nov 2019 03:53:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Nov 2019 22:53:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Nov 2019 22:49:41 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: rev-list and "ambiguous" IDs
Message-ID: <20191115034941.GB20863@sigill.intra.peff.net>
References: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
 <20191114055906.GA10643@sigill.intra.peff.net>
 <ab4dcc9c-4416-aef8-c8c4-38bb5ec97990@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab4dcc9c-4416-aef8-c8c4-38bb5ec97990@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 01:12:47AM +0100, Thomas Braun wrote:

> > That would probably help in a lot of cases, but the argument
> > against it is that when it goes wrong, it may be quite confusing (so
> > we're better off with the current message, which punts back to the
> > user).
> 
> Just out of curiosity: Is there a use case for inspecting non-commit
> objects with git log?

Not that I can think of. You can't even say "--objects" there.

And indeed, "git log" already prefers commits for disambiguation, since
d5f6b1d756 (revision.c: the "log" family, except for "show", takes
committish, 2012-07-02).

But...

> If I do (in the git repo)
> 
> $ git log 1231
> 
> I get
> 
> error: short SHA1 1231 is ambiguous
> hint: The candidates are:
> hint:   123139fc89 tree
> hint:   12316a1673 tree
> hint:   123144fe8a blob
> fatal: ambiguous argument '1231': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> 
> with
> $ git --version
> git version 2.24.0.windows.2
> 
> and all of these candidates are no commits.

...remember that the disambiguation code is just about preferring one
object to the other. If the rule in effect doesn't have a preference,
it's still ambiguous. On my system, "1231" actually _does_ have a
commit:

  $ git show 1231
  error: short SHA1 1231 is ambiguous
  hint: The candidates are:
  hint:   12319e3bf2 commit 2017-03-25 - Merge 'git-gui-add-2nd-line' into HEAD
  hint:   123139fc89 tree
  hint:   12315b58b8 tree
  hint:   12316a1673 tree
  hint:   12317ab2d9 tree
  hint:   123193f802 tree
  hint:   123144fe8a blob
  fatal: ambiguous argument '1231': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

That's ambiguous because git-show can handle trees and blobs, too. But
if I feed that sha1 to git-log:

  $ git log --oneline -1 1231
  12319e3bf2 Merge 'git-gui-add-2nd-line' into HEAD

it's perfectly fine, because git-log knows to disambiguate the commit.
But if I choose another prefix that has no commits at all, it's
ambiguous under either, because the "committish" rule has no way to
decide:

  $ git show abcd2
  error: short SHA1 abcd2 is ambiguous
  hint: The candidates are:
  hint:   abcd22f55e tree
  hint:   abcd238df0 tree
  hint:   abcd2b1cc8 blob
  
  $ git log abcd2
  error: short SHA1 abcd2 is ambiguous
  hint: The candidates are:
  hint:   abcd22f55e tree
  hint:   abcd238df0 tree
  hint:   abcd2b1cc8 blob

-Peff
