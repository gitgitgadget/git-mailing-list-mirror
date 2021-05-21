Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393A2C433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F02613BF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhEUJPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 05:15:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:33130 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234287AbhEUJPF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 05:15:05 -0400
Received: (qmail 2664 invoked by uid 109); 21 May 2021 09:13:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 May 2021 09:13:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7670 invoked by uid 111); 21 May 2021 09:13:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 May 2021 05:13:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 May 2021 05:13:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up
 by >2x
Message-ID: <YKd5xSw1bZbQXaAe@coredump.intra.peff.net>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
 <YKYdeom6SgAHqojm@coredump.intra.peff.net>
 <xmqqv97drmge.fsf@gitster.g>
 <875yzcpo52.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yzcpo52.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 08:23:15AM +0200, Ævar Arnfjörð Bjarmason wrote:

> The "performant" really doesn't matter here, we're comparing shelling
> out to getting a small number of config keys back. So I wasn't trying to
> optimize this.
> 
> Returning a flattened list is idiomatic in Perl, it means that a caller
> can do any of:
> 
>     # I only care about the last value for a key, or only about
>     # existence checks
>     my %hash = func();
> 
> Or:
> 
>     # I want all key-values to iterate over
>     my @kv = func();
> 
> Returning touples like this makes that less convenient for both, who'll
> need to do more work to unpack them.
> 
> For what it's worth In Perl "return a list" means "flattened list", the
> term "flattened list" I think comes from other languages. You'd call
> what you're suggesting a list of arrays, or (if a top-level reference)
> an array of arrays, AoA for short, AoH for array (ref) of hashes etc.

Yeah, I think that is reasonable. But it made me wonder how we handle
value-less booleans, and I think there's indeed a bug.

Try a config like this:

  $ cat >foo <<\EOF
  [foo]
  key-with-value = string
  key-with-empty =
  just-bool
  another-key-with-value = another
  EOF

A regular config --list looks like:

  $ git config --file=foo --list
  foo.key-with-value=string
  foo.key-with-empty=
  foo.just-bool
  foo.another-key-with-value=another

Note how "just-bool" drops the "=" to distinguish it from the empty
string. With "-z", it looks like this:

  $ git config --file=foo --list -z
  foo.key-with-value
  string^@foo.key-with-empty
  ^@foo.just-bool^@foo.another-key-with-value
  another^@

The NULs separate keys, but keys are separated from their values by a
newline. And again, just-bool omits the newline.

Your parser splits on newline, so for that entry we'll get only one
string returned in the list (the key), rather than two (the key and
value). In a flattened list, that becomes ambiguous. E.g., adapting your
parser into a stand-alone script:

  $ git config --file=foo --list -z |
    perl -e '
      local $/;
      my $data = <STDIN>;
      my (@kv) = map { split /\n/, $_, 2 } split /\0/, $data;

      while (@kv) {
        my $k = shift @kv;
	print "key: $k\n";
	my $v = shift @kv;
	print "  value: ", (defined $v ? $v : "undef"), "\n";
      }
    '
  key: foo.key-with-value
    value: string
  key: foo.key-with-empty
    value: 
  key: foo.just-bool
    value: foo.another-key-with-value
  key: another
    value: undef

We end up misinterpreting a key as a value, and vice versa.

Using a non-flattened structure would have prevented this (we'd sensibly
get undef when trying to access the missing second element of the
array). But I do agree the flattened structure is more perl-ish.
Probably you'd want to insert an explicit "undef" into the list. The
most perl-ish I could come up with is:

  my (@kv) = map { my ($k, $v) = split /\n/, $_, 2;
                   ($k, $v)
                 } split /\0/, $data;

I notice that $known_keys then becomes a non-flat representation. You'd
either want to turn that back into a zero-length array there, or store
the "undef" and handle it appropriately (it can be a synonym for "true",
though that is just an optimization at this point).

-Peff
