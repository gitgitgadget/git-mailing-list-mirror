Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0C1C680
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF240D4C
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 08:52:21 -0700 (PDT)
Received: (qmail 20331 invoked by uid 109); 3 Nov 2023 15:52:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Nov 2023 15:52:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24896 invoked by uid 111); 3 Nov 2023 15:52:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Nov 2023 11:52:22 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Nov 2023 11:52:20 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [BUG] Git 2.43.0-rc0 - t4216 unpack(Q) invalid type
Message-ID: <20231103155220.GA1470570@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <007501da0e66$96f124d0$c4d36e70$@nexbridge.com>
 <007101da0e65$13e3c170$3bab4450$@nexbridge.com>

On Fri, Nov 03, 2023 at 10:50:19AM -0400, rsbecker@nexbridge.com wrote:

> In RC0, the following tests are failing (with verbose). They look like the
> same root cause. Unpack("Q>".... What version does git now require for perl?
> I have v5.30.3 available, nothing more recent.

The perl used in the test suite is supposed to be vanilla enough to
support any ancient version. The perl5 Git import doesn't have version
tags that go back that far, but the quadwords in pack/unpack go back at
least to a commit from 1998.

So I suspect this is not a version issue, but rather a build-time config
one. The docs say:

  Q  An unsigned quad value.
      (Quads are available only if your system supports 64-bit integer
      values _and_ if Perl has been compiled to support those.  Raises
      an exception otherwise.)

It would probably be possible to rewrite the use of "Q" here to grab two
32-bit values instead. But I'd guess that on your system it is not as
simple as a shift-and-add to then treat them as a 64-bit value, since
presumably the problem is that perl's ints are all strictly 32-bit.

What does this script produce for you:

  perl -e '
    my $bytes = "\1\2\3\4\5\6\7\8";
    my $q = eval { unpack("Q>", $bytes) };
    print "Q = ", defined($q) ? $q : "($@)", "\n";
    my ($n1, $n2) = unpack("NN", $bytes);
    print "n1 = $n1\n";
    print "n2 = $n2\n";
    print "computed quad = ", ($n1 << 32) | $n2, "\n";
  '

I get:

  Q = 72623859790382904
  n1 = 16909060
  n2 = 84281144
  computed quad = 72623859790382904

but I'm guessing you get an exception report for Q, and that the
computed quad is probably equal to n2 (the shift of n1 goes totally off
the end).

We may not be without hope, though. These 64-bit values are file offsets
we're reading from the chunk files. The format naturally uses 64-bit
values here to accommodate arbitrarily large files. But in our tests,
the offsets are all going to be relatively small. So our "$n1" in
practice will always be 0.

> This same problem also happens in t5318, t5319, t5324

Yep. The offending code is in lib-chunk.sh, so the new tests added in
all of those scripts which use it will run into the same problem.

-Peff
