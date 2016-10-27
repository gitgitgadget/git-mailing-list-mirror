Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E0BD20193
	for <e@80x24.org>; Thu, 27 Oct 2016 14:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943080AbcJ0Ouh (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 10:50:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:34868 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942940AbcJ0Oua (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 10:50:30 -0400
Received: (qmail 18638 invoked by uid 109); 27 Oct 2016 10:50:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 10:50:28 +0000
Received: (qmail 19371 invoked by uid 111); 27 Oct 2016 10:50:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 06:50:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2016 06:50:27 -0400
Date:   Thu, 27 Oct 2016 06:50:27 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron Pelly <aaron@pelly.co>
Cc:     git@vger.kernel.org
Subject: Re: Expanding Includes in .gitignore
Message-ID: <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 01:22:43PM +1300, Aaron Pelly wrote:

> The use case for this is where I did not write my own rules, but I want
> to keep them updated. https://github.com/github/gitignore is a damn good
> resource, but I want to pull it and include relevant bits project by
> project and/or system wide. I don't want to have to update many projects
> manually if that, or any other, repo changes.

That seems like a reasonable thing to want.

> A very brief look at dir.c would indicate that a recursive call from
> add_excludes to itself when it parses some sort of include tag would do
> it within a file. I'm sure it'd be pretty straight forward to hook into
> something in dir.c to parse directories too.
> 
> I'm thinking something like ". path/to/include/file" in an ignore file,
> and/or creating .gitignore.d and/or allowing $HOME/.config/git/ignore
> and $GIT_DIR/info/exclude to be directories. Or some sane and consistent
> mixture of these things.

I'd shy away from an actual include directive, as it raises a lot of
complications:

  - as you noted, cycles in the include graph need to be detected and
    broken

  - we parse possibly-hostile .gitignore files from cloned repositories.
    What happens when I include ask to include /etc/passwd? Probably
    nothing, but there are setups where it might matter (e.g., something
    like Travis that auto-builds untrusted repositories, and you could
    potentially leak the contents of files via error messages). It's
    nice to avoid the issue entirely.

  - finding a backwards-compatible syntax

Whereas letting any of the user- or repo-level exclude files be a
directory, and simply reading all of the files inside, seems simple and
obvious. If you go that route, it probably makes sense to teach
gitattributes the same trick.

> In the case of a directory the plan would be to add links to files
> stored/sourced elsewhere. This does pose a precedence question which I
> haven't thought about yet, but probably makes it too hard for the
> limited value it brings.

I think the normal behavior in such "foo.d" directory is to just sort
the contents lexically and read them in order, as if they were all
concatenated together, and with no recursion. I.e., behave "as if" the
user had run "cat $dir/*".

That lets you handle precedence via the filenames (or symlink names). It
can't handle all cases (some items in "00foo" want precedence over "01bar"
and vice versa), but I don't think there's an easy solution. That's a
good sign that one or more of the files should be broken up.

-Peff
