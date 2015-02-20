From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Fri, 20 Feb 2015 13:09:06 +0100
Message-ID: <CACBZZX4T38j9YU3eiHTfkDoZKsgyJFrnJQNm5WBmb9RDenDOBg@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
 <CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_e2zeg@mail.gmail.com> <CACsJy8DkS65axQNY70FrfqR5s-49oOn8j7SAE9BTiRVNrm+ohQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 13:09:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOmOi-00066l-HR
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 13:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbbBTMJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2015 07:09:28 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:47699 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbbBTMJ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 07:09:27 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so23715110obc.6
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 04:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=p0iQUsP7uVrsylZyj4tzRi1idXvfB7iJBdns1CgT3LA=;
        b=FHHtWGdz0Ad9ig8JrzrMRki7LykrEquBGyRP3hgSrnk6ynJIN+Uhz0EgcgCX1mIDae
         q+/12T5GBChH2WWkj1kWaujMZHcQv11mn6v4/1e2jtV8qbEM0ZP3ytO74f6yMQidvT9r
         fYu6lIoi3rV4vU70LRVf5Z86ZTE+UcIPuPkioE3J5mAUXXHqDUcz5rGpgbi3tYTtWFZK
         YMWGxr6uYqls2DbNkWhAiaSuJUyBFKhMiMvxVNXFxsxurtCA75hqgTIo5p5sM2BJHGDM
         x3RteIvZ3E3KltKdIbqDDhxEBueZeZcsD36Ew7NWZbJ0m8JygNKFKeUHGGKc0I+qaG9E
         Fo2Q==
X-Received: by 10.60.114.40 with SMTP id jd8mr6394880oeb.12.1424434166713;
 Fri, 20 Feb 2015 04:09:26 -0800 (PST)
Received: by 10.76.82.1 with HTTP; Fri, 20 Feb 2015 04:09:06 -0800 (PST)
In-Reply-To: <CACsJy8DkS65axQNY70FrfqR5s-49oOn8j7SAE9BTiRVNrm+ohQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264162>

On Fri, Feb 20, 2015 at 1:04 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Feb 20, 2015 at 6:29 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> Anecdotally I work on a repo at work (where I'm mostly "the Git guy"=
) that's:
>>
>>  * Around 500k commits
>>  * Around 100k tags
>>  * Around 5k branches
>>  * Around 500 commits/day, almost entirely to the same branch
>>  * 1.5 GB .git checkout.
>>  * Mostly text source, but some binaries (we're trying to cut down[1=
] on those)
>
> Would be nice if you could make an anonymized version of this repo
> public. Working on a "real" large repo is better than an artificial
> one.

Yeah, I'll try to do that.

>> But actually most of "git fetch" is spent in the reachability check
>> subsequently done by "git-rev-list" which takes several seconds. I
>
> I wonder if reachability bitmap could help here..

I could have sworn I had that enabled already but evidently not. I did
test it and it cut down on clone times a bit. Now our daily repacking
is:

        git --git-dir=3D{} gc &&
        git --git-dir=3D{} pack-refs --all --prune &&
        git --git-dir=3D{} repack -Ad --window=3D250 --depth=3D100
--write-bitmap-index --pack-kept-objects &&

It's not clear to me from the documentation whether this should just
be enabled on the server, or the clients too. In any case I've enabled
it on both.

Even then with it enabled on both a "git pull" that pulls down just
one commit on one branch is 13s. Trace attached at the end of the
mail.

>> haven't looked into it but there's got to be room for optimization
>> there, surely it only has to do reachability checks for new refs, or
>> could run in some "I trust this remote not to send me corrupt data"
>> completely mode (which would make sense within a company where you c=
an
>> trust your main Git box).
>
> No, it's not just about trusting the server side, it's about catching
> data corruption on the wire as well. We have a trick to avoid
> reachability check in clone case, which is much more expensive than a
> fetch. Maybe we could do something further to help the fetch case _if=
_
> reachability bitmaps don't help.

