From: Brandon Casey <drafnel@gmail.com>
Subject: Re: git auto-repack is broken...
Date: Sat, 3 Dec 2011 13:42:22 -0600
Message-ID: <CA+sFfMdeVoz8XU5j4hNn1qCHHzaiDi0Bw=QbbuU3cwT9mMPZOA@mail.gmail.com>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
	<CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
	<CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
	<20111202171017.GB23447@sigill.intra.peff.net>
	<7vobvqoozr.fsf@alter.siamese.dyndns.org>
	<20111202174546.GA24093@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 03 20:48:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWvZN-000187-Cw
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 20:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab1LCTmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Dec 2011 14:42:24 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38489 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab1LCTmX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Dec 2011 14:42:23 -0500
Received: by ggnr5 with SMTP id r5so3989932ggn.19
        for <git@vger.kernel.org>; Sat, 03 Dec 2011 11:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bF/wPRYVjqvYrci4QUe55lEirOCwRUCGTBFXqRkjX68=;
        b=lipncW4jjnr7navaim302E/+MkqGIcvZu4iGNgBBF1/9uvSDuhnepcBiZwhmIPJEng
         1eU6iyCSd/sln8QuQAdNTCRv0+CFaszq1dtHMNg6YcBCV9vHx71rZvKwadRvz3z4RaRw
         udg4llRO0kC4F1tUMFgY26/V6ikJX/vXB30hQ=
Received: by 10.182.72.100 with SMTP id c4mr609924obv.39.1322941342677; Sat,
 03 Dec 2011 11:42:22 -0800 (PST)
Received: by 10.182.60.4 with HTTP; Sat, 3 Dec 2011 11:42:22 -0800 (PST)
In-Reply-To: <20111202174546.GA24093@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186257>

On Fri, Dec 2, 2011 at 11:45 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 02, 2011 at 09:35:52AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > When the objects become unreferenced, we eject them from the pack =
into
>> > loose form again. If they don't become referenced in the 2-week wi=
ndow,
>> > they get pruned then. So yes, you drop the age information, but th=
ey do
>> > eventually go away.
>>
>> If you update gc/repack -A to put them in a separate pack, then you =
would
>> never be able to get rid of them, no? You pack, then eject (which gi=
ves
>> them a fresher timestamp), then notice that you are within the 2-wee=
k window
>> and pack them again,...
>
> But we shouldn't be packing totally unreferenced objects. Barring bug=
s,
> the life cycle of such an object should be something like:
>
> =C2=A01. Object X is created on branch 'foo'.
>
> =C2=A02. Branch 'foo' is deleted, but its commits are still in the HE=
AD
> =C2=A0 =C2=A0 reflog, referencing X.
>
> =C2=A03. 90 days pass (actually, I think this might be the 30-day
> =C2=A0 =C2=A0 expire-unreachable time)
>
> =C2=A04. "git gc" runs "git repack -Ad", which will eject X from the =
pack
> =C2=A0 =C2=A0 into a loose form (because it is not becoming part of t=
he new pack
> =C2=A0 =C2=A0 we are writing).

Actually, it is right here when the newly loosened unreferenced
objects will be deleted.  Objects ejected from a pack _are_ given the
timestamp of the pack they were ejected from.  So, if the pack is
older than two weeks (90 days in your example), then so will be the
loosened objects, and git prune will delete them when called by git
gc.

> =C2=A05. Two weeks pass.
>
> =C2=A06. "git gc" runs "git prune --expire=3D2.weeks.ago", which remo=
ves the
> =C2=A0 =C2=A0 object.
>
> "gc" runs between (4) and (6) will not re-pack the object, because it
> remains unreferenced.

Correct with the recognition that loose objects get pack mtime, so
step 5 may be less than two weeks.

> I think things might be slowed somewhat by "gc --auto", which will no=
t
> do a "repack -A" until we have too many packs. So steps (3) and (4) a=
re
> really more like "gc runs git-repack without -A" 50 times, and then w=
e
> finally run "git repack -A".

This is correct.  This should have the effect of increasing the age of
unreferenced objects when they are finally loosened and make it more
likely that they are pruned during the same git gc operation that
loosens them.

Linus's scenario of fetching a lot of stuff that never actually makes
it into the reflogs is still a valid problem.  I'm not sure that
people who don't know what they are doing are going to run into this
problem though.  Since he fetches a lot of stuff without ever checking
it out or creating a branch from it, potentially many objects become
unreferenced every time FETCH_HEAD changes.  If he does this many
times in a short period of time, he could reach the gc.autopacklimit
and trigger gc --auto and produce more than gc.auto loose objects that
are younger than gc.pruneExpire.

Decreasing gc.pruneExpire as you suggested should make it much less
likely to run into this problem.  I wonder if it is worth trying to
limit how often gc --auto is run to not be more often than
gc.pruneExpire or something.  If we modified the timestamp that is
assigned to fetched packs, maybe we could use the pack timestamps as
an indicator of how recently git gc has run.

-Brandon
