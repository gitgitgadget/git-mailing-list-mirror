From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] fix hang in git push when pack-objects fails
Date: Thu, 31 Mar 2011 14:42:44 -0400
Message-ID: <20110331184243.GA12027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 20:42:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5MpY-0000gr-Js
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 20:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758982Ab1CaSmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 14:42:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60510
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758977Ab1CaSmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 14:42:46 -0400
Received: (qmail 1199 invoked by uid 107); 31 Mar 2011 18:43:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 14:43:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 14:42:44 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170509>

When we push over the git protocol, we spawn a pack-object process.  If
pack-objects dies prematurely (for example, because there is some repo
corruption), we are careful to clean up the sideband demuxer (if it is
being used) with finish_async. However, for an async implementation
which forks (i.e., when we have no pthreads), that means we will
waitpid() for the async process.

Meanwhile, the async sideband demuxer will continue trying to stream
data from the remote repo until it gets EOF.  Depending on what data
pack-objects actually sent, the remote repo may not actually send
anything (e.g., if we sent nothing and it is simply waiting for the
pack).  This leads to deadlock cycle in which send-pack waits on the
demuxer, the demuxer waits on the remote receive-pack, and the remote
receive-pack waits on send-pack to send the pack data.

You can test this by compiling with NO_PTHREADS=1 and running the
following script:

-- >8 --
#!/bin/sh

rm -rf parent child

git init --bare parent &&
git init child &&
cd child &&
git remote add origin ../parent &&
echo content >file &&
git add file &&
git commit -m one &&
git push origin HEAD &&
echo content >>file &&
git add file &&
git commit -m two

sha1=`git rev-parse HEAD:file`
file=`echo $sha1 | sed 's,..,&/,'`
rm -fv .git/objects/$file

git push
-- 8< --

The problem bisects to 38a81b4 (receive-pack: Wrap status reports inside
side-band-64k, 2010-02-05). In fact, at that point in time we didn't use
pthreads at all for async calls on non-win32 platforms, so even people
with pthreads are affected. For example, you can trigger it with
v1.7.0.2 even with pthreads, since we didn't use them for async code
back then.  That state continued until f6b6098 (Enable threaded async
procedures whenever pthreads is available, 2010-03-09), at which point
the problem went away for pthreads users.

So what I did was build a maint series straight on top of 38a81b4,
the source of the bug:

  [1/4]: teach wait_or_whine a "quiet" mode
  [2/4]: finish_async: be quiet when waiting for async process
  [3/4]: run-command: allow aborting async code prematurely
  [4/4]: send-pack: abort sideband demuxer on pack-objects error

The first two are refactoring so that aborting async code does not
produce a stray "child process died with signal 15" message. If they're
too invasive, they can go away and we can live with the extra message.

The third one introduces abort_async, which just kill()s the
forked process for the non-win32 case. For the win32 case, we need to
either:

  1. do nothing. I'm not 100% sure why, but the bug does not manifest
     itself with pthreads. I don't know how it behaves on win32.

  2. do the equivalent of pthread_cancel. This makes more sense to me.
     Even if this particular case doesn't have an issue in the threaded
     case, having a primitive like abort_async actually kill the thread
     is sensible.

So that fixes old versions. To fix newer ones, it needs to be merged
with f6b6098, which has a few conflicts. And then you can apply on top
of that merge:

  [5/4]: run-command: implement abort_async for pthreads

which will again break win32, as the compat wrapper doesn't implement
pthread_cancel.

If it's easier to pull than to recreate the merge, you can find the
first series based on 38a81b4 here:

  git://github.com/peff/git.git jk/maint-push-async-hang

and then the merge, with conflict resolution, and 5/4 on top here:

  git://github.com/peff/git.git jk/maint-push-async-hang-threads

If it's easier, I can also build the fix on top of v1.7.2, which was the
first release with async pthreads, and then we can either call that "old
enough", or I can backport it via cherry-pick to the source.

-Peff
