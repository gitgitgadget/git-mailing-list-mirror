From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: incremental push/pull for large repositories
Date: Mon, 12 Jul 2010 11:17:45 -0400
Message-ID: <AANLkTin_syCNhoLFsMA8qwWkGBmW2kOZ-y7UrZkKZN_L@mail.gmail.com>
References: <20100710031258.GA554@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Mon Jul 12 17:18:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYKlt-0000ao-1u
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 17:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931Ab0GLPSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 11:18:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60365 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab0GLPSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 11:18:09 -0400
Received: by gwj18 with SMTP id 18so2089408gwj.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=rGyDKqpg5sfhTcx14QJ5FB1+rhbXAlEyooYTVTapMMs=;
        b=w8MOLxQf28ltUjXkE2JBdjcXPQjtu05Ed1yPi+TjzmmaAR024sfe3WLLzOr4jwkNhx
         6lK3CuF/uVZoJIqhcebx3KDdEHeMi9TqNylzB3XNkM6fXtYAwdP/fS6vIc0CvEsBFUbl
         Y6vUEyWju45RuzmxFXyHp5osga1Kz8Ur0uZWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=G61bSgXFlrIsoCDKfRcdTM27nfInViA5vTqNCaKTQZLIOeTgp3A02S4Zjo5M4HkEtu
         kYSBNbSpC0gr3M7f0Ic+FJWjLrBsGZI9UZ8mi+PuBEfe89Z2Y+YmScvLiEGqn8ZOalmf
         vrpUc0HVnkc7WL/rcih4jhJT8Uy37NOzYDdCY=
Received: by 10.150.176.8 with SMTP id y8mr5129450ybe.311.1278947885355; Mon, 
	12 Jul 2010 08:18:05 -0700 (PDT)
Received: by 10.151.45.4 with HTTP; Mon, 12 Jul 2010 08:17:45 -0700 (PDT)
In-Reply-To: <20100710031258.GA554@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150819>

On Fri, Jul 9, 2010 at 11:12 PM, Enrico Weigelt <weigelt@metux.de> wrote:
> I often have situations where I've rebased branches with large files
> (10th of megabytes per file) and pushing them to the remote. Normally
> these files themselves stay untouched, but the history changes (eg.
> commits reordered, several changes in smaller files,etc).
>
> It seem that on each push, the whole branch is transferred, including
> all the large files, which already exist on the remote site. Is there
> any way to prevent this ?

I was hoping someone else would have replied to you with a brilliant
solution to this by now, but I guess not, so I'll try with my limited
knowledge.  I've seen this behaviour as well.

>From what I understand, git uses an algorithm something like this to
determine which objects need to be transmitted by a push:

- find the latest commit T on the remote side that is also in the
branch you want to push.  (This part isn't an exhaustive search, and
might be off by a few commits if both ends have new changes, but this
problem usually happens only with fetch/pull, not push.)

- on the client doing the push, get a list of all objects in all new
commits that weren't in commit T and generate and send the pack.

As you can imagine, this is terribly non-optimal.  For example, if you
use 'git revert', it uploads all the objects you reverted, even though
they obviously already existed in the remote repo.  Example:

    #!/bin/sh
    set -e
    cd /tmp
    mkdir repo
    cd repo
    git init --bare
    cd ..
    git clone repo worktree
    cd worktree
    for i in $(seq 1000); do echo $i >$i; done
    git add .
    git commit -m orig
    git push  # sends about 1000 objects
    echo
    echo
    for i in $(seq 1000); do echo $i >>$i; done
    git commit -a -m doubled
    git push  # sends about 1000 objects
    echo
    echo
    git revert --no-edit HEAD
    git push  # sends about 1000 objects (again!)

The promising looking "--thin" option to git-push doesn't help this at
all.  I don't really know what it does, but whatever it does seems to
be relatively ineffective.  (I guess that's why it's not the default.)

You can imagine lots of ways to improve this, of course.  There's a
tradeoff between searching the history for old objects (which can be
slow in a huge repo) vs. just sending them and discarding duplicates
on the remote server.  For many projects, the tradeoff is an easy one:
just send the files, since they're tiny anyway, and sending them is
much faster than exhaustively searching the history.  But as soon as
huge files or huge numbers of files start to get involved, the
situation changes fast.

bup (http://github.com/apenwarr/bup) uses a totally different method:
the server sends you its pack .idx files, and you never push any
object that matches anything in those .idx files.  That works fine in
bup, because bup repositories are virtually never repacked.  (You pay
a time/bandwidth cost when you first talk to a repo, but it's worth it
to potentially avoid re-sending gigabytes worth of data.)  But in git,
where repacking happens frequently, this wouldn't fly, because the
indexes change every time someone runs "git gc".

If you came up with a patch to do improved packing/negotiation, I bet
it would be accepted.  Of course, it would have to either be optional
or have a decent heuristic for when to enable itself, because *most*
of the time, the default git behaviour is probably as fast as
possible.

Have fun,

Avery
