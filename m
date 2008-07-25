From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did
 not change
Date: Fri, 25 Jul 2008 01:44:59 -0700
Message-ID: <7vod4muzck.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807222235520.8986@racer>
 <7vmyk888z5.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807241311450.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 10:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMIwF-0001dd-KQ
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 10:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546AbYGYIpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 04:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755728AbYGYIpH
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 04:45:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713AbYGYIpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 04:45:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FA823A178;
	Fri, 25 Jul 2008 04:45:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D0EE73A177; Fri, 25 Jul 2008 04:45:01 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FA51238C-5A25-11DD-80B8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90014>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> At what point in what valid workflow sequence does HEAD become different 
>> from dotest/amend?
>
> $ rebase -i HEAD~5
>
> 	<mark one commit as edit>
>
> 	<Whoa! While editing, I realize that this contains an unrelated 
> 	 bugfix>
>
> $ git reset HEAD^
> $ git add -p
> $ git commit
>
> 	<Edit a bit here, a bit there>
>
> $ git rebase --continue
>
> Sure it is a pilot error.  It hit this pilot, too.
> ...
> In the way that the user certainly did not mean to amend _this_ HEAD.  
> Another HEAD was marked with "edit".

Ok; after this "refraining from incorrectly squashing them", how would the
user edit the one the user originally intended to edit (I am not
complaining, but asking for information)?

So in your workflow example, when there is no pilot error, is this the
"ideal" sequence?

	$ git rebase -i HEAD~5
        .. mark one as edit
        .. ah, the one I wanted to just "edit" actually need to be
        .. split into two because it has some other thing I need to change
	$ git reset HEAD^
	$ git add -p
        $ git stash --keep-index
        .. test to verify the initial part
        $ git commit ;# first part of split commit
        $ git stash pop
        .. test test
        $ git add -p
        $ git rebase --continue ;# gives you the editor to edit

I wonder if we can make the transcript of the "pilot error" case look like
this:

	$ git rebase -i HEAD~5
	...
	$ git reset HEAD^
        .. same as above up to...
        .. test to verify the initial part
	$ git rebase --continue ;# oops
	.. gives you the editor to edit the message.
        .. makes a commit, and says:
        committed initial part of the change, stopping.
	.. ah, the command noticed it and did not escape, thanks!
        $ git stash pop
        .. test test
        $ git add -p
        $ git rebase --continue ;# gives you the editor to edit
	.. and goes on this time.
