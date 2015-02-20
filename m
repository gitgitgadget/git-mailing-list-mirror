From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Fri, 20 Feb 2015 15:25:59 +0100
Message-ID: <CACBZZX45eCo6YS4EpHvMQjN32+-w5BztfoLiwh_rJTs7FydgoQ@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
 <CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_e2zeg@mail.gmail.com>
 <CACsJy8DkS65axQNY70FrfqR5s-49oOn8j7SAE9BTiRVNrm+ohQ@mail.gmail.com> <CACBZZX4T38j9YU3eiHTfkDoZKsgyJFrnJQNm5WBmb9RDenDOBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 15:26:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOoXB-0003o7-SA
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 15:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbbBTO0V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2015 09:26:21 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:52926 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbbBTO0U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 09:26:20 -0500
Received: by mail-ob0-f176.google.com with SMTP id wo20so24407155obc.7
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 06:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=q6pXJNDpBGTA/m2yWL4D9uTPzck/gmKVEtaM0JmsQFE=;
        b=opyn1er1McZswlMeY+aGGp/Fk9FjcdaBY42jLqwqWoMA+ilzeqjANm730FCDKGwVRj
         nwpWxcT26qIH9WdxHz4HhasX6ZGOLtF4QEocYks9gpotiYAC5LvJMmJDYRNvicnHhbTk
         5ErvjsoUzNldHJ3jJ2cCNcdqUv47XfzuArX30MR0o30WsgBXThTO77owYrv2M63srWe/
         dxIrm6jfdCwdaw0SbH15aDsD/VBHNu7BCD4PfK5kSCHrsT+TLGHJzr6rUkOwon00xwh+
         YrrRAkTP3pJt7pZwd+idW5wSXtxyPuBVdsBrQuPQVmXDwcXCSFUhMwbkXtXPrP602Nnh
         eR7Q==
X-Received: by 10.182.231.230 with SMTP id tj6mr6859139obc.58.1424442380136;
 Fri, 20 Feb 2015 06:26:20 -0800 (PST)
Received: by 10.76.82.1 with HTTP; Fri, 20 Feb 2015 06:25:59 -0800 (PST)
In-Reply-To: <CACBZZX4T38j9YU3eiHTfkDoZKsgyJFrnJQNm5WBmb9RDenDOBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264167>

On Fri, Feb 20, 2015 at 1:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Feb 20, 2015 at 1:04 AM, Duy Nguyen <pclouds@gmail.com> wrote=
:
>> On Fri, Feb 20, 2015 at 6:29 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
>> <avarab@gmail.com> wrote:
>>> Anecdotally I work on a repo at work (where I'm mostly "the Git guy=
") that's:
>>>
>>>  * Around 500k commits
>>>  * Around 100k tags
>>>  * Around 5k branches
>>>  * Around 500 commits/day, almost entirely to the same branch
>>>  * 1.5 GB .git checkout.
>>>  * Mostly text source, but some binaries (we're trying to cut down[=
1] on those)
>>
>> Would be nice if you could make an anonymized version of this repo
>> public. Working on a "real" large repo is better than an artificial
>> one.
>
> Yeah, I'll try to do that.

tl;dr: After some more testing it turns out the performance issues we
have are almost entirely due to the number of refs. Some of these I
knew about and were obvious (e..g. git pull), but some aren't so
obvious (why does "git log" without "--all" slow down as a function of
the overall number of refs?).

Rather than getting an anonymized version of the repo we have, a
simpler isolated test case is just doing this on linux.git:

    $ git rev-list --all | perl -ne 'my $cnt; while (<>) {
s<([a-f0-9]+)><git tag -a -m"Test" TAG $1>gm; next unless int rand 10
=3D=3D 1; $cnt++; s/TAG/tagnr-$cnt/; print }'  | sh -x

That'll create a tag for every 10th commit or so, which is around 50k
tags for linux.git.

I actually ran this a few times while testing it, so this is a before
and after on a hot cache of linux.git with 406 tags v.s. ~140k. I ran
the gc + repack + bitmaps for both repos noted in an earlier reply of
mine, and took the fastest run out of 3:

    $ time (git log master -100 >/dev/null)
    Before: real    0m0.021s
    After: real    0m2.929s
    $ time (git status >/dev/null)
    # Around 150ms, no noticeable difference
    $ time git fetch
    # I'm fetching from git@github.com:torvalds/linux.git here, the
    # cache is hot but upstream has *no* changes
    Before: real    0m1.826s
    After: real    0m8.458s

Details on why "git fetch" is slow in this situation:

    $ time GIT_TRACE=3D1 git fetch
    15:15:00.435420 git.c:349               trace: built-in: git 'fetch=
'
    15:15:00.654428 run-command.c:341       trace: run_command: 'ssh'
'git@github.com' 'git-upload-pack '\''torvalds/linux.git'\'''
    15:15:02.426121 run-command.c:341       trace: run_command:
'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
    15:15:05.507327 run-command.c:341       trace: run_command:
'rev-list' '--objects' '--stdin' '--not' '--all'
    15:15:05.508329 exec_cmd.c:134          trace: exec: 'git'
'rev-list' '--objects' '--stdin' '--not' '--all'
    15:15:05.510490 git.c:349               trace: built-in: git
'rev-list' '--objects' '--stdin' '--not' '--all'
    15:15:08.874116 run-command.c:341       trace: run_command: 'gc' '-=
-auto'
    15:15:08.879570 exec_cmd.c:134          trace: exec: 'git' 'gc' '--=
auto'
    15:15:08.882495 git.c:349               trace: built-in: git 'gc' '=
--auto'
    real    0m8.458s
    user    0m6.548s
    sys     0m0.204s

Even things you'd expect to not be impacted are, like a reverse log
search on the master branch:

    $ time (git log --reverse -p --grep=3Darm64 origin/master >/dev/nul=
l)
    Before: real    0m4.473s
    After: real    0m6.194s

Or doing 10 commits and rebasing on the upstream:

    $ time (git checkout origin/master~ && for i in {1..10}; do echo
$i > file && git add file && git commit -m"moo" $file; done && git
rebase origin/master)
    Before: real    0m6.798s
    After: real    0m12.340s

The remaining slowdown comes from the size of the tree, which we can
deal with by either reducing it in size (we have some copied JS
libraries and whatnot) or trying the inotify-powered git-status.

In our case there's no good reason for why we have this many refs in
the repository everyone uses. We basically just have a bunch of dated
rollout tags that have been accumulating for years, and a bunch of
mostly unused branches people just haven't cleaned up.

So I'm going to:

 1. Write a hook that rejects tags that aren't new (i.e. forbid
re-pushes of old tags)
 2. Create an archive repository that contains all the old tags (i.e.
just run "git fetch" on the main one from cron)
 3. Run a script to regularly delete tags from the main repo
 4. Run the same script on the clients that clone the repo

The branches are slightly harder, deleting those that are fully merged
into the same branch is easy, deleting those whose contents 100%
matches patch-id's already in the main branch is another thing we can
do, and just clean up branches unconditionally after they've reached a
certain age (they'll still be archived).
