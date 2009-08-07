From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: point to 'git pull' and 'git push --force' in case
 of non-fast forward
Date: Fri, 07 Aug 2009 13:05:44 -0700
Message-ID: <7vd477v17r.fsf@alter.siamese.dyndns.org>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v7hxgk8c9.fsf@alter.siamese.dyndns.org> <vpqvdkzwh3j.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 07 22:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZVhO-0004zV-U7
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 22:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933522AbZHGUFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 16:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933328AbZHGUFt
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 16:05:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S933185AbZHGUFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 16:05:49 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36A841BF3;
	Fri,  7 Aug 2009 16:05:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 742031BF2; Fri,  7 Aug
 2009 16:05:46 -0400 (EDT)
In-Reply-To: <vpqvdkzwh3j.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri\, 07 Aug 2009 21\:37\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B37517F6-838D-11DE-A234-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125215>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> +Alternatively, you can rebase your change between X and B on top of A,
>> +with "git pull --rebase", and push the result back.  The rebase will
>> +create a new commit D that builds the change between X and B on top of
>> +A.
>> +
>> +----------------
>> +
>> +      B   D
>> +     /   /
>> + ---X---A
>> +
>> +----------------
>> +
>> +Again, updating A with this commit will fast-forward and your push will be
>> +accepted.
>
> Maybe add something about --force ? I don't like my wording very much,
> but a first try is this:
>
> Lastly, you can decide that the B shouldn't have existed, and delete
> it. This is to do with a lot of care, not only because it will discard
> the changes introduced in B, but also because if B has been pulled by
> someone else, he will have a view of history inconsistant with the
> original repository. This is done with the --force option.

To be consistent with the flow, I think you are discarding A in the
example, not B.  A is what somebody else pushed out before your failed
attempt of pushing B, and --force will discard A, replacing its history
with yours.

Of course, you also could decide that somebody else's change A is vastly
superior than your crappy B, and you may decide to do "git reset --hard A"
to get rid of your history locally; but you wouldn't be using "git push"
after that.  It is an equally valid outcome in the example situation and
until you fetch to see what A is, you cannot decide.

So, probably the order to teach would be:

 - You can pull to merge, or pull --rebase to rebase; either way, you are
   trying to preserve both histories.  [I've written on this in the
   previous message]

 - But you may realize that the commit by the other (i.e. A) was an
   incorrect solution to the same problem you solved with your B.  You
   _could_ force the push to replace it with B in such a case.  You need
   to tell the person who pushed A (and everybody else who might have
   fetched A and built on top) to discard their history (and rebuild their
   work that was done on top of A on top of B). [This is yours with A <=> B]

 - Alternatively you may realize that the commit by the other (i.e. A) was
   much better solution to the same problem you tried to solve with your
   B.  In such a case, you can simply discard B in your history with "git
   reset --hard A" after fetching.  You wouldn't be pushing anything back
   in this case.

I actually do not think it is appropriate to teach --force in an example
that involves more than one person (iow, in the context of the example in
my patch).  A lot better alternative in such a case is to "git merge -s
ours A" and push the result out, which keeps the fast-forwardness for the
person who did A, and others who pulled and built on top of A already.

So scratch your "lastly", replace it (and the second point in my list
above) with:

 - You may realize that the commit by the other (i.e. A) was an incorrect
   solution to the same problem you solved with your B.  In such a case,
   do _not_ use --force to remove A from the public history.  Instead,
   resolve the merge (in the previous instruction) favoring your solution,
   e.g. "git pull -s ours", and push the result out.
