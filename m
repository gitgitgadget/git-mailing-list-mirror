From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: Re: git-p4 issue
Date: Sat, 17 Dec 2011 00:52:57 -0500
Message-ID: <CAFLRbooKr4L+xQzzwb-V_ahw8cGz54Q=rPo9QL19NyZQHzxwUw@mail.gmail.com>
References: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com>
	<BANLkTimmVQAcx7hiQFUBcoAGdvPhktPuMg@mail.gmail.com>
	<BANLkTikDDDtyJB992DFNtvgMrGvbWf=rMw@mail.gmail.com>
	<BANLkTinJecAsXt+5JzscFYEx_ez2q9DioQ@mail.gmail.com>
	<20110420003100.GC28768@arf.padd.com>
	<BANLkTikYDR+bzJQGip9BFo-BSgsBqEcQjQ@mail.gmail.com>
	<BANLkTik49sCiBnf6ZofrtW+45uR6ZC+C9Q@mail.gmail.com>
	<loom.20110513T162233-874@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 06:53:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbnD4-0005vH-Bt
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 06:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102Ab1LQFxB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 00:53:01 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44022 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab1LQFw7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Dec 2011 00:52:59 -0500
Received: by pbdu13 with SMTP id u13so1037674pbd.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 21:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UYApo/U0zGnJm1ewM+/GPyVsumkYdEpmX4F9mBCW5Fw=;
        b=pGYP2lV26cLveJukAzmOgtD+xC21X4S27POxVbhBgM1tvyBjxvE25R+RoXs2TkooMb
         RKTPX3M3P0Rm9IrDkqT0WAMMeez3vDn4UpbSxvWKLkdTDxhQk6xTExl2DAglLDa9q7LR
         w6NE4qXVqa7szlJHxwXb+mvvKmHvcFlugECEI=
Received: by 10.68.120.72 with SMTP id la8mr21744684pbb.56.1324101177377; Fri,
 16 Dec 2011 21:52:57 -0800 (PST)
Received: by 10.143.31.6 with HTTP; Fri, 16 Dec 2011 21:52:57 -0800 (PST)
In-Reply-To: <loom.20110513T162233-874@post.gmane.org>
X-Google-Sender-Auth: wC0Paezr-bmgiFJ7S5t3f0lfA5Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187349>

Vitor,

I know it has been a long time, but I finally tried the below, and it
works for me.  I was doing things wrong at first, but I think I
finally understand what is going on...

=46irst, the branchList is great, that is what I needed.  Now I can
completely ignore the p4 branches.  It would be great if there was an
option to not have it query p4 branches at all, because we have so
many branches here it takes forever, and I am just using branchList.
What I did for now was to use your branchUser option, and pass it a
bogus username, like "XXXXXX".  At least this way it returns fast, but
would be nice to not have it try to query at all.

I think I understand now why all this is needed if you want it to
detect branches on its own.  Since in Perforce branches are just
directories, there is no way to tell if a directory is a branch or
not, and people could organize branches in an arbitrary directory
structure.  I was thinking you could look at sibling directories under
the same parent, which may be common, but there is no way to know for
sure, so better to be explicit.

The other odd issue is that if you do not add the new branch to
branchList (or p4 branches if you are using them) before you do the
git-p4 sync, then since it goes through change numbers in order, it
will never go back again and catch the branch in a change it already
synced.  This is why I could never get it to work, because I never had
it in place before I synced the relevant change.  What I realized
though is that I can always do a "git-p4 sync --detect-branches
//depot/foo/bar/@all" again, even though I already have the most
recent change, and it will re-detect any branches I missed (given I
have since added them to branchList).

What I had been thinking though is that if it had already detected
branches once, it could at least update the remote p4 branches it
already knew about to point at the latest revision, just not try to
detect new ones, and not rely on branchList.  Of course you would
still need branchList to detect any new branches.

Anyway, works a lot better than it did before.

Thanks,

Mike


On Fri, May 13, 2011 at 10:31 AM, Vitor Antunes <vitor.hda@gmail.com> w=
rote:
> Hi Michael,
>
> Michael Horowitz <michael.horowitz <at> ieee.org> writes:
>
>>
>> Vitor,
>>
>> > Could you please search for the following set of patches in this
>> > mailing list?
>> >
>> > [PATCH v2 0/3] git-p4: Improve branch support
>> >
>> > I think I sent v2 twice somehow, so please make sure you pick the
>> > latest ;)
>> > In these patches I add the possibility to use a "git-p4.branchList=
"
>> > configuration to define the branches. The patch is still to be
>> > approved because most people in the mailing list do not use branch
>> > detection, but I use it daily and it is working in my side. Could
>> > you please test it?
>>
>> Can you send this patch again? =A0It looks like you had previously
>> responded to the list only, so I never got this message, as I wasn't
>> on the list at the time (I am now). =A0I only saw this because I was
>> searching the archive for something else. =A0I searched for the patc=
h,
>> but the actual patch body doesn't seem to be in the archive.
>
> I am also not in the mailing list, I just follow its RSS and try to
> follow up on the git-p4 related topics ;) That is the reason why you
> were not included in the reply.
>
> But I have been a bit busy and did not see this email passing by. Sor=
ry.
> Luckily I had a tab opened in this thread, which I looked at today
> wondering what it was about! :P
>
> Please follow the link to the thread [1] and you can open each of the
> entries. Take care not to apply patch 1/3 as it may require you to cl=
one
> everything again.
>
>> Thanks,
>>
>> Mike
>>
>
> Regards,
> Vitor
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/167998/foc=
us=3D168000
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
