Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3F1C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087D12087E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgAXVmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:42:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:44152 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726191AbgAXVmI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:42:08 -0500
Received: (qmail 8470 invoked by uid 109); 24 Jan 2020 21:42:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Jan 2020 21:42:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11609 invoked by uid 111); 24 Jan 2020 21:49:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jan 2020 16:49:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Jan 2020 16:42:06 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 8/8] sparse-checkout: write escaped patterns in cone mode
Message-ID: <20200124214206.GA2211026@coredump.intra.peff.net>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <79b6e9a565fde766954d7cda84a835b9015af6cb.1579029963.git.gitgitgadget@gmail.com>
 <20200114212548.GD3949560@coredump.intra.peff.net>
 <e325daa4-5a26-3652-5f46-06203403e51d@gmail.com>
 <20200114224818.GD3957260@coredump.intra.peff.net>
 <d4fe0b4a-9e3f-6669-9068-d7b4b8934d1b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4fe0b4a-9e3f-6669-9068-d7b4b8934d1b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 04:10:21PM -0500, Derrick Stolee wrote:

> Hm. Perhaps you are right! The ls-tree output for the test example
> is:
> 
> 	deep
> 	folder1
> 	folder2
> 	"zbad\\dir"
> 	zdoes*exist
> 
> so the "zdoes*exist" value is not escaped. I believe the current
> logic does something extra: consider supplying this input to
> 'git sparse-checkout set --stdin':
> 
> 	deep
> 	folder1
> 	folder2
> 	"zbad\\dir"
> 	zdoes\*exist
> 
> then should we un-escape "\*" to "*"? Or is this not a valid input
> because a backslash should have been quoted into C-style quotes?

I'd think we should not un-escape anything, because we weren't told that
this was a C-style quoted string by the presence of an opening
double-quote. And that's how, say, update-index behaves:

  $ blob=$(echo foo | git hash-object -w --stdin)
  $ printf '100644 %s\t%s\n' \
      $blob 'just*asterisk' \
      $blob 'backslash\without\quotes' \
      $blob '"backslash\\with\\quotes"' |
    git update-index --index-info

which results in:

  $ git ls-files
  "backslash\\with\\quotes"
  "backslash\\without\\quotes"
  just*asterisk

  [same, but without quoting]
  $ git ls-files -z | tr '\0' '\n'
  backslash\with\quotes
  backslash\without\quotes
  just*asterisk

> The behavior in the current series allows this output that would
> never be written by "git ls-tree".

Yes, I think we'd never write that, because ls-tree would quote anything
with a backslash in it, even though it's not strictly necessary. But it
would be valid input to specify a file that has backslashes but not
double-quotes, and I think sparse-checkout should be changed to match
update-index here.

> I was playing around with this, and I think that quote_c_style() is
> necessary for the output, but we have a strange in-memory situation
> for the other escaping: we both fill the hashsets with the un-escaped
> data and fill the pattern list with the escaped patterns.

Yeah, but I think that the syntactic escaping on input might not have
identical rules to the escaping needed for the patterns.

So it makes sense to me to handle input as a separate mechanism, get a
pristine copy of what the user was trying to communicate to us, and then
re-escape whatever we need to put into the pattern list.

And ultimately the flow would be something like:

  - read input
    - if argument is from command-line, use it verbatim
    - else if reading stdin with "-z", use it verbatim
    - else if line starts with double-quote, unquote_c_style()
    - else use line verbatim
    - the result is a single pristine filename
  - fill hashset with pristine filenames
  - generate pattern list to write to sparse file, escaping filenames as
    necessary according to sparse-pattern rules

Obviously you don't have a "-z" yet, but I think it's something we'd
probably want in the long run. And anything coming from the command-line
shouldn't need quoting to get it to us either (and so we'd need to
escape before writing to the sparse file).

-Peff
