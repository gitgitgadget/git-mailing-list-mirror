Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E418E2036D
	for <e@80x24.org>; Fri, 24 Nov 2017 18:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbdKXSEE (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 13:04:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:39490 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751503AbdKXSEE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 13:04:04 -0500
Received: (qmail 21637 invoked by uid 109); 24 Nov 2017 18:04:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Nov 2017 18:04:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15728 invoked by uid 111); 24 Nov 2017 18:04:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 24 Nov 2017 13:04:20 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Nov 2017 13:04:01 -0500
Date:   Fri, 24 Nov 2017 13:04:01 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Shawn Pearce <spearce@spearce.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFC: Native clean/smudge filter for UTF-16 files
Message-ID: <20171124180401.GB29190@sigill>
References: <BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 04:18:59PM +0100, Lars Schneider wrote:

> Alternatively, I could add a native attribute to Git that translates UTF-16 
> to UTF-8 and back. A conversion function is already available in "mingw.h" [3]
> on Windows. Limiting this feature to Windows wouldn't be a problem from my
> point of view as UTF-16 is only relevant on Windows anyways. The attribute 
> could look like this:
> 
>     *.txt        text encoding=utf-16
>
> There was a previous discussion on the topic and Jonathan already suggested
> a "native" clean/smudge filter in 2010 [4]. Also the "encoding" attribute
> is already present but, as far as I can tell, is only used by the git gui
> for viewing [5].

I would not want to see a proliferation of built-in filters, but it
really seems like text-encoding conversion is a broad and practical one
that many people might benefit from. So just like line-ending
conversion, which _could_ be done by generic filters, it makes sense to
me to support it natively for speed and simplicity.

> Do you think a patch that converts UTF-16 files to UTF-8 via an attribute
> "encoding=utf-16" on Windows would have a chance to get accepted?

You haven't fully specified the semantics here, so let me sketch out
what I think it ought to look like:

 - declare utf8 the "canonical" in-repo representation, just as we have
   declared LF for line endings (alternatively this could be
   configurable, but if we can get away with declaring utf8 the one true
   encoding, that cuts out a lot of corner cases).

 - if core.convertEncoding is true, then for any file with an
   encoding=foo attribute, internally run iconv(foo, utf8) in
   convert_to_git(), and likewise iconv(utf8, foo) in
   convert_to_working_tree.

 - I'm not sure if core.convertEncoding should be enabled by default. If
   it's a noop as long as there's no encoding attribute, then it's
   probably fine. But I would not want accidental conversion or any
   slowdown for the common case that the user wants no conversion.

 - I doubt we'd want a "core.autoEncoding" similar to "core.autocrlf". I
   don't think people consistently have all utf-16 files (the way they
   might have all CRLF files) rather a few files that must be utf-16.

 - I have actually seen two types of utf-16 in git repos in the wild:
   files which really must be utf-16 (because some tool demands it) and
   files which happen to be utf-16, but could just as easily be utf-8
   (and the user simply does not notice and commits utf-16, but doesn't
   realize it until much later when their diffs are unreadable).

   For the first case, the "encoding" thing above would work fine. For
   the second case, in theory we could have an option that takes any
   file with a "text" attribute and no "encoding" attribute, and
   converts it to utf-8.

   I suspect that's opening a can of worms for false positives similar
   to core.autocrlf. And performance drops as we try to guess the
   encoding and convert all incoming data.

   So I mention it mostly as a direction I think we probably _don't_
   want to go. Anybody with the "this could have been utf-8 all along"
   type of file can remedy it by converting and committing the result.

Omitting all of the "we shouldn't do this" bullet points, it seems
pretty simple and sane to me.

There is one other approach, which is to really store utf-16 in the
repository and better teach the diff tools to handle it (which are
really the main thing in git that cares about looking into the blob
contents). You can do this already with a textconv filter, but:

  1. It's slow (though cacheable).

  2. It doesn't work unless each repo configures the filter (so not on
     sites like GitHub, unless we define a micro-format that diff=utf16
     should be textconv'd on display, and get all implementations to
     respect that).

  3. Textconv patches look good, but can't be applied. This occasionally
     makes things awkward, depending on your workflow.

  4. You have to actually mark each file with an attribute, which is
     slightly annoying and more thing to remember to do (I see this from
     the server side, since people often commit utf-16 without any
     attributes, and then get annoyed when they see the file marked as
     binary).

We've toyed with the idea at GitHub of auto-detecting UTF-16 BOMs and
doing an "auto-textconv" to utf-8 (for our human-readable diffs only, of
course). That solves (1), (2), and (4), but leaves (3). I actually
looked into using libicu to do it not just for UTF-16, but to detect any
encoding. It turned out to be really slow, though. :)

So anyway, that is an alternate strategy, but I think I like "canonical
in-repo text is utf-8" approach a lot more, since then git operations
work consistently. There are still a few rough edges (e.g., I'm not sure
if you could apply a utf-8 patch directly to a utf-16 working tree file.
Certainly not using "patch", but I'm not sure how well "git apply" would
handle that case either). But I think it would mostly Just Work as long
as people were willing to set their encoding attributes.

-Peff
