From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn metadata commands performance issue
Date: Wed, 14 Jan 2015 20:30:12 +0000
Message-ID: <20150114203012.GA26023@dcvr.yhbt.net>
References: <CAKdxknyCQf6HpnTZ8BMVVpEX3vcVEoTo5BmpqrkgFuxV+k7wmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Niluge kiwi <kiwiiii@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 21:30:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBUa4-0002IL-Cs
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 21:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbbANUaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 15:30:14 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60923 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbbANUaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 15:30:13 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6432F63381E;
	Wed, 14 Jan 2015 20:30:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAKdxknyCQf6HpnTZ8BMVVpEX3vcVEoTo5BmpqrkgFuxV+k7wmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262421>

Niluge kiwi <kiwiiii@gmail.com> wrote:
> Hi all,
> 
> In magit (http://magit.github.io/), a popular git frontend within
> emacs, there is a git-svn frontend.  With a recent refactoring, it was
> discovered that git-svn metadata commands (like "git-svn info") are
> much slower than git ones:
> git svn info: 130-150ms (after warmup): get the svn revision and url.
> git svn rebase --dry-run: 150-170ms (after warmup): get the remote
> branch.
> 
> Whereas in pure git:
> git rev-parse --abbrev-ref HEAD@{upstream}: 2-3ms (after warmup): get
> the remote branch
> Other git commands alike take all less than 10ms after warmup.

Thanks for the bug report.  I actually see worse performance from
my old machines, but I'm not a very heavy git-svn user anymore.
100ms is an eternity :<

> This is an issue for the magit developers and users: just getting a
> git-svn status with some metadata easily take ~500ms, which is really
> slow for a UI. The equivalent UI with a pure git repository in magit
> takes much less than 100ms to generate although more than 30 git
> process are forked for it.

How big is the parent process which forks the git commands?  On Linux at
least, fork() performance is negatively impacted by parent process
memory size.  To avoid spawn performance problems with large parent
processes, vfork() should be used, but there does not seem to be an
easy/portable way to use vfork() from Perl.

> A previous version of magit-svn was much faster because it
> re-implemented the logic of git-svn from perl to elisp (the
> programming language in emacs), and to get the 3 previously mentioned
> values it took less than 10ms.

I've never worked with elisp, but we can probably figure out why it's
faster.  Can you give us a pointer to the old elisp code?

> What could be done about this?
> Could git-svn performance be dramatically improved?
> Even git svn --version takes ~100ms, is perl the bottleneck?

The Linux 'perf' tool reports much time is spent is from the Perl
parser.  So we may implement lazy loading, so simple commands such as
"git svn info" do not need to load and parse all the Perl code.

> Or should each git-svn frontend developer re-implement the git-svn
> metadata commands themselves for better performance?

I prefer git-svn be fast enough; but you're free to reimplement
and optimize your own code as you see fit.

> Also, wouldn't it be better for those frontend developers if there
> were some git-svn porcelain commands like git has? Fast, easy to parse
> and stable input & output format?

Sure, but we don't know what you'd need beyond the current command set.
Of course we need to be careful about adding even more code to git-svn
as that impacts startup time, too.
