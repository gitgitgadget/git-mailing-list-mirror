From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 23/32] prune: strategies for linked checkouts
Date: Thu, 11 Sep 2014 23:06:22 -0400
Message-ID: <CAPig+cQGeEzrx9N1Rrxhf--gphWSam88BV06AJTA=6-YZvQ4Tg@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
	<1410388928-32265-1-git-send-email-pclouds@gmail.com>
	<1410388928-32265-24-git-send-email-pclouds@gmail.com>
	<5411C16C.9010406@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 05:06:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSHBs-0000Wc-VQ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 05:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbaILDGY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Sep 2014 23:06:24 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:49990 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbaILDGX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2014 23:06:23 -0400
Received: by mail-yk0-f169.google.com with SMTP id 20so69445yks.28
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 20:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=6kpnICFjmlDbKH+aLqHAqvNeD4RQ6wYohSzIK/hAcbY=;
        b=CxKLdpJVB26tJljJiC4IeVajUPNcL0Vusl143vPoj4DZNnVw6fEKiBGbzUtOA36VqM
         gi4wbW1LxOxQh0y0hHnfl0SEsTPEROw8MiWoCxueJgewBTFzW7VsXGJrTruA/SBsFbn6
         mGLKZ6INlDvr3UGL676dwGNxharYLP73Y56aqgtWD5zJuWVJMqyjjuRwBK/8NQ/Gn5ki
         8yguM/DiDHiNrnljTqkCPPb0Smwn2zr28J/UTQ1at3R/sbo9BqTCwyOEOgtWO0OPV48p
         jtegQYWmN1yMEEkuMqCAD7E8SgmyiUgM5eiExzorYugpYgamAOtzYP//Q6zYjfpn9r0V
         W5Ag==
X-Received: by 10.236.29.5 with SMTP id h5mr6482492yha.58.1410491182888; Thu,
 11 Sep 2014 20:06:22 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Thu, 11 Sep 2014 20:06:22 -0700 (PDT)
In-Reply-To: <5411C16C.9010406@xiplink.com>
X-Google-Sender-Auth: 6NYySL-UE6OvnMIRl1ly7yo479s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256894>

On Thu, Sep 11, 2014 at 11:36 AM, Marc Branchaud <marcnarc@xiplink.com>=
 wrote:
> On 14-09-10 06:41 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
>> (alias R=3D$GIT_COMMON_DIR/worktrees/<id>)
>>
>>  - linked checkouts are supposed to keep its location in $R/gitdir u=
p
>>    to date. The use case is auto fixup after a manual checkout move.
>>
>>  - linked checkouts are supposed to update mtime of $R/gitdir. If
>>    $R/gitdir's mtime is older than a limit, and it points to nowhere=
,
>>    worktrees/<id> is to be pruned.
>>
>>  - If $R/locked exists, worktrees/<id> is not supposed to be pruned.=
 If
>>    $R/locked exists and $R/gitdir's mtime is older than a really lon=
g
>>    limit, warn about old unused repo.
>>
>>  - "git checkout --to" is supposed to make a hard link named $R/link
>>    pointing to the .git file on supported file systems to help detec=
t
>>    the user manually deleting the checkout. If $R/link exists and it=
s
>>    link count is greated than 1, the repo is kept.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Documentation/git-checkout.txt             | 18 ++++++
>>  Documentation/git-prune.txt                |  3 +
>>  Documentation/gitrepository-layout.txt     | 19 ++++++
>>  builtin/checkout.c                         | 19 +++++-
>>  builtin/prune.c                            | 95 +++++++++++++++++++=
+++++++++++
>>  setup.c                                    | 13 ++++
>>  t/t2026-prune-linked-checkouts.sh (new +x) | 84 +++++++++++++++++++=
+++++++
>>  7 files changed, 249 insertions(+), 2 deletions(-)
>>  create mode 100755 t/t2026-prune-linked-checkouts.sh
>>
>> diff --git a/Documentation/git-checkout.txt b/Documentation/git-chec=
kout.txt
>> index bd0fc1d..a29748e 100644
>> --- a/Documentation/git-checkout.txt
>> +++ b/Documentation/git-checkout.txt
>> @@ -431,6 +431,24 @@ thumb is do not make any assumption about wheth=
er a path belongs to
>>  $GIT_DIR or $GIT_COMMON_DIR when you need to directly access someth=
ing
>>  inside $GIT_DIR. Use `git rev-parse --git-path` to get the final pa=
th.
>>
>> +When you are done, simply deleting the linked working directory wou=
ld
>> +suffice. $GIT_DIR/worktrees can be cleaned up using `git prune
>> +--worktrees`.
>
> This needs a tweak or two so that it follows more naturally from the =
previous
> paragraph.  How about:
>
>         When you are done with a linked working tree you can simply d=
elete
>         it.  You can clean up any stale $GIT_DIR/worktrees entries wi=
th
>         `git prune --worktrees`.

