From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: git rebase keeps saying local changes would conflict..what changes?
Date: Sat, 16 Jun 2012 11:39:25 -0700
Message-ID: <CA+7g9JxbkD+b4dzAiWdkdyGuQm72jj=GSybZmB-Tr5iGcL-4eA@mail.gmail.com>
References: <D8381FF2-A6B4-4596-B565-7E5BB3F239D8@color.com>
	<2652085F-C1BC-4EAB-9289-F508E64982F0@color.com>
	<20120615160813.GB4572@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Gillum <eric@color.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 16 20:39:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfxub-0007Yz-E7
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jun 2012 20:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab2FPSj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jun 2012 14:39:27 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64247 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439Ab2FPSj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2012 14:39:26 -0400
Received: by bkcji2 with SMTP id ji2so3126809bkc.19
        for <git@vger.kernel.org>; Sat, 16 Jun 2012 11:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=xekhUOjqUjj8FAH2ZJ7vzYf+0D1mrGvEARtp6/DGgAA=;
        b=B4XpvUrqbrcqPr4aqV1gTWhRqJpaKNgT3s6eNh2poR/AUEl6nPKSINR2hjY++p2Odk
         h6gsPmz56UWPN629+T+N2lUhKHJMvMOFajCzrB6+zScETJmztdE4zfQojNPbGZENZIKM
         F3b7j2VWQ3w5f4cduBR99T3uxXXb3qDaxXUj/jNp09WWVXpz6RalZTIi9zbEUjdkzmja
         aAOdSJ9B4BZ3h26BbstF24gQgHTjoD4ND4k9atKSytrDU1ozWWivI0B3vTwyAlD3BkrT
         JRMdkwCfsv52Si6K15RYFkFqB9d/6OUnx4NbopO3u3bXh7nSW6OVayn9hbB4zZuxqmsB
         +Ucw==
Received: by 10.205.137.5 with SMTP id im5mr4471503bkc.45.1339871965305; Sat,
 16 Jun 2012 11:39:25 -0700 (PDT)
Received: by 10.205.40.71 with HTTP; Sat, 16 Jun 2012 11:39:25 -0700 (PDT)
X-Originating-IP: [76.102.247.8]
In-Reply-To: <20120615160813.GB4572@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQkj+FVweD4TBlW2c3yUrAiCranN8xqcUSIozFqoGDWnyBATk8zZfASH5yFFLJK2B4RKGkmF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200112>

On Fri, Jun 15, 2012 at 9:08 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 14, 2012 at 04:49:54PM -0700, Eric Gillum wrote:
>
>> Just found a similar problem here:
>> http://stackoverflow.com/questions/5074136. I do use Xcode, which may
>> be related. Maybe I'll try the proposed solution. But I'd still love
>> to know what the issue is, or how I can help debug it.

This caught my attention because my team and I have had a very similar
experience.  We're iOS devs using Xcode and we use pull --rebase a
lot.  About 1 in 10 times we get these mysterious conflicts that don't
appear in git status.  Aborting the rebase and starting over usually
fixes the problem, but much anxiety was caused by people who took the
advice to run git rebase --skip and found that their commits were
missing and thought they'd lost work.  I had to introduce everyone to
git reflog a lot sooner than I'd hoped to.  I've had the intention of
asking about this problem on the list for quite a while now but the
sporadic nature of the thing made it hard to put together a coherent
bug report.

> Reading that thread, one answer mentions that Xcode may overwrite files
> in the middle of your rebase. There is no git fix for that; tweaking
> files in the middle of a git operation can only lead to bad and
> confusing results.
>
> Turning off trustctime only makes sense if Xcode is touching the file
> metadata but not modifying the file at all. Is that what's happening?

If Xcode is doing anything it is probably that.  It certainly doesn't
change the content of files spontaneously.

> Further confusing to me is that the original poster there mentioned that
> the dirty state is untracked files in the working directory. But ctime
> shouldn't be involved at all, then. It sounds more like tracked files
> were not deleted when we switched away from the branch (either because
> of a bug in git, or because something like Xcode is re-creating them
> behind our back).

If you're not careful that can happen.  Xcode will offer to re-save
files that vanish.  But I've seen mystery conflicts many many times
and this was not the cause.

>> > I have a sometimes-reproducible issue when trying to rebase. In
>> > short, I've created a local branch B off of master, made several
>> > commits on B, switched to master and pulled, switched back to B,
>> > then tried "git rebase master", which fails. What I get about half
>> > the time is a failure that claims I have local changes to files that
>> > would be overridden by the merge. Nothing is reported by git status
>> > (I've even tried closing all editors), so I am forced to do git
>> > rebase --abort or --skip.
>
> Try running "git diff-files" instead of "git status". If something is
> munging the files behind git's back, then the index (which should have
> been refreshed by "git update-index --refresh" at the start of the
> rebase) will be out of date. "git status" will refresh the index itself,
> but we would not want that if we are interested in making the same
> comparison that the rebase is doing.

Interesting.  Maybe this will help get to the bottom of the problem.

Thanks!
-n8

-- 
HexaLex: A New Angle on Crossword Games for iPhone and iPod Touch
http://hexalex.com
On The App Store: http://bit.ly/8Mj1CU
On Facebook: http://bit.ly/9MIJiV
On Twitter: http://twitter.com/hexalexgame
http://n8gray.org
