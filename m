From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Undo last commit?
Date: Sat, 18 Jun 2011 19:18:22 +0530
Message-ID: <BANLkTinDBDkUYb=R2USV-T0=h9a3PRcATA@mail.gmail.com>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Mike <xandrani@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 18 15:56:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXw19-0002P3-Kj
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 15:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab1FRN42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 09:56:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47902 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab1FRN41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 09:56:27 -0400
Received: by wyb38 with SMTP id 38so831987wyb.19
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=T/hGNu3EMZrlFGIduatGgZ8Wt1PFRVnJvgCeXF7PT64=;
        b=Wjq8MrMnszaltNP0Y638xQelnj51sDwet9ks5ucjQLKy1zXsfXBvyzOquB5KH0KqEo
         mKNVHBslcvaQuiVQywYbBBjYzn1NghOyFDJ4zsNVuqZCvXkgEaYrcUVxTvoWCxZthjO7
         fjMQARKapzVYt4lik90mAxEayN8qIEHsKfJos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MIbBO0I/E60v9TTmz/IRQzSCksvD7op02cGHqFyN2AQmKROd2lybvO1jqFj15wXAd0
         G0D32l1G45ysDeX6REVXWHA6DOvSxUTP3Mf7Xhxb2gQmzlbQQG1TnYdG1ZD9qP6iPyoe
         zG1wXh1cdPtibOl3vzO/Cy97CMh9gndJANfp0=
Received: by 10.216.145.206 with SMTP id p56mr228928wej.80.1308404922079; Sat,
 18 Jun 2011 06:48:42 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Sat, 18 Jun 2011 06:48:22 -0700 (PDT)
In-Reply-To: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175971>

Hi Mike,

Mike writes:
> I have performed a 'git commit' on all 'added' files by mistake and
> now I want to undo this commit to return to the original state. Here's
> a more detailed description:

In your situation, the "correct" answer is (arguably) 'git reset
HEAD~1'.  This is called a mixed reset (see git-reset(1) for more).

> 2. I accidentally did a commit for ALL files because I forgot to
> specify the filename at the end of the commit.
> e.g. instead of 'commit -m "commit message" example3.php' I did
> 'commit -m "commit message"'.

Ideally, you should only stage what you want to commit.  Isn't that
the reason we have a staging area?

> % git commit --amend

Remember that 'git commit --amend' behaves a lot like 'git commit'; it
commits your staged changes.  Except, instead of making a new commit,
it adds those changes to your previous commit*.  It _additionally_
gives you the ability to update the commit message -- when you tried
it without any staged changes, that's what you saw.  Anyway, this is
not a good option in your particular case;  you'd essentially have to
stage the inverse of all the changes you didn't intend to make in the
previous commit before amending the previous commit.

> % git reset --hard HEAD~1

Ouch.  I'm sorry to have to be the one to give you the bad news; the
changes that you didn't commit (the "unstaged changes" you showed) are
lost forever**.  This is quite a dangerous command, and must be used
with care.

> Any ideas how to rectify this issue? I presume the 'git commit
> --amend' just changes the commit message? I daren't try anything else
> myself in case I make matters worse.

First, you must find the commit you made in the reflog and cherry-pick
it.  See git-reflog(1) and git-cherry-pick(1).  Now you've essentially
undo the hard reset, sans your unstaged changes.  Perform a 'git reset
HEAD~1' to move your HEAD back one step, stage the correct changes
before creating new commits.  A series of commands:
$ git reflog
# Look for the commit you made before; let's call this b8bb3f
$ git cherry-pick b8bb3f
# Stage, unstage whatever you like
$ git commit

* Git never actually loses your commits unless you garbage collect, so
you can still find the old commit (the one that you amended to
originally)
** Okay, very difficult to recover.  You'll have to find the tree
object corresponding to that index state.

-- Ram
