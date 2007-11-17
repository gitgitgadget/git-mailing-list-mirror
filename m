From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] fetch-pack: Prepare for a side-band demultiplexer in a thread.
Date: Sat, 17 Nov 2007 23:09:28 +0100
Message-ID: <200711172309.28364.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 23:09:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItVrP-0000sX-1b
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 23:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbXKQWJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 17:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbXKQWJc
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 17:09:32 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:48836 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbXKQWJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 17:09:31 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id EA82013BCC2;
	Sat, 17 Nov 2007 23:09:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 95AFB59466;
	Sat, 17 Nov 2007 23:09:28 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65316>

get_pack() receives a pair of file descriptors that communicate with
upload-pack at the remote end. In order to support the case where the
side-band demultiplexer runs in a thread, and, hence, in the same process
as the main routine, we must not close the readable file descriptor early.

The handling of the readable fd is changed in the case where upload-pack
supports side-band communication: The old code closed the fd after it was
inherited to the side-band demultiplexer process. Now we do not close it.
The caller (do_fetch_pack) will close it later anyway. The demultiplexer
is the only reader, it does not matter that the fd remains open in the
main process as well as in unpack-objects/index-pack, which inherits it.

The writable fd is not needed in get_pack(), hence, the old code closed
the fd. For symmetry with the readable fd, we now do not close it; the
caller (do_fetch_pack) will close it later anyway. Therefore, the new
behavior is that the channel now remains open during the entire
conversation, but this has no ill effects because upload-pack does not read
from it once it has begun to send the pack data. For the same reason it
does not matter that the writable fd is now inherited to the demultiplexer
and unpack-objects/index-pack processes.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
	This change again originates from the MinGW port. Since we don't
	have fork(2) on Windows, we must run the sideband demultiplexer
	in a thread.

	-- Hannes

 builtin-fetch-pack.c |   42 ++++++++++++++++--------------------------
 1 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index bb1742f..807fa93 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -462,34 +462,12 @@ static int sideband_demux(int fd, void *data)
 {
 	int *xd = data;
 
-	close(xd[1]);
 	return recv_sideband("fetch-pack", xd[0], fd, 2);
 }
 
-static void setup_sideband(int fd[2], int xd[2], struct async *demux)
-{
-	if (!use_sideband) {
-		fd[0] = xd[0];
-		fd[1] = xd[1];
-		return;
-	}
-	/* xd[] is talking with upload-pack; subprocess reads from
-	 * xd[0], spits out band#2 to stderr, and feeds us band#1
-	 * through demux->out.
-	 */
-	demux->proc = sideband_demux;
-	demux->data = xd;
-	if (start_async(demux))
-		die("fetch-pack: unable to fork off sideband demultiplexer");
-	close(xd[0]);
-	fd[0] = demux->out;
-	fd[1] = xd[1];
-}
-
 static int get_pack(int xd[2], char **pack_lockfile)
 {
 	struct async demux;
-	int fd[2];
 	const char *argv[20];
 	char keep_arg[256];
 	char hdr_arg[256];
@@ -497,7 +475,20 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	int do_keep = args.keep_pack;
 	struct child_process cmd;
 
-	setup_sideband(fd, xd, &demux);
+	memset(&demux, 0, sizeof(demux));
+	if (use_sideband) {
+		/* xd[] is talking with upload-pack; subprocess reads from
+		 * xd[0], spits out band#2 to stderr, and feeds us band#1
+		 * through demux->out.
+		 */
+		demux.proc = sideband_demux;
+		demux.data = xd;
+		if (start_async(&demux))
+			die("fetch-pack: unable to fork off sideband"
+			    " demultiplexer");
+	}
+	else
+		demux.out = xd[0];
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.argv = argv;
@@ -506,7 +497,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	if (!args.keep_pack && unpack_limit) {
 		struct pack_header header;
 
-		if (read_pack_header(fd[0], &header))
+		if (read_pack_header(demux.out, &header))
 			die("protocol error: bad pack header");
 		snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%u,%u",
 			 ntohl(header.hdr_version), ntohl(header.hdr_entries));
@@ -542,11 +533,10 @@ static int get_pack(int xd[2], char **pack_lockfile)
 		*av++ = hdr_arg;
 	*av++ = NULL;
 
-	cmd.in = fd[0];
+	cmd.in = demux.out;
 	cmd.git_cmd = 1;
 	if (start_command(&cmd))
 		die("fetch-pack: unable to fork off %s", argv[0]);
-	close(fd[1]);
 	if (do_keep && pack_lockfile)
 		*pack_lockfile = index_pack_lockfile(cmd.out);
 
-- 
1.5.3.5.721.g039b-dirty
