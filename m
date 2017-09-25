Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452FB202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 16:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965025AbdIYQIi (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 12:08:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:49314 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964842AbdIYQIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 12:08:37 -0400
Received: (qmail 21946 invoked by uid 109); 25 Sep 2017 16:08:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 16:08:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26517 invoked by uid 111); 25 Sep 2017 16:09:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 12:09:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 12:08:35 -0400
Date:   Mon, 25 Sep 2017 12:08:35 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] reroll ma/plugleaks; more `object_array`-fixes
Message-ID: <20170925160835.aoomjaqrn2o2aosi@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com>
 <20170923043701.4s3xuytp5hdjwmsy@sigill.intra.peff.net>
 <CAN0heSrPBDi4q9fqr=qoTbjRHpFS_VEL0O8=MFFJ4DLCuJwahA@mail.gmail.com>
 <20170923161316.yntnccqrhv5d3jza@sigill.intra.peff.net>
 <20170923163817.7ltmkav2ytk7n43k@sigill.intra.peff.net>
 <CAN0heSqQ3Etj1mkGhuft8JzKA8SNhpF0jcnVEdFeKX5NHpyqTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqQ3Etj1mkGhuft8JzKA8SNhpF0jcnVEdFeKX5NHpyqTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 24, 2017 at 09:59:28PM +0200, Martin Ågren wrote:

> > Anyway, doing:
> >
> >   ASAN_OPTIONS=detect_leaks=1:abort_on_error=0:exitcode=0:log_path=/tmp/lsan/output \
> >   make SANITIZE=address,leak test
> >
> > should pass the whole suite and give you a host of files to analyze.
> 
> Thanks. My reading of the documentation was off. Turns out exitcode=0
> does not set the exit code to 0, but rather turns it off. Duh.

Actually, the docs are quite confusing. The LSan "exitcode" option
defaults to 23, and that is the exit code you get. So I think it
probably is interpreted as the code to exit with, or 0 for "use the
original exit code".

> > I'm not sure of the best way to count things.
> 
> Right. It's a tricky problem. And in the end, all we find out is where
> we allocate and how we got there. Exactly where we lose/leak that piece
> of allocated memory is another question...

For hunting a particular trace, I think you have to walk up the list of
called functions and see where the pointers go out of scope. I'm not
sure how to make that easier (in theory a compiler-instrumentation like
LSan could do it by performing a leak-check when pointers go out of
scope. But it would also need to know about copies you've made of
pointers, so I imagine it would be extremely slow to run).

But at least on the topic of "how many unique leaks are there", I wrote
the script below to try to give some basic answers. It just finds the
first non-boring entry in each stack trace and reports that. Where
"boring" is really "this function is not expected to free, but hands off
memory ownership to somebody else".

You can use it to do:

  perl leaks.pl /tmp/lsan/output.* | sort | uniq -c | sort -rn | head

to see places that leak a lot. These are either boring calls that need
to be annotated, or are high-value targets for de-leaking.

I notice ref-filter.c has quite a few high entries on the list. I'm not
sure yet which case it falls into. :)

The other interesting thing is seeing how many "unique" leaks there are:

  perl leaks.pl /tmp/lsan/output.* | sort -u | wc -l

I get a bit over 800 with a run of the test suite. Which is a lot, but
fewer than I expected. And I'm sure quite a few of them are really
"duplicates" that can be eliminated in chunks.

So I don't know how useful any of that will be, but it at least should
give _some_ metric that should be diminishing as we fix leaks.

-- >8 --
#!/usr/bin/perl

my $boring = join('|',
  # These are allocation functions that get called from a lot of places.
  qw(
        __interceptor_strdup
        __interceptor_calloc
        realloc
        malloc
        xstrdup
        xcalloc
        strbuf_
        xmemdupz
        xstrvfmt
        xstrfmt
        xstrndup
  ),
  # These are really just the revision machinery not getting cleaned up;
  # for many we'd probably want to just UNLEAK() at the apex caller
  qw(
        add_rev_cmdline
        add_object_array_with_path
        add_pending_object_with_path
        add_pending_object_with_mode
        add_pending_object
        handle_revision_arg
        setup_revisions
  ),
  # More allocators that drop memory ownership
  qw(
        alloc_ref_with_prefix
        alloc_ref
        copy_ref
        commit_list_insert
        copy_pathspec
  ),
);
my $boring_re = qr/^$boring/;
my $skipping;

while (<>) {
  if (/^\s*#[0-9]+ 0x[0-9a-f]+ in (.*)/) {
    next if $skipping; # we already reported this trace
    next if $1 =~ $boring_re;

    print $1, "\n";
    $skipping = 1;
  } else {
    $skipping = 0;
  }
}
