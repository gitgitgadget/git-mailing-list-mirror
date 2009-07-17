From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv2 2/2] pull: support rebased upstream + fetch + pull 
	--rebase
Date: Fri, 17 Jul 2009 09:51:38 +0200
Message-ID: <adf1fd3d0907170051u7268d8f6kba7f2e529381d275@mail.gmail.com>
References: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com>
	 <1247731921-2290-1-git-send-email-santi@agolina.net>
	 <alpine.DEB.1.00.0907161035060.3155@pacific.mpi-cbg.de>
	 <7vhbxc8inp.fsf@alter.siamese.dyndns.org>
	 <adf1fd3d0907161618o61ee4b58of25659f8c36420f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 09:51:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRiER-0005cR-6k
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 09:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934178AbZGQHvm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2009 03:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934174AbZGQHvm
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 03:51:42 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:61707 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934173AbZGQHvl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 03:51:41 -0400
Received: by fxm18 with SMTP id 18so568097fxm.37
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 00:51:40 -0700 (PDT)
Received: by 10.204.78.142 with SMTP id l14mr653812bkk.33.1247817099044; Fri, 
	17 Jul 2009 00:51:39 -0700 (PDT)
In-Reply-To: <adf1fd3d0907161618o61ee4b58of25659f8c36420f7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123446>

2009/7/17 Santi B=E9jar <santi@agolina.net>:
> 2009/7/16 Junio C Hamano <gitster@pobox.com>:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> How about
>>>
>>> =A0 =A0 =A0 oldremoteref=3D"$(git rev-list --boundary HEAD --not \
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $(git rev-list -g $remo=
teref | sed 's/$/^@/') |
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sed -e '/^[^-]/d' -e q)"
>>>
>>> Explanation: the "git rev-list -g $remoteref" lists the previous co=
mmits
>>> the remote ref pointed to, and the ^@ appended to them means all th=
eir
>>> parents. =A0Now, the outer rev-list says to take everything in HEAD=
 but
>>> _not_ in those parents, showing the boundary commits. =A0The "sed" =
call
>>> lists the first such boundary commit (which must, by construction, =
be one
>>> of the commits shown by the first rev-list).
>>
>> Hmm, I am not sure about that "(which must..." part.

Unfortunatly you are right with the "(which must..." part. Even
without the ^@. Normally gives the right answer, but it is not
sure that the first commit boundary is the correct one. For
example:

         o--C
        /
 A--x--y--B--o--z
     \      /
      o----o

A, B, C are upstream@{n}

It involves a merge with a branch forked before the fork commit
for the current branch, and it will not work neither with git
pull --rebase. We could say that it is not supported, but
nevertheless it gives the wrong answer.

The right answer is B, but:
$ git rev-list --boundary z --not C B A
z
o
o
o
-x
-B

in this case we could take the boundaries commits and filter the
commits that are ancestor of some other boundary commit, and
would get B (git show-branch --independent x B -> B).

Here it is a test case to see the above.

rm -rf test
mkdir test
cd test
git init
echo A > file
git add .
git commit -mA
git tag A
echo o > file
git commit -a -mo
git tag fork1
echo z > file
git commit -a -mz
git tag fork2
echo B > file
git commit -a -mB
git tag B
git checkout -b topic fork1
echo oo > filetopic
git add .
git commit -moo
echo ooo > filetopic
git commit -a -mooo
git checkout master
git merge topic
echo c > file
git commit -a -mc
git checkout -b upstream fork2
echo o > fileupstream
git add .
git commit -a -mo5
echo C > fileupstream
git commit -a -mo
git tag C
git rev-list --boundary master --not C B A
echo answer: $(git rev-parse B^{})

HTH,
Santi
