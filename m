From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Sun, 14 Feb 2016 09:56:16 -0800
Message-ID: <CAJo=hJuvHpWPQGV1gwgwOATy+8OO0Smt-BG9xb3q7eeJSypdaA@mail.gmail.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
 <20160210214945.GA5853@sigill.intra.peff.net> <CAJo=hJv-GWZOsv31iekW+AdNazLGQ=XYD=UXMO+RuB15baTsow@mail.gmail.com>
 <20160214170525.GB10219@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 18:57:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aV0v9-00088W-PQ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 18:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbcBNR5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 12:57:09 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35461 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbcBNR4h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 12:56:37 -0500
Received: by mail-vk0-f49.google.com with SMTP id e6so92394675vkh.2
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 09:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1LON9cZghNdQMuvU1lXTee91Uv/+aB4t/pyKo7xzhq0=;
        b=TNyJGcK3Kf22AShPU3eRqafGgBWjC21hYx/H5bthKFvDcRnBT1HyWWZNM+10LLfPai
         vzHbC1Xyt9oG162Cu83DQ8Ui6rANUBuWZWw+nOmOkIlZdebim0edVgf58yu6lPrs5tCp
         mKRyEgG0A+0r0z1MfodxE3xRUYPP3fg2B2t5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=1LON9cZghNdQMuvU1lXTee91Uv/+aB4t/pyKo7xzhq0=;
        b=U9ux+y8WJrP7j4+71chj4AbXISsL4KAbnwNw+Ye5kJxkP0AKjECT3gChIOStDcg4Bv
         Oqyx/oK4t8y7o+9uLBF6W9ShXvvyC0gORbCah5z280+A6BAe/B4SkqDrJKRS/XzXCDJN
         iv2Lk4nT3XlLnSxB1BSaZKNcvT+UDIPM0kKqXKQcgMxge4+LV0l3TxT0HoLub5/7WWzm
         t5Tce9QBQJJo3D4nzgp0d4ESiqCP13rO7E3IBV5YN535k6FHzlgprztu+7aorKTT3mWR
         UnfRchJR9k4YN7mW6KV/3UBahs4lgtHPWQT4r4qPBk8VValCXmsTwOfGqxej+spqOiLT
         oJRQ==
X-Gm-Message-State: AG10YOT4FKMpXeNafh74XiOrbs6vmpCkiZ0pDq/02C2kFQnZuNcizJZGG7bL9H1dwYCCUNv1rEycIa+U8wVEow==
X-Received: by 10.31.13.79 with SMTP id 76mr9213941vkn.148.1455472596031; Sun,
 14 Feb 2016 09:56:36 -0800 (PST)
Received: by 10.103.71.211 with HTTP; Sun, 14 Feb 2016 09:56:16 -0800 (PST)
In-Reply-To: <20160214170525.GB10219@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286159>

On Sun, Feb 14, 2016 at 9:05 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 13, 2016 at 06:14:31PM -0800, Shawn Pearce wrote:
>
>> > And with "resumable=<url>", the client does not have to hit the server
>> > to do a redirect; it can go straight to the final URL, saving a
>> > round-trip.
>>
>> It occurred to me today that to make the above ("resumable=<url>") as
>> efficient as possible, we should allow HTTP clients to include
>> &resumable=1 in the GET /info/refs URL as a hint to the server that if
>> it serves a resumable=<url> it can shrink the ref advertisement to 1
>> line containing the capabilities.
>
> I'm slightly wary of this. The client advertising "resumable=1" does not
> mean "I will definitely do a resumable clone". It means "I support the
> resumable keyword, and if you share a resumable URL with me, I _might_
> use it, depending on things that are none of your business" (e.g., if it
> does not like the server URL's protocol).
>
> It is recoverable by having the client re-contact the server without the
> resumable flag, so it could still be a net win if the client will select
> the resumable URL a majority of the time.

That was my thinking; if the client starts out with &resumable=1 and
then doesn't like the URL the server offers in the advertisement it
can drop the query parameter and relist the references for a standard
dynamic clone.

> I'm also not happy about having an HTTP-only feature in the protocol. I
> liked Stefan's proposal for the "v2" protocol that would let the two
> sides exchange capabilities before the ref advertisement. Then the
> client, having seen the server's resumable URL, knows whether or not
> to proceed with the advertisement.

Ok, that's fair. Lets forget the "&resumable=1" for now so that the
various protocols are more identical. Later if "v2" makes enough
progress we can rely on its capability exchange before advertisement
to get this potential bandwidth savings.

>> Clients are going to follow the returned <url> to get a bundle header,
>> which contains the references. And then incremental fetch from the
>> server after downloading the pack. So returning references with the
>> resumable URL during a clone is an unnecessary waste of bandwidth.
>
> If the bundle is up to date, the client can skip the follow-up
> incremental fetch, as it knows that it has everything needed for the
> original ref advertisement it got. Whether that's a net win depends on
> how up-to-date the bundles are.

Well, that comes down to "was the repository repacked since last
push". If yes the pack contains everything and its pack-*.info / split
bundle header thing contains the same contents as packed-refs.

I think in practice clients aren't going to bother with the
implementation detail of saving the initial ref advertisement aside,
grabbing the bundle header, and comparing them to see if it needs a
subsequent fetch. They are just going to discard the ref
advertisement, retrieve the pack, anchor the objects using the bundle
header, and then reconnect.

Remember this isn't just about holding the refs in memory. To be
resumable the client process may have to be restarted, so that initial
ref advertisement has to be written out to disk to persist.

> If "C" is the cost to contact the server at all and "A" is the cost of
> the advertisement, then a "hit" with this scheme means the overhead is
> C+A (we contact the server only once). A "miss" means we have do the
> followup fetch anyway, and we pay 2C+2A (paying the advertisement cost
> both times). Whereas with your scheme, we pay 2C+A always; two contacts,
> but only the second has an advertisement.
>
> So it depends on the relative cost of C and A, and how often we expect
> it to kick in.
>
> In practice, I suspect it's mostly dominated by the cost of the actual
> clone objects anyway, but maybe that is different for Gerrit. I hear
> refs/changes/ can get pretty big. :)

I hear refs/pulls/ can also get big. :)

But yes, some Gerrit advertisements are not small.
