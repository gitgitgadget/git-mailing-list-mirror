From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: git-branch --print-current
Date: Sat, 03 Jan 2009 20:26:34 -0800
Message-ID: <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	<402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
	<quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
	<20090104033839.GD21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jan 04 05:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJKal-0001DG-CF
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 05:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbZADE0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 23:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbZADE0j
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 23:26:39 -0500
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:55522 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbZADE0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 23:26:38 -0500
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 9260F34550; Sat,  3 Jan 2009 20:26:34 -0800 (PST)
X-Quack-Archive: 1
In-Reply-To: <20090104033839.GD21154@genesis.frugalware.org> (Miklos Vajna's message of "Sun\, 4 Jan 2009 04\:38\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104493>

>>>>> On 2009-01-03 19:38 PST, Miklos Vajna writes:

    Miklos> On Sat, Jan 03, 2009 at 06:18:36PM -0800, Karl Chen <quarl@cs.berkeley.edu> wrote:
    >> How about an option to git-symbolic-ref that gets rid of
    >> the refs/heads/ ?

    Miklos> Make an alias?

Thanks for the suggestion.  I don't have any problems making
aliases or using git-branch for interactive output; it's not an
issue of typing less.

I guess the broader point is that people use these "porcelain"
commands in scripts and parse their output even when they
shouldn't, and it's better to take action to prevent that.  This
reminds me of the issue of debugfs supposedly not being an ABI but
people rely on anyway since it's stable enough - people are
starting to rely on 'git branch' output just to print the current
branch name.  Better to create or at least publicly point out a
good alternative to nip this in the bud.

I suppose "user education" in the form of a big warning in the
git-branch man page would also help.  How do you even tell in the
man page whether a command is porcelain or not?  Still, I think
something like this is worth making slightly easier.  Another
minor argument for something like git branch --print-name is that
it's annoying to check the exit code inside a pipeline.

For example: Google for how to add the name of the git branch to
the bash prompt and you'll find countless examples of people using
git-branch.  And they're all different, so people aren't just
blindly copying one guy; here is a small sample:
     
    export PS1='...`git branch 2> /dev/null | grep -e ^* | sed
    -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\
     
    $(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "
    ($(git branch | grep '^*' |sed s/\*\ //))"; fi)
     
    `ruby -e \"print (%x{git branch 2>
    /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1)
    ')\"\`
     
    parse_git_branch() {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    }
     
    `git branch 2>/dev/null|cut -f2 -d\* -s`
     
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
     
    git_branch=`git branch 2>/dev/null | grep -e '^*' | sed -E 's/^\* (.+)$/(\1) /'`
     
There were a few using git-symbolic-ref but most used git-branch.
