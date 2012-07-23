From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Solve git-submodule issues with detached work trees
Date: Mon, 23 Jul 2012 22:02:54 +0200
Message-ID: <500DADEE.9060700@web.de>
References: <CAHCkQtNfz8Kbn810LgXEQ_rkyk4qn5amGgHQsv2uR6H38sTSrg@mail.gmail.com> <7vsjcjnjvj.fsf@alter.siamese.dyndns.org> <500D8C30.9010807@web.de> <7v7gtumj88.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?RGFuaWVsIEdyYcOxYQ==?= <dangra@gmail.com>,
	git@vger.kernel.org,
	Richard Hartmann <richih.mailinglist@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:04:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StOrY-000083-E1
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 22:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723Ab2GWUEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jul 2012 16:04:11 -0400
Received: from mout.web.de ([212.227.15.3]:65142 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828Ab2GWUEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 16:04:09 -0400
Received: from [192.168.178.48] ([91.3.175.185]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MGAG3-1T5klX1QWN-00Eoxp; Mon, 23 Jul 2012 22:03:01
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v7gtumj88.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:pK0WgksW/a/DmCFC9zeEmookA8pD1Sx73tEB2wLUvUM
 DNCYF7RIXGLSBDeiRaSR6rLpX7eP3kB1m8CIPtm79bQXYiOg0L
 TrK99VqUPyAivI79d8zf25Cxo6R4wPTXsJjPmUCmI43oFKfYKP
 YPCCtMiEqV8I8KnbA/ry60DszgsWWcVczjQAuisTShTJUwgprE
 LB7qF3I2HPmxyCMRUzTVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201971>

Am 23.07.2012 20:21, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>=20
>> Am 23.07.2012 07:09, schrieb Junio C Hamano:
>>> Daniel Gra=C3=B1a <dangra@gmail.com> writes:
>>>
>>>> A common way to track dotfiles with git is using GIT_DIR and
>>>> GIT_WORK_TREE to move repository out of ~/.git with something like=
:
>>>>
>>>>     git init --bare ~/.dotfiles
>>>>     alias dotfiles=3D"GIT_DIR=3D~/.dotfiles GIT_WORK_TREE=3D~ git"
>>>>
>>>>     dotfiles add ~/.bashrc
>>>>     dotfiles commit -a -m "add my bashrc"
>>>>     ...
>>>>
>>>> but git-submodule complains when trying to add submodules:
>>>>
>>>>     dotfiles submodule add http://path.to/submodule
>>>>     fatal: working tree '/home/user' already exists.
>>>>
>>>>     git --git-dir ~/.dotfiles submodule add http://path.to/submodu=
le
>>>>     fatal: /usr/lib/git-core/git-submodule cannot be used without =
a
>>>> working tree.
>>>>
>>>> Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
>>>> ---
>>>
>>> I think this is in line with what we discussed earlier on list when
>>> the interaction between GIT_DIR/GIT_WORK_TREE and submodules came u=
p
>>> the last time.  Jens?
>>
>> Yes, I think this is the only way submodules in current git can
>> be used with the GIT_DIR and GIT_WORK_TREE environment variables:
>> set them when adding or initializing the submodule and always use
>> the same settings when accessing them later. Daniel's dotfile
>> alias achieves exactly that, so his fix looks good. But I agree
>> the tests should be improved as you already pointed out.
>=20
> Thanks for a quick review.  The "the only way ... in current git can
> be used" part makes it sound as if it is a somewhat suboptimal ugly
> workaround, but if that is what you meant, what is a more optimal
> and less ugly way that you have in mind?

I don't see it as an ugly workaround, I just don't see a way to get
the flexibility GIT_DIR and GIT_WORK_TREE offer for repos without
submodules (e.g. put the work tree temporarily somewhere else for
deployment or compare the current work tree with the history in a
different git directory) without changing core git. I have no idea
how many people use this flexibility but when submodules are
involved, you have to stick to the choices you made in the first
place or things will break. Right now the two relative links tie
exactly two directories together as git dir and work tree. I suspect
e.g. some setups using symlinks could benefit if we could get rid
of one of them or even both.

We could get rid of the core.worktree setting by assuming that the
directory a gitfile was found in is the root of the repo's work
tree (unless configured otherwise). And we could introduce a new
gitfile notation which gives the git dir relative to a parent repo's
git dir (e.g. "parent: modules/name" or such). But I'm not sure if
it is worth the hassle.

> If you want to move .git out of way with GIT_DIR and if you want to
> sit somewhere different from the top of your working tree, you must
> use GIT_WORK_TREE (or core.worktree) to tell where the top resides,
> whether your project use submodules or not, so I do not think it is
> an ugly workaround but is the one true way to use such a dismembered
> layout, I would think.

That is a perfect use case and we should make it work.
