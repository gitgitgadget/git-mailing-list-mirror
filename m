From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge driver not called for locally modified files?
Date: Sat, 02 Apr 2016 09:21:38 -0700
Message-ID: <xmqqwpogf0bx.fsf@gitster.mtv.corp.google.com>
References: <56FFD3BD.1060002@svario.it>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
X-From: git-owner@vger.kernel.org Sat Apr 02 18:21:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amOJ0-0000fK-K3
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 18:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbcDBQVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 12:21:42 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751299AbcDBQVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 12:21:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7FEB24F880;
	Sat,  2 Apr 2016 12:21:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fQbvb6+qCje//dygz1JEiBQF8/A=; b=e4gD4f
	Oze10M7+tceU5EyUHzU2J53YEl4rhsIsVFHIfpiZsvDWoc8Vi9MDkRrh4P6toJLs
	uxljIGZr4hIz9pcaDCoXu6IYgoRzpl7c8Q3oOmFVOnNcf4b/1LrFa7E9pwUtPkNK
	PeyE2Ge/oHQbv4vPVW9kqqoadhZej5jJND6UU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZThA0PJ5OzhWFdiqonfbNIdF++qboq+
	cyo+kP0m2QSp1iQyc+qw6CvC2mLQzUuOKowbmmr08ojedltNr0OVwGK0Pv+pqyYJ
	u4rdkFzHpBLeZtaGH9YFuEvCLQiMoNgbC+yW2kpDssb2N9avqURSN/IKNtEGZFh3
	Sgoi+HFXSvQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77D354F87F;
	Sat,  2 Apr 2016 12:21:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DFCD64F87E;
	Sat,  2 Apr 2016 12:21:39 -0400 (EDT)
In-Reply-To: <56FFD3BD.1060002@svario.it> (Gioele Barabucci's message of "Sat,
	2 Apr 2016 16:14:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FADC41D6-F8EE-11E5-AA37-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290595>

Gioele Barabucci <gioele@svario.it> writes:

> it seems to me that merge drivers are not called while merging commits
> that touch locally modified (but uncommited) files. Is this correct?

Yes.  "git merge" first notices this situation and stops before it
has to decide which merge driver to use.

When you try to merge commit 'B' when you are at commit 'A', and
have some local changes, and these two branches were forked from a
common ancestor 'X', the history may look like this:

                1
               /
        X--o--A
         \
          --o--B

where '1' is a hypothetical commit that would result if you were to
make a commit with all your local changes, i.e. diff(1,A) is your
uncommitted changes.  As usual, time flows from left to right.

When you merge branch 'B' into your history, you would want to end
up with this history (tentatively ignoring what is in the working
tree):

        X--o--A--M
         \      /
          --o--B

where 'M' is the merge between 'A' and 'B', and the change diff(M,A)
must represent what happened between 'X' and 'B' that did not happen
between 'X' and 'A'.  When A and B are independent and without
conflict, that is roughly the same as diff(B,X), in other words, M
is roughly the same as patch(A,diff(B,X)).

As you haven't committed your local changes, diff(1,A) must not
participate in computing the result M of this merge.  After this
merge is done, the blob in M is checked out to the working tree, but
doing so by overwriting the working tree files would lose your local
changes, and that is the reason why you see this error message:

>     error: Your local changes to the following files would
>     be overwritten by merge:
> 	.local/share/pw/passwords
>     Please, commit your changes or stash them before you can merge.

What you would want at the very end with is like this:

                1  2
               /  /
        X--o--A--M
         \      /
          --o--B

where '2' is a hypothetical commit that would result if you were to
cherry pick '1' on top of 'M', after making 'M' according to
thediscussion above (i.e. ignoring the local changes you made since
'A').  But just like you did not have '1' because you were not ready
to record your changes based on 'A' as a commit, you are not ready
to actually make this commit '2', so you would want your head to be
at 'M' and the state of '2' in your working tree, leaving diff(2,M)
as the local uncommitted change.

However.

"git merge" does not do the "create the hypothetical commit '1'" to
store away the local changes, and it does not do the "cherry pick
'1' to create the hypothetical commit '2'" to forward-port the local
changes on top of the merge result 'M'.

This is primarily because there are two distinct steps in the above
hypothetifcal "enhanced" merge.  Creating 'M' may conflict and you
would have to resolve it, while "git merge" somehow need to remember
it has to further do the "cherry pick of '1'" on the result (but
there is no facility to do so in the system).  And after you resolve
the conflict to help it create the merge result 'M', it has to
somehow remember that it needs to "cherry-pick --no-commit '1'", and
have the user resolve the conflict.  As the presence of '1' is not
made explicit to the user (we do not even create '1'), when the
latter step of patch(M,diff(1,A)) fails in conflicts, it is hard for
the user to attempt to resolve them starting from scratch, which
likely leads to "I lost the local change" when in fact it is more
like "I had some local change, but because the merge result was
vastly different from what I had when I started the local change, I
was unable to forward-port them and instead I had to redo it from
scratch".  It is not a good user experience.

> Is it possible to configure git so that the merge driver is called also
> while merging locally modified files?

No.  But you _can_ do that

                1  2
               /  /
        X--o--A--M
         \      /
          --o--B

thing manually, by following the advice you received from the error
message, by creating '1' yourself.

	$ git merge 78d4f09 ;# should fail

        $ git checkout -b store-local-changes-away
        $ git commit -a -m 'local changes'
        $ git checkout @{-1} ;# come back to the original branch
			      # at this point, "git status" would report
			      # there is no local changes, hence ...

        $ git merge 78d4f09   ;# ...this should succeed

	$ git cherry-pick --no-commit store-local-changes-away

The last step may conflict (this is what I called 'the latter step'
in the explanation) but at least you have the exact state of '1'
recorded and you know what branch (i.e. store-local-changes-away)
contains the changes, so you can resolve the conflicts in your
working tree without fearing "git reset --hard" to clear the slate
in order to start and retry the conflict resolution from scratch
losing your precious local modification.

And after you are done, you can

	$ git branch -D store-local-changes-away

to conclude the whole thing.

You could simplify this somewhat by using "git stash save" before
you run the merge and "git stash pop" after, but because using real
commit and branch to store the local changes away is easier to see
and understand, that is what the error message you saw suggests.
