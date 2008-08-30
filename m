From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] checkout: do not check out unmerged higher stages
 randomly
Date: Sat, 30 Aug 2008 11:02:48 -0700
Message-ID: <7v1w06ido7.fsf@gitster.siamese.dyndns.org>
References: <7vbpzb4i1h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 20:04:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZUnn-0000BS-QJ
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 20:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbYH3SCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 14:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbYH3SCy
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 14:02:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYH3SCy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 14:02:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B7555AEE0;
	Sat, 30 Aug 2008 14:02:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 66AE75AEDF; Sat, 30 Aug 2008 14:02:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DD145D2A-76BD-11DD-B64F-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94398>

Junio C Hamano <gitster@pobox.com> writes:

> During a conflicted merge when you have unmerged stages for a path F in
> the index, if you asked:
>
>     $ git checkout F
>
> we rewrote F as many times as we have stages for it, and the last one
> (typically "theirs") was left in the work tree, without resolving the
> conflict.
>
> This patch fixes it by noticing that a specified pathspec pattern matches
> an unmerged path, and by erroring out.

The patch claims that it is a bugfix, but I have a slight worry that
somebody might be depending on this broken behaviour in their workflow.

    $ git pull
    Conflicts in foo.c (modify/modify)
    .. Eeek, conflicts.  My changes are always crap, and I trust my
    .. upstream more than I trust myself, so I'll take advantage of
    .. the bug to check out "their" version.
    $ git checkout foo.c

In modify/modify case, because we will have stage #3 (state after their
change), that will be the version you will get as the final result of this
broken behaviour of "checkout".

This patch alone will make the above to check out "theirs" an error.  In a
later one in the series, you can still say:

    $ git checkout --theirs foo.c ;# or "git checkout -3 foo.c"

to get the feature back, at the same time you will now be able to say

    $ git checkout --ours foo.c ;# or "git checkout -2 foo.c"

for symmetry (admittably, it is the same thing as "git checkout HEAD
foo.c").

So we _could_ choose to stay backward compatible by leaving this "bug"
unattended without loss of ability to checkout either theirs or ours, even
though without fixing this, you cannot sanely add "git checkout -m foo.c"
feature that comes later in the updated series, which allows you to go
back to the original conflicted state after you (or rerere) messed up the
working tree state.

Thoughts?
