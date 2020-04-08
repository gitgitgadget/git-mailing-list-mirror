Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90D1C2D0EA
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 07:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4C720747
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 07:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgDHHxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:53:02 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:38132 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgDHHxC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 03:53:02 -0400
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
        by smtp5-g21.free.fr (Postfix) with ESMTP id 447195FFAF;
        Wed,  8 Apr 2020 09:52:59 +0200 (CEST)
Date:   Wed, 8 Apr 2020 09:52:59 +0200 (CEST)
From:   ydirson@free.fr
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Message-ID: <1540391834.807942587.1586332379241.JavaMail.root@zimbra39-e7>
In-Reply-To: <CABPp-BEHQUzRjddKrC7Q7j+2W-W9ZjdVnXVjsM6wVWrpDF7cwQ@mail.gmail.com>
Subject: Re: [BUG] submodule move badly handled by git-rebase
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [91.170.159.152]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

> Hi Yann,
> 
> On Tue, Apr 7, 2020 at 9:36 AM <ydirson@free.fr> wrote:
> >
> > Hello all,
> >
> > When rebasing commits involving move of a submodule, git-rebase
> > fails to
> > record in index the "add" part of the rename.  This leaves the
> > workdir
> > dirty and the rebase gets stopped.
> >
> > fast-export of a testcase is attached.  To reproduce, just
> > "git rebase -i", add a "break" before the move commit,
> > use this to introduce some noise, and watch.
> >
> > Best regards,
> > --
> > Yann
> >
> >
> > (master)$ git rebase -i HEAD^^
> > hint: Waiting for your editor to close the file... Waiting for
> > Emacs...
> > Stopped at b0e1b00... add submodule
> >
> > (master|REBASE 2/3)$ echo >>README
> >
> > (master|REBASE 2/3)$ git commit -a -m noise
> > [detached HEAD d67c886] noise
> >  1 file changed, 1 insertion(+)
> >
> > (master|REBASE 2/3)$ git rebase --continue
> > Adding as subdir/gitlab-oe~08e230f... move submodule instead
> > error: could not apply 08e230f... move submodule
> > Resolve all conflicts manually, mark them as resolved with
> > "git add/rm <conflicted_files>", then run "git rebase --continue".
> > You can instead skip this commit: run "git rebase --skip".
> > To abort and get back to the state before "git rebase", run "git
> > rebase --abort".
> > Could not apply 08e230f... move submodule
> >
> > (master|REBASE 3/3)$ git st
> > interactive rebase in progress; onto c21ef8e
> > Last commands done (3 commands done):
> >    break
> >    pick 08e230f move submodule
> >   (see more in file .git/rebase-merge/done)
> > No commands remaining.
> > You are currently rebasing branch 'master' on 'c21ef8e'.
> >   (fix conflicts and then run "git rebase --continue")
> >   (use "git rebase --skip" to skip this patch)
> >   (use "git rebase --abort" to check out the original branch)
> >
> > Changes to be committed:
> >   (use "git restore --staged <file>..." to unstage)
> >         modified:   .gitmodules
> >         deleted:    gitlab-oe
> >
> > Unmerged paths:
> >   (use "git restore --staged <file>..." to unstage)
> >   (use "git add <file>..." to mark resolution)
> >         added by them:   subdir/gitlab-oe
> >
> > (master|REBASE 3/3)$
> 
> I couldn't figure out how to duplicate.  Maybe I did something wrong,
> but it was:
>     # download your fast-export stream
>     git init temp
>     cd temp
>     cat ~/Downloads/submodule-move.fexp | git fast-import --quiet
>     git checkout master
>     git rebase -i HEAD^^
>     # Insert a line with just 'b' between the two pick lines; save
>     and
> exit and when it breaks:
>     echo >>README
>     git commit -a -m noise
>     git rebase --continue
> 
> After the rebase --continue, the rebase completes just fine applying
> the patch with the submodule move.  git range-diff master@{1}... will
> show that I inserted a new commit in the middle.  git log --raw looks
> good, showing all four commits including the moved submodule at the
> end.

You're right, I missed crucial point: no problem appears unless the submodule
is initialized.  After checking out the master branch (and possibly issuing
"git reset --hard" to make sure everything is clean), it is necessary to
run "git submodule update --init".


> What git version did you use?  Do you need special settings (what's
> in
> your ~/.gitconfig and your .git/config)?

This is 2.26.0, but like my other report I had it with 2.25.1 already.
Just tested with an clear config (HOME and GIT_CONFIG_NOSYSTEM set) and
the problem triggers as well.

Best regards,
-- 
Yann

