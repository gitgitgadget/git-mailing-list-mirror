From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv2 2/2] pull: support rebased upstream + fetch + pull 
	--rebase
Date: Fri, 17 Jul 2009 15:24:21 +0200
Message-ID: <adf1fd3d0907170624t7c2bf8f5w35c03788fdd82422@mail.gmail.com>
References: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com>
	 <1247731921-2290-1-git-send-email-santi@agolina.net>
	 <alpine.DEB.1.00.0907161035060.3155@pacific.mpi-cbg.de>
	 <7vhbxc8inp.fsf@alter.siamese.dyndns.org>
	 <adf1fd3d0907161618o61ee4b58of25659f8c36420f7@mail.gmail.com>
	 <adf1fd3d0907170051u7268d8f6kba7f2e529381d275@mail.gmail.com>
	 <7vr5wf67iz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 15:24:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRnQR-0008EY-Aa
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 15:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933941AbZGQNY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2009 09:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933583AbZGQNYZ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 09:24:25 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:35273 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933635AbZGQNYZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 09:24:25 -0400
Received: by bwz28 with SMTP id 28so731338bwz.37
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 06:24:22 -0700 (PDT)
Received: by 10.204.100.70 with SMTP id x6mr914539bkn.140.1247837061923; Fri, 
	17 Jul 2009 06:24:21 -0700 (PDT)
In-Reply-To: <7vr5wf67iz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123462>

2009/7/17 Junio C Hamano <gitster@pobox.com>:
> Santi B=E9jar <santi@agolina.net> writes:
>
>> 2009/7/17 Santi B=E9jar <santi@agolina.net>:
>>> 2009/7/16 Junio C Hamano <gitster@pobox.com>:
>>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>>
>>>>> How about
>>>>>
>>>>> =A0 =A0 =A0 oldremoteref=3D"$(git rev-list --boundary HEAD --not =
\
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $(git rev-list -g $re=
moteref | sed 's/$/^@/') |
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sed -e '/^[^-]/d' -e q)"
>>>>>
>>>>> Explanation: the "git rev-list -g $remoteref" lists the previous =
commits
>>>>> the remote ref pointed to, and the ^@ appended to them means all =
their
>>>>> parents. =A0Now, the outer rev-list says to take everything in HE=
AD but
>>>>> _not_ in those parents, showing the boundary commits. =A0The "sed=
" call
>>>>> lists the first such boundary commit (which must, by construction=
, be one
>>>>> of the commits shown by the first rev-list).
>>>>
>>>> Hmm, I am not sure about that "(which must..." part.
>>
>> Unfortunatly you are right with the "(which must..." part. Even
>> without the ^@. Normally gives the right answer, but it is not
>> sure that the first commit boundary is the correct one. For
>> example:
>>
>> =A0 =A0 =A0 =A0 =A0o--C
>> =A0 =A0 =A0 =A0 /
>> =A0A--x--y--B--o--z
>> =A0 =A0 =A0\ =A0 =A0 =A0/
>> =A0 =A0 =A0 o----o
>>
>> A, B, C are upstream@{n}
>>
>> It involves a merge with a branch forked before the fork commit
>> for the current branch, and it will not work neither with git
>> pull --rebase. We could say that it is not supported, but
>> nevertheless it gives the wrong answer.
>>
>> The right answer is B, but:
>> $ git rev-list --boundary z --not C B A
>> z
>> o
>> o
>> o
>> -x
>> -B
>
> Now a short question. =A0Does your original loop give a correct answe=
r in
> this case?

Yes, it returns B. But there are other cases where there is not a singl=
e right
answer if you allow merges. For the moment the more sensible thing to d=
o is to
not allow merges in the local commits. I hope nobody relies on "git pul=
l
--rebase" with local merges.

Just an example:

        E
       /
=A0 =A0 =A0 D----a topic2
     /      \
=A0A--B--C--b--c--d--topic1

A, B, C, D, E are upstream@{n} (n =3D 4,3,2,1,0)

if you are on branch "topic1", and run "git pull --rebase" you would wa=
nt to
rebase only b, c and d (maybe "a" but you should not), but for sure not=
 D.
And my algorithm returns C, but a more "correct" answer would be C and =
D.

Another possibility could be to check that there is only one boundary
commit (only one fork point for all the local commits).

Wait! Let's return to the original problem. The original problem is tha=
t you
cannot do a "git pull --rebase" with a rebased upstream if you have alr=
eady
done "git fetch" before. And the solution would be:
Try to behaved as if the "git fetch" was not run.

And this is exactly what my patch does.

All the other "problems" happens already.

Now I only have to solve the "git rev-parse -q --verify upstream@{large=
_n}"
problem or workaround it.

Sometimes thinks aloud,
Santi
