From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] t5510: run auto-gc in the foreground
Date: Tue, 03 May 2016 13:50:28 +0200
Message-ID: <20160503135028.Horde.jeJdKT1kb2NTVAS1HpcsQh2@webmail.informatik.kit.edu>
References: <20160501153743.323-1-szeder@ira.uka.de>
 <alpine.DEB.2.20.1605020859131.9313@virtualbox>
 <20160503015526.Horde.e0uZ0P4BqpNnwx_zmhu3WfE@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 03 13:51:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axYrC-000271-ID
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 13:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbcECLvI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 07:51:08 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52557 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932252AbcECLvH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2016 07:51:07 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1axYr0-0001bs-SI; Tue, 03 May 2016 13:51:02 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1axYqS-00029N-P3; Tue, 03 May 2016 13:50:28 +0200
Received: from x590e24b5.dyn.telefonica.de (x590e24b5.dyn.telefonica.de
 [89.14.36.181]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Tue, 03 May 2016 13:50:28 +0200
In-Reply-To: <20160503015526.Horde.e0uZ0P4BqpNnwx_zmhu3WfE@webmail.informatik.kit.edu>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1462276262.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293352>


Quoting SZEDER G=C3=A1bor <szeder@ira.uka.de>:

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
>> Hi G=C3=A1bor,
>>
>> On Sun, 1 May 2016, SZEDER G=C3=A1bor wrote:
>>
>>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>>> index 38321d19efbe..454d896390c0 100755
>>> --- a/t/t5510-fetch.sh
>>> +++ b/t/t5510-fetch.sh
>>> @@ -682,6 +682,7 @@ test_expect_success 'fetching with auto-gc does
>>> not lock up' '
>>> 	(
>>> 		cd auto-gc &&
>>> 		git config gc.autoPackLimit 1 &&
>>> +		git config gc.autoDetach false &&
>>> 		GIT_ASK_YESNO=3D"$D/askyesno" git fetch >fetch.out 2>&1 &&
>>> 		! grep "Should I try again" fetch.out
>>> 	)
>>
>> Sounds good to me.
>
> There is something still bothering me, though.
>
> I take this was a Windows-specific issue; deleting open files on Linu=
x is
> no brainer.  According to a comment on the original Git for Windows i=
ssue
> at github[1], 'git gc' runs in the background by default on Windows a=
s well.

Ok, having slept on it, it was a false alarm.

Though 'git gc --auto' claims "Auto packing the repository in backgroun=
d for
optimum performance." on Windows, it does in fact runs in the foregroun=
d.

'git gc --auto' first prints that message, unless gc.autoDetach is disa=
bled,
and then calls daemonize() to go to the background.  However, daemonize=
() is
basically a no-op on Windows, thus 'git gc' will remain in the foregrou=
nd and
the sequence I described below is impossible.  Good.

Perhaps it would be worth updating 'git gc' to not lie about going to t=
he
background when we can already know in advance that it won't.



> Now, it's 'git gc --auto' that's trying to delete pack and index file=
s that
> became redundant after repacking, and when it can't delete those file=
s,
> then complains.  I.e. those "Should I try again" questions the test l=
ooks
> for come from 'git gc', not from 'git fetch'.  So far so good.
>
> Let's assume that someone inconsiderately removes that closed_all_pac=
k()
> call added to cmd_fetch(), basically reverting the fix in 0898c962810=
4.
> The test added in the same commit (i.e. not including my fix here) sh=
ould
> still be able to catch it, but I think it's possible that it sometime=
s
> remains unnoticed. Consider the following sequence:
>
>    1. 'git fetch' does its thing, including opening pack and index fi=
les.
>    2. 'git fetch' launches 'git gc --auto' which then goes into backg=
round.
>    3. The scheduler happens to decide that it's 'git fetch's turn aga=
in,
>       and it finishes, including closing all opened pack and index fi=
les.
>    4. 'git gc' gets a chance to proceed, repacks and then manages to =
delete
>       all redundant pack and index files successfully.
>    5. 'grep' doesn't find the string it looks for.
>    6. The test succeeds.
>
> And the background 'git gc --auto' doesn't even have to be delayed th=
at
> long, because 'git fetch' exits immediately after launching it.  That=
's
> considerably shorter than the delay necessary for the 'rm -rf' error =
I
> described in the commit message, because for the latter 'git fetch' m=
ust
> finish, 'grep' must run, and 'test_done' must write the test results =
and
> start 'rm -rf $trash' while 'git gc' is still running in the backgrou=
nd.
>
> So, if I'm right, then my fix is not just about avoiding a sporadic e=
rror
> from the test harness, but it's also important for the test's
> correctness.  But am I right?  Alas I don't have a Git for Windows de=
v
> environment to play around with this.
>
> [1] - =20
> https://github.com/git-for-windows/git/issues/500#issuecomment-149933=
531
>
>
> G=C3=A1bor
>
>
>> Alternatively, we could consider passing `-c gc.autoDetach=3Dfalse` =
instead,
>> to limit the scope. I am not insisting on it, of course ;-)
>>
>> Ciao,
>> Dscho
