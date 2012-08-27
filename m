From: cmn@eleog.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: [PATCH 2/3] branch: add --unset-upstream option
Date: Mon, 27 Aug 2012 23:33:46 +0200
Message-ID: <87vcg4m345.fsf@centaur.cmartin.tk>
References: <1345470460-28734-1-git-send-email-cmn@elego.de>
	<1345470460-28734-3-git-send-email-cmn@elego.de>
	<7vpq6h2tmk.fsf@alter.siamese.dyndns.org>
	<87a9xgnsxx.fsf@centaur.cmartin.tk>
	<7vy5l0qknd.fsf@alter.siamese.dyndns.org>
	<7vmx1gqk12.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 23:34:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T66x7-0003qh-B5
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 23:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378Ab2H0Vdp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 17:33:45 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:54387 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754219Ab2H0Vdp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 17:33:45 -0400
Received: from cmartin.tk (p4FC5D726.dip.t-dialin.net [79.197.215.38])
	by hessy.dwim.me (Postfix) with ESMTPA id C511E80040;
	Mon, 27 Aug 2012 23:33:43 +0200 (CEST)
Received: (nullmailer pid 18241 invoked by uid 1000);
	Mon, 27 Aug 2012 21:33:46 -0000
In-Reply-To: <7vmx1gqk12.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 27 Aug 2012 11:14:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204373>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> cmn@elego.de (Carlos Mart=C3=ADn Nieto) writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>>>>
>>>>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>>>>> index e9019ac..93e5d6e 100755
>>>>> --- a/t/t3200-branch.sh
>>>>> +++ b/t/t3200-branch.sh
>>>>> @@ -383,6 +383,22 @@ test_expect_success 'use --set-upstream-to m=
odify a particular branch' \
>>>>>       test "$(git config branch.my13.remote)" =3D "." &&
>>>>>       test "$(git config branch.my13.merge)" =3D "refs/heads/mast=
er"'
>>>>> =20
>>>>> +test_expect_success 'test --unset-upstream on HEAD' \
>>>>> +    'git branch my14
>>>>> +     test_config branch.master.remote foo &&
>>>>> +     test_config branch.master.merge foo &&
>>>>> +     git branch --set-upstream-to my14 &&
>>>>> +     git branch --unset-upstream &&
>>>>> +     test_must_fail git config branch.master.remote &&
>>>>> +     test_must_fail git config branch.master.merge'
>>>>> +
>>>>> +test_expect_success 'test --unset-upstream on a particular branc=
h' \
>>>>> +    'git branch my15
>>>>> +     git branch --set-upstream-to master my14 &&
>>>>> +     git branch --unset-upstream my14 &&
>>>>> +     test_must_fail git config branch.my14.remote &&
>>>>> +     test_must_fail git config branch.my14.merge'
>>>>> +
>>>>
>>>> What should happen when you say "--unset-upstream" on a branch B
>>>> that does not have B@{upstream}?  Should it fail?  Should it be
>>>> silently ignored?  Is it undefined that we do not want to test?
>>>
>>> I'd say it should be ignored, as the end result we want is for ther=
e to
>>> be no upstream information. What we do underneath is remove a coupl=
e of
>>> config options, wich doesn't fail if they didn't insist in the firs=
t
>>> place.
>>
>> I am not sure about that reasoning.
>>
>>     $ git config --unset core.nosuchvariable ; echo $?
>>     5
>>
>> looks like a failure to me.
>>
>> More importantly, wouldn't we want to catch typo in
>>
>> 	git branch --unset-upstream mext
>>
>> which admittedly should come from a different codepath (I do not
>> think your patch checks if "mext" branch exists before going ahead
>> to the config--unset dance)?
>
> Sorry, the last paragraph was incomplete.
>
> In general, we should detect errors and allow the user to choose to
> ignore.
>
> A script that wants to make sure that B does not have an upstream,
> without knowing if it already has one, can say "--unset-upstream B"
> and choose to ignore the error if B does not have an upstream. =20
>
> If the script is carefully written, it would try to check if B has
> one and call "--unset-upstream B" only when it doesn't.  A casually
> written loose script would say "--unset-upstream B 2>/dev/null"
> and keep going (it would not notice other kinds of errors, but that
> is what makes it "casual and loose").

OK, that's a good point, I'll update the patch.

   cmn
