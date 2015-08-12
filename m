From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: enhanced remote ref namespaces
Date: Wed, 12 Aug 2015 11:34:50 -0700
Message-ID: <CA+P7+xocd+LE2A+srH0p1qTuXKRXanTp5E+imC1GE+9-biqR6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 20:35:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZParv-00029x-LZ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 20:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbbHLSfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 14:35:12 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33010 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbHLSfK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 14:35:10 -0400
Received: by igbpg9 with SMTP id pg9so118063733igb.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=0V4EqmEbkDIbeVZeXB2OXtqRGpXFQeoZpVrZxlEXDMQ=;
        b=mAPOV3rfi80tBLRm94sxkXUc3CqSHAYU2bv9clz+Hiu5vCSANUdwJOx0wRO1VCCqjQ
         F/+jjqtyQQFj6J6vBYSWj+ZoUNqPsJJUEAW5rHJqmEA3duh8hgxNO+/suAAljMlaC4FP
         sAzXPDQwJmDJ66HUSTEYw1oI7sprTpURnTxhEktUQZfsCVW6O6GRFiWYrp65+XyP4J6K
         ghNu9HX9nAfugk/m4ZpPq6H7slDExkccVD1jZfJV0qy4u1J2EGTuBvAlrXAxTPOdstcX
         DCazdoiAqKLcuBLRVBYUHt3jnaYxzPrAwt8kXW1a8dYXr1ltVhxyXfVqsN0gKbVWcBXh
         pAnw==
X-Received: by 10.50.27.39 with SMTP id q7mr23874297igg.73.1439404509800; Wed,
 12 Aug 2015 11:35:09 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 12 Aug 2015 11:34:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275794>

On Wed, Aug 12, 2015 at 9:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Recently there was some discussion about git-notes and how we do not
>> fetch notes from remotes by default. The big problem with doing so is
>> because refs/remotes/* hierarchy is only setup for branches (heads),
>> so we don't have any clean location to put them.
>
> I wouldn't call this topic "proper" namespaces, though.  What we
> have is widely used and it shouldn't be broken.  Call it "enhanced",
> perhaps.
>

Ok.

> Some design boundaries:
>
>  - Moving the remote-tracking branch hierarchy from refs/remotes/$O/*
>    to refs/remotes/$O/heads/* would not fly, because it will break
>    existing repositories.  Do not even waste time on pursuing
>    refs/remotes/$O/{heads,tags,notes...}/*
>

even if we maintained new git's abililty to work with this, ie: only
external-to-git scripts would break and only for new clones? Maybe we
don't want to go this route, but it seems like the way that the
original proposal was headed.

>  - Extending the current refs/remotes/$O/* (for branches) and doing
>    refs/remote-tags/$O/* (for tags) may work, would not break
>    existing repositories, and could to be extended further to cover
>    refs/remote-notes/$O and friends.  It however may not look pretty
>    (weak objection) and more importantly, it would make it harder to
>    "cull" things that came from a single remote.
>
> Just thinking aloud, perhaps we can introduce a brand new top level
> hierarchy refs/remote/$O/{heads,tags,notes,...}, and give backward
> compatibility by making a moral equivalent of a symbolic link from
> refs/remote/$O/heads to refs/remotes/$O/.  The true remote-tracknig
> refs continue to live in refs/remotes/$O/* and old tools that do not
> know the new layout would not be hurt.  New tools that want to
> ignore and look only at refs/remote/$O/* can do so through the moral
> equivalent of a symbolic link.  "remote remove" needs to be taught
> about this single exception (i.e. "the symbolic link"), but the
> places it needs to touch is limited only to two places and will not
> grow.
>


I think this proposal makes the sense..  I'd go with something like:

refs/tracking/<origin>/(heads|tags|notes|replace|etc)/*

with a symlink from or into

refs/tracking/<origin>/heads -> refs/remotes/<origin>

I prefer tracking vs remote because "remote" and "remotes" are too
similar for my taste. tracking I think gets the idea across pretty
straight forward. Using a symlink personally I'd symlink the
refs/tracking into refs/remotes rather than make refs/remotes the real
storage.


> If somebody got confused, notice that in the above description, I
> said refs/remotes/ and refs/remote/.  The former must stay.  The
> name of the latter is open to bikeshedding.  Some may prefer a name
> that is more distinct (refs/tracking/ or something, perhaps?).  I
> happen to prefer a name that is similar, but this preference is very
> weak and I can persuaded to go either way.

I don't like it being so similar that we now have typos between
remotes and remote.. ie: remotes/<origin> works for heads, but
"remotes/<origin>/tags" does not... that sounds like it would get
confusing.

Symlinking the old location seems reasonable to me, as it would leave
all the same data in the locations expected by the old tools, while
keeping all actual storage in the new location.

In this way, we would no longer need configuration settings. It
honestly doesn't matter to me which direction we symlink either.

As for the other complex issue is what to do about "refs/tracking/<origin>/tags

The big discussion on the original thread is about how tags would
work. I'm personally ok with *ignoring* tags and leaving it the way it
is for now, and just doing this as a solid place to stick
notes/replace/etc.

Or, we could go the route of continuing to stick tags into "refs/tags"
at the same time as also sticking them into
refs/tracking/<origin>/tags

Or.. we could go the full route of fixing up lookup of tags such that
we put tags in refs/tracking/<origin>/tags and we have it lookup tags
there via something like:

1) local tags preferred

2) any remote tag as long as all remote tags point to the same commit
object (how we select which to use is not very relevant here... we
could actually go with as long as the tag object is the same so two
remotes with annotated tags pointing to the same object but different
tag id would be ambiguous as well)

3) warn the user must disambiguate the tag via the remote name.

We could also teach fetch to warn about remote tags which are
ambiguous (ie: two remotes with same named tag objects pointing to
different things)

How goes this sound? I think it makes sense... I don't know how to do
all this without breaking some backwards compatibility though... I
think we can maintain expectations for the general user but I feel
that any change here will break *someones* scripts.

Regards,
Jake
