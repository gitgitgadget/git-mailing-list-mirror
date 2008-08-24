From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2008, #07; Sat, 23)
Date: Sun, 24 Aug 2008 13:24:47 -0700
Message-ID: <7vwsi6kvow.fsf@gitster.siamese.dyndns.org>
References: <7v1w0ft750.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808241955550.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vd4jymdfn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sun Aug 24 22:26:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXMAJ-0000bb-Ip
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 22:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbYHXUY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 16:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbYHXUY4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 16:24:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbYHXUY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 16:24:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0FEB166BB4;
	Sun, 24 Aug 2008 16:24:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4537C66BB2; Sun, 24 Aug 2008 16:24:50 -0400 (EDT)
In-Reply-To: <7vd4jymdfn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 24 Aug 2008 12:16:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B6AB0104-721A-11DD-9435-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93558>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> * sb/daemon (Thu Aug 14 20:02:20 2008 +0200) 4 commits
>>>  - git-daemon: rewrite kindergarden, new option --max-connections
>>>  - git-daemon: Simplify dead-children reaping logic
>>>  - git-daemon: use LOG_PID, simplify logging code
>>>  - git-daemon: call logerror() instead of error()
>>> 
>>> Can somebody who actually runs the daemon standalone comment on this 
>>> one?
>>
>> I am somewhat uneasy about running my production machine with these 
>> changes, since the last commit (the one introducing a kindergarden with 
>> cradles) is too unobvious for me.
>
> Well, I didn't ask anybody to _run_ it.
>
> I asked people who care about their daemons to comment on the change, so
> that if there are any issues in the code that I didn't see, the breakage
> gets caught before it propagates to their daemons they build from 'next'
> or 'master'.
>
> Having said that, I do agree that the kindergarden change is very involved
> (it removes more code than it adds --- the reduction of lines is somewhat
> inflated because quite a lot of comments that have become stale gets
> removed by the patch).

Ok, so I looked at the patch again (sorry, Stephen, for keeping this in a
limbo for very long).

First of all, I have to say that I think this patch is reasonably well
done.  I do see an unnecessary check of xcalloc() return value and some
style differences from what git uses, but that is only an indication of
the author not very familiar with git code, and every other aspect of the
change shows that this is quite competently done.  The list traversal with
cradle/blanket/newborn, except using perhaps too cute names for some
people's tastes, makes sense.

I however do have one issue with the logic, though.

It seems that kill_some_child() will not kill anything if nobody else is
coming from the same address, while the old code did kill some.  Is this
intended?

By the way, add_child() compares the whole "struct sockaddr_storage" in
order to queue the newborn in front of an existing connection from the
same address, and kill_some_child() takes advanrage of this to kill the
newest connection ("We kill the newest" comment should probably be moved
to add_child() to describe why the queuing is done this way).  If you
simplify add_child() to queue the newborn always at the front of the list,
your kill_some_child() will continue to do so, so I do not see the point
of the loop in add_child().  Am I mistaken?