Thanks for these rewrites; I was going to provide similar suggestions.

One minor addition for clarification would be to mention that the 'git
prune --worktrees' invocation applies to the main worktree:

    When you are done with a linked working tree, you can simply delete
    it. You can clean up any stale $GIT_DIR/worktrees entries via
    `git prune --worktrees` in the main worktree.

> Then in commit 28, when you add worktrees pruning to gc, you should c=
hange
> this paragraph again:
>
>         When you are done with a linked working tree you can simply d=
elete
>         it.  The working tree's entry in the repository's $GIT_DIR/wo=
rktrees
>         directory will eventually be removed automatically (see
>         `gc.pruneworktreesexpire` in linkgit::git-config[1]), or you =
can run
>         `git prune --worktrees` to clean up any stale entries in
>         $GIT_DIR/worktrees.

Ditto about qualifying 'git prune --worktrees' with "in the main work t=
ree".

>> +After you move a linked working directory to another file system, o=
r
>> +on a file system that does not support hard link, execute any git
>> +command (e.g. `git status`) in the new working directory so that it
>> +could update its location in $GIT_DIR/worktrees and not be
>> +accidentally pruned.
>
> It took me a couple of seconds to parse that.  How about:
>
>         If you move a linked working directory to another file system=
, or
>         within a file system that does not support hard links, you ne=
ed to
>         run at least one git command inside the moved linked working

I trip over "moved linked" every time I read it. I think there's
sufficient context in the 'if' clause leading to this that "moved" can
be dropped.

>         directory (e.g. `git status`) in order to update its entry in
>         $GIT_DIR/worktrees so that it does not get automatically remo=
ved.
>
>> +To stop `git prune --worktrees` from deleting a specific working
>> +directory (e.g. because it's on a portable device), you could add t=
he
>> +file 'locked' to $GIT_DIR/worktrees. For example, if `.git` file of
>> +the new working directory points to `/path/main/worktrees/test-next=
`,
>> +the full path of the 'locked' file would be
>> +`/path/main/worktrees/test-next/locked`. See
>> +linkgit:gitrepository-layout[5] for details.
>
> Sorry, I can't help rewriting this one too:
>
>         To prevent `git prune --worktrees` from deleting a
>         $GIT_DIR/worktrees entry (which can be useful in some situati=
ons,
>         such as when the entry's working tree is stored on a portable
>         device), add a file named 'locked' to the entry's directory. =
 For
>         example, if a linked working tree's `.git` file points to
>         `/path/main/.git/worktrees/test-next` then a file named
>         `/path/main/.git/worktrees/test-next/locked` will prevent the
>         `test-next` entry from being pruned.  See
>         linkgit:gitrepository-layout[5] for details.

Each time I read this (or Duy's original), the first question that
pops into my head is "should 'locked' be empty or have content, and if
content, what content?" gitrepository-layout.txt does explain the
content (if the reader bothers to chase the link), but perhaps it is
worth an explanatory sentence here?

> I also suggest this paragraph get updated in commit 28, but just chan=
ge the
> first clause, before "(which can be ...":
>
>         To prevent a $GIT_DIR/worktrees entry from being pruned (whic=
h ...
>
> Thanks for all this work!
>
>                 M.
