Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A3C201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 22:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750928AbdBTWPo (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 17:15:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:58973 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdBTWPn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 17:15:43 -0500
Received: (qmail 8787 invoked by uid 109); 20 Feb 2017 22:15:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 22:15:43 +0000
Received: (qmail 29712 invoked by uid 111); 20 Feb 2017 22:15:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 17:15:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2017 17:15:40 -0500
Date:   Mon, 20 Feb 2017 17:15:40 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Sokolov, Konstantin" <konstantin.sokolov.ext@siemens.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Inconsistent results of git blame --porcelain when detecting
 copies from other files
Message-ID: <20170220221540.6vemjdvyvwonpqyt@sigill.intra.peff.net>
References: <71BF70CE41AEE741896AF3A5450D86F11F4268FF@DEFTHW99EH3MSX.ww902.siemens.net>
 <xmqqd1ecim8a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1ecim8a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2017 at 01:30:29PM -0800, Junio C Hamano wrote:

> "Sokolov, Konstantin" <konstantin.sokolov.ext@siemens.com> writes:
> 
> > However, when using --porcelain DirectoryReader.java is reported as the origin of lines 502-504:
> > ...
> > This is not only inconsistent with the other outputs but the output is also inconsistent in itself because lines 496 -498 do not even exist in a previous version of DirectoryReader.java.
> 
> Hmph, this sounds vaguely familiar with
> 
>     http://public-inbox.org/git/20170106042051.nwjiuyyp7ljhs4sr@sigill.intra.peff.net
> 
> which is part of Git 2.12-rc0

Yeah, I had the same thought while reading Konstantin's report.

I'm not sure Git is wrong, though. I think it's just the way the
porcelain output works.

Here's a minimal reproduction; the interesting thing is when a commit is
mentioned twice (as happens on lines 1 and 5 here):

  git init repo
  cd repo
  
  # use long lines to make sure we trigger content-movement detection
  for i in $(seq 1 5); do
  	echo this is really long line number $i
  done >file
  git add file
  git commit -m initial
  
  sed 's/1/one/; s/5/five/' <file >renamed
  git rm file
  git add renamed
  git commit -m 'rename and use english'
  
  git blame renamed
  git blame --line-porcelain renamed
  git blame --porcelain renamed

The first blame output looks something like this:

  bab03701 renamed ... line number 1
  ^dda1349 file    ... line number 2
  ^dda1349 file    ... line number 3
  ^dda1349 file    ... line number 4
  bab03701 renamed ... line number 5

so we can see it's the same case. The --line-porcelain similarly matches
the commits and filenames.

But the --porcelain output is:

  bab037010dcabaf0509db27bf232d25659b180fa 1 1 1
  ...
  filename renamed
          this is really long line number one
  dda1349d41da859f4c37e018dbed714ba6c1aa18 2 2 3
  ...
  filename file
          this is really long line number 2
  dda1349d41da859f4c37e018dbed714ba6c1aa18 3 3
          this is really long line number 3
  dda1349d41da859f4c37e018dbed714ba6c1aa18 4 4
          this is really long line number 4
  bab037010dcabaf0509db27bf232d25659b180fa 5 5 1
          this is really long line number five

You might be tempted to say that the fifth line comes from "filename
file", because that was the last "filename" entry we saw. But that's
_not_ how the porcelain output works. That "filename" entry was
associated with dda1349, but the line comes from bab0370 here.

The simplest way (IMHO) to parse --porcelain output is:

  - maintain a mapping of commit sha1s to the commit's details

  - whenever you see a "<sha1> <line_nr> <orig_nr> [<size-of-hunk>]"
    line, any key-value fields which follow impact _only_ that sha1, and
    you should update the details for that map entry

  - when you see the actual tab-indented line content, you have gotten
    all of the key-value updates for that sha1. You can now safely do
    what you like with the line entry.

Another way, if you don't want to update your mapping, is to actually
pay attention to the size-of-hunk headers. In this case the middle three
lines come in their own hunk (which you can see from the "2 2 3" header
on the second line). The "filename" field we get applies to that hunk,
but once we switch to a different one, the filename field needs to be
looked up in the commit mapping.

But it's definitely not correct to blindly apply one "filename" field to
subsequent lines in other hunks.

And yes, I do think this is probably more complex than it needs to be.
I didn't write it. And I don't think it is worth the backwards
compatibility headache of trying to change it now. It's possible this
could be better documented (I didn't look at the documentation to write
that explanation; I happened to puzzle it out for somebody else
recently who had a similar case. That's what led to the bug-fix in the
message you linked).

-Peff
