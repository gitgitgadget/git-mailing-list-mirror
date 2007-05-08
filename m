From: Bill Lear <rael@zopyra.com>
Subject: git pull failure, truncated object
Date: Tue, 8 May 2007 09:28:41 -0500
Message-ID: <17984.35097.568689.482933@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 16:29:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlQgY-0005zh-0P
	for gcvg-git@gmane.org; Tue, 08 May 2007 16:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967868AbXEHO24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 10:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967955AbXEHO24
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 10:28:56 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61489 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967868AbXEHO2z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 10:28:55 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l48ESr903552;
	Tue, 8 May 2007 09:28:53 -0500
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46579>

Our QA dude had a disk fill up a while back.  Forgot about it.  Went
to pull during a nightly build.  Got this:

% git pull
remote: Generating pack...
remote: Done counting 104 objects.
remote: Result has 72 objects.
remote: Deltifying 72 objects.
remote:  100% (72/72) done
Unpacking 72 objects
remote: Total 72 (delta 46), reused 52 (delta 26)
error: failed to read delta-pack base object
4b93eb81265ea4f2b436618a4b1c3bea2bedf06d
fatal: unpack-objects died with error code 1

He did a git-gc, twice, and retried.  Still failed.

So, he called me in and we tried to see if the server was acting up
--- perhaps an NFS problem, as we've had those before, but got very
different error messages.  Watched the log file from git-daemon, and
saw nothing.  Finally we took a look at the local repos
.git/objects/4b, and 4b93eb81265ea4f2b436618a4b1c3bea2bedf06d was of
length 0.

So, I looked in the man page of git-gc and thought to try --prune,
as this was not an active repository.  This worked, and then
the pull did as well.

I'm wondering why git-gc did not at least warn us of this problem when
we tried it.  It appeared to us that git-gc gave our repo a clean bill
of health, and so we turned our attention to the remote and
investigated there, instead of continuing in the local repo.

Should we have tried git fsck instead in this case?

It might be nice to have a better error message in this case, one
that locates the problem in the local repo.

If the failure is a short/bad (?) read of a local object, then it
might be nice to say something like:

error: this repo's local object 4b93eb81265ea4f2b436618a4b1c3bea2bedf06d
       in .git/objects/4b is corrupt.  You will need to run
       XXX to diagnose and YYY to repair this.

Or some such.


Bill
