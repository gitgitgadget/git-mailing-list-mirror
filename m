From: Junio C Hamano <gitster@pobox.com>
Subject: Re: question about conflict resolution across multiple branches
Date: Thu, 19 Mar 2009 13:11:16 -0700
Message-ID: <7viqm58e8r.fsf@gitster.siamese.dyndns.org>
References: <1237483813-sup-5631@entry>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: William Morgan <wmorgan-git@masanjin.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:13:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkObq-0003Va-IR
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 21:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbZCSULY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 16:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbZCSULY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 16:11:24 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbZCSULX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 16:11:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 91A0C7E3A;
	Thu, 19 Mar 2009 16:11:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D1B797E37; Thu,
 19 Mar 2009 16:11:17 -0400 (EDT)
In-Reply-To: <1237483813-sup-5631@entry> (William Morgan's message of "Thu,
 19 Mar 2009 10:56:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1CBA180A-14C2-11DE-86F2-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113821>

William Morgan <wmorgan-git@masanjin.net> writes:

> Sometimes those topic branches are remote branches on someone else's
> repo. What happens when merging a remote topic branch into next creates
> a conflict? Ideally I'd like for the topic branch author to deal with
> resolving the conflict, and leave me to my carefree maintainer existence
> of eating icecream on the couch.

Well, merging, applying and managing the conflicts between contributors is
what the maintainers do.  If you push that to your contributors, you do
not have to exist ;-).

> ... In the no-conflict case, I merge their
> remote branch directly into my local next. But in the case of conflicts,
> it seems like me only way to acquire their resolution is to merge their
> next branch entirely into mine. Is that true?

It is not clear what you mean by 'their next' as the only thing you told
us is "some topic are from elsewhere".  Do you mean the originator of the
topic also keeps an integration branch of his own, something similar to
your 'next'?

If that is the case, I _think_ you can fetch their next and feed the merge
you are interested in to rerere-train.sh (in contrib) before you attempt
the merge yourself.  This is "I _think_" because I never used that script
myself (and it wasn't even accepted to git.git by me---I was away back
then).

> Likewise, what happens when someone sends a patch against master to the
> mailing list, and applying that patch to next creates a conflict? Is
> there any way for them to resolve the conflict, and pass that resolution
> to me?

You can tell the contributor that the area the patch touches is under an
active development that you expect to be ready soon, and ask him to redo
the patch on a specific commit on the topic.

Or you can ask the contributor to do this:

    $ git fetch ;# from you
    $ git checkout origin/master ;# detach to your master
    $ git am the-patch
    $ git merge origin/next ;# this will conflict you cannot resolve
    $ edit to resolve conflicts
    $ git commit ;# the resolution you cannot come up with yourself
    $ git diff origin/next >fixup.patch

and send the fixup.patch to you.  You would do the reverse:

    $ git checkout master
    $ git am the-patch
    $ git checkout next
    $ git merge -s ours master
    $ git apply --index fixup.patch
    $ git commit --amend
    $ git show ;# to review what the fix-up did

Needless to say, you need to be careful when accepting such a fixup
patch.
