From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Thu, 28 Jul 2005 22:04:36 -0700
Message-ID: <7vack6mcd7.fsf@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<20050722205948.GE11916@pasky.ji.cz>
	<7vd5p73jlu.fsf@assigned-by-dhcp.cox.net>
	<20050728155210.GA17952@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Fri Jul 29 07:04:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyN39-0001wp-Hn
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 07:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVG2FEj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 01:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVG2FEj
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 01:04:39 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:10494 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262348AbVG2FEi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 01:04:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729050437.BQVA7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 01:04:37 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> You generally don't say "I never want this ignored, but I want
> the rest of that ignored", but "I want that ignored, except
> this".

OK.

> But more importantly,
>
> 	.gitignore: *.txt
> 	Documentation/.gitignore: !*.txt
>
> will not work, which was the whole _point_ of the exclusion.

I agree that this is a bigger issue.

My updated proposal is as follows:

 * We collect --exclude patterns in "command line patterns"
   list, in the same order as given on the command line.

 * We collect patterns read from the files specified with
   --exclude-from in "exclude-from patterns" list, in the same
   order as given on the command line and the same order
   patterns appear in the file.

 * While we descend the directories, files named by EPD flag, if
   found, are read from top to bottom and concatenated into the
   "per directory patterns" list.  When leaving the directory,
   the patterns read from that directory's EPD file are popped
   off.

 * When checking a file to see if it is excluded, we first look
   at "exclude-from patterns" list, then "per directory
   patterns" list, and then "command line patterns list", in
   that order.  The last match wins [*1*].

An example:

You have three files in your git source tree and your $HOME:

    git/.gitignore                      lists patterns A and B
    git/Documentation/.gitignore        lists patterns C and D
    git/.git/info/ignore                lists patterns E and F
    $HOME/.gitrc/ignore                 lists patterns G and H

You say:

    git-ls-files --others \
        --exclude=I --exclude=J \
        --exclude-from=.git/info/ignore \
        --exclude-from=~/.gitrc/ignore \
        --exclude-per-directory=.gitignore \

While in git/ directory itself, the following patterns are
checked and the last match wins:

    E F G H   A B       I J

When we descend into git/Documentation, the list of patterns
used becomes the following, still the last match wins:

    E F G H   A B C D   I J

The reason --exclude-from comes first (i.e. having the least say
in the outcome) and --exclude comes last (i.e. having the most
say) is because the former is to give the overall fallback
default, and the latter is the ultimate end user preference.

Does this sound reasonable?

[Footnote]

*1* In real implementation, I would probably scan in reverse
from the end and stop at the first match, but that is an
implementation detail.