Still, if that's indeed a big bottleneck what's the worst-case
scenario here? That the local repository gets hosed? The server will
still recursively validate the objects it gets sent, right?

I wonder if a better trade-off in that case would be to skip this in
some situations and instead put something like "git fsck" in a
cronjob.

Here's a "git pull" trace mentioned above:

$ time GIT_TRACE=3D1 git pull
13:06:13.603781 git.c:555               trace: exec: 'git-pull'
13:06:13.603936 run-command.c:351       trace: run_command: 'git-pull'
13:06:13.620615 git.c:349               trace: built-in: git
'rev-parse' '--git-dir'
13:06:13.631602 git.c:349               trace: built-in: git
'rev-parse' '--is-bare-repository'
13:06:13.636103 git.c:349               trace: built-in: git
'rev-parse' '--show-toplevel'
13:06:13.641491 git.c:349               trace: built-in: git 'ls-files'=
 '-u'
13:06:13.719923 git.c:349               trace: built-in: git
'symbolic-ref' '-q' 'HEAD'
13:06:13.728085 git.c:349               trace: built-in: git 'config'
'branch.trunk.rebase'
13:06:13.738160 git.c:349               trace: built-in: git 'config' '=
pull.ff'
13:06:13.743286 git.c:349               trace: built-in: git
'rev-parse' '-q' '--verify' 'HEAD'
13:06:13.972091 git.c:349               trace: built-in: git
'rev-parse' '--verify' 'HEAD'
13:06:14.149420 git.c:349               trace: built-in: git
'update-index' '-q' '--ignore-submodules' '--refresh'
13:06:14.294098 git.c:349               trace: built-in: git
'diff-files' '--quiet' '--ignore-submodules'
13:06:14.467711 git.c:349               trace: built-in: git
'diff-index' '--cached' '--quiet' '--ignore-submodules' 'HEAD' '--'
13:06:14.683419 git.c:349               trace: built-in: git
'rev-parse' '-q' '--git-dir'
13:06:15.189707 git.c:349               trace: built-in: git
'rev-parse' '-q' '--verify' 'HEAD'
13:06:15.335948 git.c:349               trace: built-in: git 'fetch'
'--update-head-ok'
13:06:15.691303 run-command.c:351       trace: run_command: 'ssh'
'git.example.com' 'git-upload-pack '\''/gitrepos/core.git'\'''
13:06:17.095662 run-command.c:351       trace: run_command: 'rev-list'
'--objects' '--stdin' '--not' '--all' '--quiet'
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (6/6), done.
3:06:20.426346 run-command.c:351       trace: run_command:
'unpack-objects' '--pack_header=3D2,6'
13:06:20.431806 exec_cmd.c:130          trace: exec: 'git'
'unpack-objects' '--pack_header=3D2,6'
13:06:20.437343 git.c:349               trace: built-in: git
'unpack-objects' '--pack_header=3D2,6'
remote: Total 6 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (6/6), done.
13:06:20.444196 run-command.c:351       trace: run_command: 'rev-list'
'--objects' '--stdin' '--not' '--all'
13:06:20.447135 exec_cmd.c:130          trace: exec: 'git' 'rev-list'
'--objects' '--stdin' '--not' '--all'
13:06:20.451283 git.c:349               trace: built-in: git
'rev-list' '--objects' '--stdin' '--not' '--all'
=46rom ssh://git.example.com/gitrepos/core
   02d33d2..41e72c4  core      -> origin/core
