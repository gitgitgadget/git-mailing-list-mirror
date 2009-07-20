From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 0/8] introduce 'git remote add --push' and 'git clone
 --push'
Date: Mon, 20 Jul 2009 15:15:13 -0700
Message-ID: <7vprbvt30u.fsf@alter.siamese.dyndns.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Finn Arne Gangstad <finnag@pvv.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 00:15:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MT18s-0005tz-Dd
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 00:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbZGTWPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 18:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbZGTWPV
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 18:15:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbZGTWPV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 18:15:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A3A1B6D9;
	Mon, 20 Jul 2009 18:15:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B46ADB6D8; Mon, 20 Jul 2009
 18:15:15 -0400 (EDT)
In-Reply-To: <1248112195-3761-1-git-send-email-bonzini@gnu.org> (Paolo
 Bonzini's message of "Mon\, 20 Jul 2009 19\:49\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D0034BB6-757A-11DE-AB57-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123641>

Paolo Bonzini <bonzini@gnu.org> writes:

> I post as an initial RFC the third series in the push.default saga.
> This is on top of origin/next and even then it requires the
> "push --current" patches to be fully functional.  Even without it,
> however, it will create correct configuration.
>
> The series adds --push options to "git remote add" and "git clone".
> These accept a push strategy of the same kind as "push.default",
> and will use it to create push configuration and refspecs.  These
> will then override push.default.

Let's step back a bit.

If I have a local branch X, is it conceivable that if I ever want to push
it out to elsewhere on a regular basis, I would likely to push it to the
same branch at the same remote?

I think the answer to the above question is yes, and partly because that
is because the precondition of the question is qualified with "on a
regular basis".

Now, I regularly push my 'master' to four repositories (k.org, repo.or.cz,
sf.net and sourceforge.jp), and I could be pushing it out to a different
branch at each of these remotes, but we could loosen the above statement
somewhat and still keep the main point.

    If I have a local branch X that want to push it out to another
    repository R on a regular basis, I would very likely to push it to the
    same branch Y at that remote.

Now, how do (X,R) and Y related with each other?  I think there are three
workflows that want different settings (and one is actually a special case
of another one, so essentially there are only two).

 * X tracks Y from R, iow, branch.X.remote = R, branch.X.merge = Y;
   push.default = tracking helps pushing out X when X is the current
   branch, but it does not help pushing all such X out.

 * X is Y; push.default = matching helps pushing all such X out.  This is
   a special case of the above.

 * X tracks Y from R, but there are other X' that also track Y from R and
   pushing all of them is nonsense.  push.default = tracking helps pushing
   X when it is the current branch.  This is the case where you fork your
   topic(s) directly from remote integration branch

Are these all?  What I am trying to get at is if we can tweak the rules
without introducing too much configuration variables to cover all these
cases.

Traditionally, we said:

    $ git push $there $ref

is _always_ a shorthand for

    $ git push $there $ref:$ref

This favors the second case in that if for whatever reason you cannot
afford to push all of them in matching, but as long as your (X,R) -> Y
mapping is X==Y (i.e. matching), then you do not have to say colon to
duplicate refname.  You can say "git push origin master next" to push only
these two without pushing out 'pu', for example.  If we somehow tweak
this "$ref is a shorthand for $ref:$ref" rule to account for the tracking
branch.*.merge gives us, perhaps we can make the push easier to use.

If the conjecture "no matter what your workflow is, (X,R) -> Y is a
function, not a one-to-many-mapping" holds, perhaps we may instead want to
say something like:

 (1) "git push R" pushes out the refs according to remote.R.push refspec
     rules (this is also the same as the current set of rules).  Absense
     of such configured refspec rules used to always trigger "matching"
     rule, but now it can optionally use "tracking" rule for all the local
     branches.

 (2) "git push R $ref" is *NOT* same as "git push R $ref:$ref" anymore.
     Because for a given (R,X) we can say what (R,X) -> Y function yields,
     we should map the given ref to where the user wants to put it.  If X
     tracks Y, "git push R X" should become "git push R X:Y" without any
     funky configuration.

 (3) "git push $ref" used to be illegal, but when it is unambiguous that
     $ref cannot name a remote, we look at branch.$ref.remote = R to find
     that the push is a shorthand for "git push R $ref".  The mapping rules
     of (2) also applies.

 (4) "git push" is a synonym for "git push R" where R is the value of
     branch.X.remote, or "origin" if there is no such configuration.  This
     will in turn trigger rule (1) above.

     We could optionally make it a synonym for "git push X" (where X is
     the name of the current branch), which would invoke rule (3) above,
     which in turn would invoke rule (2) above.  Perhaps "push only the
     current branch" option in the configuration, or "git push HEAD" from
     the command line, would trigger this alternate behaviour.

I think one of the workflows quoted as the original motivation of Finn
Arne's series that added push.default also falls naturally out of this.
When you interact with more than one remote, you may track the 'master'
branch from remote R1 as your local R1-master while tracking the 'master'
branch from remote R2 as your local R2-master.

Then

	$ git push

while on R1-master, with the optional setting of rule (4) above, will be
the same as

	$ git push R1-master

both of which would mean

	$ git push R1 R1-master:master

Also

	$ git push R1

will trigger rule (1) and would push whatever is configured in
remote.R1.push.  Optionally, without remote.R1.push, it can inspect local
branches and find ones that track branches from R1, and push them to
corresponding places (this would match "matching" ref behaviour but with
the renaming expressed by branch.*.merge).

Jut thinking aloud.
