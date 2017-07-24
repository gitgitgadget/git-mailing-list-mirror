Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0366208AB
	for <e@80x24.org>; Mon, 24 Jul 2017 19:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932606AbdGXTYC (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 15:24:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:47430 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932592AbdGXTX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 15:23:59 -0400
Received: (qmail 11804 invoked by uid 109); 24 Jul 2017 19:24:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 19:24:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12093 invoked by uid 111); 24 Jul 2017 19:24:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 15:24:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 15:23:57 -0400
Date:   Mon, 24 Jul 2017 15:23:57 -0400
From:   Jeff King <peff@peff.net>
To:     "tonka3100@gmail.com" <tonka3100@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: change the filetype from binary to text after the file is
 commited to a git repo
Message-ID: <20170724192357.y3oj5urfuie7ffjr@sigill.intra.peff.net>
References: <CAEor4NHDNL4CQP_FpCuJ_3F86-A3P8i=yvp1AZr-NKt0i1=cXw@mail.gmail.com>
 <20170724181835.zo3lcv7pxmkif2jr@sigill.intra.peff.net>
 <7DE91669-D603-4C83-9151-78F2D5676E36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7DE91669-D603-4C83-9151-78F2D5676E36@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 09:02:12PM +0200, tonka3100@gmail.com wrote:

> There is no .gitattributes file in the repo. I think that the git
> heuristic will also detect utf-16 files as binary (in windows), so i
> think that is the reason why my file is binary (i have to check that
> tomorrow).

Correct. UTF-16 _is_ binary, if you are trying to include it alongside
ASCII content (like the rest of the text diff headers). The two cannot
mix.

> If i add a .gitattribute file i have the problem that git
> diff will treat the old and the new blob as utf-8, which generate
> garbage.

Git's diff doesn't look at encodings at all; it does a diff of the
actual bytes without respect to any encoding. So yes, if you use "-a" or
a gitattribute to ask git to show you the bytes, the UTF-16 is likely to
look like garbage (and a commit rewriting from utf-16 to utf-8 will
basically be a rewrite of the whole file contents).

> Do you have another idea?  Could it be possible to add only a space in
> code (utf-8) and then add the real content in a second commit, so the
> old and the new one are both utf-8?

I'm not sure exactly what you're trying to accomplish. If you're unhappy
with the file as utf-16, then you should probably convert to utf-8 as a
single commit (since the diff will otherwise be unreadable) and then
make further changes in utf-8.

If you need the file to remain utf-16 but you want more readable diffs
for those versions, you can ask git to convert to utf-8 before
performing the diff. Such a diff couldn't be applied, but would be
useful for reading. E.g., try:

  echo 'file diff=utf16' >.gitattributes
  git config diff.utf16.textconv 'iconv -f utf16 -t utf8'

You can read more about how this works in the "textconv" section of "git
help attributes".

Note that I'm relying on the external "iconv" tool to do the conversion
there. It's pretty standard on most Unix systems, but I don't know what
would be the best tool on Windows.

-Peff
