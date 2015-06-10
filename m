From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] index-pack: avoid excessive re-reading of pack directory
Date: Wed, 10 Jun 2015 14:34:37 -0700
Message-ID: <CAJo=hJs51hG15MSdB-kdDy0NKn=50cbDpVS6o+VRx-6M-C0twA@mail.gmail.com>
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
Cc: steve.norman@thomsonreuters.com,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 23:35:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2neQ-0002ad-CF
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 23:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbbFJVfC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 17:35:02 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35490 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbbFJVe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 17:34:59 -0400
Received: by wiga1 with SMTP id a1so60320024wig.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WYKEeBy/DVtR+NVbRaWhLnd/kNj+kKAvHF7w8F0KpSs=;
        b=ax4L0K/pZkDuI/jQe4tqsx+G+tDQAelGxko0tSnOWp9SpZIJQrfVeya4F8FCJ0ywpw
         XfQf4oR5H3GWUVQnn568BedKeQ7adXfhalTlY5nN9+tOZrUnHNlbYb50mglm5W5GCFJ0
         CAQI6Qo+tchX7gIO+nk+P6KVRi0lCubh495ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=WYKEeBy/DVtR+NVbRaWhLnd/kNj+kKAvHF7w8F0KpSs=;
        b=ZA2iBpFUIY3N0+RKI6cu4gLwBEYwq+3t86QKAKrjDMZ3iLUG5Edj+vLcWaNz+ouG/F
         RiX3UZ755hSpU8N1gXVnoYcACSwCQEqlhh/MkS1Sf4t8DpTzAFxAm1sc80gBmp3p/0Et
         CRYcDJNcfLS3ivFhGgjtkavjL/6iJokHTqmYZ1hel+0nf6dWIlVLQIFFr1ZvvMU4JIaA
         C0blsixTkLxYE1nuX3wjWwmJQU62rQs1FT3Zw/aW1kbVNwT+nTgH2hsqaxMHjYnFoiVG
         fpVF6Mxzi06sYh/szaS2foxzF8HetiIKVVqJ3P62bjwMVbtADGjwsPSFw5TFdnq3e93Z
         lnWg==
X-Gm-Message-State: ALoCoQlBvEqrpF9a7xoe5M8SzhFidISYl0Oz58oqLK+07wnQsCocE17vGR5YgZNu4qY7AFe+2Vuh
X-Received: by 10.180.14.193 with SMTP id r1mr22863215wic.47.1433972097589;
 Wed, 10 Jun 2015 14:34:57 -0700 (PDT)
Received: by 10.28.49.134 with HTTP; Wed, 10 Jun 2015 14:34:37 -0700 (PDT)
In-Reply-To: <20150610140024.GA9395@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271359>

On Wed, Jun 10, 2015 at 7:00 AM, Jeff King <peff@peff.net> wrote:
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

Correct, fortunately we are not this naive.

JGit always does the reprepare_packed_git() + retry search on a miss.

But we have a code path to bypass that inside critical loops like our
equivalent of index-pack pulling off the wire. We snapshot the object
tree at the start of the operation before we read in the pack header,
and then require that the incoming pack be completed with that
snapshot. Since the snapshot was taking after ref
negotiation/advertisement, we should be at least as current as the
refs that were exchanged on the wire.

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

Interesting. We were getting hurt by this in JGit. For most
repositories it was cheaper to issue 256 readdir() and build a set of
SHA-1s we found. I think we even just hit every directory 00..ff, we
don't even bother with a readdir() on the $GIT_DIR/objects itself.

> I'm also hesitant to go that route because it's basically caching, which
> introduces new opportunities for race conditions when the cache is stale
> (we do the same thing with loose refs, and we have indeed run into races
> there).

Yes. But see above, we do this only after we snapshot the packs, and
only after the ref negotiation, and only for the duration of parsing
the pack off the wire. So we should never have a data race.

Since JGit is multi-threaded, this cache is also effectively a
thread-local. Its never shared across threads.

> [1] As measured mostly by __d_lookup_rcu calls. Of course, my patch
>     gives a 5% improvement over the original, and we were not spending
>     5% of the time there originally. I suspect part of the problem is
>     that we do the lookup under a lock, so the longer we spend there,
>     the more contention we have between threads, and the less
>     parallelism. Indeed, I just did a quick repeat of my tests with
>     pack.threads=1, and the size of the improvement shrinks.

Interesting. Yea, fine-grained locking can hurt parallel execution... :(
