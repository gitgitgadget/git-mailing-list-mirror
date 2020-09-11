Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0060FC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 15:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEDC2245F
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 15:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIKPCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:02:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:54490 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgIKPBN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 11:01:13 -0400
Received: (qmail 1079 invoked by uid 109); 11 Sep 2020 14:33:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2020 14:33:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3129 invoked by uid 111); 11 Sep 2020 14:33:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2020 10:33:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Sep 2020 10:33:21 -0400
From:   Jeff King <peff@peff.net>
To:     Bouke Versteegh <info@boukeversteegh.nl>
Cc:     git@vger.kernel.org
Subject: Re: Docs: possible incorrect diagram of Delta Copy instruction
Message-ID: <20200911143321.GA2374950@coredump.intra.peff.net>
References: <CAFag0172JvkTgzXs2ieq2kSfnNRy_8n5YsP87uQ-Pyf5vB+yfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFag0172JvkTgzXs2ieq2kSfnNRy_8n5YsP87uQ-Pyf5vB+yfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 02:30:20PM +0200, Bouke Versteegh wrote:

> While working on an implementation of git in dart, I've noticed a
> possible error in the documentation. I hope I'm using the correct
> channel to report this issue.

This is definitely the right place.

> On [pack format](https://git-scm.com/docs/pack-format#_instruction_to_copy_from_base_object)
> a diagram is shown, that explains the format of a Copy instruction
> inside a Deltified pack entry:
> 
> +----------+---------+---------+---------+---------+-------+-------+-------+
> | 1xxxxxxx | offset1 | offset2 | offset3 | offset4 | size1 | size2 | size3 |
> +----------+---------+---------+---------+---------+-------+-------+-------+
> 
> The documentation specifies that diagrams follow the RFC950
> (https://www.ietf.org/rfc/rfc1950.txt) format.

I think you mean rfc1951 here, but yeah, it is clear in that document
that bytes are in MSB order. And also that each of those boxes is a
single byte.

> That means that the left bit is MSB, and the right bit is LSB, so the
> OpCode is MSB (1xxxxxxx), which is correct and matches other sources.

Right, agreed.

> It also would mean that offset 1-4 should be read from bit 7, 6, 5 and
> 4 (i.e. 0x40, 0x20, 0x10, 0x08)

I don't think this follows, though. "offset1" is a separate byte. We
have a sequence of bytes here, some of which may be present. Their
presence is determined by the bits "xxxxxxx", but the diagram does not
say anything about the order.

The paragraphs below do say:

  This is the instruction format to copy a byte range from the source
  object. It encodes the offset to copy from and the number of bytes to
  copy. Offset and size are in little-endian order.

So "offset1" is the lowest byte of the offset value. We still don't know
which bit in the instruction byte tells us whether it's there yet,
though. The next paragraph says:

  All offset and size bytes are optional. This is to reduce the
  instruction size when encoding small offsets or sizes. The first seven
  bits in the first octet determines which of the next seven octets is
  present. If bit zero is set, offset1 is present. If bit one is set
  offset2 is present and so on.

So bit zero of the "xxxxxxx" (the LSB) is offset1, and we have to check
that first. Which I think is what happens in:

>   PARSE_CP_PARAM(0x01, cp_off, 0);

That's reading the low bit of the command byte, and then reading the
_next_ byte from data, and shifting it not at all (because it's the low
byte of the offset). That macro looks like this:

  #define PARSE_CP_PARAM(bit, var, shift) do { \
                          if (cmd & (bit)) { \
                                  if (data >= top) \
                                          goto bad_length; \
                                  var |= ((unsigned) *data++ << (shift)); \
                          } } while (0)

> However, looking at the git source-code and other documentation (see
> [1] [2]), I see that offset [1-4] are read from the LOWEST 4 bits, and
> the SIZE  bits are stored right after MSB (opcode).

I think both the code and diagram are right. It's just that the order of
the follow-on bytes is not part of that diagram, but rather the
explanation below it.

> From this source code, I would conclude that the diagram should look
> like this instead:
> 
> +----------+---------+---------+---------+---------+-------+-------+-------+
> | 1xxxxxxx | size3 | size 2 | size1 | offset4 | offset3 | offset2 | offset1 |
> +----------+---------+---------+---------+---------+-------+-------+-------+

That would definitely be wrong. If there's an offset1 byte, it
immediately follows the command byte.

-Peff
