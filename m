From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] move --show-cdup, --show-prefix, and --show-git-dir out of git-rev-parse.
Date: Sat, 07 Oct 2006 22:43:54 -0700
Message-ID: <7vvemvmkf9.fsf@assigned-by-dhcp.cox.net>
References: <20061007210429.GA2871@admingilde.org>
	<eg95a6$2v7$1@sea.gmane.org> <20061007213603.GB2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 07:44:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWRSH-00070J-BO
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 07:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWJHFn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 01:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWJHFn4
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 01:43:56 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:28150 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750813AbWJHFnz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 01:43:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061008054355.RBHM22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Oct 2006 01:43:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Xhjm1V00G1kojtg0000000
	Sun, 08 Oct 2006 01:43:47 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20061007213603.GB2871@admingilde.org> (Martin Waitz's message of
	"Sat, 7 Oct 2006 23:36:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28522>

Martin Waitz <tali@admingilde.org> writes:

> I thought doing the same for these commands as for --help and --version
> but wanted to hear some opinions first...
>
> After all, the comment in front of --version talked about legacy,
> so I was afraid to add more legacy ;-)

Nothing to fear; legacy is about "version" vs "--version".

By the way, rev-parse is not about "refs" at all.  It is about
"revs".

A possibly useless comment for people unfamiliar with history I
should add is that git-rev-parse serves two completely different
purposes.  One is to separate command line parameters into four
category and output only specified kind.  Four categories come
from flags vs non-flags and arguments related to revision
traversal vs other arguments.  The "parse" in rev-parse actually
stands for this feature.  Many git Porcelainish were implemented
as shell scripts that pipes rev-list output into diff-tree, and
rev-parse was originally invented as a helper for them.

We made many "rev-list | diff-tree --stdin" pattern into
built-in commands, by introducing revision.c, so this first
feature of rev-parse has become less useful.

But as a side-feature, when showing "non-flag, revision
traversal argument", it is told how to show the object name, and
also it acquired --verify option to make sure "extended sha1
expression" (refname, refname followed by ^n, ~n etc.) are
valid.

These days, the command is used primarily to get the object name
from an extended sha1 expression.  But some commands (most
notably, bisect) still rely on the "parse" aspect of the
command.

However, in its history it has also become a kitchen sink
command.  I think it may make sense to move these kitchen-sink
features such as --show-cdup etc. out of it and give it the
direct options to git wrapper these days.  When these features
were added, git wrapper did not even exist.
