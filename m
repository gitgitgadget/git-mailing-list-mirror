From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to split a patch
Date: Mon, 28 Jan 2008 02:40:38 -0800
Message-ID: <7vr6g2teqh.fsf@gitster.siamese.dyndns.org>
References: <4d8e3fd30801280105g2876cedfjbe1ba323ede57e0a@mail.gmail.com>
	<7vhcgyuwsx.fsf@gitster.siamese.dyndns.org>
	<4d8e3fd30801280132k59676921h272addab6cac6899@mail.gmail.com>
	<vpqfxwi5ljf.fsf@bauges.imag.fr>
	<7vy7aatfck.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"git mailing list" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jan 28 11:41:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJRQr-00044b-6c
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 11:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921AbYA1Kky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 05:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755630AbYA1Kkx
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 05:40:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756597AbYA1Kkv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 05:40:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A8F8160C;
	Mon, 28 Jan 2008 05:40:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DE15E160A;
	Mon, 28 Jan 2008 05:40:44 -0500 (EST)
In-Reply-To: <7vy7aatfck.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 28 Jan 2008 02:27:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71875>

Junio C Hamano <gitster@pobox.com> writes:

> Yes, and you can do the same with "git add -i".  These tools are
> not quite nice, as they encourage a wrong workflow of committing
> what you haven't had as a whole in the work tree.  By
> definition, you are making untested commits between your base
> commit (that presumably was tested well) and your final commit
> (that would also be tested well).
> ...
> There is no such tool yet, though.
> 
> The splitting you can do with "rebase -i" instead walks
> forwards.  That also lets you test before you make commits in
> each step.

Having said all that, what I tend to do in practice is something
like this:

 (1) Prepare a perfect state (i.e. what to become the final
     commit in the series) in work tree.  Make a commit.  Let's
     say I was working on 'master' branch.

 (2) Checkout the state before the series.  If I currently have
     a three commit series that I want to split further, that
     would be HEAD~3.  If I just made a huge change without
     making intermediate commits, that would be HEAD~1:

     $ git checkout HEAD~3

 (3) Get the final state in the work tree, to decide what to put
     in and what to omit from the first in the series:

     $ git diff -R master | git apply --index

 (4) Use "git-add -i" to prepare what I want in the first
     commit.

     $ git add -i

 (5) When the index is in a good shape, drop all other changes
     from the work tree.  This is what I thought would be a good
     first commit:

     $ git diff -R | git apply

 (6) Test it.  Make corrections.  Perfect it.  Then commit.

     $ git commit

 (7) Go back to step (3), until the commit that I make in step
     (6) matches 'master'.

 (8) Reset 'master' with HEAD:

    $ git branch -f master HEAD
    $ git checkout master
