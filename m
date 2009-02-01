From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git clone' doesn't use alternates automatically?
Date: Sat, 31 Jan 2009 16:55:13 -0800
Message-ID: <7vtz7f2cy6.fsf@gitster.siamese.dyndns.org>
References: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com>
 <20090131071238.GC3033@coredump.intra.peff.net>
 <885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 01:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTQdk-0004EZ-PZ
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 01:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbZBAAzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 19:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbZBAAzX
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 19:55:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbZBAAzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 19:55:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E13FA9563B;
	Sat, 31 Jan 2009 19:55:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 78ACB9563A; Sat,
 31 Jan 2009 19:55:14 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FF8A4DFE-EFFA-11DD-B29A-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107956>

James Pickens <jepicken@gmail.com> writes:

> So, is there any reason 'git clone' shouldn't automatically use
> the alternates that it copied into the new repository?

When you say "git clone" without -s, you are saying "I do not want to use
the repository I am cloning from as my alternate, because I do not know if
will stay stable.  I do not trust it."

This would be a very sensible way to clone, if you were cloning my
repository whose 'pu' and its constituent topic branches are subject to
rewinding at any time.  After I rebase some of the branches and rebuild
'pu', and prune the unnecessary objects from my repository, the objects
you may have been borrowing from me will be gone from my repository.  Of
course, I can remove my repository altogether any time, and when that
happens, your repository will have many missing objects.

That is why "-s" is not the default.

Only when you positively know that the other repository will not drop
branches or rewind them, perhaps because you control that repository
yourself, it is safe to use it as your alternate, and you use commands
like "git clone -s" and/or "git clone --reference" to do so.

        Side note. People on k.org are encouraged to use Linus's
        repository as an alternate to save space on the k.org machine,
        because it is known that Linus's repository will never rewind its
        branches.

Now, if you are cloning from a local filesystem, by default we will copy
the objects/info/alternates from the source repository to the new one.  It
may be debatable if this is a sensible thing to do.  On one hand, because
you are saying you don't trust if the objects in the source repository
will stay stable by not giving "-s", it might be sensible not to trust its
choice of alternates either.  But in such a case, you can always use file://
URL when cloning to get a full freestanding copy.

I suspect you are trying to improve the other extreme end: trusting all
the other repositories involved in the cloning process a lot more than the
code currently does.

I do not think it is a bad thing to do per-se.

I haven't looked at the codepaths involved recently, but if I recall
correctly, optimizing of cloning from a repository that uses alternates
itself was never a part of the initial design considerations.  I suspect
there may be an ample room for you to optimize things.
