From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Possible bug] diff-tree --stat info does not count copies
Date: Thu, 17 Aug 2006 02:40:08 -0700
Message-ID: <7vveorsnt3.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550608170219q12fcb34ewf93a195eabe0b94a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 11:40:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDeMI-0004nU-Bx
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWHQJkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWHQJkL
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:40:11 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:36316 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964787AbWHQJkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 05:40:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060817094009.TRKG12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Aug 2006 05:40:09 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550608170219q12fcb34ewf93a195eabe0b94a@mail.gmail.com>
	(Marco Costalba's message of "Thu, 17 Aug 2006 11:19:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25574>

"Marco Costalba" <mcostalba@gmail.com> writes:

> While testing qgit with the new rename/copy support  I found this
> (possible) bug playing on git tree.
>
> $ git-diff-tree -r --stat 6973dca
> 6973dcaee76ef7b7bfcabd2f26e76205aae07858
>  Makefile                      |    2
> diff-files.c                  |  212 +----
> diff-lib.c                    | 1862 ++---------------------------------------
> diff.c                        | 1795 ++++++++++++++++++++++++++++++++++++++++
> diff.h                        |    7
> t/t1001-read-tree-m-2way.sh   |    2
> t/t1002-read-tree-m-u-2way.sh |    2
> 7 files changed, 1929 insertions(+), 1953 deletions(-)
>
> $ git-diff-tree -r --stat -C 6973dca
> 6973dcaee76ef7b7bfcabd2f26e76205aae07858
>  Makefile                      |    2
> diff-files.c                  |  212 +----
> diff-lib.c                    | 1862 ++---------------------------------------
> diff-lib.c => diff.c          |    0
> diff.h                        |    7
> t/t1001-read-tree-m-2way.sh   |    2
> t/t1002-read-tree-m-u-2way.sh |    2
> 7 files changed, 134 insertions(+), 1953 deletions(-)
>
> IMHO the bug is
>
>   "diff-lib.c => diff.c          |    0"
>
> instead of
>
>   "diff-lib.c => diff.c          |    1795"
>
> because, after the patch applied, in the repository we have
> 1953-1929=24 lines of code more, not 1953-134= 1819 less.

Interesting.  That's really a matter of taste and interpretation.

If it were a straight rename without changing a single line,
then would you say 1795 lines were removed (from the LHS file)
and 1795 lines were added (to the RHS file)?

I personally find that output would be useless and would prefer
it to say "I renamed file A to file B.  Content-wise, there were
N lines added and M lines removed, compared to the straight
rename case, by the way".

And that is what the current output does.  I do not see why it
should be different in the case of a copy instead of a rename.
