From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to use two bare repositories?
Date: Fri, 11 Apr 2008 17:55:46 -0700
Message-ID: <7vbq4fnb71.fsf@gitster.siamese.dyndns.org>
References: <7vabk0nd6x.fsf@gitster.siamese.dyndns.org>
 <20080411234430.GQ29940@cs-wsok.swansea.ac.uk>
 <200804120042.m3C0gmWR004445@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, Oliver Kullmann <O.Kullmann@swansea.ac.uk>
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 02:56:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkU2x-000785-UX
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 02:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080AbYDLA4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 20:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755975AbYDLA4D
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 20:56:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962AbYDLA4B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 20:56:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C34320DE;
	Fri, 11 Apr 2008 20:55:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C86E420DD; Fri, 11 Apr 2008 20:55:55 -0400 (EDT)
In-Reply-To: <200804120042.m3C0gmWR004445@mi0.bluebottle.com>
 (nanako3@bluebottle.com's message of "Sat, 12 Apr 2008 09:42:05 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79321>

しらいしななこ  <nanako3@bluebottle.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Typically, you would update a bare repository used for publishing by
>> pushing into it, and trigger update-server-info from the post-update hook.
>>
>> But it is perfectly fine if you initiate a mirror-fetch from that
>> publishing repository (in your case, "B"), and the caller to "git fetch"
>> can run update-server-info after fetching.
>>
>> And no, there is not a "post-fetch" hook, nor is there a need for one.
>
> Can you please explain why?

There are five valid reasons you might want to have a hook to a git
command/operation:

 (1) A hook that countermands the normal decision made by the underlying
     command.  Examples of this class are the update hook and the
     pre-commit hook.

 (2) A hook that operates on data generated after the command starts to
     run.  The ability to munge the commit log message by the commit-msg
     hook is an example.

 (3) A hook that operates on the remote end of the connection that you may
     not otherwise have access to, other than over the git protocol.  An
     example is the post-update hook that runs update-server-info.

 (4) A hook that runs under a lock that is acquired by the command for
     mutual exclusion.  Currently there is no example, but if we allowed
     the update hook to modify the commit that was pushed through
     send-pack => receive-pack pair, which was discussed on the list a
     while ago, it would be a good example of this.

 (5) A hook that is run differently depending on the outcome of the
     command.  The post-merge hook conditionally run by git-pull is an
     example of this (it is not even run if no merge takes place).
     Another example is the post-checkout hook that gets information that
     is otherwise harder to get (namely, if it was a branch checkout or
     file checkout -- you can figure it out by examining the command line
     but that already is part of the processing git-checkout does anyway,
     so no need to force duplicating that code in the userland).

You cannot do an equivalent operation from outside the git command for the
above classes of operations.  You need hooks for them.

On the other hand, if you want to always cause an action before or after
running a git opeation locally, you do not have to have a hook.  This is
true even if the action you would do after running a git operation depends
on what happened (class (5) above) if the result is easily observable
after the fact.

Of course there can be a very valid exception to the above policy.  If it
is common enough so that the policy means effectively everybody has to
reinvent the same wrapper.  But for this particular case I do not think
that is the case.
