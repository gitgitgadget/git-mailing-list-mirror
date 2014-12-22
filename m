From: Patrick Reynolds <piki@github.com>
Subject: Re: XDL_FAST_HASH can be very slow
Date: Mon, 22 Dec 2014 03:08:12 -0600
Message-ID: <CAJrMUs_fM8+=2j1e5hYiaRjQq1QF87X6qOLN847q-B7Nu-wniw@mail.gmail.com>
References: <20141222041944.GA441@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 22 10:08:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2yyT-0006sR-SP
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 10:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbaLVJIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 04:08:15 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:43007 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbaLVJIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 04:08:13 -0500
Received: by mail-ob0-f169.google.com with SMTP id vb8so20371374obc.0
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 01:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kl+g60P+vzUEReMeqKyYiZwLN0g19CaE4nK2jJPmYXI=;
        b=UJstgMJSTWs98ckEWl0NxsqFPmRLQJi+VveEuF/x/CneZ3P20Ys5PnbQEcs+WAaBRx
         M3fSm6iiCySeebMTrjxY6BuzLDU0VCmSRxYVaZOJyfxQj+MTyDgdAnwZTy7x9BShiXy/
         oUSo8hO+ijzM17HjBdlEBb+W9PZDOJYTRg6e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kl+g60P+vzUEReMeqKyYiZwLN0g19CaE4nK2jJPmYXI=;
        b=QFq/LQfOVx+w86s/b2v3aOLtoRoQ8frx3C0thRKTuUc858y8Vfp6+YygjO6GXPrCt0
         4c7BmpcYOvjfg9rojgtPv2HHF8ddfLwp3KXL59+Ia4oLZcjYMsEeyMpqEY5W456szM0P
         dY/sjU/r5RMo7m7TBMuHDBp5ALbsBWk9Ah9LQ3r5LukTueEh6rr2gsZroRzpzvNv2eum
         jbj6k5SgbZelQJi57kwlY/lF4XJMUqFV/qvf7Zz7fiZhZlmkPaKnKurPTtOAGcUPYi7i
         S/30jTLrpIzC+6/Qg/uquXnJqR/MPSS5ksktOJBWVCdeljY1fO5Wvyvfm+tlG1lEY9+7
         iZUA==
X-Gm-Message-State: ALoCoQndUCD0Md7ggt9esZrEY1CzLTQnuPEmqP1GnfriFdY4NZWJC1zJhzbGzsK6CGZFNRChoDWB
X-Received: by 10.202.4.5 with SMTP id 5mr11849039oie.22.1419239292558; Mon,
 22 Dec 2014 01:08:12 -0800 (PST)
Received: by 10.76.116.40 with HTTP; Mon, 22 Dec 2014 01:08:12 -0800 (PST)
In-Reply-To: <20141222041944.GA441@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261641>

I have been working with Peff on this and have more results to share.

For background, xdl_hash_record is a hashing function, producing an
unsigned long from an input string terminated by either a newline or
the end of the mmap'd file.

The original xdl_hash_record is essentially DJB hash, which does a
multiplication, load, and xor for each byte of the input.  Commit
6942efc introduces an "XDL_FAST_HASH" version of the same function
that is clearly inspired by the DJB hash, but it does only one
multiplication, load, and xor for each 8 bytes of input -- i.e., fewer
loads, but also a lot less bit mixing.  Less mixing means far more
collisions, leading to the performance problems with evil-icons.  It's
not clear to me if the XDL_FAST_HASH version intended to match the
output of the DJB hash function, but it doesn't at all.

Peff has been experimenting with using two modern hash functions, FNV
and Murmur3.  In theory, these should produce fewer collisions than
DJB, but in his measurements, they didn't run diff any faster than
plain DJB.  They do fix the evil-icons problem.

I have implemented two simpler possibilities, both of which fix the
problems diffing the evil-icons repository:

1. An XDL_FAST_HASH implementation that matches the output of the DJB
hash exactly.  Its performance is basically the same as DJB, because
the only thing is does differently is load 8 bytes at a time instead
of 1.  It does all the same ALU operations as DJB.

2. Using (hash % prime_number) instead of (hash & ((1<<hbits)-1)) to
map hash values to buckets in the hash table.  This helps because
there's entropy in the high bits of the hash values that's lost
completely if we just mask off the low hbits bits.  I've chosen prime
numbers that are close to the power-of-two sizes of the table -- e.g.,
32749 instead of 32768 -- so very little space is wasted.  Applying
this change to the XDL_FAST_HASH hash function makes it perform as
well as DJB and Murmur3.  That is, it eliminates the performance
problems with the evil-icons repo.

I evaluated several of the hash functions according to how deep the
chains are in each hash bucket, when diffing the evil-icons repo.
DJB, Murmur3, and XDL_FAST_HASH%prime all produce near-optimal
scattering, with the longest chain between 29 and 34 elements long.
XDL_FAST_HASH as implemented in the current git tree -- with
bit-masking instead of modulo-prime -- produces 100 buckets with chain
lengths over 4000.  Most of the other buckets are empty.  Each of
these long chains takes quadratic time to build and linear time to
traverse, which presumably is where the terrible performance for
evil-icons comes from.

The bottom line is, I think XDL_FAST_HASH needs to go, because it has
poorly understood collision behavior with pretty bad worst cases.  I
don't have strong feelings about what should replace it -- original
DJB, a fixed XDL_FAST_HASH, Murmur3, or something else.  All of the
replacements have good collision behavior and good behavior on the
repos I've tested, but appear to be a few percent slower in the common
case.

--Patrick
