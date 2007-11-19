From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current branch
Date: Mon, 19 Nov 2007 11:57:02 -0800
Message-ID: <7vy7cum2k1.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site>
	<11954023881802-git-send-email-prohaska@zib.de>
	<119540238994-git-send-email-prohaska@zib.de>
	<7vwssfqb0w.fsf@gitster.siamese.dyndns.org>
	<EA5C3227-12E1-43C4-96E8-43BABF26792B@zib.de>
	<7vejempudf.fsf@gitster.siamese.dyndns.org>
	<53F12F4D-73C5-446E-9A97-9D2D4CA9DF9F@zib.de>
	<7vk5oeocnr.fsf@gitster.siamese.dyndns.org>
	<fhrrbt$lvk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 21:00:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuCkq-0000CO-Ax
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 20:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbXKST5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 14:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbXKST5L
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 14:57:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59072 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbXKST5J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 14:57:09 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5871A2FB;
	Mon, 19 Nov 2007 14:57:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A47779786F;
	Mon, 19 Nov 2007 14:57:26 -0500 (EST)
In-Reply-To: <fhrrbt$lvk$1@ger.gmane.org> (Jakub Narebski's message of "Mon,
	19 Nov 2007 12:17:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Brief recap, to check if I understand things correctly:
>
> 1. If you use "matching" more often, then it should be enough to provide
>    remote.<remotename>.push with refspec or wildcard refspec.

Eh, excuse me, what refspec would you write there?  "matching"
is defined to push the intersection of what we have and what
they have when "git-push" is run.  I do not think there is any
way to write that in remote.$there.push and cast in stone.

With "matching", you can arrange a set of semi-permanent
branches to be shown to others and let others build on, in
either "publishing" or "shared repository" model, while keeping
experimental branches in your private repository, and:

	$ git push $there

will only send what are in "the set of semi-permament branches",
like 'master' and 'maint.  Adding a new branch to that set is
just the matter of a one-shot:

	$ git push $there next

(older git may have choked and asked you to be more explicit by
"next:refs/heads/next").  After you do it once, "matching" will
push 'master', 'maint', 'next' without any additional
configuration.  Removing a branch from the set is also just a
matter of one-shot:

	$ git push $there :next

When you replace 'next' in the above with something that is a
lot short lived, the principle is the same.  I can push a topic
branch (say, jn/gitweb), asking "I have queued your patches but
I am having trouble merging this back to 'master' due to heavy
conflicts; could you do the honors instead?".  While waiting for
you to respond to that request, I may add more commits to that
branch and the "matching" push by me will update what is shown
$there.  Hopefully you would eventually pick it up and merge,
and either push the result back to my 'master' directly or
publish the result elsewhere for me to pull to my 'master'.

After all the interaction is done, the topic branch does not
have to stay $there and can be deleted.  Then 'matching' will
not touch the topic branch anymore, even if I still keep it
privately in my repository.

>    ... If one wants to push only current branch, one
>    would use "git push --current" or "git push <remotename> HEAD".

I think that is the proposal by Steffen (added back CC).

I am wondering if an alternative approach could be simpler.  If
we teach "git-push" to notice when only the refspecs are given
without remotename, and default to branch.$current.remote in
such a case, IOW, make these:

	$ git push HEAD
        $ git push next

push the obvious thing to the default remote, I _think_ we can
achieve the same effect as --current and a bit more.

The latter could be run after I made the 'next' integration
branch into a good shape, switched to 'pu' to merge up other
bits but before finishing that merging yet (it would not help me
personally as I do not work that way --- I push things out only
after I am done with all the public branches --- but it may help
the others).

>    Question: what to do if there is no remote.<remotename>.push? Assume
>    1-1 matching?

One-to-one is what 'matching' does, and the way to trigger it is
not to have a remote.$there.push.
