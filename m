From: Niluge kiwi <kiwiiii@gmail.com>
Subject: Re: git-svn metadata commands performance issue
Date: Thu, 15 Jan 2015 12:26:03 +0100
Message-ID: <CAKdxknzztdUU+nP28R82mor=Cf7tqt98h2NwN9o0BczzT8adQw@mail.gmail.com>
References: <CAKdxknyCQf6HpnTZ8BMVVpEX3vcVEoTo5BmpqrkgFuxV+k7wmw@mail.gmail.com>
	<20150114203012.GA26023@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 12:26:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBiZ2-0007cJ-0m
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 12:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbbAOL0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 06:26:06 -0500
Received: from mail-we0-f176.google.com ([74.125.82.176]:53647 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbbAOL0F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 06:26:05 -0500
Received: by mail-we0-f176.google.com with SMTP id w61so14046065wes.7
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 03:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G0jLqhNzQCs+X+wLMhfYEqn6VaU0eeHW8SzmxFQ8IxA=;
        b=pLuA/PEPPqf30n6FkmG246BKTkuycOgrY8C+K3fta+4LmH9NYcVr3qQBeHd/2Ak0jz
         5t2B7KPMA832wwxEnla+kC0af7jzer2Gh/k9nW1ew680PAox/beGDk9krJ0ztcPlHkeR
         p52IYBSeqHw2FqWdPWoleZuZX09CE6fpPtssn6HFcdlW4cpaMfqGqtgF5LqjIF0Qz8j7
         pAjr+SqxcTtjSua2lGBHZi1Lmp05aiGv+ZjsluOdHAu3pIhFwCkla3uMkR5W6vvnZxWb
         gs4BbeHy4X3BgZOiRuGj8CmeOoJOx9OwD3pjxDlEVwwTt9zZs6bUaC6ploYMOnHiZAnL
         uKZg==
X-Received: by 10.194.60.70 with SMTP id f6mr17186633wjr.109.1421321163275;
 Thu, 15 Jan 2015 03:26:03 -0800 (PST)
Received: by 10.27.86.37 with HTTP; Thu, 15 Jan 2015 03:26:03 -0800 (PST)
In-Reply-To: <20150114203012.GA26023@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262475>

On Wed, Jan 14, 2015 at 9:30 PM, Eric Wong <normalperson@yhbt.net> wrote:
> Niluge kiwi <kiwiiii@gmail.com> wrote:
>> Hi all,
>>
>> In magit (http://magit.github.io/), a popular git frontend within
>> emacs, there is a git-svn frontend.  With a recent refactoring, it was
>> discovered that git-svn metadata commands (like "git-svn info") are
>> much slower than git ones:
>> git svn info: 130-150ms (after warmup): get the svn revision and url.
>> git svn rebase --dry-run: 150-170ms (after warmup): get the remote
>> branch.
>>
>> Whereas in pure git:
>> git rev-parse --abbrev-ref HEAD@{upstream}: 2-3ms (after warmup): get
>> the remote branch
>> Other git commands alike take all less than 10ms after warmup.
>
> Thanks for the bug report.  I actually see worse performance from
> my old machines, but I'm not a very heavy git-svn user anymore.
> 100ms is an eternity :<
>
>> This is an issue for the magit developers and users: just getting a
>> git-svn status with some metadata easily take ~500ms, which is really
>> slow for a UI. The equivalent UI with a pure git repository in magit
>> takes much less than 100ms to generate although more than 30 git
>> process are forked for it.
>
> How big is the parent process which forks the git commands?  On Linux at
> least, fork() performance is negatively impacted by parent process
> memory size.  To avoid spawn performance problems with large parent
> processes, vfork() should be used, but there does not seem to be an
> easy/portable way to use vfork() from Perl.

My emacs process uses ~500MB in RAM, but all the timings from my first
email come from commands run from bash that uses 8Mo in RAM. I don't
see any significant difference between timings from emacs and bash.

>
>> A previous version of magit-svn was much faster because it
>> re-implemented the logic of git-svn from perl to elisp (the
>> programming language in emacs), and to get the 3 previously mentioned
>> values it took less than 10ms.
>
> I've never worked with elisp, but we can probably figure out why it's
> faster.  Can you give us a pointer to the old elisp code?

The commit that removes the old code and replaces it by simple calls
to git-svn is here:
https://github.com/magit/magit/commit/b583e43a57dee164fdd53e0772220e32c1b3fab3

It may be faster because we don't have to start perl each time...

>
>> What could be done about this?
>> Could git-svn performance be dramatically improved?
>> Even git svn --version takes ~100ms, is perl the bottleneck?
>
> The Linux 'perf' tool reports much time is spent is from the Perl
> parser.  So we may implement lazy loading, so simple commands such as
> "git svn info" do not need to load and parse all the Perl code.
>
>> Or should each git-svn frontend developer re-implement the git-svn
>> metadata commands themselves for better performance?
>
> I prefer git-svn be fast enough; but you're free to reimplement
> and optimize your own code as you see fit.

The magit maintainer also prefers git-svn to be fast enough, because
it means less code to write and maintain.

>
>> Also, wouldn't it be better for those frontend developers if there
>> were some git-svn porcelain commands like git has? Fast, easy to parse
>> and stable input & output format?
>
> Sure, but we don't know what you'd need beyond the current command set.
> Of course we need to be careful about adding even more code to git-svn
> as that impacts startup time, too.
I'll ask the magit maintainer to weight in here for the ideal git-svn
command line features.

Also, couldn't the code be split into multiple files to have no global
impact on startup time when adding new features?
