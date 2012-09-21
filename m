From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] receive-pack: send pack-processing stderr over sideband
Date: Fri, 21 Sep 2012 01:34:55 -0400
Message-ID: <20120921053455.GB9863@sigill.intra.peff.net>
References: <20120921053057.GA9768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 07:35:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEvtL-0002QK-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 07:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab2IUFe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 01:34:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52302 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063Ab2IUFe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 01:34:57 -0400
Received: (qmail 29492 invoked by uid 107); 21 Sep 2012 05:35:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 01:35:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 01:34:55 -0400
Content-Disposition: inline
In-Reply-To: <20120921053057.GA9768@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206107>

Receive-pack invokes either unpack-objects or index-pack to
handle the incoming pack. However, we do not redirect the
stderr of the sub-processes at all, so it is never seen by
the client. From the initial thread adding sideband support,
which is here:

  http://thread.gmane.org/gmane.comp.version-control.git/139471

it is clear that some messages are specifically kept off the
sideband (with the assumption that they are of interest only
to an administrator, not the client). The stderr of the
subprocesses is mentioned in the thread, but it's unclear if
they are included in that group, or were simply forgotten.

However, there are a few good reasons to show them to the
client:

  1. In many cases, they are directly about the incoming
     packfile (e.g., fsck warnings with --strict, corruption
     in the packfile, etc). Without these messages, the
     client just gets "unpacker error" with no extra useful
     diagnosis.

  2. No matter what the cause, we are probably better off
     showing the errors to the client. If the client and the
     server admin are not the same entity, it is probably
     much easier for the client to cut-and-paste the errors
     they see than for the admin to try to dig them out of a
     log and correlate them with a particular session.

  3. Users of the ssh transport typically already see these
     stderr messages, as the remote's stderr is copied
     literally by ssh. This brings other transports (http,
     and push-over-git if you are crazy enough to enable it)
     more in line with ssh. As a bonus for ssh users,
     because the messages are now fed through the sideband
     and printed by the local git, they will have "remote:"
     prepended and be properly interleaved with any local
     output to stderr.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is logically independent of the first patch, but relies
textually on the conversion of unpack-objects to use a separate
child_process.

 builtin/receive-pack.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5ba0c98..ac679ab 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -795,7 +795,7 @@ static const char *pack_lockfile;
 
 static const char *pack_lockfile;
 
-static const char *unpack(void)
+static const char *unpack(int err_fd)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -827,6 +827,7 @@ static const char *unpack(void)
 		memset(&child, 0, sizeof(child));
 		child.argv = unpacker;
 		child.no_stdout = 1;
+		child.err = err_fd;
 		child.git_cmd = 1;
 		code = run_command(&child);
 		if (!code)
@@ -853,6 +854,7 @@ static const char *unpack(void)
 		memset(&ip, 0, sizeof(ip));
 		ip.argv = keeper;
 		ip.out = -1;
+		ip.err = err_fd;
 		ip.git_cmd = 1;
 		status = start_command(&ip);
 		if (status) {
@@ -869,6 +871,26 @@ static const char *unpack(void)
 	}
 }
 
+static const char *unpack_with_sideband(void)
+{
+	struct async muxer;
+	const char *ret;
+
+	if (!use_sideband)
+		return unpack(0);
+
+	memset(&muxer, 0, sizeof(muxer));
+	muxer.proc = copy_to_sideband;
+	muxer.in = -1;
+	if (start_async(&muxer))
+		return NULL;
+
+	ret = unpack(muxer.in);
+
+	finish_async(&muxer);
+	return ret;
+}
+
 static void report(struct command *commands, const char *unpack_status)
 {
 	struct command *cmd;
@@ -966,7 +988,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		const char *unpack_status = NULL;
 
 		if (!delete_only(commands))
-			unpack_status = unpack();
+			unpack_status = unpack_with_sideband();
 		execute_commands(commands, unpack_status);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
-- 
1.7.11.7.15.g085c6bd
