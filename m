From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revision walker: Fix --boundary when limited
Date: Mon, 05 Mar 2007 17:32:22 -0800
Message-ID: <7vd53nupg9.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
	<7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
	<7vejo3xuq9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703060137210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 02:33:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOOY2-0001XK-Ae
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 02:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933782AbXCFBcY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 20:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933781AbXCFBcY
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 20:32:24 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38763 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933782AbXCFBcX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 20:32:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306013222.BTPT26279.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 20:32:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XDYN1W00W1kojtg0000000; Mon, 05 Mar 2007 20:32:22 -0500
In-Reply-To: <Pine.LNX.4.63.0703060137210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 6 Mar 2007 02:12:16 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41521>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +	if (revs->reverse) {
>> +		l = NULL;
>> +		while ((c = get_revision_1(revs)))
>> +			commit_list_insert(c, &l);
>> +		revs->commits = l;
>> +		revs->reverse = 0;
>>  	}
>
> Clever!

It is not clever, but just is stupid and WRONG.  It just shows
how little I care about --reverse ;-).

revision_1() is to get the full list without non limit limiters,
so the above loop would not even deplete the max_count but
literally grabs everything.

Arguably, you can do "rev-list --reverse -2 master" to get the
first two commits with this, but it was not intended.  We would
need to grab (skip + max_count) from get_revision_1() and set
max_count to -1 before leaving the if () {} here, or something
like that.

> I guess that you want to do this instead:
>
> 	case 0:
> 		c = NULL;
> 		/* fall through */
>>  	default:
>>  		revs->max_count--;
>
> ...

Actually that is not correct either.  The other patch fixes it
(but not the unintended semantic change to --reverse).

>> +	for (l = c->parents; l; l = l->next) {
>
> AFAICT this changes behaviour: c->parents were possibly rewritten.

Well, the behaviour of max with boundary in 'master' did the
same thing, as what was in revs->commits are rewritten parents
of commits we already returned, didn't it?

> But I 
> guess it makes sense showing the rewritten parents as boundary commits, 
> not the real parents.
>
>> +		struct object *p;
>> +		p = &(l->item->object);
>> +		if (p->flags & CHILD_SHOWN)
>
> ... or
> 		if (p->flags & (CHILD_SHOWN | SHOWN))

"If itself is shown it cannot be a boundary, and if we know we
marked it as potential boundary we do not have to mark it
again"...  I think you are right.
