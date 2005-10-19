From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-pack segfaulting on DebianPPC
Date: Wed, 19 Oct 2005 02:21:31 -0700
Message-ID: <7v7jc9c15w.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 11:24:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESA8e-0007n0-PT
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 11:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVJSJVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 05:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVJSJVd
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 05:21:33 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:49098 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932468AbVJSJVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 05:21:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019092121.PHWC1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 05:21:21 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 19 Oct 2005 22:02:14 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10281>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> ... However, git-fetch-pack is segfaulting on this Debian PPC
> (etch). This is true of the current git "master" and 0.99.8.c. I
> don'thave strace on the box until tomorrow, so I can't tell you more
> about it.

Thanks, that is good to know.  As I said in another message, I
looked at cg-fetch's current tag completion code while working
on the ref^{tree} thing, and saw it used commit walker with '-a'
option (IOW, not producing an incomplete tag) to download
everything.

Even after fetch-pack segfaulted, since it does not update any
refs itself (it only writes them to stdout for the wrapper to
process), it should not have resulted in the repository that has
refs pointing at objects it does not have. In fact, it writes
its "SHA1 - name" list only after seeing unpack-objects exit
successfully, that should not have resulted in a corrupt
repository that records incomplete refs.  I suspect there is
something else going on here.

In cg-fetch, fetch-pack is used only in one location, and it
does not have anything to do with the tag completion code.
Presumably that explains why removing tags did not have any
effect, although it does not explain why removing some objects
did -- maybe those object files you needed to remove were
corrupt?
