From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/6] Add side-band-64k extension to send-pack/receive-pack for hook output
Date: Thu, 14 Feb 2008 01:23:01 -0500
Message-ID: <20080214062301.GE30516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 07:23:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPXVZ-00034M-6P
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbYBNGXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbYBNGXI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:23:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58469 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbYBNGXG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:23:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPXUt-0003pg-B5
	for git@vger.kernel.org; Thu, 14 Feb 2008 01:23:03 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E158C20FBAE; Thu, 14 Feb 2008 01:23:01 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73854>

The fetch-pack/upload-pack protocol currently uses the side-band-64k
protocol extension to pass the stderr output from the upload-pack
side of the connection down to the fetch-pack side.  This lets the
remote send progress messages from pack-objects down to the user,
so they know the server is working on their behalf and don't just
break a connection off.

In the past we haven't needed this secondary channel during push,
as most users only push over SSH and there is already a multiplexed
stdout and stderr available as part of the native SSH protocol and
client/server implementations.  All output from hooks executed
by receive-pack on the remote side is sent to stderr, which is
automatically routed back to the user's terminal by SSH, completely
bypassing fetch-pack.

In Git 1.5.0 Linus allowed users to enable receive-pack as a service
in git-daemon, which is useful in friendly office LAN situations
where all of the users can be implicitly trusted.  However as
git-daemon runs on a straight TCP/IP channel there is no automated
multiplexing to bring the stderr output from any hooks back to the
push client.

This change adds the sideband multiplexer/demultiplexer and uses
it to wrap the status response from receive-pack into band #1,
which is the standard payload band.  To keep this change smaller
we do not wrap the hook output yet, which should be on band #2,
the standard "stderr/verbose/progress" band.

One of the complexities of arranging the status response data into
band #1 is the use of pkt-line for both the status reponse and for
the sideband multiplexing.  We have to wrap the pkt-lines inside of
another set of pkt-lines (but with the additional band field) to get
the data correctly sent over the wire.  Further when we do actually
flush we now have two flushes; one to end the status and another to
end the multiplexing.  The first flush is actually still part of band

The side-band-64k extension is only enabled if both sides have the
capability, and only if send-pack sent commands to receive-pack
for processing.  This allows both sides to transparently work with
older clients or servers.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-send-pack.c |   37 +++++++++++++++++++++++++++++++------
 pkt-line.c          |   28 +++++++++++++++++++++++++---
 pkt-line.h          |    2 ++
 receive-pack.c      |   17 ++++++++++++-----
 4 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 63fbcd2..5c4844c 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -3,6 +3,7 @@
 #include "tag.h"
 #include "refs.h"
 #include "pkt-line.h"
+#include "sideband.h"
 #include "run-command.h"
 #include "remote.h"
 #include "send-pack.h"
@@ -374,12 +375,18 @@ static int refs_pushed(struct ref *ref)
 	return 0;
 }
 
