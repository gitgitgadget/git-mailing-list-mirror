From: Junio C Hamano <junkio@cox.net>
Subject: Re: Delitifier broken (Re: diff-core segfault)
Date: Mon, 12 Dec 2005 13:54:49 -0800
Message-ID: <7vek4igevq.fsf@assigned-by-dhcp.cox.net>
References: <1134404990.5928.4.camel@localhost.localdomain>
	<7vmzj6i206.fsf@assigned-by-dhcp.cox.net>
	<7virtui1kj.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512121620380.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 22:58:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElvdI-0006vF-2U
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 22:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVLLVyw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 16:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVLLVyw
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 16:54:52 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:44161 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932076AbVLLVyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 16:54:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051212215321.ENXK26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 16:53:21 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0512121620380.26663@localhost.localdomain>
	(Nicolas Pitre's message of "Mon, 12 Dec 2005 16:28:49 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13544>

Nicolas Pitre <nico@cam.org> writes:

>> This is not just "diff".  Our deltify code is half-broken, and
>> in the worst case this can corrupt our packs if an empty blob is
>> involved.
>
> I would say involving an empty blob with deltas _is_ the bug in the 
> first place.  Please don't let that happen.

Not all use of delta is to produce a pack.  An empty->empty
delta is a valid two byte \0\0 sequence, and I do not see any
reason to forbid it.  Although using such delta to represent
anything in a pack does *not* make any sense as you say, it
makes other callers simpler if they do not have to check if
from_len and to_len are empty before calling the delta code.
They care about from_len=0 (or to_len=0) case to produce similar
results as from_len=1 (or to_len=1) case and do not care at all
about the produced delta being a useful one for compressed
storage purposes.

> Especially with pack files, an empty blob can be represented with a 
> _single_ byte.  A delta must always be against something else and simply 
> storing the reference for the object the delta is against will always 
> use at least 20 bytes even for empty ones.

True, and the pack code is actually safe.  It punts on NULL
return, so my initial worry about packs turns out to be
unneeded.

> If my opinion is still of any weight I'd strongly vote for the former.  

I ended up doing both ;-).  The call site of diffcore-break was
certainly careless and broken (fixed); I've run git-grep to
check all callers to diff_delta() and the only one that did not
check the return value with NULL was the one that started with
thread.
