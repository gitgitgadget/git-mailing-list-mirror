From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: fix 'git pull --all' when current branch is
 tracking remote that is not last in the list of remotes
Date: Wed, 24 Feb 2010 09:05:39 -0800
Message-ID: <7vpr3uwom4.fsf@alter.siamese.dyndns.org>
References: <7vzl2zxz20.fsf@alter.siamese.dyndns.org>
 <1267016842-3380-1-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 18:06:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkKgR-0007iA-Bo
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 18:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354Ab0BXRFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 12:05:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334Ab0BXRFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 12:05:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A60C9C3EC;
	Wed, 24 Feb 2010 12:05:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qV7pH2pITZ2Ip8VZ0qn185gxVvE=; b=pGor2T
	BQH8yMqwRXrztscIgxXgGJpP4/MgCasPRZSBrZorHvrbgs6s14BCva8YinReTxSg
	v6vkvbmjg+gt+Oi0J6kLh9lkppcAcZi6KIdWz3+iPhjeBYdJsLNAElUqqRKvLm1B
	F5ug7Pq+iPXZb/K/l3Yuav615/0ijSlXR+tSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t7jkf6zS9RDvdKQ0w/xnjp83mOtB0AGC
	EHrgpUEXABV53FNdzHFCBrJPxHH24gjtAKCahGcPL35p2FRLtEDP5J4d3QU+jPkT
	eqR0KrGMU7v6NbuDO7hGNly+oBpNeTe1P17Qk5OInKgGQ+5OP6v0GuZqGfE59HZ1
	3WFKR8heP2c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D377C9C3E5;
	Wed, 24 Feb 2010 12:05:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1814C9C3E4; Wed, 24 Feb
 2010 12:05:44 -0500 (EST)
In-Reply-To: <1267016842-3380-1-git-send-email-michael.lukashov@gmail.com>
 (Michael Lukashov's message of "Wed\, 24 Feb 2010 13\:07\:22 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DA5D17B6-2166-11DF-BF7D-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140954>

Michael Lukashov <michael.lukashov@gmail.com> writes:

> Steps to reproduce the bug:
>
> 	1. Create repository and add more than one remote
> 	2. Make sure current branch is tracking branch from the remote AND this remote
> 	   is not last in the list of remotes
> 	3. 'git pull --all' exits with error message:
>
> 		You asked to pull from the remote '--all', but did not specify
> 		a branch. Because this is not the default configured remote
> 		for your current branch, you must specify a branch on the command line.
>
> After 'git pull --all' you need to run 'git pull' to update current branch.
> This is annoying.

I started to rewrite the commit log message to present the backstory and
the assumptions existing code makes, _why_ things break, and then explain
what the proposed solution is and why it is the right fix to the problem
(by the way, presenting the log message this way helps you to think things
through).  And I had to stop immediately after the description of _why_
things break:

    "git fetch" learned "--all" option and it has become tempting for
    users to say "git pull --all", even though it may not be absolutely
    necessary to pull from many remotes that are not involved in the merge
    about to happen to the current branch.

    "git fetch --all" however clears the list of fetched branches every
    time it contacts a different remote.  Unless the current branch is
    configured to merge with a branch from a remote that happens to be the
    last in the list of remotes "fetch --all" contacts with, "git pull
    --all" will not be able to find the branch it should be merging with.

Notice that presented this way, it becomes clear that it not a bug in
"pull --all" at all. "fetch --all" should be doing the clearing of
FETCH_HEAD at the very beginning (unless --append is given from the
command line, in which case it should just use FETCH_HEAD as-is), and then
run in the --append mode even when --append is not given.

So I think you identified a valid issue to address, but the patch is
solving it in a wrong way.  The commit log message I started above would
be concluded with something like the following explanation of what the
proposed solution is and why it is the right fix:

    Make "fetch --all" to clear FETCH_HEAD (unless --append is given) and
    then append the list of branches fetched to it (even when --apend is
    not given).  That way, "pull --all" will be able to find the data for
    the branch being merged in FETCH_HEAD no matter where the remote
    appears in the list of remotes to be contacted by "git fetch".

and the patch would touch fetch, not pull.
