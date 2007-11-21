From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] When re-initializing, set shared permissions on all directories.
Date: Tue, 20 Nov 2007 22:45:17 -0800
Message-ID: <7vk5ochzb6.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711202045140.4046@ybpnyubfg.ybpnyqbznva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Jensen <jon@endpoint.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 07:45:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujLE-0003hz-04
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 07:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbXKUGp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 01:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbXKUGp0
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 01:45:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44141 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbXKUGpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 01:45:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2236F2EF;
	Wed, 21 Nov 2007 01:45:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 798B09615C;
	Wed, 21 Nov 2007 01:45:41 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711202045140.4046@ybpnyubfg.ybpnyqbznva> (Jon
	Jensen's message of "Tue, 20 Nov 2007 20:48:58 -0700 (MST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65599>

Jon Jensen <jon@endpoint.com> writes:

> Below is a small patch to make git-init --shared change permissions
> not just of .git/refs/ but of the other directories too.

Those existing calls to adjust_shared_perm() are not about
changing permissions for existing directories, but are meant to
change the ones we _create_ under the user's umask() during the
initialization.

As you said, your change does not go far enough and you have to
tell the users to run "chmod" (and "chgrp") anyway.  If we were
to update init-db, then it would need to do the recursive chmod
and chgrp itself.

However, the user need to do recursive chmod and chgrp to
correct earlier screwups and to adjust to the new reality anyway
(see below), and doing so using vanilla filesystem tools is
often easier.  It might be better to train them early how to do
so, instead of making git-init a specialized command that knows
how to run chmod and chgrp in $GIT_DIR, as one of the major
strength of git comes from the fact that its implementation is
transparent.  People who can read or write under $GIT_DIR can
access or build on the history --- it's just that simple.
Exposing users to the filesystem enhances that transparency.

Two reasons for correcting an initial screw-up, and two reasons
for adjusting the new reality are:

 (A) making a non-shared repository to a shared one; you need

     $ find .git -type d -print | xargs chmod g+rwxs
     $ find .git -type f -print | xargs chmod g+rX

 (B) the same as above but the repository is owned by your
     personal group, not project; you further need

     $ chgrp -R projectgroup .git

 (C) an already shared project repository is transferred to a
     new group; you need

     $ chgrp -R newprojectgroup .git

 (D) a shared repository is turned back to a private one; you
     may need (if you are paranoid and do not want them to be
     read):

     $ find .git -type d -print | xargs chmod go=
     $ find .git -type f -print | xargs chmod go=

    or (if you only want to refuse writing)

     $ find .git -type d -print | xargs chmod g-w
     $ find .git -type f -print | xargs chmod g-w

Of course the above assumes that your umask is at most 077 (iow,
you did not forbid any access to yourself).

So I'd suggest us to do this in three steps:

 Step #1. Documentation.

   (1) How to transform a personal, non-shared project to a shared
       one;

   (2) How to transfer a shared project from one group to another;

   (3) How to transform a shared project to a non-shared,
       private one (two variants);

   I think your documentation patch is a good start, but notice
   the differences from the above (A)-(D).

 Step #2. Teach "git-init --shared" to do (1),

 Step #3. Discuss if we want to teach the "re-initialization"
          mode of git-init to do (2) and (3) as well, and if so,
          design and code it.  We'd need new options to name the
          desired group and such so it would involve an
          interface change.

Personally, I suspect that we do not need to go any further than
Step #1 above, but people who like "magic" may disagree.  Don't
take my suspicion as a rejection.