+static int sideband_demux(int fd, void *data)
+{
+	return recv_sideband("send-pack", *((int*)data), fd, 2);
+}
+
 static int do_send_pack(int in, int out, struct remote *remote, const char *dest, int nr_refspec, const char **refspec)
 {
 	struct ref *ref;
 	int new_refs;
 	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
+	int use_sideband = 0;
 	int flags = MATCH_REFS_NONE;
 	int pushing = 0;
 	int ret;
@@ -398,6 +405,8 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		expect_status_report = 1;
 	if (server_supports("delete-refs"))
 		allow_deleting_refs = 1;
+	if (server_supports("side-band-64k"))
+		use_sideband = 1;
 
 	/* match them up */
 	if (!remote_tail)
@@ -478,9 +487,10 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 
 			if (!pushing)
-				packet_write(out, "%s %s %s%c%s",
+				packet_write(out, "%s %s %s%c%s%s",
 					old_hex, new_hex, ref->name, 0,
-					(expect_status_report ? " report-status" : "")
+					(expect_status_report ? " report-status" : ""),
+					(use_sideband ? " side-band-64k" : "")
 				);
 			else
 				packet_write(out, "%s %s %s",
@@ -501,11 +511,26 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	}
 	close(out);
 
-	if (pushing && expect_status_report)
-		ret = receive_status(in, remote_refs);
-	else
-		ret = 0;
+	ret = 0;
+	if (pushing) {
+		struct async demux;
+		int demux_in = in;
+
+		if (use_sideband) {
+			memset(&demux, 0, sizeof(demux));
+			demux.proc = sideband_demux;
+			demux.data = &demux_in;
+			if (start_async(&demux))
+				die("send-pack: unable to start sideband demultiplexer");
+			in = demux.out;
+		}
+
+		if (expect_status_report)
+			ret = receive_status(in, remote_refs);
 
+		if (use_sideband && (finish_async(&demux) || close(demux.out)))
+			die("error in sideband demultiplexer");
+	}
 	print_push_status(dest, remote_refs);
 
 	if (!args.dry_run && remote) {
diff --git a/pkt-line.c b/pkt-line.c
index 5917e1d..0b5f422 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "pkt-line.h"
+#include "sideband.h"
 
 /*
  * Write a packetized stream, where each line is preceded by
@@ -37,14 +38,23 @@ ssize_t safe_write(int fd, const void *buf, ssize_t n)
  * If we buffered things up above (we don't, but we should),
  * we'd flush it here
  */
+void packet_sideband_flush(int fd, int band)
+{
+	if (band >= 0)
+		send_sideband(fd, band, "0000", 4, LARGE_PACKET_MAX);
+	else
+		safe_write(fd, "0000", 4);
+}
+
 void packet_flush(int fd)
 {
-	safe_write(fd, "0000", 4);
+	packet_sideband_flush(fd, -1);
 }
 
 #define hex(a) (hexchar[(a) & 15])
 static void packet_vwrite(
 	int fd,
+	int band,
 	const char *fmt,
 	va_list args)
 {
@@ -60,7 +70,10 @@ static void packet_vwrite(
 	buffer[1] = hex(n >> 8);
 	buffer[2] = hex(n >> 4);
 	buffer[3] = hex(n);
-	safe_write(fd, buffer, n);
+	if (band >= 0)
+		send_sideband(fd, band, buffer, n, LARGE_PACKET_MAX);
+	else
+		safe_write(fd, buffer, n);
 }
 
 void packet_write(int fd, const char *fmt, ...)
@@ -68,7 +81,16 @@ void packet_write(int fd, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	packet_vwrite(fd, fmt, args);
+	packet_vwrite(fd, -1, fmt, args);
+	va_end(args);
+}
+
+void packet_sideband_write(int fd, int band, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	packet_vwrite(fd, band, fmt, args);
 	va_end(args);
 }
 
diff --git a/pkt-line.h b/pkt-line.h
index 9df653f..0b7ded1 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -7,7 +7,9 @@
  * Silly packetized line writing interface
  */
 void packet_flush(int fd);
+void packet_sideband_flush(int fd, int band);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+void packet_sideband_write(int fd, int band, const char *fmt, ...) __attribute__((format (printf, 3, 4)));
 
 int packet_read_line(int fd, char *buffer, unsigned size);
 ssize_t safe_write(int, const void *, ssize_t);
diff --git a/receive-pack.c b/receive-pack.c
index 7380395..8962c4c 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -2,6 +2,7 @@
 #include "pack.h"
 #include "refs.h"
 #include "pkt-line.h"
+#include "sideband.h"
 #include "run-command.h"
 #include "exec_cmd.h"
 #include "commit.h"
@@ -14,8 +15,9 @@ static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
+static int use_sideband;
 
-static char capabilities[] = " report-status delete-refs ";
+static char capabilities[] = " report-status delete-refs side-band-64k ";
 static int capabilities_sent;
 
 static int receive_pack_config(const char *var, const char *value)
@@ -321,6 +323,8 @@ static void read_head_info(void)
 			const char *reqcap = refname + reflen + 1;
 			if (strstr(reqcap, "report-status"))
 				report_status = 1;
+			if (strstr(reqcap, "side-band-64k"))
+				use_sideband = LARGE_PACKET_MAX;
 		}
 		cmd = xmalloc(sizeof(struct command) + len - 80);
 		hashcpy(cmd->old_sha1, old_sha1);
@@ -426,18 +430,19 @@ static const char *unpack(void)
 
 static void report(const char *unpack_status)
 {
+	int band = use_sideband ? 1 : -1;
 	struct command *cmd;
-	packet_write(1, "unpack %s\n",
+	packet_sideband_write(1, band, "unpack %s\n",
 		     unpack_status ? unpack_status : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string)
-			packet_write(1, "ok %s\n",
+			packet_sideband_write(1, band, "ok %s\n",
 				     cmd->ref_name);
 		else
-			packet_write(1, "ng %s %s\n",
+			packet_sideband_write(1, band, "ng %s %s\n",
 				     cmd->ref_name, cmd->error_string);
 	}
-	packet_flush(1);
+	packet_sideband_flush(1, band);
 }
 
 static int delete_only(struct command *cmd)
@@ -501,6 +506,8 @@ int main(int argc, char **argv)
 			report(unpack_status);
 		run_hook(post_receive_hook);
 		run_update_post_hook(commands);
+		if (use_sideband)
+			packet_flush(1);
 	}
 	return 0;
 }
-- 
1.5.4.1.1309.g833c2
