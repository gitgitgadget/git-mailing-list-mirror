Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3E7202DD
	for <e@80x24.org>; Mon, 23 Oct 2017 00:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932177AbdJWAp1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 20:45:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:60744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932144AbdJWAp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 20:45:26 -0400
Received: (qmail 1986 invoked by uid 109); 23 Oct 2017 00:45:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Oct 2017 00:45:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31537 invoked by uid 111); 23 Oct 2017 00:45:32 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Oct 2017 20:45:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Oct 2017 20:45:24 -0400
Date:   Sun, 22 Oct 2017 20:45:24 -0400
From:   Jeff King <peff@peff.net>
To:     Jason Pyeron <jpyeron@pdinc.us>
Cc:     'Joris Valette' <joris.valette@gmail.com>,
        'Andreas Schwab' <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: Consider escaping special characters like 'less' does
Message-ID: <20171023004523.temglxnlpuns2ejy@sigill.intra.peff.net>
References: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
 <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat>
 <87zi8sxvkg.fsf@linux-m68k.org>
 <CA+o7MD8fcD5-SFeQsX84Etu68ov7yy48OO4dV=gXMp5xY8s9Rg@mail.gmail.com>
 <20171015200635.e2u4qkxlz2xwpfov@sigill.intra.peff.net>
 <CA+o7MD84O5uTOz0xAGmd=xL+Hw8UsVCu5v_HEEeMWvAhSRQCeA@mail.gmail.com>
 <20171016221324.stn56gqnliunvcdv@sigill.intra.peff.net>
 <37013BB09DFE493BB7E11E66A34657CE@blackfat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37013BB09DFE493BB7E11E66A34657CE@blackfat>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 22, 2017 at 08:27:20AM -0400, Jason Pyeron wrote:

> > ESC (for color)
> > +			if ($line =~ s/[\000-\011\013-\032\034-\037]/?/g) {
> 
> What about CR [0x0D] ?

I assumed that CR was one of the things we'd want to avoid (and it was
in fact what I used to test this). E.g., try:

  echo base >file
  git add file
  printf 'foo\r+bar\n' >file

Running through "less" shows something like:

  diff --git a/file b/file
  index df967b9..5b6ee80 100644
  --- a/file
  +++ b/file
  @@ -1 +1 @@
  -base
  +foo^M+bar

but "git add -p" shows:

  $ git add -p
  diff --git a/file b/file
  index df967b9..5b6ee80 100644
  --- a/file
  +++ b/file
  @@ -1 +1 @@
  -base
  +bar
  Stage this hunk [y,n,q,a,d,/,e,?]? 

For systems where CRLF is the native line ending, we'd still expect to
see only LFs here when line-ending conversion is on (since the diff
shows the canonical in-repo form).

For files where the CRs must remain for some reason, they'd show as a
"?" at the end. The "^M" shown by "less" is a bit more informative. If
we really do want to pursue this direction, it might make sense to use
more descriptive placeholders.

-Peff
