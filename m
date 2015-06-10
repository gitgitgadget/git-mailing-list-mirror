From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] index-pack: avoid excessive re-reading of pack directory
Date: Wed, 10 Jun 2015 21:36:23 +0700
Message-ID: <CACsJy8AfyYFcDdXN8jyRedhAx9f7c2n9Mmxs2W_FzfYd-f=AEg@mail.gmail.com>
References: <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net> <CACsJy8Bb1O7QZtiPWdzYwYgOdV0dLDgD3Xu_YaWNUbsuTqJB5g@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C55197764FE@C111KXTEMBX51.ERF.thomson.com>
 <20150605121817.GA22125@peff.net> <20150605122921.GA7586@peff.net>
 <CAJo=hJv6O66yFC_O_4aeL2JxBOtk2f+k1wGt3VW7dk71Q1ov3A@mail.gmail.com> <20150610140024.GA9395@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	steve.norman@thomsonreuters.com, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 16:37:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2h80-0002pt-Dy
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 16:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933054AbbFJOhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 10:37:12 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33005 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964877AbbFJOgy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 10:36:54 -0400
Received: by iebgx4 with SMTP id gx4so35670643ieb.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7YO7VNW7eMPHyfPrVBwJ9VxoDm7MGu/w+t39Qf+iBgo=;
        b=wJpH+qvtm9QLdTAbIqE1t3QotrYvQIEaiDLAuPHCMePEQBKXw/7qzbN2YCaT3Ur64z
         M9MXf0TR7xD6N01bORNxacLd9EPtPrQQ/60pgNN/BJ5lXldpkqPINjtyfcF5B1Xhs/B7
         OVxLYZ0pKYqE+8R0lymCgorz/fn2KOxWm0JBjW6PHzlZi+7Pd2i3p/HacN3UUw6yyRws
         WN3ByfLax8OddOLa8AS7E0WGvO/R7rp4Bl9JQ3eTvGxZvmYDy2myQwpNJ2YnRbKdTLtZ
         pIKnwbmOHhrp6Kmr/rJbQ0f36jWsfgPNjTLVB5rSAnWrZJs1RabDF84ZytCkmlEmseT8
         O5GQ==
X-Received: by 10.107.47.224 with SMTP id v93mr4732006iov.86.1433947013977;
 Wed, 10 Jun 2015 07:36:53 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Wed, 10 Jun 2015 07:36:23 -0700 (PDT)
In-Reply-To: <20150610140024.GA9395@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271289>

On Wed, Jun 10, 2015 at 9:00 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 09, 2015 at 08:46:24PM -0700, Shawn Pearce wrote:
>
>> > This patch introduces a "quick" flag to has_sha1_file which
>> > callers can use when they would prefer high performance at
>> > the cost of false negatives during repacks. There may be
>> > other code paths that can use this, but the index-pack one
>> > is the most obviously critical, so we'll start with
>> > switching that one.
>>
>> Hilarious. We did this in JGit back in ... uhm before 2009. :)
>>
>> But its Java. So of course we had to do optimizations.
>
> This is actually how Git did it up until v1.8.4.2, in 2013. I changed it
> then because the old way was racy (and git could flakily report refs as
> broken and skip them during repacks!).
>
> If you are doing it the "quick" way everywhere in JGit, you may want to
> reexamine the possibility for races. :)

I was expecting this :D

>> > @@ -3169,6 +3169,8 @@ int has_sha1_file(const unsigned char *sha1)
>> >                 return 1;
>> >         if (has_loose_object(sha1))
>> >                 return 1;
>> > +       if (flags & HAS_SHA1_QUICK)
>> > +               return 0;
>> >         reprepare_packed_git();
>> >         return find_pack_entry(sha1, &e);
>>
>> Something else we do is readdir() over the loose objects and store
>> them in a map in memory. That way we avoid stat() calls during that
>> has_loose_object() path. This is apparently a win enough of the time
>> that we always do that when receiving a pack over the wire (client or
>> server).
>
> Yeah, I thought about that while writing this. It would be a win as long
> as you have a small number of loose objects and were going to make a
> large number of requests (otherwise you are traversing even though
> nobody is going to look it up). According to perf, though, loose object
> lookups are not a large expenditure[1].
>
> I'm also hesitant to go that route because it's basically caching, which
> introduces new opportunities for race conditions when the cache is stale
> (we do the same thing with loose refs, and we have indeed run into races
> there).

Watchman may help avoid races _with_ caching. But we need to support
both ways in that case, falling back to normal file poking when
watchman gives up, or when we're on Windows. Extra work needs big
enough performance gain to justify. I haven't seen that gain yet.

> [1] As measured mostly by __d_lookup_rcu calls. Of course, my patch
>     gives a 5% improvement over the original, and we were not spending
>     5% of the time there originally. I suspect part of the problem is
>     that we do the lookup under a lock, so the longer we spend there,
>     the more contention we have between threads, and the less
>     parallelism. Indeed, I just did a quick repeat of my tests with
>     pack.threads=1, and the size of the improvement shrinks.
-- 
Duy
