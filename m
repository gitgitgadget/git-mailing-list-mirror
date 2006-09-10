From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Sat, 09 Sep 2006 21:13:07 -0700
Message-ID: <7vpse4uzos.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	<Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	<17666.4936.894588.825011@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
	<17666.13716.401727.601933@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
	<e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
	<Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
	<e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
	<Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
	<e5bfff550609092049t5e016cacr2502ce81bbb6489e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 10 06:12:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMGga-00065m-Us
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 06:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWIJEMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 00:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbWIJEMd
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 00:12:33 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:61356 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965227AbWIJEMc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 00:12:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060910041231.IWJP22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Sep 2006 00:12:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LUCX1V00X1kojtg0000000
	Sun, 10 Sep 2006 00:12:33 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550609092049t5e016cacr2502ce81bbb6489e@mail.gmail.com>
	(Marco Costalba's message of "Sun, 10 Sep 2006 05:49:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26780>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 9/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
>>
>> The example is
>>
>>                     A           <--- tip of branch
>>                    / \
>>                   B   E
>>                   |   |
>>                   |   F
>>                   | /
>>                   C
>>                   |
>>                   D
>>                 ...
>>
>
> Ok now it' clear, thanks. But anyhow I think that it should be
> possible to avoid the check and reordering on the receiver side.
>
> Suppose for a moment to split the graph drawing from the sequence
> reordering problem, suppose for a moment that receiver does do not
> draw the graph immediately.
>
> As you described, in our case git-rev-list sends the following sequence:
> A, B, C, D, E, F
>
> instead git-rev-list --topo-order would have sent something like
> A, E, F, B, C, D
>
> Now I ask, is it possible to have a sequence (without latency) like
> A, B, C, D, (-3)E, (-3)F
>
> where, in case of not topological correct revisions, git-rev-list
> gives the hint on the correct position in sequence (3 revs before in
> our case) where the revision would have been if the sequence would
> have been --topo-order ?

When rev-list is writing E out, it does not know it is a
descendant of something it already emitted (i.e. C) because it
hasn't looked at F nor checked its parent yet.  So asking for
(-3)F may be fine but I think (-3)E is just a fantasy.
