From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] Make unpack-tree update removed files before any
 updated files
Date: Sat, 22 Mar 2008 22:49:53 -0700
Message-ID: <7vbq56f0qm.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221028170.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221030380.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221033430.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221038320.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Frank <streamlake@tiscali.it>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 06:50:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdJ6X-0007Me-0H
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 06:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbYCWFuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 01:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbYCWFuG
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 01:50:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYCWFuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 01:50:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E7062FBE;
	Sun, 23 Mar 2008 01:50:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8FF272FBD; Sun, 23 Mar 2008 01:49:58 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77867>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Ok, this one looks - and is, really - trivial, but it's actually the only 
> one in the whole series that I'm even remotely nervous about. First off, 
> it actually does what it does regardless of that "core.ignorecase" 
> variable, but that wouldn't worry me if it wasn't for the fact that I 
> don't remember/understand what the heck that "last_symlink" logic was 
> there for.

last_symlink is just a cached information used by underlying
has_symlink_leading_path() function for optimization.

The motivation behind has_symlink_leading_path() is reasonably well
described in

 - f859c84: Add has_symlink_leading_path() function., 2007-05-11,

 - 64cab59: apply: do not get confused by symlinks in the middle,
   2007-05-11, and

 - 16a4c61: read-tree -m -u: avoid getting confused by intermediate
   symlinks., 2007-05-10

The short version is that:

 - sometimes we want to make sure a path a/b/c/d exists (or does not
   exist) in the work tree;

 - however, !lstat("a/b/c/d") is not quite it.  if a/b is a symlink in the
   work tree that points at somewhere that happens to have c/d underneath,
   !lstat() says "yeah, there is", but that one is _different_ from what
   checking out a cache entry a/b/c/d would produce (because in that case
   we will remove a/b symlink, create a/b/ directory and deposit blob b
   there).

 - So we often need to see if a given path has symlink component in the
   leading part in the work tree (e.g. given "a/b/c/d", we would need to
   check if any of "a", "a/b", "a/b/c" is a symlink).

The function has_symlink_leading_path() answers that question, and its
second argument is a buffer to cache "the last work tree path found to be
a symlink", so if you call it with "a/b/c/d" and then with "a/b/c/e" in
the above example situation, the second call can re-use the information
the first call found out, which is "a/b is a symlink".


I do not think your patch breaks the passing around of last_symlink cached
information.  Although the three commits I quoted above are all backed by
real-world breakage cases that they did fix, the issues they deal with are
indeed tricky cases.  Although your patch (the change in 7/7) should not
make any difference to the issues, thinking about them is already making
me feel nervous.
