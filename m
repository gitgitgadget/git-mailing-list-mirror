From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 18:45:58 +0530
Message-ID: <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 15:16:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URjH2-000554-HI
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 15:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021Ab3DONQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 09:16:40 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:59912 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab3DONQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 09:16:39 -0400
Received: by mail-ia0-f179.google.com with SMTP id l25so4267699iad.38
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 06:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=TOkmlAJiqrr/UAhKG1H+btqafNY10xSxqfRtUz3JpEI=;
        b=sfU8fvSlVUwFoP/xTp0Q9z8IIxW/+EG85PLyZgaXHbx+B1VLIuWGjG3SQ7TtxHwzM2
         nXeOrnc/sexGZOidfgRVbkiGGP7RpYGHD+YRtz9/sRCE29M5flNc+HL7S+GvpDS7s04n
         xao7OgkNtTw9tkmLXm1qBNMevzQyxaMAttdCMqfytOVxgRlNUFojILFntcYwzrDpp31K
         TUg4BejBoGZE3aI9VyQPe1zg7mDFui/yoAQLcW6OpvoagMh907hkJxMbOqrk/TeRCTvL
         FhvcUObOxwASRKldNxVEfz1Gu9X2TZA9O2uFr/bhDh66tAe1mwP39ic0+narsEt1ilSY
         s/Ng==
X-Received: by 10.43.9.68 with SMTP id ov4mr11895946icb.22.1366031798698; Mon,
 15 Apr 2013 06:16:38 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 06:15:58 -0700 (PDT)
In-Reply-To: <vpq38us2oov.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221227>

Matthieu Moy wrote:
> Isn't this too pessimistic? If the local changes do not overlap (in
> terms of files) with the pulled changes, then autosquash is not needed.
>
> There should be a test for the case of non-overlapping changes.

In the pull-rebase case, no; it is not too pessimistic.

In the pull-merge case, maybe: if your worktree isn't clean, you lose
a lot of goodies like merge --abort anyway, and I hate that.
Secondly, it's impossible to determine whether the changes overlap or
not before actually running merge_trees().  If there were an easy way
to do it, I might have considered it.

Overall, I don't see how an extra stash/ stash pop where not
absolutely necessary hurts.

> Shouldn't this belong to "git merge" instead (i.e. implement "git merge
> --autosquash" and call it from "git pull")? Users doing "git fetch &&
> git merge" by hand should be able to use --autosquash, I think.

--autosquash reminds me of rebase.autosquash, and that is completely
unrelated to the issue at hand.  Did you mean git merge --squash (to
update the worktree/index but not create the actual commit?).  Sure,
it's probably useful to have a merge.squash configuration variable,
but I don't see what it has to do with the pull.autostash I'm
proposing.

> Something should be done for "git rebase" and "git pull --rebase" too.
> In this case, the UI can be much smoother, since the user would have to
> run "git rebase --continue" anyway, so you can do the auto-stash-pop for
> him by adding something like "exec git stash pop" at the end of the todo-list.

No.  I'm against executing a special codepath for a pull-rebase that
has no equivalent in the pull-merge world.  Or did you mean: have one
configuration variable to git merge --squash and do this for git
rebase, as if they're equivalent from the pull perspective?  No, they
aren't.

> Ideally, "git rebase --abort" should auto-stash-pop too, although this
> is much less trivial to implement.

As I already pointed out in my message to Junio, "fixing" rebase is
not the topic of discussion at all.

> Maybe a good first step is to implement --autosquash only for non-rebase
> pull, and later to implement "git rebase --autosquash" and call it from
> "git pull".

"Implement" git rebase --autosquash?  If I just set rebase.autosquash
to true, the rebase will automatically autosquash whether called from
git pull or otherwise.  Sorry, I just don't understand what you're
saying.
