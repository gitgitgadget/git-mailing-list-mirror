From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: FIX/COMMENT: git remote manual page
Date: Sat, 25 Dec 2010 20:00:21 +0700
Message-ID: <AANLkTik_x+FcdRs7ac1X45OE7_9E8W-y44HJU=XUuRog@mail.gmail.com>
References: <20101222021546.4b24c4e9@eana.kheb.homelinux.org>
 <AANLkTim_pHYEZ+7-Rm5N4Ycw2MTHD8AhvZrZqNhttkck@mail.gmail.com> <20101225124104.06a4f83c@eana.kheb.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michel Briand <michelbriand@free.fr>
X-From: git-owner@vger.kernel.org Sat Dec 25 14:08:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWTrU-0003Ik-T0
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 14:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab0LYNAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Dec 2010 08:00:53 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60094 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab0LYNAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Dec 2010 08:00:52 -0500
Received: by wyb28 with SMTP id 28so7481031wyb.19
        for <git@vger.kernel.org>; Sat, 25 Dec 2010 05:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=gjqJoN1mBp+ZX/saSKEzb4tmJG/lOWZePmrNX1YvKy0=;
        b=ZqDOgb46UvI2GdJl53A9ce1s8d6DXzNyd+Y+v2PLPKTBhsvIbE+Z58qSQGyBgAu6N9
         V/5OYFxQ02RZbrbfqa0TFwtN/jgkaLgeYKtoTpOJ9GKxJUknmp/f5IBhKfVrsBj4gfi0
         wugaMv6EkhFWZDE8h/M/b8EQQt0hGPLCtRT9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ib8CCaTnsETWzSORsGtmc/vSBN8pwBxzav8EqyK2YxJlS2IvIhjmImVJlIZeg+5gJR
         NDHP+J0kJoYo/M+IWhy9Ahzob1eYOKHSAfkdxYzVpSQGd2mJqw5YMqfJWIgYzDcCkxfJ
         H+rhvoORekQGjTFRyz/4+rOMuKTEI9XwKw8+I=
Received: by 10.216.51.67 with SMTP id a45mr4015850wec.19.1293282051453; Sat,
 25 Dec 2010 05:00:51 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Sat, 25 Dec 2010 05:00:21 -0800 (PST)
In-Reply-To: <20101225124104.06a4f83c@eana.kheb.homelinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164175>

On Sat, Dec 25, 2010 at 6:41 PM, Michel Briand <michelbriand@free.fr> wrote:
> Hi,
>
> I'm running Debian squeeze. Git is version 1.7.2.3.
>
> Here is the complete command sequence I used:
>
> ~/tmp/git $ mkdir toto toto_wk
> ~/tmp/git $ GIT_DIR=toto GIT_WORK_TREE=toto_wk git init

Note that this also sets core.worktree=`cwd`/toto_wk so you only need
to set GIT_DIR in the following commands. But I wouldn't recommend it,
just set GIT_WORK_TREE the way you are doing, until maybe 1.7.4.
core.worktree is buggy.

> ~/tmp/git $ GIT_DIR=toto GIT_WORK_TREE=toto_wk git merge TOTO
> fatal: This operation must be run in a work tree
> fatal: read-tree failed

Thanks for the instructions. We've got a problem with $GIT_WORK_TREE
vs cwd here. I'll send a patch later.

> ~/tmp/git $ ls toto_wk/
> <NOTHING>
>
> I re-issue the latest command :
>
> ~/tmp/git $ GIT_DIR=toto GIT_WORK_TREE=toto_wk git merge TOTO
> Already up-to-date.
>
> Strange isn't it ?

Actually no. 'git-merge' is successful and its last step is to call
'git read-tree --reset -u SHA-1' to update worktree. Unfortunately,
git's internal cwd has been moved to ~/tmp/git/toto_wk while
$GIT_WORK_TREE is still "toto_wk". When git-read-tree is run, it tries
to find a worktree at ~/tmp/git/toto_wk/toto_wk.

> But directory is still empty
> ~/tmp/git $ ls toto_wk/
> <NOTHING>

Because git-read-tree fails to run.

> Trying to recover :
>
> ~/tmp/git $ GIT_DIR=toto GIT_WORK_TREE=toto_wk git reset --hard

Or you can try this until new git release:

GIT_DIR=toto GIT_WORK_TREE=$HOME/tmp/toto_wk git merge TOTO

or

GIT_DIR=toto git merge TOTO

In other words, making worktree absolute should work (core.worktree is
always set absolute by git-init).
-- 
Duy
