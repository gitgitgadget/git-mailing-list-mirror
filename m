From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Allow fetch-pack to decide keeping the fetched pack without exploding
Date: Mon, 22 Jan 2007 22:47:50 -0800
Message-ID: <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 07:47:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9FRj-0006rY-Lr
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 07:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933092AbXAWGrx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 01:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933091AbXAWGrx
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 01:47:53 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:65154 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933092AbXAWGrv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 01:47:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070123064750.XZWF7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Tue, 23 Jan 2007 01:47:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EWmu1W00H1kojtg0000000; Tue, 23 Jan 2007 01:46:55 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37483>

With --keep-auto option, fetch-pack decides to keep the pack
without exploding it just like receive-pack does.

We may want to later make this the default.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 And this is the second half.  It looks larger than it really
 is, because it involves some code movements; it removes two
 separate functions that called get_pack() and moves what they
 did to get_pack() after setup_sideband() happens.

 Although I did test it with --keep-auto with large and small
 packs once each. I haven't tested this at all with the
 git-fetch script.

 fetch-pack.c |   91 +++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 726140a..4ee041c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -4,9 +4,11 @@
 #include "commit.h"
 #include "tag.h"
 #include "exec_cmd.h"
+#include "pack.h"
 #include "sideband.h"
 
 static int keep_pack;
+static int keep_auto;
 static int quiet;
 static int verbose;
 static int fetch_all;
@@ -486,13 +488,58 @@ static pid_t setup_sideband(int fd[2], int xd[2])
 	return side_pid;
 }
 
-static int get_pack(int xd[2], const char **argv)
+static int get_pack(int xd[2])
 {
 	int status;
 	pid_t pid, side_pid;
 	int fd[2];
+	const char *argv[20];
+	char keep_arg[256];
+	char hdr_arg[256];
+	const char **av;
+	int do_keep = keep_pack;
 
 	side_pid = setup_sideband(fd, xd);
+
+	av = argv;
+	*hdr_arg = 0;
+	if (keep_auto) {
+		struct pack_header header;
+
+		if (read_pack_header(fd[0], &header))
+			die("protocol error: bad pack header");
+		snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%u,%u",
+			 ntohl(header.hdr_version), ntohl(header.hdr_entries));
+		if (ntohl(header.hdr_entries) < keep_auto)
+			do_keep = 0;
+		else
+			do_keep = 1;
+	}
+
+	if (do_keep) {
+		*av++ = "index-pack";
+		*av++ = "--stdin";
+		if (!quiet)
+			*av++ = "-v";
+		if (use_thin_pack)
+			*av++ = "--fix-thin";
+		if (keep_pack > 1 || keep_auto) {
+			int s = sprintf(keep_arg,
+					"--keep=fetch-pack %d on ", getpid());
+			if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
+				strcpy(keep_arg + s, "localhost");
+			*av++ = keep_arg;
+		}
+	}
+	else {
+		*av++ = "unpack-objects";
+		if (quiet)
+			*av++ = "-q";
+	}
+	if (*hdr_arg)
+		*av++ = hdr_arg;
+	*av++ = NULL;
+
 	pid = fork();
 	if (pid < 0)
 		die("fetch-pack: unable to fork off %s", argv[0]);
@@ -522,39 +569,10 @@ static int get_pack(int xd[2], const char **argv)
 	die("%s died of unnatural causes %d", argv[0], status);
 }
 
-static int explode_rx_pack(int xd[2])
-{
-	const char *argv[3] = { "unpack-objects", quiet ? "-q" : NULL, NULL };
-	return get_pack(xd, argv);
-}
-
-static int keep_rx_pack(int xd[2])
-{
-	const char *argv[6];
-	char keep_arg[256];
-	int n = 0;
-
-	argv[n++] = "index-pack";
-	argv[n++] = "--stdin";
-	if (!quiet)
-		argv[n++] = "-v";
-	if (use_thin_pack)
-		argv[n++] = "--fix-thin";
-	if (keep_pack > 1) {
-		int s = sprintf(keep_arg, "--keep=fetch-pack %i on ", getpid());
-		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
-			strcpy(keep_arg + s, "localhost");
-		argv[n++] = keep_arg;
-	}
-	argv[n] = NULL;
-	return get_pack(xd, argv);
-}
-
 static int fetch_pack(int fd[2], int nr_match, char **match)
 {
 	struct ref *ref;
 	unsigned char sha1[20];
-	int status;
 
 	get_remote_heads(fd[0], &ref, 0, NULL, 0);
 	if (is_repository_shallow() && !server_supports("shallow"))
@@ -589,8 +607,7 @@ static int fetch_pack(int fd[2], int nr_match, char **match)
 			 */
 			fprintf(stderr, "warning: no common commits\n");
 
-	status = (keep_pack) ? keep_rx_pack(fd) : explode_rx_pack(fd);
-	if (status)
+	if (get_pack(fd))
 		die("git-fetch-pack: fetch failed.");
 
  all_done:
@@ -655,6 +672,16 @@ int main(int argc, char **argv)
 				keep_pack++;
 				continue;
 			}
+			if (!strcmp("--keep-auto", arg)) {
+				keep_auto = 100;
+				continue;
+			}
+			if (!strncmp("--keep-auto=", arg, 12)) {
+				keep_auto = strtoul(arg + 12, NULL, 0);
+				if (keep_auto < 20)
+					keep_auto = 20;
+				continue;
+			}
 			if (!strcmp("--thin", arg)) {
 				use_thin_pack = 1;
 				continue;
-- 
1.5.0.rc2.gc9a89
