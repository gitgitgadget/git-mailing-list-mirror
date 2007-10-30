From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Tue, 30 Oct 2007 12:19:32 -0700
Message-ID: <7vejfcl8aj.fsf@gitster.siamese.dyndns.org>
References: <1193593581312-git-send-email-prohaska@zib.de>
	<11935935812741-git-send-email-prohaska@zib.de>
	<1193593581114-git-send-email-prohaska@zib.de>
	<1193593581486-git-send-email-prohaska@zib.de>
	<11935935812185-git-send-email-prohaska@zib.de>
	<11935935822846-git-send-email-prohaska@zib.de>
	<11935935821136-git-send-email-prohaska@zib.de>
	<11935935823045-git-send-email-prohaska@zib.de>
	<11935935821800-git-send-email-prohaska@zib.de>
	<11935935823496-git-send-email-prohaska@zib.de>
	<11935935821192-git-send-email-prohaska@zib.de>
	<7vfxztm2dx.fsf@gitster.siamese.dyndns.org>
	<52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 20:20:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImwdP-0008QX-C2
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 20:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbXJ3TTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 15:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbXJ3TTk
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 15:19:40 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:53604 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbXJ3TTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 15:19:39 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 79C7D2F9;
	Tue, 30 Oct 2007 15:19:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id AE79D9060C;
	Tue, 30 Oct 2007 15:19:55 -0400 (EDT)
In-Reply-To: <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> (Steffen Prohaska's
	message of "Tue, 30 Oct 2007 11:15:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62737>

Steffen Prohaska <prohaska@zib.de> writes:

> On Oct 30, 2007, at 9:29 AM, Junio C Hamano wrote:
>
>> It simply is insane to make this strange rule 10/10 introduces
>> the default behaviour.  It is too specific to a particular
>> workflow (that is, working with a shared central repository,
>> having many locally tracking branches that are not often used
>> and become stale, and working on only things to completion
>> between pushes).
>
> I don't think its very strange behaviour if you see it in the
> light of what the user wants to achieve. We are talking about
> the case were only fast forward pushes are allowed. So, we
> only talk about a push that has the goal of adding new local
> changes to the remote. The user says "git push" and means
> push my new local changes to the remote.

If you want to push a specific subset of branches, you should
not be invoking the "matching refs" to begin with.  And breaking
the "matching refs" behaviour is not the way to fix it.

You can rewind a wrong branch by mistake locally and run push.
With your change you would not notice that mistake.

        $ git checkout bar
        $ work work work; commit commit commit
	$ git checkout test
        $ git merge bar
	... integrate, build, test
        ... notice that the tip commit of bar is not ready
        $ git checkout foo ;# oops, mistake
        $ git reset --hard HEAD^
	$ git push

If you checked out foo instead of bar by mistake at the last
"git checkout" step like this, your change will make 'foo' an
ancestor of the other side of the connection, and push silently
ignores it instead of failing.

Also, the behaviour is too specific to your workflow of working
on things only to completion between pushes.  If you work a bit
on branch 'foo' (but not complete), and work much on branch
'bar', 'baz', and 'boo' making all of them ready to be
published, you cannot say "git push" anyway.  Instead you have
to say "git push $remote bar baz boo".

This discourages people from making commits that are not ready
to be published, which is a very wrong thing to do, as a major
selling point of distributed revision control is the
dissociation between committing and publishing.

You work and commit freely, and at any point some of your
branches are ready to be published while some others
aren't. Inconvenience of "matching refs" may need to be worked
around.  I liked your "current branch only", with "git push
$remote HEAD" (I presume that "remote.$remote.push = HEAD" and
"branch.$current.remote = $remote" would let you do that with
"git push"), exactly because the way it specifies which branch
is to be published is very clearly defined and easy to
understand.  This "matching but only ff" does not have that
attractive clarity.
