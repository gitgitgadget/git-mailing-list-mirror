From: Junio C Hamano <gitster@pobox.com>
Subject: Re: is rebase the same as merging every commit?
Date: Thu, 26 Jun 2008 17:51:11 -0700
Message-ID: <7vzlp7n1j4.fsf@gitster.siamese.dyndns.org>
References: <1006.35704952783$1214525911@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "David Jeske" <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 02:52:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC2CP-0006U7-WE
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 02:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbYF0Av3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 20:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbYF0Av3
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 20:51:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbYF0Av2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 20:51:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C761228F0;
	Thu, 26 Jun 2008 20:51:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3B90E228EF; Thu, 26 Jun 2008 20:51:23 -0400 (EDT)
In-Reply-To: <1006.35704952783$1214525911@news.gmane.org> (David Jeske's
 message of "Thu, 26 Jun 2008 23:04:58 -0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2C6DBA78-43E3-11DD-8B7A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86510>

"David Jeske" <jeske@willowmail.com> writes:

> Rebasing is described in the docs I've read as turning this: (sorry for the
> dots)
>
> ..........A---B---C topic
> ........./
> ....D---E---F---G master
>
> Into this:
>
> ...................A'--B'--C' topic
> ................../
> .....D---E---F---G master
>
> If I understand it right (and that's a BIG if), it's the same as doing a merge
> of C into G where every individual commit in the C-line is individually
> committed into the new C' line.
>
> ...........-------------A---B---C
> ........../            /   /   /
> ........./        /---A'--B'--C'  topic
> ......../        /
> ....D---E---F---G - master
>
>
> (1) Is the above model a valid explanation?

I would presume that the resulting trees A' in the second picture and in
the first picture would be the same, so are B' and C'.  But that is only
true when commits between A and C do not have any duplicate with the
development that happened between E and G.

Thinking about it like that is an interesting mental exercise, but it is
not very useful otherwise.

> (2) From the documentation diagrams, it looks like the rebased A' has
> only (G) as a parent, not (A,G). If this is the case, why?  (i.e. not
> connecting those nodes throws away useful information)

You would rebase ONLY WHEN the project as the whole (either "other people
in the project", or "yourself down the road one year from now") is
interested mostly in the progress of 'master' D-E-F-G, and nobody cares
whether you developed your A (or B or C) on top of E or G.  So the answer
is definite "no" --- the line you drew between A and A' is a useless
information.  Nobody cares you did it first on top of E but then you have
redone the patches based on G (because things changed between E and G).

If there were no "rebase", your changes will be integrated into 'master'
branch like this:

          A---B---C
         /         \
    D---E---F---G---M

Rebasing is a way to _help you_ pretend that you did _not_ start working
on an ancient code base that was at E.  You redo your series on top of the
latest and greatest G, the commit that everybody else agrees is the
current state of affairs when he sees your changes for the first time, to
produce a history like this:


    D---E---F---G---A'--B'--C'

Doing so tends to make the history easier to understand, and more
importantly, it reduces mistakes during the integration _and_ distributes
the burden of integration from central point.

If E..G and A..C happen to have conflicting changes, rebasing puts the
burden to rewrite the changes A..C into A'..C', based on the modified base
code G, on _you_ (the person who is rebasing).  Some people do not like
this, as they feel that is an added, unwanted burden.  On the other hand,
if your upstream maintainer is integrating like the above picture to
create a merge 'M', it is more likely that he would make mistakes during
the conflict resolution, than you make incorrect adjustment during your
rebasing to recreate the series A'..C'.  You read what G gives you as the
foundation to build your changes on, determine what got changed since E,
on which you originally based your changes, and adjust your changes to
better integrate on top of G.  After all, A..C is _your code_ and you
understand what it assumes better than anybody else.

If the fact that parallel developments have happened is important, instead
of the second picture like you drew, you will just do the real merge
naturally to create a merge "M" like the picture I drew above.

Your "A' is merge between E and A, B' is merge between A' and B" is not
something anybody is interested in if you are going to rebase.  It is not
interesting because it is not how things happened in the real life at all,
and it is not interesting because it is not simplifying the history for
later analysis nor reducing mistakes during the conflict resolution.
