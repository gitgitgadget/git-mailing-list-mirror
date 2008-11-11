From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9 v4] bisect: add "git bisect replace" subcommand
Date: Tue, 11 Nov 2008 15:23:27 -0800
Message-ID: <7v8wrpyhhs.fsf@gitster.siamese.dyndns.org>
References: <20081111063904.7da4df94.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 00:25:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L02bb-00068Z-KG
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 00:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbYKKXXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 18:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbYKKXXw
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 18:23:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbYKKXXw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 18:23:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 275547BCA9;
	Tue, 11 Nov 2008 18:23:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A686F7BCA8; Tue,
 11 Nov 2008 18:23:34 -0500 (EST)
In-Reply-To: <20081111063904.7da4df94.chriscool@tuxfamily.org> (Christian
 Couder's message of "Tue, 11 Nov 2008 06:39:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CABC3ADA-B047-11DD-AC8B-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100692>

Christian Couder <chriscool@tuxfamily.org> writes:

> This subcommand should be used when you have a branch or a part of a
> branch that isn't easily bisectable because of a bug that has been
> fixed latter.

While I acknowledge your effort to make bisect easier to use, I do
not think this is going in the right direction, from the point of view of
the workflow.

I do agree that the issue it tries to solve is a problem in real life.
When you want to hunt for a bug, it is certainly possible that your tests
fail for a bug that is unrelated to what you are hunting for for a range
of commits.  Borrowing from your picture:

    ...--O--A--X1--X2--...--Xn--B--...

non of the commit marked as Xi may not be testable.

But at that point, will you really spend time to rebuild history between A
and B by fixing an unrelated bug that hinders your bisect, so that you can
have a parallel history that is bisectable?  I doubt anybody would.

Even if we assume that somebody wants to adopt the workflow to first fix
an unrelated bug (that may be totally uninteresting for the purpose of
solving the original issue he set out to figure out) to rewrite the
history, what he first needs to do is to find out what part of the history
to rewrite.  IOW, he needs to know A and B (and in general, the history is
not even linear).  Maybe he guesses what A and B is.  But for one thing,
after making the guess, he would certainly test A and B to see if the
original issue exists at these commits.  The sequence of commits Xi become
irrelevant if A turns out to be bad or B turns out to be good.

And if A is good and B is bad, then the _original bug_ is in the very
sequence of Xi you are going to rewrite.  By the time you made a rewritten
history with sequence of commits Yi to be grafted like this:


         C--Y1--Y2--...--Yn
       /
 ...--O--A--X1--X2--...--Xn--B--...

to make it bisectable, it is very likely that you would have already seen
the original bug.

In such a case where you need to figure out what an unrelated bug is, and
which commit A and B are involved while bisecting, I think you are much
better off using bisect skip, as Johannes mentioned earlier.

On the other hand, if you already have a well-known bug that was
introduced at A whose fix at B is also very well-known, you would not even
need a separate "bisect replace" command nor replace_parents() machinery
only for the purpose of bisection, would you?  In such a case I think you
can just use a usual graft.


I have a separate idea make 'grafts' easier on object transfer, that is
somewhat related to this one, by the way.  Instead of making the grafts
completely a local matter as we do now, we can reserve refs/replace/
namespace, and record a new commit object to replace an existing commit
whose object name is $sha1 as refs/replace/$sha1.  We make almost all the
commands except object enumeration (fsck, receive-pack, send-pack, prune,
etc.  Roughly speaking, anything that involves "rev-list --objects") honor
this commit replacement, so that any time you ask for commit $sha1, the
object layer gives you the replacement commit object back.  In this way,
you can clone or fetch from such a repository (along with refs in
refs/replace/ hierarchy) and fsck/prune won't lose the original parents
(because it does not see replacements).  Things like paranoid update hook
needs to become very careful about refs/replace/ for security reasons, but
I think this would make the grafts much easier to use.
