From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can someone explain this git-blame/git-rev behavior to me?
Date: Mon, 16 Jul 2007 16:13:50 -0700
Message-ID: <7v7ip02b81.fsf@assigned-by-dhcp.cox.net>
References: <86sl7oaasx.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 01:14:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAZly-00013a-1d
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 01:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbXGPXNx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 19:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755248AbXGPXNw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 19:13:52 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:44488 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778AbXGPXNv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 19:13:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716231352.KAQE1358.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Jul 2007 19:13:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QPDq1X00Z1kojtg0000000; Mon, 16 Jul 2007 19:13:51 -0400
In-Reply-To: <86sl7oaasx.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Mon, 16 Jul 2007 12:43:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52732>

David Kastrup <dak@gnu.org> writes:

> git-rev-list HEAD --not tags/v1.4.2-rc1~88 --parents contrib/emacs/vc-git.el|tail -1|git-name-rev --stdin
>
> d87b90e47f7430455385edcf8506288b9a73d3b5 (tags/v1.4.2-rc1~87) b5dd9d2027c1bd5758033c7baf6d087752b0263d (tags/v1.4.2-rc1~88) 280242d1cc1fe2847f649d2f16b273e168fcbc48 (tags/v1.4.2-rc1~92)
>
> So we have tags/v1.4.2-rc1~87 listed as successor again, so I get into
> a loop of blame.

Without the final name-rev, it reads:

d87b90e4... b5dd9d20... 280242d1...

Without the --parent option, you get only d87b90e4...; the
option tells the command to additionally give you the (virtual)
parents in the simplified history on the same line as well.

Now, true parents of d87b90e4 are b5dd9d20 and 00449f99; the
former changes the path you are interested in, but the latter
does not.  Which means in this history:

  $ git show-branch d87b90e4 00449f99 280242d1
  ! [d87b90e4] Merge branch 'js/fmt-merge-msg'
   ! [00449f99] Make git-fmt-merge-msg a builtin
    ! [280242d1] send-email: do not barf when Term::ReadLine does not
  ---
  -   [d87b90e4] Merge branch 'js/fmt-merge-msg'
  ++  [00449f99] Make git-fmt-merge-msg a builtin
  +   [b5dd9d20] Fix print-log and diff compatibility with recent vc
  +   [b5dd9d20~1] git-svn: avoid fetching files outside of the URL w
  +   [b5dd9d20~2] Improve git-peek-remote
  +   [b5dd9d20~3] t8001-annotate: fix a bash-ism in this test
  +++ [280242d1] send-email: do not barf when Term::ReadLine does not

the true history of a side branch forked at 280242d1 to 00449f99
is simplified away, and 00449f99 is replaced with the boundary
commit 280242d1:

       00449f99                                   d87b90e4
         o--( branch that does not change the path) ---*
        /                                             /
    ---o----------o----------o----------o------------*
    280242d1  b5dd9d20~3  b5dd9d20~2  b5dd9d20~1  b5dd9d20


Note that 280242d1 is reachable from v1.4.2-rc1~88, so the
traversal does not go beyond it (as you said --not $that).
