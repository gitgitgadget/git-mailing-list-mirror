From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use git-update-ref in scripts.
Date: Wed, 28 Sep 2005 12:47:12 -0700
Message-ID: <7vek79q8jj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
	<Pine.LNX.4.58.0509251153090.3308@g5.osdl.org>
	<7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509280819000.3308@g5.osdl.org>
	<7vek79w2ps.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509281007200.3308@g5.osdl.org>
	<7vk6h1rr9l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Wed Sep 28 21:48:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKhth-0002Ch-PR
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 21:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVI1TrU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 15:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVI1TrU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 15:47:20 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:56823 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750747AbVI1TrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 15:47:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050928194713.UXZD16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Sep 2005 15:47:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6h1rr9l.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 28 Sep 2005 11:17:26 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9447>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Wed, 28 Sep 2005, Junio C Hamano wrote:
>>> 
>> I don't like doing the diff before-hand, but it looked like the default 
>> was to try just one strategy, and avoid the diff in that case.
>
> By 'diff before-hand' I take it to mean the savestate for later
> rounds to keep the pre-merge state.  You are correct that it is
> not done in a single strategy case, and 'git pull' by default
> would use only one of Daniel's git-merge-resolve or in the
> multi-remote case git-merge-octopus, depending on the number of
> heads being merged.  BTW, I decided not to use diff, just in
> case somebody has binary blob we cannot reproduce with diff and
> patch.

I see two more diffs that turns out to be problematic in
git-merge.sh code.

 (1) As a safety measure I have a check to make sure the index
     is in sync with $head.  This visibly hurts; on my slow disk
     and CPU with a couple of locally modified paths in the
     working tree, this check takes about a second in the kernel
     tree with hot cache.

     git-merge-resolve uses "git-read-tree -u -m O A B" form, so
     this is totally unnecessary.  I am not so sure about
     Fredrik's git-merge-recursive (I haven't looked at it for a
     while).

 (2) savestate uses "git diff $head" to find out the list of
     paths that have local modifications, but the current code
     calls it after the check described above, so "git-ls-files
     -m" is enough.  On a kernel tree with hot cache and index
     in sync with HEAD, "git-ls-files -m" is about 3-4 times as
     fast with a couple of locally modified files.

Keeping (1) and using 'git-ls-files -m' in (2) is optimizing for
a wrong path.  On the other hand, (1) is a safety measure, and
if it is kept (2) becomes a quite cheap operation.

I am inclined to just remove the check in (1), and make it the
responsibility of merge strategies to make sure it does not
commit unrelated changes.

Comments?
