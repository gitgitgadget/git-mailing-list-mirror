Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E5A1FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 09:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbcL1JUS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 04:20:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:60974 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751103AbcL1JUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 04:20:17 -0500
Received: (qmail 15107 invoked by uid 109); 28 Dec 2016 09:20:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 09:20:14 +0000
Received: (qmail 17564 invoked by uid 111); 28 Dec 2016 09:21:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 04:21:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Dec 2016 04:20:11 -0500
Date:   Wed, 28 Dec 2016 04:20:11 -0500
From:   Jeff King <peff@peff.net>
To:     "John P. Hartmann" <jphartmann@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: HowTo distribute a hook with the reposity.
Message-ID: <20161228092011.bnqqcvujescbdhji@sigill.intra.peff.net>
References: <6e228b75-0208-63e8-b4e8-70905e3f9ea3@gmail.com>
 <CA+P7+xqHTgRvMRwgL2TJ7SRb_SR0sbtA039J_5N0xSjf3TNrgg@mail.gmail.com>
 <20161228060840.gelgcs2hd33id56j@sigill.intra.peff.net>
 <6801f971-418d-18c9-8002-9c2f7b8c8008@gmail.com>
 <20161228085248.tu54e6ug5fvpr26l@sigill.intra.peff.net>
 <39886f48-c48f-6800-8aa4-20e0b2ab0e6d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39886f48-c48f-6800-8aa4-20e0b2ab0e6d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 09:09:04AM +0000, John P. Hartmann wrote:

> The problem I am grappling with is how to obtain the latest git commit hash
> and enter it into the generated code.  Configure/make would appear to the
> the time, but by then the user may not have git installed (e.g., extracted
> the project as .zip from github), so it needs to be done "back at the farm".
> 
> I hear that the best I can do is create a normal script in the repro and add
> to the developer handbook that "btw, here is a git hook that will run it
> automatically if you so choose".

Yes, if you want the information to be conveyed in a .zip from GitHub,
then you'll have to commit the value to the repository. For example,
the script in Git itself looks like this:

  https://github.com/git/git/blob/master/GIT-VERSION-GEN

We pull the value from the Git repository if we have one, then fallback
to a .version file which is generated when release tarballs are
generated, and then finally fall back to a baked-in DEF_VER variable
that is updated manually after each release (and that last is what you'd
get if you had, say, a .zip file from GitHub).

I'm not sure you would want to update that DEF_VER for _every_ commit,
though, even if you could do so with a hook. It would mean every commit
would update the version field. And of course it could not have the git
commit id, because that is generated from a hash of the contents that
includes the contents of that version field.

If you're mostly interested in building straight from GitHub .zip files,
those do include the commit id (or tag name) in the directory name, so
your Makefile could deduce it at runtime from that information.

-Peff
