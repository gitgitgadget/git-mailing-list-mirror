From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Sun, 12 Aug 2007 23:14:22 -0700
Message-ID: <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net>
References: <11869508753328-git-send-email-prohaska@zib.de>
	<118695087531-git-send-email-prohaska@zib.de>
	<7veji8ifs2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dmitry.kakurin@gmail.com, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 13 08:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKTC7-0006tk-CS
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 08:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504AbXHMGOY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 02:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757548AbXHMGOY
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 02:14:24 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43876 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756347AbXHMGOX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 02:14:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070813061422.INKK325.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 13 Aug 2007 02:14:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bJEN1X00B1kojtg0000000; Mon, 13 Aug 2007 02:14:22 -0400
In-Reply-To: <7veji8ifs2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 12 Aug 2007 14:50:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55745>

Junio C Hamano <gitster@pobox.com> writes:

> Steffen Prohaska <prohaska@zib.de> writes:
> ...
>> This works only together with the commit
>>
>> 'attr: fix attribute handling if .gitattributes is involved'
>
> While I think it is _one_ good approach to make things two-pass,
> I do not know if this is enough.  A logic similar to this should
> be made available to the codepath that switches branches,
> shouldn't it?

Ok, let's step back a bit and I'll suggest an alternative
approach to your 1/2.  This would hopefully solve 2/2 without
any code change your patch 2/2 has.

I think this approach is very much in line with how the git
plumbing works, but you would need to know how the world is
designed to work in order to appreciate it fully.  Let's have a
few paragraphs to give the readers some background.

The work tree side of git is primarily about the index, and what
is on the work tree is more or less secondary.  At the lower
level, often we deliberately treat not having a working tree
file as equivalent to having an unmodified work tree file.  We
can apply the same principle to this "missing .gitattributes
file" case.

People who only know modern git may not be aware of this, but
you can apply patches and perform a merge in a work tree that
does not have any file checked out, as long as your index is
fully populated.  For example, you can do something like this:

    $ git clone -n git://.../git.git v.git
    $ cd v.git
    $ git update-ref --no-deref HEAD $(git rev-parse v1.5.3-rc4^0)
    $ git read-tree HEAD
    $ git apply --index patch.txt

You will have the files that are patched in the resulting work
tree, so that you can inspect the result.  If you like the
result, you can even make a commit in such a sparsely populated
tree:

    $ git commit

Of course, "git commit -a" and "git add -u" Porcelain options
are more recent inventions, and they would not work with such a
sparsely populated work tree.  But the above demonstration shows
that at the plumbing level the index is the king and the work
tree is secondary, and this is very much as designed.  The merge
operation has similar characteristics:

    $ git merge master

... will check out the paths that need file-level 3-way merge,
so that you can inspect the result, but what you will have is a
sparsely populated work tree, and this is as designed.

Currently, the attr_stack code reads only from the work tree
and work tree alone.  We could change it to:

 - If the directory on the work tree has .gitattributes, use it
   (this is what the current code does);

 - Otherwise if the index has .gitattributes at the
   corresponding path, use that instead.

This essentially treats not having .gitattributes files checked
out as equivalent to having these files checked out unmodified,
which is very much in line with how the world is designed to
work.
