From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Mon, 21 Apr 2014 17:38:34 -0700
Message-ID: <CAB=NE6U7zYurAXNvjkHmk12Qsp9rerr=JyMjrVHrab98h9_+gQ@mail.gmail.com>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
 <xmqqppkhexw3.fsf@gitster.dls.corp.google.com> <CAB=NE6VvDrMQ4ybF10MpXM-2672OdUTC_Rp2mdO3a5fuo1-H1Q@mail.gmail.com>
 <xmqqfvlbga4r.fsf@gitster.dls.corp.google.com> <CAB=NE6Vt8etieyR256Hxb=q6zMo7UAO2Zkm5900NrE+4=-3eXA@mail.gmail.com>
 <xmqq7g6mb47f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
	Andreas Schwab <schwab@suse.de>, Jan Kara <jack@suse.cz>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 02:39:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcOjl-00081l-K9
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 02:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbaDVAi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 20:38:58 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35388 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbaDVAi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 20:38:56 -0400
Received: by mail-lb0-f170.google.com with SMTP id s7so3776581lbd.1
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 17:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=cuRgbDiaYy0dlFWKBYhx36vVU8Szpyknx/VWtkF/vjw=;
        b=yun1u2X6LrTKUhBW2TKZabxwQQBRk4Vwu/bD1zZKqlcWIi69zY5EDjtXBlge9VafRE
         hcpFJHPKrZ9uXm0O8jkHKKsvud7liyE2nXN+tniqin5wxvEqkqYEtFoBU70JXHnBjmqN
         qCsbggRRErnTVzokkQTH7+f5Fhpfb2UAeVCpUdZhEFC+64Lu58DQ2UnZHPysoNqNSF8W
         KUTXYg0VSLif0pLgsSvNmpucXyaU1UR6k7dRipLfcrZIy4/4nBas4xw4E7pv18eomy+Y
         bIGHTebKkAqxuGFqKYI8geABKp5F4nf4ZtHR4665nIJfxOUgQ5xriJJ+aMMs3BiKwzLl
         PcxQ==
X-Received: by 10.112.47.3 with SMTP id z3mr4275307lbm.34.1398127134833; Mon,
 21 Apr 2014 17:38:54 -0700 (PDT)
Received: by 10.112.215.74 with HTTP; Mon, 21 Apr 2014 17:38:34 -0700 (PDT)
In-Reply-To: <xmqq7g6mb47f.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: pRxjdpY7fDKbgbTPXZq3iS5eTUM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246681>

On Fri, Apr 18, 2014 at 4:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Luis R. Rodriguez" <mcgrof@do-not-panic.com> writes:
>
>> I think ultimately this reveals that given that tags *can* be
>> arbitrary and subjective,...
>
> Yes; see the part at the bottom.
>
>>> Commit A can be described in terms of both v3.4 and v9.0,
>>
>> And in the real example case, why *would* c5905afb' be be described in
>> terms of v3.5 instead of v3.4 ?
>
> I am not interested in graphing that particular history between v3.4
> and v3.5 myself.  If you are interested, I already gave you enough
> information on how to figure that out.

I was alluding to another possible issue here, my concern was that the
commit's parent (which is not really the point at which it was merged,
but rather where the topic got forked off to be worked on) could be
used for as reference points but clearly its not given the nature of
how name-rev was implemented. I still do see some possible issues with
it's parent on other commands (but I haven't studied the other's
implementation) that reveals some of my original concerns, but its
unclear if they are related. I also found that if we didn't want to
rely on dates or start defining naming convention we may want to
reconsider the name_rev() recursive implementation. I'll illustrate a
few results that might help to show my concerns for both other
commands perhaps using the parent erroneously, and a possible
alternative implementation for name_rev() or at the very least
contains.

[0] mcgrof@ergon ~/linux (git::master)$ git log c5905afb..v3.5| grep
^commit | wc -l
24878
[1] mcgrof@ergon ~/linux (git::master)$ git log c5905afb..v3.4| grep
^commit | wc -l
13106
[2] mcgrof@ergon ~/linux (git::master)$ git log c5905afb..v3.3| grep
^commit | wc -l
1360

Now that I revised name_rev.c I see the recursive nature of name_rev()
works top down from each tag down to each v* tag object and for each
actual commit pegs a name on it. How we rule out each tag under this
implementation is not that obvious to me, specially when results like
[0] and [1] reveal v3.4 should be 'shorter' in light of number of
commits. I see now how we don't update a commit's name if other
crucial information such as the ones discussed on this thread might be
important for the user, and I can see how this can help but an
alternative approach, which is what I expected to see implemented at
least for 'git describe --contains', would have been to see how many
commits are present from the commit's *merged* upstream parent (not
the actual parent as in c5905afb's commit case its v3.3 which is not
where it got merged). Getting the smallest number of commits under
this logic and stopping when we don't find any commits should yield us
the base tag under which the commit was merged, without any heuristics
on dates. This however applies to Linux though given that we don't
merge commits on stable branches but rather create new commits and
reference the upstream sha1sum, a practice which also solves the
problem Jeff pointed out.

The results for command [2] above however a bit surprising, I'd take a
look but I should go back to look at other stuff, figured I'd at least
bring it up now as it seems relevant.

>>>     - find candidate tags that can be used to "describe --contains"
>>>       the commit A, yielding v3.4, v3.5 (not shown), and v9.0;
>>
>>>     - among the candidate tags, cull the ones that contain another
>>>       candidate tag, rejecting v3.5 (not shown) and v9.0;
>>
>>>     - among the surviving tags, pick the closest.
>>>
>>> Hmm?
>>
>> Sounds good to me!
>
> Not so fast ;-)
>
> My other message to Peff in response to his another example has an
> updated position on this.  "Reject candidates that can reach other
> candidates" is universally correct, but after that point, there are
> at least three but probably more options that suit preference of
> different people and project to break ties:
>
>  - Your case that started this thread may want to favor v3.4 if only
>    because that v3.4 _sounds_ smaller than v4.0 (in Peff's example),
>    even when v3.4 and v4.0 do not have ancestry relationship.
>
>  - The "closest" we have had is a heuristic to produce a result that
>    is textually shorter.
>
>  - And as I alluded to, "which one has the earliest timestamp?", is
>    another valid question to ask.

The first one above can be subjective if and only if the Linux
upstream model of dealing with stable branches is not followed. In
other words I think its a non issue if you create new commits on the
stable branches instead of merge stuff onto them. This however is
technical practice and I guess not everyone follows.

> And there may be more to appear.  A new command line option (and
> possibly a new configuration) to choose from these three (and more
> heuristics that will be added later) would be necessary.

Yeah this is rather complex, the resolutions to the issue in the ways
you've described seem reasonable to me but do wonder if this can be
simplified by reevaluating how the candidates are considered. You'd
know better :)

 Luis
