From: Junio C Hamano <gitster@pobox.com>
Subject: Gated Merge?
Date: Thu, 11 Feb 2016 14:06:55 -0800
Message-ID: <xmqqvb5uvr40.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 23:07:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTzOF-0007Kw-Cj
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 23:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbcBKWHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 17:07:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751657AbcBKWHA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 17:07:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 49ACB40669;
	Thu, 11 Feb 2016 17:06:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=h
	Mn86D23wtX6XFbOdBxboERxFKc=; b=PLnp2s20sRPyE+epk62jYFbfDG/3u9cks
	CyMqruHrV05zVkqLhIZEo4lBd9dYrBnSIPC2nUToaOjCm0LtysEFa6x5/q0dL8u1
	kEwdvoeszcslN+aeQnbvylz8j9Pjdm8YCaeZ2ykDr/40W9hcyGlUgcsnk4Lo1tpZ
	Cx8oXigDhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=QNy
	ewKMJV3ylhi4PTArKFryf0k2fjYA9f/aQQeyDvnfFNwZAKUmR/fe9O4xX9je7tZe
	bwpFA5O7FNWdFiNrH2BgpykLv/24clAcmjLYUNcY3DK2/Tjp+HxzboRaWtYErND2
	plspXmAtmyVUS8q9OEzfZmHAsbLelXk+OS3A0w5U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4095C40666;
	Thu, 11 Feb 2016 17:06:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C44A440665;
	Thu, 11 Feb 2016 17:06:56 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C404AD3E-D10B-11E5-8BF7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286007>

I wish there were a way to let me annotate a commit with a statement
like this:

 * When merging a branch that does not have me in it into a trunk
   that already has me, do this extra check on the result of the
   merge before allowing it to be recorded.

For example, suppose there is a topic that changes all instances of
this

	__attribute__((format(printf, X, Y)))

into a new macro FORMAT_PRINTF(X, Y).  With such a facility, I can
annotate the commit at the tip of that series to define an extra
check:

   ! git diff HEAD | grep '^+.*__attribute__((format(printf'

which would prevent me from merging a topic that introduces a new
instance of the printf-format attribute that is spelled in an
old-fashioned way.

In this particular example, it might be even better if the facility
allowed me to declare something like this instead:

 * When merging a branch that does not have me in it into a trunk
   that already has me, do this extra processing on the result of
   the merge before recording it.

The difference between them is the "extra processing" part.  For
this example, it would be something that is built around:

    perl -p -e '
        s{__attribute__\(\(format\(\s*printf,\s*(\d+),\s*(\d+)\)\)\)}
         {FORMAT_PRINTF($1, $2)}gx
    '

to update the old-fashioned one to use the new macro, and the result
would become an evil merge.

To realize this, there are low-hanging-fruit building blocks that
are trivial:

 - Such an annotation can be made as a note attached to the commit
   in question;

 - Such a check can be done in pre-commit hook;

 - Such a pre-commit hook can iterate over this set of commits

    DIFF=$(git rev-list --left-right HEAD...MERGE_HEAD)
    
   collect these Merge Gate annotations from the commit appears on
   the left hand side (e.g. only exists on the trunk that a side
   branch is about to be merged in), and run them.

But the last one feels very costly, and I suspect that there must be
a better way to do this.  I do not think we want the "what to do"
part (i.e. checking new lines for __attribute__ in the first
example, or rewriting new lines that has __attribute_ in the second
example) to be in git-core; that clearly is outside the scope of the
plumbing.  But the part that finds these "annotations", especially
if we can come up with a fast implementation that may be hard to
script, may be a good addition to the plumbing command set.

Thoughts?
