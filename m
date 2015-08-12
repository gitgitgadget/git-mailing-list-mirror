From: Johan Herland <johan@herland.net>
Subject: Re: enhanced remote ref namespaces
Date: Thu, 13 Aug 2015 00:52:58 +0200
Message-ID: <CALKQrgdVD6HX9_wKUwQn4VK8Rd=SDNAtCJccSZqh6r5vQ35QcA@mail.gmail.com>
References: <CA+P7+xocd+LE2A+srH0p1qTuXKRXanTp5E+imC1GE+9-biqR6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 00:53:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPetW-0003Qj-9v
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 00:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbbHLWxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 18:53:09 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:64069 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbbHLWxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 18:53:07 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZPetM-000NB6-Ij
	for git@vger.kernel.org; Thu, 13 Aug 2015 00:53:04 +0200
Received: by ykdz80 with SMTP id z80so27279449ykd.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 15:52:58 -0700 (PDT)
X-Received: by 10.13.249.198 with SMTP id j189mr36130917ywf.170.1439419978707;
 Wed, 12 Aug 2015 15:52:58 -0700 (PDT)
Received: by 10.37.201.134 with HTTP; Wed, 12 Aug 2015 15:52:58 -0700 (PDT)
In-Reply-To: <CA+P7+xocd+LE2A+srH0p1qTuXKRXanTp5E+imC1GE+9-biqR6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275828>

On Wed, Aug 12, 2015 at 8:34 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Aug 12, 2015 at 9:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Some design boundaries:
>>
>>  - Moving the remote-tracking branch hierarchy from refs/remotes/$O/*
>>    to refs/remotes/$O/heads/* would not fly, because it will break
>>    existing repositories.  Do not even waste time on pursuing
>>    refs/remotes/$O/{heads,tags,notes...}/*
>
> even if we maintained new git's abililty to work with this, ie: only
> external-to-git scripts would break and only for new clones? Maybe we
> don't want to go this route, but it seems like the way that the
> original proposal was headed.

I don't think it's worth trying to go that route. Even though it's
theoretically possible to solve it, the complexity added by e.g.
multiple git versions operating on the same repository (maybe even
simultaneously?) suggests that it's much simpler to just go with a new
clean hierarchy that simply Works for new Git versions, and the older
versions don't have to deal with at all. IMHO, maybe even going as far
as incrementing core.repositoryFormatVersion, so that older Git
versions will refuse to work with new-style repos...

[...]
>> If somebody got confused, notice that in the above description, I
>> said refs/remotes/ and refs/remote/.  The former must stay.  The
>> name of the latter is open to bikeshedding.  Some may prefer a name
>> that is more distinct (refs/tracking/ or something, perhaps?).  I
>> happen to prefer a name that is similar, but this preference is very
>> weak and I can persuaded to go either way.
>
> I don't like it being so similar that we now have typos between
> remotes and remote.. ie: remotes/<origin> works for heads, but
> "remotes/<origin>/tags" does not... that sounds like it would get
> confusing.

I like refs/tracking. At some point I was planning to use refs/peers,
but that's merely another color for the bikeshed...

> Symlinking the old location seems reasonable to me, as it would leave
> all the same data in the locations expected by the old tools, while
> keeping all actual storage in the new location.
>
> In this way, we would no longer need configuration settings. It
> honestly doesn't matter to me which direction we symlink either.
>
> As for the other complex issue is what to do about "refs/tracking/<origin>/tags
>
> The big discussion on the original thread is about how tags would
> work. I'm personally ok with *ignoring* tags and leaving it the way it
> is for now, and just doing this as a solid place to stick
> notes/replace/etc.

That is probably the best plan for now: Solve most of the problem, and
punt on the controversial parts.

> Or, we could go the route of continuing to stick tags into "refs/tags"
> at the same time as also sticking them into
> refs/tracking/<origin>/tags

I don't like the copying approach; makes it harder to deduce which tags
are (truly) local, and which came from a remote.

> Or.. we could go the full route of fixing up lookup of tags such that
> we put tags in refs/tracking/<origin>/tags and we have it lookup tags
> there via something like:
>
> 1) local tags preferred
>
> 2) any remote tag as long as all remote tags point to the same commit
> object (how we select which to use is not very relevant here... we
> could actually go with as long as the tag object is the same so two
> remotes with annotated tags pointing to the same object but different
> tag id would be ambiguous as well)
>
> 3) warn the user must disambiguate the tag via the remote name.

As was probably obvious from the old threads, this is where I'd like
to go. Eventually.

> We could also teach fetch to warn about remote tags which are
> ambiguous (ie: two remotes with same named tag objects pointing to
> different things)

Agreed. This would actually be a good improvement Right Now, without
changing any ref layout at all: If get fetch would otherwise copy a
remote tag into refs/tags/*, but doesn't because there is already a
_different_ tag in its place, then warn loudly to the user, so that
user has a chance to discover the tag difference.

> How goes this sound? I think it makes sense... I don't know how to do
> all this without breaking some backwards compatibility though... I
> think we can maintain expectations for the general user but I feel
> that any change here will break *someones* scripts.

As I said above: Punt on tags for now, and you might be able to not
break anyone's scripts (and if you do, it's probably a poorly written
script). Provided that you leave a symlink to/from refs/remotes/$O in
place, you're AFAICS only adding functionality, not (visibly) changing
existing behavior.


BTW, thanks for resurrecting this topic!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
