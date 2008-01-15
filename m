From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Tue, 15 Jan 2008 04:21:49 -0800
Message-ID: <7vfxwze0te.fsf@gitster.siamese.dyndns.org>
References: <4787E981.7010200@nrlssc.navy.mil>
	<478C1D7A.6090103@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jan 15 13:22:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEkog-00070Z-9X
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 13:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbYAOMWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 07:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbYAOMWE
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 07:22:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbYAOMWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 07:22:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 99F203530;
	Tue, 15 Jan 2008 07:21:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E679F352F;
	Tue, 15 Jan 2008 07:21:55 -0500 (EST)
In-Reply-To: <478C1D7A.6090103@nrlssc.navy.mil> (Brandon Casey's message of
	"Mon, 14 Jan 2008 20:42:02 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70518>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Brandon Casey wrote:
>> I got this message from git-commit:
>> 
>> $ git commit -a
>> <edit message, :wq>
>> fatal: Out of memory? mmap failed: Bad file descriptor
>> Create commit <my_prompt_string>

I think from your earlier reports we already know that the issue
is that somebody is closing a file descriptor we opened for a
packfile and makes the code to shuffle the window that is used
to access the packfile unhappy because it uses the fd to mmap.

> I ran git-bisect and the result is below. Doesn't look like
> much help though.

That change alone does look innocuous, but indeed is around the
place the code finds that the necessary fd is already closed.

> The other possibly useful info is that running
> 'git commit -a -C HEAD --amend' does not cause the error.

A huge difference between "-C HEAD" and a commit with an editor
is that the former bypasses the git-status code to fill the
commit message template.  In addition to that, the latter spawns
a new process.

It could be the editor codepath may be closing the fd when it
shouldn't, or some atexit() thing is triggering incorrectly.
IIRC the fd incorrectly closed was #6, so it is not likely that
process spawning code that may shuffle low fds is the culprit.

As Linus said already (and Alex suggested earlier in the nearby
thread), strace output might be a good place to help digging
this issue further, instead of us idly speculating.

What platform is this on?

Does it reliably reproduce for any commit in the repository, or
reliably reproduce for one particular commit, or sometimes
reprooduce for one particular commit?
