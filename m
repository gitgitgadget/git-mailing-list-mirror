From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Sharing a massive distributed merge
Date: Thu, 17 Mar 2011 01:21:19 -0400
Message-ID: <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
References: <4D8119BE.2090208@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 06:21:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q05em-0000Pr-GW
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 06:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962Ab1CQFVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 01:21:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45738 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab1CQFVt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2011 01:21:49 -0400
Received: by iwn34 with SMTP id 34so2442353iwn.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 22:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=5qPEaABuG9anrlx/9m8lcI9x3n6Ug9e42ZNW2K6c7TM=;
        b=RPPIYqO6DOy1TPQmWlw0jzXmoFgjd3LyBtOf4rjX48UIDc8QxfbZtr7gSjgUEAkRik
         L49AZSxLXB3Kj2tgQlKesFGKkxRrEwjxh9AiFIW1qOSRWxfGsUFIKFQPj3Kgr8yNVNqg
         B1XMw6Upz6uTbiDZ5U/ejplDmvMQNE3DyrYqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bpma4OhkKXM8Gc2I7xocOhVR9qmGQuYDqZCQMFbVJMgiuHFoegUiH6Dfg0MyPvu8NZ
         W/CTVioT1ZC2AeuL+YIS+6hS38GHnZBql4u0cQWboFSSZa78YhPu8NSWWbV+aG0gZwO4
         /8Fdm5lozJDJXroAc+3dH3c9AEw4ZeAC8KssY=
Received: by 10.231.141.133 with SMTP id m5mr793683ibu.107.1300339309111; Wed,
 16 Mar 2011 22:21:49 -0700 (PDT)
Received: by 10.231.34.7 with HTTP; Wed, 16 Mar 2011 22:21:19 -0700 (PDT)
In-Reply-To: <4D8119BE.2090208@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169210>

On Wed, Mar 16, 2011 at 4:12 PM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> We have two codelines that diverged quite a while back, and we are no=
w
> bringing them back together. =C2=A0More than 800 files are in conflic=
t, but it is
> very possible that the automatic non-conflicting merge is not correct=
ing.
> =C2=A0This means thousands of files need to be examined.

Have you considered breaking this up into multiple merges, so that
each merge deals with only a subset of the conflicts? This may mean
more work overall, but makes reviewing each individual merge much more
tenable.

IOW, given a history like:

 a--b--c--d--e...z
  \
   1--2--3--4...25

Instead of trying to merge z into 25, first merge b, then c, etc. I'd
try a divide and conquer approach - merge half way back to the common
ancestor, it that's too big, go half way back again, etc.

This obviously doesn't parallelize the effort.

> Git doesn't support distribution of a merge (although that would be
> extraordinarily cool), so the next best thing seemed to be force addi=
ng all
> files with conflict markers and then committing the merge. =C2=A0We t=
hen publish
> the conflicting branch and have each person fix their files. =C2=A0Gi=
ven that the
> conflict markers are already in place, they can't use their favorite
> graphical merge tool.

Well, this is awful, but you could do something like:

for x in conflicted_files:
   git show :1:$x > $x.base
   git show :3:$x > $x.theirs
   git checkout --ours $x
   git add $x.base $x.theirs $x

Commit that, then folks can use their favorite merge tools, commit the
result, and remove the .base and .theirs.

Notes:

- I'd do all this work on its own branch. When all the files have been
resolved, then do a real merge, but consult the branch for the
conflict resolution, e.g. "git merge ...; git checkout
merge_resolution -- ."

- See git-mergetool.sh for how to use checkout-index instead of "show
:<stage>:..."

- This only handles modify/modify conflicts.

- You might want to use "merge.conflictstyle diff3" and commit that
file too so that there's a reference file with the conflict markers --
I find the diff3 style very helpful in addition to GUI mergetools, for
which I've not found one that does a good presentation of theirs,
ours, base, and resolved.

> What I want to be able to do is have each person perform the merge lo=
cally,
> stage only the files they care about in that session, reset all other=
 files,
> and commit as a regular commit, not a merge commit. =C2=A0The user ca=
n take
> advantage of whatever tools they want in the in progress merge. =C2=A0=
When
> everyone has finished this process, we run git merge and keep our loc=
al
> changes.

$ git merge --squash other_branch
# resolve foo
$ git commit -m "resolved foo" -- foo
$ git reset --hard

Though I think the "awful" solution above might prove less error prone
and do a better job of keeping track of the remaining work.

j.
