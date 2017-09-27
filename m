Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67BCB2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 19:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbdI0TSd (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 15:18:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:52422 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750786AbdI0TSc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 15:18:32 -0400
Received: (qmail 25804 invoked by uid 109); 27 Sep 2017 19:18:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 19:18:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18096 invoked by uid 111); 27 Sep 2017 19:19:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 15:19:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 15:18:30 -0400
Date:   Wed, 27 Sep 2017 15:18:30 -0400
From:   Jeff King <peff@peff.net>
To:     Ilya Kantor <iliakan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's the idea of specifying binary=true together with textconv?
Message-ID: <20170927191830.qegbaoxtcxzbfkoe@sigill.intra.peff.net>
References: <CAFU8umg2cgmmCvGYbu0P3M02AMcttUfTCFGTUcsF7shd80XwSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFU8umg2cgmmCvGYbu0P3M02AMcttUfTCFGTUcsF7shd80XwSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 10:06:25PM +0300, Ilya Kantor wrote:

> When textconv is specified, the program is always used for conversion.

Not always. It's enabled by default for the git-diff and git-log"
porcelain, but not for plumbing commands, nor for git-format-patch
(which needs to create a patch that can be applied). And it can be
disabled with --no-textconv.

> E.g. consider this:
> [diff "png"]
>   textconv = wc
> 
> Even if a png file is ASCII (manually created), wc gets called, and
> the result is made of its output.
> 
> So, the question is: why should one specify binary = true together
> with textconv?
> 
> There is an example in docs:
> [diff "ps"]
>   textconv = ps2ascii
>   binary = true
> 
> ...But what binary = true does here?
> Even if we remove it, textconv is called for all ps-files.

Setting binary=true overrides Git's binary-detection heuristics. When
textconv is in effect, those heuristics aren't used at all. But when
it's disabled, if you want to make sure a file is marked as binary, it
would kick in then. For example:

  $ git init
  $ echo fake-binary >foo.png
  $ echo "*.png diff=png" >.git/info/attributes
  $ git config diff.png.textconv "sed s/^/converted:/"
  $ git add .
  $ git commit -m foo

  $ git show
  ...
  --- /dev/null
  +++ b/foo.png
  @@ -0,0 +1 @@
  +converted:fake-binary

  $ git format-patch --stdout -1
  ...
  --- /dev/null
  +++ b/foo.png
  @@ -0,0 +1 @@
  +fake-binary

  $ git config diff.png.binary true
  $ git format-patch --stdout -1
  diff --git a/foo.png b/foo.png
  new file mode 100644
  index 0000000000000000000000000000000000000000..96060daf0866dbaf9538b76587f0da801bed4a5f
  GIT binary patch
  literal 12
  TcmYdG%udx!%FIhFs^kIy9YO?D
  
  literal 0
  HcmV?d00001

It's a pretty rare corner case where this is useful. After all, if your
file really isn't binary, then a text patch is actually preferable. But
you could imagine cases where the heuristics are wrong (e.g., a single
NUL very far into the file).

-Peff
