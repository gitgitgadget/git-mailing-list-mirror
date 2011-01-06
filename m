From: Jeff King <peff@peff.net>
Subject: Re: Concurrent pushes updating the same ref
Date: Thu, 6 Jan 2011 11:30:35 -0500
Message-ID: <20110106163035.GA7812@sigill.intra.peff.net>
References: <4D25E3DE.7050801@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 17:31:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pask5-0003dT-Uf
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 17:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab1AFQam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 11:30:42 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43058 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811Ab1AFQal (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 11:30:41 -0500
Received: (qmail 6584 invoked by uid 111); 6 Jan 2011 16:30:38 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 06 Jan 2011 16:30:38 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Jan 2011 11:30:35 -0500
Content-Disposition: inline
In-Reply-To: <4D25E3DE.7050801@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164638>

On Thu, Jan 06, 2011 at 10:46:38AM -0500, Marc Branchaud wrote:

> fatal: Unable to create
> '/usr/xiplink/git/public/Main.git/refs/builds/3.3.0-3.lock': File exists.
> If no other git process is currently running, this probably means a
> git process crashed in this repository earlier. Make sure no other git
> process is running and remove the file manually to continue.
> fatal: The remote end hung up unexpectedly
> 
> I think the cause is pretty obvious, and in a normal interactive situation
> the solution would be to simply try again.  But in a script trying again
> isn't so straightforward.
> 
> So I'm wondering if there's any sense or desire to make git a little more
> flexible here.  Maybe teach it to wait and try again once or twice when it
> sees a lock file.  I presume that normally a ref lock file should disappear
> pretty quickly, so there shouldn't be a need to wait very long.

Yeah, we probably should try again. The simplest possible (and untested)
patch is below. However, a few caveats:

  1. This patch unconditionally retries for all lock files. Do all
     callers want that? I wonder if there are any exploratory lock
     acquisitions that would rather return immediately than have some
     delay.

  2. The number of tries and sleep time are pulled out of a hat.

  3. Even with retries, I don't know if you will get the behavior you
     want. The lock procedure for refs is:

        1. get the lock
        2. check and remember the sha1
        3. release the lock
        4. do some long-running work (like the actual push)
        5. get the lock
        6. check that the sha1 is the same as the remembered one
        7. update the sha1
        8. release the lock

     Right now you are getting contention on the lock itself. But may
     you not also run afoul of step (6) above? That is, one push updates
     the ref from A to B, then the other one in attempting to go from A
     to B sees that it has already changed to B under our feet and
     complains?

     I can certainly think of a rule around that special case (if we are
     going to B, and it already changed to B, silently leave it alone
     and pretend we wrote it), but I don't know how often that would be
     useful in the real world.

Anyway, patch (for discussion, not inclusion) is below.

diff --git a/lockfile.c b/lockfile.c
index b0d74cd..3329719 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -122,7 +122,7 @@ static char *resolve_symlink(char *p, size_t s)
 }
 
 
-static int lock_file(struct lock_file *lk, const char *path, int flags)
+static int lock_file_single(struct lock_file *lk, const char *path, int flags)
 {
 	if (strlen(path) >= sizeof(lk->filename))
 		return -1;
@@ -155,6 +155,21 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	return lk->fd;
 }
 
+static int lock_file(struct lock_file *lk, const char *path, int flags)
+{
+	int tries;
+	int fd;
+	for (tries = 0; tries < 3; tries++) {
+		fd = lock_file_single(lk, path, flags);
+		if (fd >= 0)
+			return fd;
+		if (errno != EEXIST)
+			return fd;
+		sleep(1);
+	}
+	return fd;
+}
+
 static char *unable_to_lock_message(const char *path, int err)
 {
 	struct strbuf buf = STRBUF_INIT;