13:06:22.559609 run-command.c:351       trace: run_command: 'gc' '--aut=
o'
13:06:22.562176 exec_cmd.c:130          trace: exec: 'git' 'gc' '--auto=
'
13:06:22.565661 git.c:349               trace: built-in: git 'gc' '--au=
to'
13:06:22.594980 git.c:349               trace: built-in: git
'rev-parse' '-q' '--verify' 'HEAD'
13:06:22.845728 git.c:349               trace: built-in: git
'show-branch' '--merge-base' 'refs/heads/core'
'41e72c42addc5075e8009a3eebe914fa0ce98b27'
'02d33d2be7f8601c3502fdd89b0946447d7cdf15'
13:06:23.087586 git.c:349               trace: built-in: git 'fmt-merge=
-msg'
13:06:23.341451 git.c:349               trace: built-in: git
'rev-parse' '--parseopt' '--stuck-long' '--' '--onto'
'41e72c42addc5075e8009a3eebe914fa0ce98b27'
'41e72c42addc5075e8009a3eebe914fa0ce98b27'
13:06:23.350513 git.c:349               trace: built-in: git
'rev-parse' '--git-dir'
13:06:23.362011 git.c:349               trace: built-in: git
'rev-parse' '--is-bare-repository'
13:06:23.365282 git.c:349               trace: built-in: git
'rev-parse' '--show-toplevel'
13:06:23.372589 git.c:349               trace: built-in: git 'config'
'--bool' 'rebase.stat'
13:06:23.377056 git.c:349               trace: built-in: git 'config'
'--bool' 'rebase.autostash'
13:06:23.382102 git.c:349               trace: built-in: git 'config'
'--bool' 'rebase.autosquash'
13:06:23.389458 git.c:349               trace: built-in: git
'rev-parse' '--verify' '41e72c42addc5075e8009a3eebe914fa0ce98b27^0'
13:06:23.608894 git.c:349               trace: built-in: git
'rev-parse' '--verify' '41e72c42addc5075e8009a3eebe914fa0ce98b27^0'
13:06:23.894026 git.c:349               trace: built-in: git
'symbolic-ref' '-q' 'HEAD'
13:06:23.898918 git.c:349               trace: built-in: git
'rev-parse' '--verify' 'HEAD'
13:06:24.102269 git.c:349               trace: built-in: git
'rev-parse' '--verify' 'HEAD'
13:06:24.338636 git.c:349               trace: built-in: git
'update-index' '-q' '--ignore-submodules' '--refresh'
13:06:24.539912 git.c:349               trace: built-in: git
'diff-files' '--quiet' '--ignore-submodules'
13:06:24.729362 git.c:349               trace: built-in: git
'diff-index' '--cached' '--quiet' '--ignore-submodules' 'HEAD' '--'
13:06:24.938533 git.c:349               trace: built-in: git
'merge-base' '41e72c42addc5075e8009a3eebe914fa0ce98b27'
'02d33d2be7f8601c3502fdd89b0946447d7cdf15'
13:06:25.197791 git.c:349               trace: built-in: git 'diff'
'--stat' '--summary' '02d33d2be7f8601c3502fdd89b0946447d7cdf15'
'41e72c42addc5075e8009a3eebe914fa0ce98b27'
[details on updated files]
13:06:25.488275 git.c:349               trace: built-in: git
'checkout' '-q' '41e72c42addc5075e8009a3eebe914fa0ce98b27^0'
13:06:26.467413 git.c:349               trace: built-in: git
'update-ref' 'ORIG_HEAD' '02d33d2be7f8601c3502fdd89b0946447d7cdf15'
=46ast-forwarded trunk to 41e72c42addc5075e8009a3eebe914fa0ce98b27.
13:06:26.716256 git.c:349               trace: built-in: git 'rev-parse=
' 'HEAD'
13:06:26.958595 git.c:349               trace: built-in: git
'update-ref' '-m' 'rebase finished: refs/heads/core onto
41e72c42addc5075e8009a3eebe914fa0ce98b27' 'refs/heads/core'
'41e72c42addc5075e8009a3eebe914fa0ce98b27'
'02d33d2be7f8601c3502fdd89b0946447d7cdf15'
13:06:27.205320 git.c:349               trace: built-in: git
'symbolic-ref' '-m' 'rebase finished: returning to refs/heads/core'
'HEAD' 'refs/heads/core'
13:06:27.208748 git.c:349               trace: built-in: git 'gc' '--au=
to'
