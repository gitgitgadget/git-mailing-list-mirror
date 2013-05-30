From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/7] add tests for rebasing with patch-equivalence
 present
Date: Thu, 30 May 2013 14:54:20 +0200
Message-ID: <51A74BFC.4020900@kdbg.org>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com> <1369809572-24431-1-git-send-email-martinvonz@gmail.com> <1369809572-24431-3-git-send-email-martinvonz@gmail.com> <51A5A992.306@viscovery.net> <CANiSa6joMXeh7HoGAFXskdXaPZjN+0uHrtN7V85FyQHTGCwZMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 14:54:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui2NB-0000Ku-An
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 14:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab3E3My0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 08:54:26 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:20840 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752752Ab3E3MyY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 08:54:24 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BA8C3130045;
	Thu, 30 May 2013 14:53:42 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 241C619F5DE;
	Thu, 30 May 2013 14:54:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CANiSa6joMXeh7HoGAFXskdXaPZjN+0uHrtN7V85FyQHTGCwZMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225979>

Am 30.05.2013 07:30, schrieb Martin von Zweigbergk:
> On Wed, May 29, 2013 at 12:09 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 5/29/2013 8:39, schrieb Martin von Zweigbergk:
>>> +#       f
>>> +#      /
>>> +# a---b---c---g---h
>>> +#      \
>>> +#       d---G---i
>> ...
>>> +test_run_rebase () {
>>> +     result=$1
>>> +     shift
>>> +     test_expect_$result "rebase $* --onto drops patches in onto" "
>>> +             reset_rebase &&
>>> +             git rebase $* --onto h f i &&
>>> +             test_cmp_rev h HEAD~2 &&
>>> +             test_linear_range 'd i' h..
>>
>> Isn't this expectation wrong? The upstream of the rebased branch is f, and
>> it does not contain G. Hence, G should be replayed. Since h is the
>> reversal of g, the state at h is the same as at c, and applying G should
>> succeed (it is the same change as g). Therefore, I think the correct
>> expectation is:
>>
>>                 test_linear_range 'd G i' h..
> 
> Good question! It is really not obvious what the right answer is. Some
> arguments in favor of dropping 'G':
> 
> 1. Let's say origin/master points to 'b' when you start the 'd G i'
> branch. You then send the 'G' patch to Junio who applies it as 'g'
> (cherry-picking direction is reversed compared to figure, but same
> effect). You then "git pull --rebase" when master on origin points to
> 'h'. Because of the cleverness in 'git pull --rebase', it issues 'git
> rebase --onto h b i'.

The reason for this git pull cleverness is to be prepared for rewritten
history:

   b'--c'--g'--h'
  /
 a---b
      \
       d---G---i

to avoid that b is rebased.

> In this case it's clearly useful to have the
> patch dropped.
> 
> 2. In the test a little before the above one, we instead do 'git
> rebase --onto f h i' and make sure that the 'G' is _not_ lost. In that
> case it doesn't matter what's in $branch..$upstream. Do we agree that
> $branch..$upstream should never matter (instead, $upstream is only
> used to find merge base with $branch)?

No, we do not agree. $branch..$upstream should be the set of patches
that should be omitted. $branch..$onto should not matter. $onto is only
used to specify the destination of the rebased commits.

> Do we also agree that 'git
> rebase a b' should be identical to 'git rebase --onto a a b'?

Absolutely!

> Because
> 'git rebase h i' should clearly drop 'G', then so should 'git rebase
> --onto h h i'.

Yes!

> Then, if we agreed that $branch..$upstream doesn't
> matter, 'git rebase --onto h f i' should behave the same, no?

Correct in the mathematically logical sense. ;) But we do not agree that
$branch..$upstream doesn't matter.

> The set of commits to rebase that I was thinking of using was
> "$upstream..$branch, unless equivalent with patch in $branch..$onto".
> But I'm not very confident about my conclusions above :-)

At least the man page says that ..$upstream counts and $onto tells just
the new base.

The way how git pull calls rebase should be revisited, I think.

-- Hannes
