From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: prepare for repositories with packed refs.
Date: Sat, 07 Oct 2006 02:33:29 -0700
Message-ID: <7vzmc8tqqe.fsf@assigned-by-dhcp.cox.net>
References: <7vsli5pwqf.fsf@assigned-by-dhcp.cox.net>
	<20061006154059.GQ20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 11:33:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW8Ys-0002dT-03
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 11:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWJGJdb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 05:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWJGJdb
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 05:33:31 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8894 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750701AbWJGJda (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 05:33:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007093330.VGDH21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 05:33:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XMZY1V00M1kojtg0000000
	Sat, 07 Oct 2006 05:33:33 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28462>

Petr Baudis <pasky@suse.cz> writes:

>> Running -e "$dir/HEAD" to guess if $dir is a git repository does
>> not give us the right answer anymore in such a case.
>
> I think this is a wrong answer to this problem - I guess Cogito's going
> to be confused by HEAD a dangling symlink as well and I'll bet there's
> more places where this will give us trouble. Having HEAD a dangling
> symlink is just wrong and git-pack-refs --prune is buggy if it causes
> that.

I disagree.

When we introduced symref, "cat .git/HEAD" stopped being the way
to read the value of the tip of the current branch, "echo
$commit >.git/HEAD" stopped being the way to update it, and
"rev-parse --verify HEAD" and "update-ref HEAD $commit" were
introduced at the same time as the official alternatives to
support both old and new implementations of .git/HEAD.

The way to find out which branch we are currently on used to be
"readlink .git/HEAD"; that stopped to be true, and we introduced
"symbolic-ref HEAD" as the official alternative to support both
old and new implementation.

The way to see if a random symbolic link whose name happens to
be HEAD is a symref has been to see if it points at a path that
begins with "refs/".

The user has a repository that uses symbolic link HEAD, and is
asking to use pack-refs and is also asking to prune loose refs
that no longer are needed, but definitely is NOT asking to
convert the repository to use symref HEAD.  The repository after
"pack-refs --prune" works perfectly well with symbolic link
HEAD, so doing that unasked-for conversion is unnecessary.

And the thing is, if the repository is actively being used, it
is a non issue -- recent-enough git would create a symref by
default.  The only place where it matters in practice are public
git repositories initialized using git before mid November last
year, and has never switched the "current branch" ever since
using git of newer vintage.
