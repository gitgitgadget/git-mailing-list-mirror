Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99EA202A5
	for <e@80x24.org>; Thu, 13 Jul 2017 20:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbdGMUfh (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:35:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:39924 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752847AbdGMUfg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:35:36 -0400
Received: (qmail 5563 invoked by uid 109); 13 Jul 2017 20:35:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 20:35:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4948 invoked by uid 111); 13 Jul 2017 20:35:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 16:35:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 16:35:33 -0400
Date:   Thu, 13 Jul 2017 16:35:33 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
Subject: Re: reftable: new ref storage format
Message-ID: <20170713203533.vcfyf5iei46g4tcf@sigill.intra.peff.net>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net>
 <CAGZ79kbY_t=Xtpb7fy0sZ9TWOy-UOUx8X5+_qLx60Dtg48Ok-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbY_t=Xtpb7fy0sZ9TWOy-UOUx8X5+_qLx60Dtg48Ok-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 12:56:54PM -0700, Stefan Beller wrote:

> >> ### Problem statement
> >>
> >> Some repositories contain a lot of references (e.g.  android at 866k,
> >> rails at 31k).  The existing packed-refs format takes up a lot of
> >> space (e.g.  62M), and does not scale with additional references.
> >> Lookup of a single reference requires linearly scanning the file.
> >
> > I think the linear scan is actually an implementation short-coming. Even
> > though the records aren't fixed-length, the fact that newlines can only
> > appear as end-of-record is sufficient to mmap and binary search a
> > packed-refs file (you just have to backtrack a little when you land in
> > the middle of a record).
> 
> Except that a record is a "delta" to the previous record, so it's not
> just finding a record, but reconstructing it. Example for records:

I was still talking about the existing packed-refs implementation here.

I agree that a full binary search of a reftable is harder because of the
prefix compression (it may still be possible by scanning backwards, but
I think there are ambiguities when you land in the middle of a record,
since there's no unambiguous end-of-record character). But I don't think
it matters. If you binary-search to a constant-sized block, then a
linear scan of the block is acceptable.

> >> - Occupy less disk space for large repositories.
> >
> > Good goal.  Just to play devil's advocate, the simplest way to do that
> > with the current code would be to gzip packed-refs (and/or store sha1s
> > as binary). That works against the "mmap and binary search" plan,
> > though. :)
> 
> Given the compression by delta-ing the name to the previous change and
> the fact that Gerrit has
> 
>   refs/heads/changes/1
>   refs/heads/changes/2
>   refs/heads/changes/3
>   ...
> 
> I think this format would trump a "dumb" zip.
> (Github having sequentially numbered pull requests would also
> benefit here)

You may be surprised. Let's imagine that you have a set of 4096 refs in
refs/changes/1, refs/changes/2, etc:

  for i in $(seq 1 4096)
  do
    echo refs/changes/$i
  done >input

Now let's do a prefix compression, with a single byte for "how many
characters to reuse from the last entry":

  perl -lne '
    my $common;
    if (defined $last) {
      chop $last while !/\Q$last\E/;
      $common = length($last);
    } else {
      $common = 0;
    }
    print chr($common), substr($_, $common);
    $last = $_;
  ' <input >prefix

And a gzip:

  gzip -c -9 <input >zip

And the results:

  $ wc -c prefix; wc -c zip
  12754 prefix
  10116 zip

The secret sauce is most likely that gzip is bit-packing, using only a
few bits per character and not aligning with byte boundaries.

Not that I'm recommending just gzipping the whole packed-refs file. It
ruins the fast-lookup. We _could_ consider gzipping individual blocks of
a reftable (or any structure that allows you to search to a
constant-sized block and do a linear search from there). But given that
they're in the same ballpark, I'm happy with whatever ends up the
simplest to code and debug. ;)

Just for fun, here's the decoding script for the prefix-compression:

  perl -e '
    while (read(STDIN, $common, 1)) {
      $common = ord($common);
      $rest = <STDIN>;
      if ($common > 0) {
        $rest = substr($last, 0, $common) . $rest
      }
      print $rest;
      $last = $rest}' <prefix
  '

> > OK, let me try to summarize to see if I understand.
> 
> When Shawn presented the proposal, a couple of colleagues here
> were as excited as I was, but the daring question is, why Shawn
> did not give the whole thing in BNF format from top down:
> 
>   initial-block
>   content-blocks*
>   (index-block)
>   footer

Yeah, I agree it took me a bit to figure out what was going on. A
high-level overview of the format would have been nice.

> >  So lookup really is more
> > like O(block_size * log(n/block_size)), but block_size being a constant,
> > it drops out to O(log n).
> 
> There is also an index block such that you can binary search across
> blocks, so
> 
> O( log(block_count) + log(intra_block_restarting_points) + small linear scan)
> 
> There are 2 binary searches, and the block size is an interesting
> thing to look at when making up trade offs.

Right, the cross-block index was what I was trying to account for.
Either way, from a big-O perspective the block size and the number of
restarts are constants with respect to the total number of entries. I'm
happy with log(n), though. It's hard to do better.

-Peff
