From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 23/32] prune: strategies for linked checkouts
Date: Fri, 12 Sep 2014 15:08:02 -0400
Message-ID: <54134492.6020004@xiplink.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>	<1410388928-32265-1-git-send-email-pclouds@gmail.com>	<1410388928-32265-24-git-send-email-pclouds@gmail.com>	<5411C16C.9010406@xiplink.com> <CAPig+cQGeEzrx9N1Rrxhf--gphWSam88BV06AJTA=6-YZvQ4Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 21:08:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSWD6-0006Bm-Rf
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 21:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbaILTIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2014 15:08:41 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:33383 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbaILTIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 15:08:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp12.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 37A2710014A;
	Fri, 12 Sep 2014 15:08:39 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp12.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id DF2691000C5;
	Fri, 12 Sep 2014 15:08:38 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Fri, 12 Sep 2014 19:08:39 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CAPig+cQGeEzrx9N1Rrxhf--gphWSam88BV06AJTA=6-YZvQ4Tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256943>

On 14-09-11 11:06 PM, Eric Sunshine wrote:
> On Thu, Sep 11, 2014 at 11:36 AM, Marc Branchaud <marcnarc@xiplink.co=
m> wrote:
>> On 14-09-10 06:41 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrot=
e:
>>> (alias R=3D$GIT_COMMON_DIR/worktrees/<id>)
>>>
>>>  - linked checkouts are supposed to keep its location in $R/gitdir =
up
>>>    to date. The use case is auto fixup after a manual checkout move=
=2E
>>>
>>>  - linked checkouts are supposed to update mtime of $R/gitdir. If
>>>    $R/gitdir's mtime is older than a limit, and it points to nowher=
e,
>>>    worktrees/<id> is to be pruned.
>>>
>>>  - If $R/locked exists, worktrees/<id> is not supposed to be pruned=
=2E If
>>>    $R/locked exists and $R/gitdir's mtime is older than a really lo=
ng
>>>    limit, warn about old unused repo.
>>>
>>>  - "git checkout --to" is supposed to make a hard link named $R/lin=
k
>>>    pointing to the .git file on supported file systems to help dete=
ct
>>>    the user manually deleting the checkout. If $R/link exists and i=
ts
>>>    link count is greated than 1, the repo is kept.
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>>  Documentation/git-checkout.txt             | 18 ++++++
>>>  Documentation/git-prune.txt                |  3 +
>>>  Documentation/gitrepository-layout.txt     | 19 ++++++
>>>  builtin/checkout.c                         | 19 +++++-
>>>  builtin/prune.c                            | 95 ++++++++++++++++++=
++++++++++++
>>>  setup.c                                    | 13 ++++
>>>  t/t2026-prune-linked-checkouts.sh (new +x) | 84 ++++++++++++++++++=
++++++++
>>>  7 files changed, 249 insertions(+), 2 deletions(-)
>>>  create mode 100755 t/t2026-prune-linked-checkouts.sh
>>>
>>> diff --git a/Documentation/git-checkout.txt b/Documentation/git-che=
ckout.txt
>>> index bd0fc1d..a29748e 100644
>>> --- a/Documentation/git-checkout.txt
>>> +++ b/Documentation/git-checkout.txt
>>> @@ -431,6 +431,24 @@ thumb is do not make any assumption about whet=
her a path belongs to
>>>  $GIT_DIR or $GIT_COMMON_DIR when you need to directly access somet=
hing
>>>  inside $GIT_DIR. Use `git rev-parse --git-path` to get the final p=
ath.
>>>
>>> +When you are done, simply deleting the linked working directory wo=
uld
>>> +suffice. $GIT_DIR/worktrees can be cleaned up using `git prune
>>> +--worktrees`.
>>
>> This needs a tweak or two so that it follows more naturally from the=
 previous
>> paragraph.  How about:
>>
>>         When you are done with a linked working tree you can simply =
delete
>>         it.  You can clean up any stale $GIT_DIR/worktrees entries w=
ith
>>         `git prune --worktrees`.
>=20
> Thanks for these rewrites; I was going to provide similar suggestions=
=2E
>=20
> One minor addition for clarification would be to mention that the 'gi=
t
> prune --worktrees' invocation applies to the main worktree:
>=20
>     When you are done with a linked working tree, you can simply dele=
te
>     it. You can clean up any stale $GIT_DIR/worktrees entries via
>     `git prune --worktrees` in the main worktree.
>=20
>> Then in commit 28, when you add worktrees pruning to gc, you should =
change
>> this paragraph again:
>>
>>         When you are done with a linked working tree you can simply =
delete
>>         it.  The working tree's entry in the repository's $GIT_DIR/w=
orktrees
>>         directory will eventually be removed automatically (see
>>         `gc.pruneworktreesexpire` in linkgit::git-config[1]), or you=
 can run
>>         `git prune --worktrees` to clean up any stale entries in
>>         $GIT_DIR/worktrees.
>=20
> Ditto about qualifying 'git prune --worktrees' with "in the main work=
 tree".
>=20
>>> +After you move a linked working directory to another file system, =
or
>>> +on a file system that does not support hard link, execute any git
>>> +command (e.g. `git status`) in the new working directory so that i=
t
>>> +could update its location in $GIT_DIR/worktrees and not be
>>> +accidentally pruned.
>>
>> It took me a couple of seconds to parse that.  How about:
>>
>>         If you move a linked working directory to another file syste=
m, or
>>         within a file system that does not support hard links, you n=
eed to
>>         run at least one git command inside the moved linked working
>=20
> I trip over "moved linked" every time I read it. I think there's
> sufficient context in the 'if' clause leading to this that "moved" ca=
n
> be dropped.

=46ine by me, as are your other suggestions.

		M.


>>         directory (e.g. `git status`) in order to update its entry i=
n
>>         $GIT_DIR/worktrees so that it does not get automatically rem=
oved.
>>
>>> +To stop `git prune --worktrees` from deleting a specific working
>>> +directory (e.g. because it's on a portable device), you could add =
the
>>> +file 'locked' to $GIT_DIR/worktrees. For example, if `.git` file o=
f
>>> +the new working directory points to `/path/main/worktrees/test-nex=
t`,
>>> +the full path of the 'locked' file would be
>>> +`/path/main/worktrees/test-next/locked`. See
>>> +linkgit:gitrepository-layout[5] for details.
>>
>> Sorry, I can't help rewriting this one too:
>>
>>         To prevent `git prune --worktrees` from deleting a
>>         $GIT_DIR/worktrees entry (which can be useful in some situat=
ions,
>>         such as when the entry's working tree is stored on a portabl=
e
>>         device), add a file named 'locked' to the entry's directory.=
  For
>>         example, if a linked working tree's `.git` file points to
>>         `/path/main/.git/worktrees/test-next` then a file named
>>         `/path/main/.git/worktrees/test-next/locked` will prevent th=
e
>>         `test-next` entry from being pruned.  See
>>         linkgit:gitrepository-layout[5] for details.
>=20
> Each time I read this (or Duy's original), the first question that
> pops into my head is "should 'locked' be empty or have content, and i=
f
> content, what content?" gitrepository-layout.txt does explain the
> content (if the reader bothers to chase the link), but perhaps it is
> worth an explanatory sentence here?
>=20
>> I also suggest this paragraph get updated in commit 28, but just cha=
nge the
>> first clause, before "(which can be ...":
>>
>>         To prevent a $GIT_DIR/worktrees entry from being pruned (whi=
ch ...
>>
>> Thanks for all this work!
>>
>>                 M.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
