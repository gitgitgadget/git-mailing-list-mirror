From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 13:58:37 -0700
Message-ID: <7viqkzdoua.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
 <20090420113216.GC25059@dpotapov.dyndns.org>
 <49EC6596.8060208@drmicha.warpmail.net>
 <20090420132414.GD25059@dpotapov.dyndns.org>
 <49EC7E3B.9050909@drmicha.warpmail.net>
 <20090420184048.GF25059@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 23:00:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw0bG-0003qn-Dt
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 23:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755425AbZDTU6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 16:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755349AbZDTU6s
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 16:58:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbZDTU6r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 16:58:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F04EAC32D;
	Mon, 20 Apr 2009 16:58:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1C854AC32B; Mon,
 20 Apr 2009 16:58:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0A01513E-2DEE-11DE-8377-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117033>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Mon, Apr 20, 2009 at 03:52:59PM +0200, Michael J Gruber wrote:
> ...
>> A git branch is a pointer to a commit. That commit and its predecessors
>> are contained in the branch. A commit may be contained in multiple
>> branches, on equal footing: there is no "prime branch".
>
> This is not accurate description.

On the contrary, Michael's description is very accurate; its problem may
be that it is too accurate to be useful for people who do not use certain
features.

> The aforementioned pointer is called
> "branch head". Branch (in strictly sense) is a line of development,
> which is defined by its head. A usual commit has one parent; a merge
> commit can have more than one parent, the first parent defines the
> branch line while other parents point to branches merged to it.

Now, that again is technically accurate but is not very useful or even
harmful if you read too much into --first-parent.

Dscho may have been working on this nifty feature while my tree added tons
of changes that conflict with his work based on an older tree of mine.
And then he says "I have a clean history of this new feature; please pull".


         o---o---o---o---o Dscho's changes
        /
    ---o---D---D---D---o My tree
       ^     
       |       D = changes from Dmitry that conflicts with Dscho's branch
    v1.6.2

I may pull, and see a lot of conflicts; being unfamiliar with what he did,
I may say "I tried to pull, and I give up---there are too many conflicts
with what patches from Dmitry did recently since your tree forked, and I
do not know the area affected very well, so I feel uneasy doing the merge
myself."

         o---o---o---o---o Dscho's changes
        /                 .
    ---o---D---D---D---o...X My tree, unable to resolve conflicts
       ^     
       |       D = changes from Dmitry that conflicts with Dscho's branch
    v1.6.2

Dscho can do two things.  One is to rebase, but his code was in use
outside of my tree for some time and doing so will screw up other people.

But he can merge my tree and resolve the conflicts, and then tell me to
pull again.


           Dscho's changes
         o---o---o---o---o---M
        /                   /    
    ---o---D---D---D---o---. My tree
       ^     
       |       D = changes from Dmitry that conflicts with Dscho's branch
    v1.6.2     M = merge made by Dscho for me

Now, if I did the merge, the first parent of X would have been the tip of
my tree that had patches from you, and it would have merged Dscho's
changes as a side branch.  But if Dscho did a merge _for me_, then his
merge M will have his history as the first parent, and your patches
(together with possibly ones from other people) will be merged into the
history as a side branch.

However, especially after I fast-forward my branch tip to M and continue
building on it, it is more useful to treat Dscho's topic as the side
branch that was merged to my mainline that had your patches, for the
purpose of most people.  Your "first parent" rule does not match that
expectation.

If we made it easy for Dscho to create the merge M to record my tree as
the first parent, you _could_ make the "first parent" rule to be more
meaningful than it currently is, but without it, it still is merely one of
the heuristics as people suggested in this discussion.
