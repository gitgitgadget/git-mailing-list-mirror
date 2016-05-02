From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] t5510: run auto-gc in the foreground
Date: Tue, 03 May 2016 01:55:26 +0200
Message-ID: <20160503015526.Horde.e0uZ0P4BqpNnwx_zmhu3WfE@webmail.informatik.kit.edu>
References: <20160501153743.323-1-szeder@ira.uka.de>
 <alpine.DEB.2.20.1605020859131.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 03 01:56:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axNhF-0000RV-1H
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 01:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbcEBX4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 19:56:08 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52766 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932274AbcEBX4G convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2016 19:56:06 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1axNh2-0005Ri-LZ; Tue, 03 May 2016 01:56:00 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1axNgU-0000D7-Vk; Tue, 03 May 2016 01:55:26 +0200
Received: from x4db1aa0c.dyn.telefonica.de (x4db1aa0c.dyn.telefonica.de
 [77.177.170.12]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Tue, 03 May 2016 01:55:26 +0200
In-Reply-To: <alpine.DEB.2.20.1605020859131.9313@virtualbox>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1462233360.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293307>


Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> Hi G=C3=A1bor,
>
> On Sun, 1 May 2016, SZEDER G=C3=A1bor wrote:
>
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index 38321d19efbe..454d896390c0 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -682,6 +682,7 @@ test_expect_success 'fetching with auto-gc does
>> not lock up' '
>> 	(
>> 		cd auto-gc &&
>> 		git config gc.autoPackLimit 1 &&
>> +		git config gc.autoDetach false &&
>> 		GIT_ASK_YESNO=3D"$D/askyesno" git fetch >fetch.out 2>&1 &&
>> 		! grep "Should I try again" fetch.out
>> 	)
>
> Sounds good to me.

There is something still bothering me, though.

I take this was a Windows-specific issue; deleting open files on Linux =
is
no brainer.  According to a comment on the original Git for Windows iss=
ue
at github[1], 'git gc' runs in the background by default on Windows as =
well.

Now, it's 'git gc --auto' that's trying to delete pack and index files =
that
became redundant after repacking, and when it can't delete those files,
then complains.  I.e. those "Should I try again" questions the test loo=
ks
for come from 'git gc', not from 'git fetch'.  So far so good.

Let's assume that someone inconsiderately removes that closed_all_pack(=
)
call added to cmd_fetch(), basically reverting the fix in 0898c9628104.
The test added in the same commit (i.e. not including my fix here) shou=
ld
still be able to catch it, but I think it's possible that it sometimes
remains unnoticed. Consider the following sequence:

    1. 'git fetch' does its thing, including opening pack and index fil=
es.
    2. 'git fetch' launches 'git gc --auto' which then goes into backgr=
ound.
    3. The scheduler happens to decide that it's 'git fetch's turn agai=
n,
       and it finishes, including closing all opened pack and index fil=
es.
    4. 'git gc' gets a chance to proceed, repacks and then manages to d=
elete
       all redundant pack and index files successfully.
    5. 'grep' doesn't find the string it looks for.
    6. The test succeeds.

And the background 'git gc --auto' doesn't even have to be delayed that
long, because 'git fetch' exits immediately after launching it.  That's
considerably shorter than the delay necessary for the 'rm -rf' error I
described in the commit message, because for the latter 'git fetch' mus=
t
finish, 'grep' must run, and 'test_done' must write the test results an=
d
start 'rm -rf $trash' while 'git gc' is still running in the background=
=2E

So, if I'm right, then my fix is not just about avoiding a sporadic err=
or
from the test harness, but it's also important for the test's
correctness.  But am I right?  Alas I don't have a Git for Windows dev
environment to play around with this.

[1] - https://github.com/git-for-windows/git/issues/500#issuecomment-14=
9933531


G=C3=A1bor


> Alternatively, we could consider passing `-c gc.autoDetach=3Dfalse` i=
nstead,
> to limit the scope. I am not insisting on it, of course ;-)
>
> Ciao,
> Dscho
