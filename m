From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fixup no-progress for fetch & clone
Date: Fri, 23 Feb 2007 20:03:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Feb 23 20:03:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKfhM-00028d-E5
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 20:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933176AbXBWTDN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 14:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933177AbXBWTDN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 14:03:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:52017 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933176AbXBWTDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 14:03:12 -0500
Received: (qmail invoked by alias); 23 Feb 2007 19:03:11 -0000
X-Provags-ID: V01U2FsdGVkX1/0PDdLWvz0BPl2L/8wvzzKjjn/PfzWzbH4sNmpbb
	B4Ug==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40464>


The intent of the commit 'fetch & clone: do not output progress when
not on a tty' was to make fetching and cloning less chatty when
output was not redirected (such as in a cron job).

However, there was a serious thinko in that commit. It assumed that
the client _and_ the server got this update at the same time. But
this is obviously not the case, and therefore upload-pack died on
seeing the option "--no-progress".

This patch fixes that issue by making it a protocol option. So, until
your server is updated, you still see the progress, but once the
server has this patch, it will be quiet.

A minor issue was also fixed: when cloning, the checkout did not
heed no_progress.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Do you want me to fold that back into the original patch?

 Documentation/git-upload-pack.txt |    5 +----
 fetch-pack.c                      |   10 +++-------
 git-clone.sh                      |    2 +-
 upload-pack.c                     |   10 ++++------
 4 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index c75c86e..fd65192 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -8,7 +8,7 @@ git-upload-pack - Send objects packed back to git-fetch-pack
 
 SYNOPSIS
 --------
-'git-upload-pack' [--strict] [--timeout=<n>] [--no-progress] <directory>
+'git-upload-pack' [--strict] [--timeout=<n>] <directory>
 
 DESCRIPTION
 -----------
@@ -30,9 +30,6 @@ OPTIONS
 \--timeout=<n>::
 	Interrupt transfer after <n> seconds of inactivity.
 
-\--no-progress::
-	Do not show the progress.
-
 <directory>::
 	The repository to sync from.
 
diff --git a/fetch-pack.c b/fetch-pack.c
index fc6b4e0..8428546 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -174,12 +174,13 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 		}
 
 		if (!fetching)
-			packet_write(fd[1], "want %s%s%s%s%s%s\n",
+			packet_write(fd[1], "want %s%s%s%s%s%s%s\n",
 				     sha1_to_hex(remote),
 				     (multi_ack ? " multi_ack" : ""),
 				     (use_sideband == 2 ? " side-band-64k" : ""),
 				     (use_sideband == 1 ? " side-band" : ""),
 				     (use_thin_pack ? " thin-pack" : ""),
+				     (no_progress ? " no-progress" : ""),
 				     " ofs-delta");
 		else
 			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
@@ -732,12 +733,7 @@ int main(int argc, char **argv)
 	}
 	if (!dest)
 		usage(fetch_pack_usage);
-	if (no_progress) {
-		char buf[256];
-		snprintf(buf, sizeof(buf), "%s --no-progress", uploadpack);
-		pid = git_connect(fd, dest, buf);
-	} else
-		pid = git_connect(fd, dest, uploadpack);
+	pid = git_connect(fd, dest, uploadpack);
 	if (pid < 0)
 		return 1;
 	if (heads && nr_heads)
diff --git a/git-clone.sh b/git-clone.sh
index 86890ea..de51983 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -395,7 +395,7 @@ then
 
 	case "$no_checkout" in
 	'')
-		test "z$quiet" = z && v=-v || v=
+		test "z$quiet" = z -a "z$no_progress" = z && v=-v || v=
 		git-read-tree -m -u $v HEAD HEAD
 	esac
 fi
diff --git a/upload-pack.c b/upload-pack.c
index d1be07f..d9907ca 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,7 +10,7 @@
 #include "revision.h"
 #include "list-objects.h"
 
-static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] [--no-progress] <dir>";
+static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
 
 /* bits #0..7 in revision.h, #8..10 in commit.c */
 #define THEY_HAVE	(1u << 11)
@@ -547,6 +547,8 @@ static void receive_needs(void)
 			use_sideband = LARGE_PACKET_MAX;
 		else if (strstr(line+45, "side-band"))
 			use_sideband = DEFAULT_PACKET_MAX;
+		if (strstr(line+45, "no-progress"))
+			no_progress = 1;
 
 		/* We have sent all our refs already, and the other end
 		 * should have chosen out of them; otherwise they are
@@ -615,7 +617,7 @@ static void receive_needs(void)
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
-		" side-band-64k ofs-delta shallow";
+		" side-band-64k ofs-delta shallow no-progress";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
@@ -670,10 +672,6 @@ int main(int argc, char **argv)
 			timeout = atoi(arg+10);
 			continue;
 		}
-		if (!strcmp(arg, "--no-progress")) {
-			no_progress = 1;
-			continue;
-		}
 		if (!strcmp(arg, "--")) {
 			i++;
 			break;
-- 
1.5.0.1.2248.g9f85a-dirty
