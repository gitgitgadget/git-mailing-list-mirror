From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Bloom filters for have/want negotiation
Date: Fri, 11 Sep 2015 22:16:54 -0700
Message-ID: <CAJo=hJstD8c2RPUAj2OznFSCuyJsKFmvymsQMHOPhGdaqPgyvg@mail.gmail.com>
References: <55F343F5.6010903@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git discussion list <git@vger.kernel.org>,
	Wilhelm Bierbaum <bierbaum@gmail.com>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 12 07:17:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZadC0-0003cG-Vf
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 07:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbbILFRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 01:17:15 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35925 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbbILFRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 01:17:14 -0400
Received: by vkfp126 with SMTP id p126so35533693vkf.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 22:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=69I4kUNZs/p03MohBhX7yqvA5JV2QlqqavR+5lOoxT0=;
        b=QrVyZw/htq+kOBt2MpT/ou6cOpwDegcO/lJry3zpmGVsL9j/p+TNLcRefemDzQf895
         RhJnUyZNO3lTxqSbdIZIkCMoAcCSIBGeij1u9/2lSYZRQhOmpehQKTT/1//v5qeKq4JV
         B7cUzr+7kh5h5WXaaTiAKuAylVY3bhRQONmW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=69I4kUNZs/p03MohBhX7yqvA5JV2QlqqavR+5lOoxT0=;
        b=DtYzb13X9JvZpfBh1MBbZPXyqR/IteA1Cd7+BjvPa3U9CA1IYqI7I0Jjrbx80Q73kD
         4g5h5a3r3TEIBvtEaq30U9aO5GqNr2VM9LKkXznCtCozvksaoJWyanMd55FAb2aWKbPb
         yJssg3DgJ5YYaWmdYiu3ZDTM6MrZ1VfTdIzhDm7ic3pTb8szaR7ISp8ftHZObgm5c0jT
         GxDf/6Jw6HkaGUXpXC2Q4ZVpluolj4r0HDSbS/Ih66qf5mSfgaN666A7J4OUeGw3fppy
         +bmbQ4aXmjpK2SYdofFGNk93gT/Tv3+9sJYcQilqGC3O6eTSlGoYGhyhFM2DaRWyDInH
         KNRg==
X-Gm-Message-State: ALoCoQnPkMRwHwIQSoC4/PG4xg/SKoduOaPMqsi/S4zap+lFV95w8QNh2GHm1z4q0bGo4P86x6Jm
X-Received: by 10.31.182.12 with SMTP id g12mr1985643vkf.93.1442035033753;
 Fri, 11 Sep 2015 22:17:13 -0700 (PDT)
Received: by 10.103.10.65 with HTTP; Fri, 11 Sep 2015 22:16:54 -0700 (PDT)
In-Reply-To: <55F343F5.6010903@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277714>

On Fri, Sep 11, 2015 at 2:13 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I have been thinking about Wilhelm Bierbaum's talk at the last GitMerge
> conference [1] in which he describes a scheme for using Bloom filters to
> make the initial reference advertisement less expensive.
...
> But it got me thinking about how the client could use a Bloom filter in
> a later stage of the negotiation, when telling the server what objects
> it already has, while preserving 100% reliability.
...
> I don't have a gut feeling about the cost of this phase of the
> negotiation, so I don't know whether this would be a net savings, let
> alone one that is worth the added complexity. But I wanted to document
> the idea in case somebody thinks it has promise. (I have no plans to
> pursue it.)

Maybe I can help... it just so happens that I have Git servers at
$DAY_JOB instrumented in the smart HTTP negotiate code. They do "many"
fetch requests. :)

The average client is only sending 16 have lines; at 50 bytes/line
this is 800 bytes.

The worst case is due to a bug in the negotiation. With nothing
common, the client just goes on forever until it reaches roots
(something is wrong with MAX_IN_VAIN). We saw 56,318 have lines ... a
2.6 MiB section. But smart HTTP gzips, so this may be only 1.3 MiB on
the wire.

But average/worst doesn't tell the entire picture. Bucketing requests
by have lines gives us more:

  %req | have_lines
  -----|-----------
  100%   56,318
   99%       88
   98%       52
   97%       35
   96%       31
   95%       26

95% of requests have <= 26 have lines, or ~650 bytes after gzip on smart HTTP.
99% of requests have <= 88 have lines, like 2.15 KiB after gzip.

The smart HTTP client with nodone extension is allowed to send up to
1024 have lines in a single round trip; if the server can make an
efficient graph cut using only that batch, it can immediately return
the pack in that same round trip.

Ergo, if this is all working correctly on smart HTTP, clients can
fetch from a server they already "know" with decent efficiency, and
smaller than your 2 KiB Bloom filter estimate for git.git at 1% error
rate.


In practice this is not what always happens. The client isn't making
great decisions about what to send on smart HTTP. For example I have
observed a fetch session where the client sends:

  req #1:  16 haves
  req #2:  26 haves
  req #3:  45 haves
  req #4:  70 haves ... and done

So that is 4 round trips. It started out with 16; waited for common
ACKs. I guess 10 were common but no clean graph cut was made so the
client send another 16 to make 26. Again no clean cut so it added more
to send 45, then finally at 70 we found the cut point.

Reading fetch-pack.c, the first flush is at 16 lines. On the 2nd
request my intent was to double to 32 lines, but its not because count
is not reset to 0. So flush_at starts at 16, doubles to 32, but count
stays at 16 and only 16 new lines can be sent in the next packet, when
the intent was to try probing 32 on the second round. IOW fetch-pack.c
is not expanding the have window as quickly as I wanted.

In reality the above session probably sent:

  16 new,  0 state = 16 haves
  16 new, 10 state = 26 haves
  32 new, 13 state = 45 haves
  ?? new, ?? state = 70 haves

Maybe 120 unique have lines.


Looking at my request data and your Bloom filter "budget" of 2 KiB ..
we could just update fetch-pack.c to send 88 have lines in the first
request burst. 90+-ish% of my user's traffic might be served in just 1
round trip on smart HTTP, instead of 4.


This smart HTTP study also applies to the traditional bi-directional
protocol. With multi_ack the sends a 2nd batch while waiting for reply
from the server. With data moving in both directions on the wire total
round-trips becomes less important and its just data volume. But again
we are talking about 120 unique have lines, so 5.9 KiB (no
compression).

The have lines are very verbose in text format. Just using a binary
SHA-1 would nearly halve the negotiation to ~3 KiB. Binary SHA-1 have
line extension to upload-pack extension is far simpler than a Bloom
filter.

I do wonder if we are stuffing the pipe deep enough with multi_ack on
Internet links. Git doesn't need very long to walk 16 commits,
certainly less than the 200 ms RTT a user might have talking to a
server on the other side of the US. It is possible both sides are
spending most of their time waiting for data transfer of the batches
in flight.
