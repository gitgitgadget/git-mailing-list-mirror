From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-branch - allow deleting a fully specified
 branch-name
Date: Thu, 09 Apr 2009 20:18:01 -0700
Message-ID: <7vbpr519jq.fsf@gitster.siamese.dyndns.org>
References: <1239323335-4684-1-git-send-email-mlevedahl@gmail.com>
 <7vhc0x1gvh.fsf@gitster.siamese.dyndns.org>
 <200904092119.10520.mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 05:19:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls7HO-0005l2-2A
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 05:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763395AbZDJDSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 23:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763126AbZDJDSK
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 23:18:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762512AbZDJDSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 23:18:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 271B8DD27;
	Thu,  9 Apr 2009 23:18:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 57109DD26; Thu, 
 9 Apr 2009 23:18:03 -0400 (EDT)
In-Reply-To: <200904092119.10520.mlevedahl@gmail.com> (Mark Levedahl's
 message of "Thu, 9 Apr 2009 21:19:09 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3581AA7A-257E-11DE-A241-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116236>

Mark Levedahl <mlevedahl@gmail.com> writes:

> On Thursday 09 April 2009 20:39:46 Junio C Hamano wrote:
>> Mark Levedahl <mlevedahl@gmail.com> writes:
>> > This change allows, for instance
>> > 	git branch -d refs/heads/foo
>> > to succeed. Without this patch, the code just assumes that the
>> > given branch name should be appended to "refs/heads" or
>> > "refs/remotes", thus attempting (and failing) in the above case
>> > to delete "refs/heads/refs/heads/foo"
>>
>> Your logic is broken.
>>
>> Why doesn't the user simply say "git branch -d foo"?  The command takes
>> "the branch name", not "arbitrary ref name".
>
> 1) git branch -d refs/<whatever> used to work,  I haven't bisected to find 
> when this stopped working, but the change broke one of my scripts, so this is 
> not new behavior, it is restoration of previous behavior.

I need to look at the history, if that is the case then perhaps Ok.

> 2) If I create branch  refs/frotz/bar , how do I ever delete it?

By this you must mean .git/refs/heads/refs/frotz/bar, right?  Then
shouldn't "git branch -d refs/frotz/bar" just work as is?  If you are
talking about .git/refs/frotz/bar, "git branch" should not touch it, it is
not even a branch.

> Also, the following all work

> 3) git branch refs/heads/foo
> 4) git branch -m refs/heads/foo refs/heads/bar 

If you mean it creates .git/refs/heads/refs/heads/foo, then sure it
should.  If it creates .git/refs/heads/foo, I think it is broken.

> 5) git  [checkout|pull|push|fetch|show] refs/heads/foo

Among these, checkout is the only special case that can take "branch name"
to switch branches.  Everything else takes extended SHA-1 expression.
Checkout can interpret the first argument as "branch to switch to", but it
does not necessarily so---think "detached HEAD", and also think "checking
out paths out of tree-ish".

> So, why is "git branch -d" so special?

"git branch -d", "git branch -m" and friends all take branch name, and as
such it can use "@{-1}" to _name_ 'the previous branch".  In that context,
you are _not_ naming the commit at the tip of the branch.  You are naming
the branch itself.

All other commands happen to take a branch name because that is just one
case of extended SHA-1 expression to name an object.  In that context, a
refname (which a branch name is a special case of) refers to the commit
pointed by it.  E.g.

        "git checkout HEAD~20 -- Makefile"
        "git show refs/heads/foo"
        "git show heads/foo"
        "git show foo"
