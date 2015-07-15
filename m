From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log fails to show all changes for a file
Date: Wed, 15 Jul 2015 10:58:56 -0700
Message-ID: <xmqqy4ihwbdr.fsf@gitster.dls.corp.google.com>
References: <20150714073035.GA22707@aepfle.de>
	<20150714074508.GE1451@serenity.lan>
	<20150714075955.GA24577@aepfle.de>
	<CA+55aFzPvwAghGtA-WH8i1PcNe55XORokaXF9hNu7OUXBx++6Q@mail.gmail.com>
	<xmqq8uahxu3e.fsf@gitster.dls.corp.google.com>
	<CA+55aFy8urE+0w7mfgywcAnyoUu+6LMz-GGaOrUQYJ59gT9FfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Olaf Hering <olaf@aepfle.de>, John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 15 19:59:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFQxU-0003HB-58
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 19:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbbGOR67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 13:58:59 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37065 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbbGOR66 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 13:58:58 -0400
Received: by igbpg9 with SMTP id pg9so42374810igb.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=z6eCkD2r3QqRforWH3IwYLTWGmln1buJkD9I0n8QdaI=;
        b=qmSjAPnM1yr2zwPt8MfluWhyIfKxvPJHnt04bbLN0qtUZlsSVHN9bFxzqgOmWjRVo3
         Gw0bYLfKTZqodfyA6+INGjtfTebHzhXmlZfvc2JqDkSsC2UbX3G0D4q+FRBYYH+Y3qGA
         FPVp8coJw8wFZckHXS+Hzk3cSqBpZI/VpWQbFBUN51W3Q4Ii0dw41Q7Rrz8A3/OGNW8r
         FIuVVRWY+RxZ1E308KRcnTKMMihm86NC+0V2G0bjTpeze1eQieSNGTbPkEqyUaLjnj7n
         lEO57jUKdV7WRUTsfk82fbpS5LmDK2UenKs3Rki0AziG5eP29R6JaBqjGJ6IEmnO2V0/
         6Yyw==
X-Received: by 10.50.13.34 with SMTP id e2mr11805917igc.23.1436983137764;
        Wed, 15 Jul 2015 10:58:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91d4:b530:378d:909b])
        by smtp.gmail.com with ESMTPSA id d4sm3248251iod.17.2015.07.15.10.58.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jul 2015 10:58:57 -0700 (PDT)
In-Reply-To: <CA+55aFy8urE+0w7mfgywcAnyoUu+6LMz-GGaOrUQYJ59gT9FfA@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 15 Jul 2015 10:13:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273989>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ...
> So the whole "don't show diffs for merges by default" actually made a
> lot of sense originally, because our merge diffs were not very useful.

I agree with most of your analysis of the history, but not with "-m"
(rather, a part of what "-m" does).

> And "-m"? We should probably get rid of it. The diffs we get for
> merges when "-c" or "--cc" isn't given are _not_ useful. The original
> non-combined diff format was really just useful for showing that
> "yeah, we have multiple parents, and they are different in all these
> ways".  So there is no actual valid use for "-m" that I can imagine.

When combined with "--first-parent" it is a way to view what the
merge brought in from a side branch.

    $ git log --first-parent -m -p ko/master..master

is something I do every time I merge a batch of topics to the
'master' branch (where ko/master keeps track of what was pushed
to k.org the last time).

The fact that "-m" shows diffs with each and every parent is an odd
historical behaviour, and the only justification for it is that
people might want to view differences with second and later parents,
which is weak, and one way to allow them to view differences with
later parents is to show all (and force people to skip them in
normal use case), which is even weaker.

So to be constructive and to pu a different proposal on the table,
how about aiming for this end-game state?

 * When '-p' is given, we show only diff with first-parent by
   default, regardless of the traversal (i.e. --first-parent option
   currently controls both traversal and patch display, but in the
   new world order, it reverts back to purely a traversal option).

 * We could allow you to say '-p -m2' to get second-parent diff for
   merges, but I do not think we should bother, for at least two
   reasons.  It opens a can of worms, like "what should '-p -m4' to
   for a two-parent merge?"  Also "log" unlike "show" is about many
   commits, and I do not think of a reason why you would want a
   series of diff between the side-branch tip and the result.  '-m2'
   would only be useful for commits that was made by mistake,
   merging the trunk into a side branch, swapping the
   first-parenthood, which ought to be rare.

 * If somebody wants to omit patch for merges, while still showing
   the merge log, use '-p --no-show-merge-diff'.

 * When people want '--cc' or '-c', they can with 'log -p --cc',
   just like today.  We might want to make '--cc' imply '-p', but I
   vaguely recall some discussion against this [*2*].

Transition plan is a separate matter.


[Footnotes]

*1* With modern Git if you were pushing only to a single
    destination, you could say master@{push} instead, but I do not
    have remote.origin in my repository and push to multiple places,
    so master@{push} does not resolve ;-)

*2* http://thread.gmane.org/gmane.comp.version-control.git/215341/focus=215470
