From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH] rebase: use reflog to find common base with upstream
Date: Mon, 21 Oct 2013 23:24:14 -0700
Message-ID: <CANiSa6jSVyKmF4Z5uRFSEZbciq+AqU3ybhrDmf-2gyCj0GD6Eg@mail.gmail.com>
References: <d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk>
	<CANiSa6gqGKAyLwwPVoZ_gzN85_06aTCfkdRRscNNZYs7g1rL0A@mail.gmail.com>
	<20131021112408.GA24317@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Oct 22 08:24:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYVO9-0006Ea-CW
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 08:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602Ab3JVGYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 02:24:16 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:45345 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab3JVGYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 02:24:16 -0400
Received: by mail-wi0-f177.google.com with SMTP id h11so5113264wiv.16
        for <git@vger.kernel.org>; Mon, 21 Oct 2013 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/YP33z9ZAgEgDhnjsv/z+k15p6yifcnseZ1N/6/Jbao=;
        b=xEOdX7XCbGtT7OTn0hWhTuaCKGwcLm6Y68+kHoS2/vguumCIbI+KRqmLtdjLPDfZhZ
         2aEwmqN8cM1Bv4U+aaSPKiH53c6yxoDOp81whxZ4GLcoSPSquPrVYG3oIzfSrcQrtlj+
         64lMNaJeZB0IMaB4Rg63nOb/lmy1mA5DHhpTJfksVfTtdGWrf3VoVBpZWv/2Ea9bn5kt
         HRlpgs17Nqdp76MfHhRjkhx2pWNcKsc7ykK5RCVd+5fUzZIvz6yFMpKVJrpT87haX038
         qU4USJ3s1C+P5KDq+QLTbIPDxd8pXnhIA2FbKdnJft2kkdX/rjlx0yCdq1wYec50ve9g
         v9sA==
X-Received: by 10.180.20.13 with SMTP id j13mr12886101wie.6.1382423054760;
 Mon, 21 Oct 2013 23:24:14 -0700 (PDT)
Received: by 10.180.12.69 with HTTP; Mon, 21 Oct 2013 23:24:14 -0700 (PDT)
In-Reply-To: <20131021112408.GA24317@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236460>

On Mon, Oct 21, 2013 at 4:24 AM, John Keeping <john@keeping.me.uk> wrote:
> On Sun, Oct 20, 2013 at 10:03:29PM -0700, Martin von Zweigbergk wrote:
>> On Wed, Oct 16, 2013 at 11:53 AM, John Keeping <john@keeping.me.uk> wrote:
>> > Commit 15a147e (rebase: use @{upstream} if no upstream specified,
>> > 2011-02-09) says:
>> >
>> >         Make it default to 'git rebase @{upstream}'. That is also what
>> >         'git pull [--rebase]' defaults to, so it only makes sense that
>> >         'git rebase' defaults to the same thing.
>> >
>> > but that isn't actually the case.  Since commit d44e712 (pull: support
>> > rebased upstream + fetch + pull --rebase, 2009-07-19), pull has actually
>> > chosen the most recent reflog entry which is an ancestor of the current
>> > branch if it can find one.
>>
>> It is exactly this inconsistency between "git rebase" and "git pull
>> --rebase" that confused me enough to make me send my first email to
>> this list almost 4 years ago [1], so thanks for working on this! I
>> finished that thread with:
>>
>>   Would it make sense to teach "git rebase" the same tricks as "git
>> pull --rebase"?
>>
>> Then it took me a year before I sent a patch not unlike this one [2].
>> To summarize, the patch did not get accepted then because it makes
>> rebase a little slower (or a lot slower in some cases). "git pull
>> --rebase" is of course at least as slow in the same cases, but because
>> it often involves connecting to a remote host, people would probably
>> blame the connection rather than git itself even in those rare (?)
>> cases.
>>
>> I think
>>
>>   git merge-base HEAD $(git rev-list -g "$upstream_name")
>>
>> is roughly correct and hopefully fast enough. That can lead to too
>> long a command line, so I was planning on teaching merge-base a
>> --stdin option, but never got around to it.
>
> I'm not sure we should worry about the additional overhead here.  In the
> common case, we should hit a common ancestor within the first couple of
> reflog entries; and in the case that will be slow, it's likely that
> there are a lot of differences between the branches so the cherry
> comparison phase will take a while anyway.

Perhaps true. I created a simple commit based on my origin/master@{1}
in git.git, which happened to be 136 commits behind origin/master.
Before (a modified version of) your patch, it took 0.756s to rebase it
(best of 5) and afterwards it took 0.720s.

And in a worse case: The same test with one commit off my
origin/master@{13}, 2910 behind origin/master, shows an increase from
2.75s to 4.04s.

And a degenerate case: I created a test branch (called u) with
1000-entry reflog from the output of "git rev-list --first-parent
origin/master | head -1000 | tac" and created the same simple commit
as before off of the end of this reflog (u@{999}). This ended up 3769
commits behind u@{0} (aka origin/master). In this case it went from
3.43s to 3m32s. Obviously, this was a degenerate case designed to be
slow, but I think it's still worth noting that one can get such O(n^2)
behavior e.g. if one lets a branch get out of sync with an upstream
that's very frequently fetches (I've heard of people running
short-interval cron jobs that fetch from a remote).

I do like the feature, but I'm still concerned about this last case.
