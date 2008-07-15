From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase.sh: Display error output from git-checkout
 when detaching HEAD fails.
Date: Tue, 15 Jul 2008 08:22:25 -0700
Message-ID: <7vmykj2mvi.fsf@gitster.siamese.dyndns.org>
References: <1215811619-28512-1-git-send-email-robertshearman@gmail.com>
 <7vr6a0hvvu.fsf@gitster.siamese.dyndns.org>
 <1096648c0807141257i76f70322p5a16c86c1c826a66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Rob Shearman" <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 17:23:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KImNI-0000x8-HJ
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946AbYGOPWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 11:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754846AbYGOPWd
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 11:22:33 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbYGOPWb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 11:22:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4DE932D463;
	Tue, 15 Jul 2008 11:22:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AA4222D452; Tue, 15 Jul 2008 11:22:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D7A40652-5281-11DD-B0E9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88567>

"Rob Shearman" <robertshearman@gmail.com> writes:

> 2008/7/11 Junio C Hamano <gitster@pobox.com>:
> ...
>> I think this very much is done deliberately by somebody who knows the
>> shell to discard everything.
>
> Why wasn't "git checkout "$onto^0" &> /dev/null" used then? Then only
> reason I can come up with would be portability,...

Yes, we are quite old fashioned when it comes to shell scripting.

>> ...  Perhaps you can replace the line with
>>
>>        git checkout -q "$onto^0"
>>
>> and be done with it.  I haven't tested it, though.
>
> I just tested it and it solves the original issue whilst not
> displaying unnecessary messages during a rebase. For reference, the
> attached script reproduces the issue that I was trying to solve.
>
> Should I resend the patch (like the following) now that it is
> effectively completely your work?

Your choice.

The issues you might want to consider when making that choice are:

 - Resending something that is trivial may seem waste of time on your
   part;

 - Bringing the issue up is more than half of solving it, and you deserve
   the credit.  By resending with a clear commit log message you assure
   this;

 - I am handling many patches for git.git that are readily applicable
   immediately after I read them in my mbox, while creating a commit out
   of this discussion is something I need to "work on".  When I get around
   to do some git work tonight, I may not even recall this dialogue, and
   the solution may be forgotten.

 - I am lazy and may forget to pass --author="Rob Shearman <your@email>"
   even if I remember this conversation and when I make a commit myself;

I just made a commit out of this discussion before I forget, so no need to
resend for this one, but in general I'd appreciate a resend in general ;-)

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 14 Jul 2008 14:05:35 -0700
Subject: [PATCH] git-rebase: report checkout failure

When detaching the HEAD to the base commit, the "git checkout" command
could fail if, for example, upstream contains a file that would overrwrite
a local, untracked file.  Unconditionally discarding the standard error
stream was done to squelch the progress and notices back when checkout
did not have -q option, but there is no reason to keep doing it anymore.

Noticed by Robert Shearman.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index e2d85ee..7825f88 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -376,9 +376,7 @@ fi
 
 # Detach HEAD and reset the tree
 echo "First, rewinding head to replay your work on top of it..."
-git checkout "$onto^0" >/dev/null 2>&1 ||
-	die "could not detach HEAD"
-# git reset --hard "$onto^0"
+git checkout -q "$onto^0" || die "could not detach HEAD"
 
 # If the $onto is a proper descendant of the tip of the branch, then
 # we just fast forwarded.
-- 
1.5.6.3.473.gc658e
