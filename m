From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][PATCH] for_each_ref() returning heads in wrong order
Date: Sat, 23 Sep 2006 12:31:59 -0700
Message-ID: <7vu02ys7kg.fsf@assigned-by-dhcp.cox.net>
References: <20060923160712.5890.73139.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 21:32:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRDER-0000L3-8i
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 21:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWIWTcB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 15:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWIWTcB
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 15:32:01 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:40940 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751486AbWIWTcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 15:32:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923193159.YKVZ21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Sep 2006 15:31:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RvXy1V00P1kojtg0000000
	Sat, 23 Sep 2006 15:31:58 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060923160712.5890.73139.stgit@machine.or.cz> (Petr Baudis's
	message of "Sat, 23 Sep 2006 18:36:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27617>

Petr Baudis <pasky@suse.cz> writes:

> Using the #next branch I've now hit a problem with git-fetch-pack
> master choosing refs/bases/master (I geuss created by StGIT) instead
> of refs/heads/master. The old upload-pack returned the refs in the order
> heads-tags-everything_else but the new one just goes for whatever order
> readdir() returns them in (modulo merging with packed refs). I actually
> can't see the difference that caused this right now, though.

I think it is the other way around (the new one sorts, the old
one doesn't).  fetch-pack lets for_each_ref() to pick, but the
wrapper git-fetch I think prepends refs/ and refs/heads as
needed, so if you explicitly say heads/master I do not think you
have a problem.

However, I see a bit bigger problem here.  I think rev-parse
would not complain "master" is ambiguous in your repository,
because it has a fixed list of prefixes ("", refs, refs/tags,
refs/heads, refs/remotes, refs/remotes/%/HEAD) it uses to DWIM
in sha1_file.c::get_sha1_basic(), and refs/bases is not part of
the prefixes.

I suspect we should fix connect.c::count_refspec_match(), which
currently is just a strict tail match, to use the same list of
prefix.
