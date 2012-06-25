From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] git-submodule: support 'rm' command.
Date: Mon, 25 Jun 2012 23:09:20 +0200
Message-ID: <4FE8D380.20803@web.de>
References: <1340621820-19448-1-git-send-email-mgorny@gentoo.org> <1340621820-19448-2-git-send-email-mgorny@gentoo.org> <4FE898BC.2020307@web.de> <CABURp0od-nNFVhLQU9BsiJ=wXkdneJfhxun_PHOfV=sgzOFShg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 23:09:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjGXM-0003eh-D1
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 23:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756949Ab2FYVJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 17:09:28 -0400
Received: from mout.web.de ([212.227.15.4]:63082 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756395Ab2FYVJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 17:09:27 -0400
Received: from [192.168.178.48] ([91.3.156.12]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0LtWsC-1RkbNV027g-0115b0; Mon, 25 Jun 2012 23:09:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <CABURp0od-nNFVhLQU9BsiJ=wXkdneJfhxun_PHOfV=sgzOFShg@mail.gmail.com>
X-Provags-ID: V02:K0:brD87+2CHPsCJ7bdc5D3FSVlntDtPHqSAIaBt2PDWoe
 RbO9MgylmNG+SvmucKT7A1t7z2+ARDPzbFhSNj5IelKBkmEQsB
 hkVvIXpjF7JSGp03x/nQwI5DISyg5+1ZB8XZwjDvUGmoCgf0tJ
 tNi7uu4/f8MUomXSHNK+dIZIweUgVWQ/BIjodobtQQtVzgEy/A
 P6b8N1Jqfd7NLd/H+p6ng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200599>

Am 25.06.2012 22:53, schrieb Phil Hord:
> On Mon, Jun 25, 2012 at 12:58 PM, Jens Lehmann <Jens.Lehmann@web.de> =
wrote:
>> Am 25.06.2012 12:57, schrieb Micha=C5=82 G=C3=B3rny:
>>> Add an 'rm' command to git-submodule which provides means to
>>> (semi-)easily remove git submodules.
>>>
>>> Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
>>> ---
>>> Right now, it requires the submodule checkout to be removed manuall=
y
>>> first (so it does not remove unstaged commits), and just removes
>>> the index entry and module information from config.
>>>
>>> I based it on 'cmd_add' code trying to preserve the original coding
>>> standards.
>>
>> I really like the goal of this patch but would prefer that "git rm"
>> learns how to remove submodules instead of adding more code to the
>> git-submodule.sh script.
>=20
> I would like to see both supported, eventually. That is, git-rm and
> git-submodule-rm should both work.  It would make sense to me when I
> am looking for the counterpart to 'git submodule add' to find it unde=
r
> 'git submodule rm', and also under 'git submodule --help'.

Hmm, as long as "git submodule rm" would just use "git rm" under the
hood and not its own scripting that would be ok.

>> Also it shouldn't be necessary for the user to remove the directory
>> by hand before running "git rm". At least all files recorded in the
>> submodule can be removed (and if the submodule uses a gitfile that
>> can be removed too). Then all that is left are untracked files the
>> user has to decide what to do with (which might be removed too when
>> running "git rm --recurse-submodules=3Duntracked").
>=20
> That sounds like a nice next step.  But I would expect that a 'git
> [submodule] rm foo' where foo has uncommitted changes to complain to
> me (and do nothing else) unless I used --force.  This is similar to
> how git-rm already behaves, I think.  And in the case of a dirty
> submodule it makes sense to treat the submodule files as an atomic
> unit.  That is, if any of the submodule files are dirty and git-rm
> will "leave" them, then it should leave the whole submodule.  It woul=
d
> be very inconvenient to have to restore files back into place at the
> correct commit just so I could examine them in context to determine
> what I should have done with them before I used git-rm.

We absolutely agree here, this is pretty much what I wrote further
down in my first response ;-)
(except additionally I consider a submodule dirty if it's HEAD isn't
on any branch to avoid loosing commits)

> In the special case of a submodule which does not use a gitfile, I am
> not even sure if any of the submodule files should be removed. If the=
y
> are, what state does that leave the submodule repository in?  A
> checked-out workdir whose files are all removed?  'git-status' would
> be very noisy in this case.  I'd rather expect this to behave the sam=
e
> as if I checked out a previous commit which did not have the submodul=
e
> added yet.  Today, this leaves the submodule in-place and it shows up
> as an untracked file.  I don't know a better way to handle that,
> though I expect it would be ok remove all the files even in this case
> (if the workdir is not dirty and if the head commit is current in the
> superproject).  But it seems extreme to do all of that and then leave
> the .git directory lying about in the former submodule directory.

Good point. Another option would be to move the git directory into
=2Egit/modules of the superproject before removing the files, then next
time it's updated it'll use gitfile. But maybe that's a problem which
will go away anyways as all submodules cloned with newer git use
gitfiles anyway.
