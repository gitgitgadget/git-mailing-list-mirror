From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] send-pack: close demux pipe before finishing async
 process
Date: Tue, 19 Apr 2016 18:45:17 -0400
Message-ID: <20160419224517.GA18255@sigill.intra.peff.net>
References: <20160419223945.GA18055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:45:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aseOc-0006sg-Cl
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 00:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbcDSWpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 18:45:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:52436 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752129AbcDSWpU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 18:45:20 -0400
Received: (qmail 27554 invoked by uid 102); 19 Apr 2016 22:45:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 18:45:20 -0400
Received: (qmail 20879 invoked by uid 107); 19 Apr 2016 22:45:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 18:45:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 18:45:17 -0400
Content-Disposition: inline
In-Reply-To: <20160419223945.GA18055@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291942>

This fixes a deadlock on the client side when pushing a
large number of refs from a corrupted repo.  There's a
reproduction script below, but let's start with a
human-readable explanation.

The client side of a push goes something like this:

  1. Start an async process to demux sideband coming from
     the server.

  2. Run pack-objects to send the actual pack, and wait for
     its status via finish_command().

  3. If pack-objects failed, abort immediately.

  4. If pack-objects succeeded, read the per-ref status from
     the server, which is actually coming over a pipe from
     the demux process started in step 1.

We run finish_async() to wait for and clean up the demux
process in two places. In step 3, if we see an error, we
want it to end early. And after step 4, it should be done
writing any data and we are just cleaning it up.

Let's focus on the error case first. We hand the output
descriptor to the server over to pack-objects. So by the
time it has returned an error to us, it has closed the
descriptor and the server has gotten EOF. The server will
mark all refs as failed with "unpacker error" and send us
back the status for each (followed by EOF).

This status goes to the demuxer thread, which relays it over
a pipe to the main thread. But the main thread never even
tries reading the status. It's trying to bail because of the
pack-objects error, and is waiting for the demuxer thread to
finish. If there are a small number of refs, that's OK; the
demuxer thread writes into the pipe buffer, sees EOF from
the server, and quits. But if there are a large number of
refs, it may block on write() back to the main thread,
leading to a deadlock (the main thread is waiting for the
demuxer to finish, the demuxer is waiting for the main
thread to read).

We can break this deadlock by closing the pipe between the
demuxer and the main thread before calling finish_async().
Then the demuxer gets a write() error and exits.

The non-error case usually just works, because we will have
read all of the data from the other side. We do close
demux.out already, but we only do so _after_ calling
finish_async(). This is OK because there shouldn't be any
more data coming from the server. But technically we've only
read to a flush packet, and a broken or malicious server
could be sending more cruft. In such a case, we would hit
the same deadlock. Closing the pipe first doesn't affect the
normal case, and means that for a cruft-sending server,
we'll notice a write() error rather than deadlocking.

Note that when write() sees this error, we'll actually
deliver SIGPIPE to the thread, which will take down the
whole process (unless we're compiled with NO_PTHREADS). This
isn't ideal, but it's an improvement over the status quo,
which is deadlocking. And SIGPIPE handling in async threads
is a bigger problem that we can deal with separately.

A simple reproduction for the error case is below. It's
technically racy (we could exit the main process and take
down the async thread with us before it even reads the
status), though in practice it seems to fail pretty
consistently.

    git init repo &&
    cd repo &&

    # make some commits; we need two so we can simulate corruption
    # in the history later.
    git commit --allow-empty -m one &&
    one=$(git rev-parse HEAD) &&
    git commit --allow-empty -m two &&
    two=$(git rev-parse HEAD) &&

    # now make a ton of refs; our goal here is to overflow the pipe buffer
    # when reporting the ref status, which will cause the demuxer to block
    # on write()
    for i in $(seq 20000); do
    	echo "create refs/heads/this-is-a-really-long-branch-name-$i $two"
    done |
    git update-ref --stdin &&

    # now make a corruption in the history such that pack-objects will fail
    rm -vf .git/objects/$(echo $one | sed 's}..}&/}') &&

    # and then push the result
    git init --bare dst.git &&
    git push --mirror dst.git

Signed-off-by: Jeff King <peff@peff.net>
---
Even though the SIGPIPE isn't great, it's certainly better
than a deadlock.  So if we had to take just this one for
"maint" (e.g., because the SIGPIPE stuff causes problems on
Windows), I think it's still worth doing (and is why I stuck
this patch at the front of the series).

One alternative would be to add async_cancel() which would
run pthread_cancel() for the threaded case, and kill() for
the non-threaded. That helps the error case, but makes the
non-error case a bit weird (if the thread _isn't_ blocking
on write to us, we want to get the real status code, rather
than canceling it. But we don't have any way of knowing
which of _cancel() or finish() to call).

 send-pack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 047bd18..fc27db6 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -531,8 +531,10 @@ int send_pack(struct send_pack_args *args,
 				close(out);
 			if (git_connection_is_socket(conn))
 				shutdown(fd[0], SHUT_WR);
-			if (use_sideband)
+			if (use_sideband) {
+				close(demux.out);
 				finish_async(&demux);
+			}
 			fd[1] = -1;
 			return -1;
 		}
@@ -551,11 +553,11 @@ int send_pack(struct send_pack_args *args,
 		packet_flush(out);
 
 	if (use_sideband && cmds_sent) {
+		close(demux.out);
 		if (finish_async(&demux)) {
 			error("error in sideband demultiplexer");
 			ret = -1;
 		}
-		close(demux.out);
 	}
 
 	if (ret < 0)
-- 
2.8.1.512.g4e0a533
