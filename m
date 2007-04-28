From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/5] Add --remote option to send-pack
Date: Sat, 28 Apr 2007 13:05:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 19:06:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhqNO-0001U8-LB
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 19:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161861AbXD1RFk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 13:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756419AbXD1RFj
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 13:05:39 -0400
Received: from iabervon.org ([66.92.72.58]:4837 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161873AbXD1RFT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 13:05:19 -0400
Received: (qmail 7653 invoked by uid 1000); 28 Apr 2007 17:05:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Apr 2007 17:05:18 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45784>

With the --remote option, send-pack will look at the remote
configuration for the specified remote (which must match the
destination URL), and update the local tracking refs to match changes
it causes in the remote heads they track.

The previous values of local tracking heads are ignored.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 send-pack.c |   54 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index d5b5162..7f76ef0 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -4,6 +4,7 @@
 #include "refs.h"
 #include "pkt-line.h"
 #include "run-command.h"
+#include "remote.h"
 
 static const char send_pack_usage[] =
 "git-send-pack [--all] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
@@ -176,7 +177,7 @@ static int receive_status(int in)
 	return ret;
 }
 
-static int send_pack(int in, int out, int nr_refspec, char **refspec)
+static int send_pack(int in, int out, struct remote *remote, int nr_refspec, char **refspec)
 {
 	struct ref *ref;
 	int new_refs;
@@ -213,18 +214,18 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char old_hex[60], *new_hex;
-		int delete_ref;
+		int will_delete_ref;
 
 		if (!ref->peer_ref)
 			continue;
 
-		delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
-		if (delete_ref && !allow_deleting_refs) {
+		will_delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
+		if (will_delete_ref && !allow_deleting_refs) {
 			error("remote does not support deleting refs");
 			ret = -2;
 			continue;
 		}
-		if (!delete_ref &&
+		if (!will_delete_ref &&
 		    !hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (verbose)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
@@ -251,7 +252,7 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 		 */
 
 		if (!force_update &&
-		    !delete_ref &&
+		    !will_delete_ref &&
 		    !is_null_sha1(ref->old_sha1) &&
 		    !ref->force) {
 			if (!has_sha1_file(ref->old_sha1) ||
@@ -275,7 +276,7 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 			}
 		}
 		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
-		if (!delete_ref)
+		if (!will_delete_ref)
 			new_refs++;
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
 		new_hex = sha1_to_hex(ref->new_sha1);
@@ -290,7 +291,7 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 		else
 			packet_write(out, "%s %s %s",
 				     old_hex, new_hex, ref->name);
-		if (delete_ref)
+		if (will_delete_ref)
 			fprintf(stderr, "deleting '%s'\n", ref->name);
 		else {
 			fprintf(stderr, "updating '%s'", ref->name);
@@ -300,6 +301,27 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 			fprintf(stderr, "\n  from %s\n  to   %s\n",
 				old_hex, new_hex);
 		}
+		if (remote) {
+			char *track =
+				remote_fetch_to(remote, ref->name);
+			if (track) {
+				struct ref_lock *lock;
+				fprintf(stderr, " Also local %s\n", track);
+				if (will_delete_ref) {
+					if (delete_ref(track, NULL)) {
+						error("Failed to delete");
+					}
+				} else {
+					lock = lock_any_ref_for_update(track, NULL);
+					if (!lock)
+						error("Failed to lock");
+					else
+						write_ref_sha1(lock, ref->new_sha1,
+							       "update by push");
+				}
+				free(track);
+			}
+		}
 	}
 
 	packet_flush(out);
@@ -344,6 +366,8 @@ int main(int argc, char **argv)
 	char **heads = NULL;
 	int fd[2], ret;
 	pid_t pid;
+	char *remote_name = NULL;
+	struct remote *remote = NULL;
 
 	setup_git_directory();
 	git_config(git_default_config);
@@ -361,6 +385,10 @@ int main(int argc, char **argv)
 				receivepack = arg + 7;
 				continue;
 			}
+			if (!prefixcmp(arg, "--remote=")) {
+				remote_name = arg + 9;
+				continue;
+			}
 			if (!strcmp(arg, "--all")) {
 				send_all = 1;
 				continue;
@@ -393,10 +421,18 @@ int main(int argc, char **argv)
 		usage(send_pack_usage);
 	verify_remote_names(nr_heads, heads);
 
+	if (remote_name) {
+		remote = remote_get(remote_name);
+		if (!remote_has_uri(remote, dest)) {
+			die("Destination %s is not a uri for %s",
+			    dest, remote_name);
+		}
+	}
+
 	pid = git_connect(fd, dest, receivepack);
 	if (pid < 0)
 		return 1;
-	ret = send_pack(fd[0], fd[1], nr_heads, heads);
+	ret = send_pack(fd[0], fd[1], remote, nr_heads, heads);
 	close(fd[0]);
 	close(fd[1]);
 	ret |= finish_connect(pid);
-- 
1.5.1.2.255.g6ead4-dirty
