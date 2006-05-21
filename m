From: Jeff King <peff@peff.net>
Subject: [RFC] send-pack: allow skipping delta when sending pack
Date: Sun, 21 May 2006 01:48:27 -0400
Message-ID: <20060521054827.GA18530@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 21 07:48:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhgnu-0000aZ-Pm
	for gcvg-git@gmane.org; Sun, 21 May 2006 07:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWEUFsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 01:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWEUFsa
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 01:48:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4825 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751483AbWEUFsa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 01:48:30 -0400
Received: (qmail 93931 invoked from network); 21 May 2006 05:48:28 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 21 May 2006 05:48:28 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 May 2006 01:48:27 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20432>

I have a git repo where I keep relatively large files (digital photos).
I have a local repo and a "master" repo on a server which I access over
ssh.  Deltifying a bunch of large images takes a relatively long time. I
can live with this while packing (though it is slightly annoying to have
to pack separately on both repos, I understand why it might be hard to
reuse the deltification).

However, it is extremely annoying to add a large set of images and then
push them to the server. The server is on a 100Mbit LAN, so the
deltification part of the process takes up most of the time (and
typically ends up making no deltas, since the files are unrelated
images). The patch below causes the GIT_NODELTA environment variable to
set the window depth to 0 when sending a pack, preventing deltification.

The result is much better performance in my case. However, the method
seems quite hack-ish, so I wanted to get comments on how this should be
done. Possibilities I considered:
  1. A command line option to git-send-pack. The problem with this is
     that support is required from git-push and cg-push to pass the
     option through.
  2. A repo config variable that says not to deltify on sending (or
     potentially, not to deltify at all, which makes packing in general
     much nicer -- however, I don't think this is a good idea, as I do
     still want deltification rarely, it's just that it mostly will
     fail). This should probably be per-remote for the obvious reason
     that one might push to local and remote repos. One drawback is that
     sometimes deltification may be a win; it's just that I sometimes
     know that it won't be (because I added a bunch of unrelated large
     files). It's nice to selectively turn this option on for a given
     push.
  3. Ideally, we could do some heuristic to see if deltification will
     yield helpful results. In particular, we may already have a pack
     with these commits in it (especially if we just repack before a
     push). If we can re-use this information, it at least saves
     deltifying twice (once to pack, once to push). In theory, I would
     think the fact that we don't pass --no-reuse-delta to pack-objects
     means that this would happen automatically, but it clearly doesn't.

Comments?

---

f1cf653120dd492d1c86ee2a92a9c8221023cef1
 send-pack.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

f1cf653120dd492d1c86ee2a92a9c8221023cef1
diff --git a/send-pack.c b/send-pack.c
index 409f188..4ad6489 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -30,8 +30,14 @@ static void exec_pack_objects(void)
 	static const char *args[] = {
 		"pack-objects",
 		"--stdout",
+		NULL,
 		NULL
 	};
+	const char *nodelta;
+
+	nodelta = getenv("GIT_NODELTA");
+	if(nodelta && !strcmp(nodelta, "1"))
+		args[2] = "--depth=0";
 	execv_git_cmd(args);
 	die("git-pack-objects exec failed (%s)", strerror(errno));
 }
-- 
1.3.3.g288c-dirty
