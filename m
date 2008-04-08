From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bisect on multiple cores
Date: Tue, 08 Apr 2008 11:50:51 -0700
Message-ID: <7vhcecmb90.fsf@gitster.siamese.dyndns.org>
References: <dbbf25900804080358o6b1ada20pfb94f68f06a23f83@mail.gmail.com>
 <ee77f5c20804080550h251918d6n73d73a1de8ec6c09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "A B" <gentosaker@gmail.com>, git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 20:52:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjIvB-0007O0-Ao
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 20:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbYDHSvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 14:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbYDHSvI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 14:51:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbYDHSvH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 14:51:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BAF1210DBC;
	Tue,  8 Apr 2008 14:51:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 92BBD10DBA; Tue,  8 Apr 2008 14:51:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79015>

"David Symonds" <dsymonds@gmail.com> writes:

> Git is used to track more than just source code that can be "built",
> and git bisect can be used for more than just tracking down bugs.
>
> I'm not convinced the considerable extra complexity would be
> worthwhile. You'd have to have git bisect do checkouts to new
> temporary directories, track them and clean them up.

I personally think "git bisect" Porcelain does a bit too much.  For
example, it always checks the revision out, but some non-build checks can
be done without having a checkout.

The core idea of bisect, which is really about how to effectively use "git
rev-list --bisect", is quite simple.  You start by one bad and zero or
more "good" ones, where the "bad" one is a descendant of the good ones,
and hunt for a _single_ change that changed a "good" state into a "bad"
one.

This last point is important.  The only thing "bisect" can find is a
single flip where all of its ancestors are "good" and where all of its
descendants are "bad".  Think of a bad gene introduced by a mutation at a
particular commit (i.e. "generation") and that contaminates all of its
children and descendants forever.

If you visualize the commit ancestry graph growing from left to right like
we usually draw in our documentation and e-mails, and if you paint
known-to-be-good ones blue, known-to-be-bad ones red, and unknown ones
yellow, you will get a picture not unlike the ones shown on pp.111-115 of 
http://userweb.kernel.org/~junio/200607-ols.pdf

The underlying "git rev-list --bisect" takes a set of "good" commits and a
single "bad" commit, computes the set of commits that are unknown
("yellow"), and gives one of them that lies halfway from "good" ones
("blue") and the "bad" one ("red").

The way "git bisect" operates is:

 (0) Prime the process by getting a single "bad" and zero or more "good";
     switch to "bisect" branch.

 (1) Ask "rev-list --bisect" the midpoint; check out that revision for you
     to test.

 (2) It's your turn to give more information to "git bisect".

 (2-a) If you say "good", it is added to the set of "good"; go back to (1)

 (2-b) If you say "bad", it is set to "bad" (because of the way bisection
       works, this is always an ancestor of the previous "bad", and
       because the only thing we do is to find a single flip, keeping a
       single "bad" that is an ancestor of all the commits previously
       known-to-be-bad is sufficient); go back to (1)

One thing to note is that in (2-a) or (2-b), you do not necessarily have
to say the commit the command gave you in step (1) is good or bad.  If the
revision given by (1) is untestable, you can reset to another yellow one,
test that, and tell the command "This is good/bad".

So one way to speed up your bisection process would be:

 * Have multiple work trees (e.g. contrib/workdir/git-new-workdir);

 * Run bisect in one repository;

 * In step (1) of each round, look at gitk output and pick another commit
   that is distant from the one you are going to test.  In another work
   tree, check that one out and test it in parallel.

 * You can feed the good/bad information you obtained from the test you
   run in the neighbouring work tree, in addition to what you learn in
   your main tree, with "git bisect good $it" or "git bisect bad $it".

> It might be interesting if you approached it as a tri-section or a
> general N-section where you try to divide the interval into N parts
> and concurrently test N-1 commits. But really, do you find git bisect
> all that slow in practice? You probably have a reasonable guess as to
> where a regression has come in, and so even 1000 revisions needs at
> most 10 bisections to find the culprit.

I think adding N-section to "rev-list --bisect" would generally be an
interesting thing to do.  For one thing, it would allow you to automate
the step to "pick another commit that is distant from the one you are
going to test" in the above sequence.
