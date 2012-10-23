From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Tue, 23 Oct 2012 22:36:44 +0200
Message-ID: <5086FFDC.2050700@web.de>
References: <61a31f6bc61d4df322a097e32ba472390c583a81.1350923683.git.wking@tremily.us> <5086ED06.5020406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, wking@tremily.us
To: Nahor <nahor.j+gmane@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 22:37:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQlE4-0002gQ-DH
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 22:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034Ab2JWUhF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2012 16:37:05 -0400
Received: from mout.web.de ([212.227.17.12]:57171 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965028Ab2JWUhB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 16:37:01 -0400
Received: from [192.168.178.41] ([79.193.87.155]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M7bYJ-1TBxGP0LZ9-00wZbk; Tue, 23 Oct 2012 22:36:58
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <5086ED06.5020406@gmail.com>
X-Provags-ID: V02:K0:ExsAwUQ3JZosvOpxoxR4D7XelWMMlxCuifQwyNh0kWL
 OkLpqKA+AA0PO729g6BlamCqpacFJolVz2TjQEN9qOQ87XrlPr
 OCW4NM8lleeuj/TMMQfm7yOpR4sWNaF4OsOZLs9R4YBIW/olT7
 HLfqpSTnJCEKRydqWT7Rbe/LQtSd9qPo02A3MeID2kQFpun7Pb
 kZCvvLY3v7y0oo39QRI3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208243>

Am 23.10.2012 21:16, schrieb Nahor:
> On 2012-10-22 09:34, W. Trevor King wrote:
>> From: "W. Trevor King" <wking@tremily.us>
>>
>> This removes a configuration step if you're trying to setup =C3=86va=
r's
>>
>>    $ git submodule foreach 'git checkout $(git config --file $toplev=
el/.gitmodules submodule.$name.branch) && git pull'
>>
>> workflow from
>>
>>    commit f030c96d8643fa0a1a9b2bd9c2f36a77721fb61f
>>    Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>    Date:   Fri May 21 16:10:10 2010 +0000
>>
>>      git-submodule foreach: Add $toplevel variable
>>
>> If you're not using that workflow, I see no harm in recording the
>> branch used to determine the original submodule commit.

Except recording the branch name might raise expectations about what gi=
t
will do with it. And as far as this patch goes, git won't do anything
with it (yet).

> IMHO, the problem is that this works only for a very specific workflo=
w. Normal git usage can very easily break this feature.
>=20
> For instance, the module may later be updated to a commit in branch B=
 instead of branch A. Unless you remember to also update .gitmodule, yo=
u have then inconsistent information.
>=20
> A similar issue arises if branch A is deleted from the module later (=
for instance because it has been merged in the master branch and is not=
 useful anymore). Then .gitmodule points to a non-existant branch.
> Same thing if a branch is renamed.

Those are valid points. The next "git submodule update" will leave the
submodule with a detached HEAD, making the branch configuration rather
meaningless (except for your "git submodule foreach ..." use case of
course).

> Last issue, the branch that exists in your local repository may not e=
xist in someone else's repository, either because the branch is purely =
local, or because it has a different name on the remote repo.

You'll always face this kind of problems with commits too when using
submodules, so I don't see that as a problem here.

> I think a better place to store that kind of information is using git=
-notes. That way, if the branch is renamed or deleted, you can easily u=
pdate the old notes to use the new name instead.

I can't comment on that, as I have never been using notes so far.

But I'd rather see a patch series properly implementing the always-tip
mode =C3=86var mentions in f030c96d86 (and which is requested by some u=
sers),
especially the interesting parts: What should git record as commit in
that case and how are "git status" and "git diff" going to handle
submodules which shall follow a specific branch. I assume "git submodul=
e
update" is the right point in time to fetch that branch again and check
out a newer branch tip if necessary, but should that commit be added to
the superproject for that submodule automagically or not? This patch
falls short of this, as it does the easy part but not the interesting
ones ;-)
