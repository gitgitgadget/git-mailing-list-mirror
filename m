From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Re: pull/push inconsistencies
Date: Tue, 15 May 2007 22:50:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705152214580.18541@iabervon.org>
References: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 04:50:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho9au-0005EK-28
	for gcvg-git@gmane.org; Wed, 16 May 2007 04:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbXEPCuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 22:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbXEPCuV
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 22:50:21 -0400
Received: from iabervon.org ([66.92.72.58]:1683 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbXEPCuV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 22:50:21 -0400
Received: (qmail 31447 invoked by uid 1000); 16 May 2007 02:50:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 May 2007 02:50:19 -0000
In-Reply-To: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47407>

On Wed, 16 May 2007, Martin Langhoff wrote:

> My second issue is that git-push does not update
> remotes/<repo>/<headname> so if I do git-push && gitk --all it looks
> as if I haven't pushed. Misleading again. :-/

This patch is based on my "remote" series, currently in "pu". I'm not 100% 
sure that this is the right behavior for the case where the change isn't a 
fast-forward; if the push worked, it just assumes that you don't care if 
the tracking ref would be rewound, even if the fetch wouldn't force it.
In this case, you must have rewound your head, and forced the push, so 
it's implausible that you want the tracking ref to go strictly forward 
when you've made the source of the ref rewind.

	-Daniel
*This .sig left intentionally blank*

---- cut here ----
Update local tracking refs when pushing

This also adds a --remote option to send-pack, which specifies the
configured remote being used. It is provided automatically by
git-push, and must match the url (which is still needed, since there
could be multiple urls).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-push.c |    9 +++++++--
 send-pack.c    |   55 ++++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 0e602f3..6084899 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -178,8 +178,13 @@ static int do_push(const char *repo)
 		if (!prefixcmp(dest, "http://") ||
 		    !prefixcmp(dest, "https://"))
 			sender = "http-push";
-		else if (thin)
-			argv[dest_argc++] = "--thin";
+		else {
+			char *rem = xmalloc(strlen(remote->name) + 10);
+			sprintf(rem, "--remote=%s", remote->name);
+			argv[dest_argc++] = rem;
+			if (thin)
+				argv[dest_argc++] = "--thin";
+		}
 		argv[0] = sender;
 		argv[dest_argc++] = dest;
 		while (dest_refspec_nr--)
diff --git a/send-pack.c b/send-pack.c
index 6851043..eabadbe 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -177,7 +177,7 @@ static int receive_status(int in)
 	return ret;
 }
 
-static int send_pack(int in, int out, int nr_refspec, char **refspec)
+static int send_pack(int in, int out, struct remote *remote, int nr_refspec, char **refspec)
 {
 	struct ref *ref;
 	int new_refs;
@@ -214,18 +214,19 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char old_hex[60], *new_hex;
-		int delete_ref;
+		int will_delete_ref;
 
 		if (!ref->peer_ref)
 			continue;
 
-		delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
-		if (delete_ref && !allow_deleting_refs) {
+
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
@@ -252,7 +253,7 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 		 */
 
 		if (!force_update &&
-		    !delete_ref &&
+		    !will_delete_ref &&
 		    !is_null_sha1(ref->old_sha1) &&
 		    !ref->force) {
 			if (!has_sha1_file(ref->old_sha1) ||
@@ -276,7 +277,7 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 			}
 		}
 		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
-		if (!delete_ref)
+		if (!will_delete_ref)
 			new_refs++;
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
 		new_hex = sha1_to_hex(ref->new_sha1);
@@ -291,7 +292,7 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 		else
 			packet_write(out, "%s %s %s",
 				     old_hex, new_hex, ref->name);
-		if (delete_ref)
+		if (will_delete_ref)
 			fprintf(stderr, "deleting '%s'\n", ref->name);
 		else {
 			fprintf(stderr, "updating '%s'", ref->name);
@@ -301,6 +302,28 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 			fprintf(stderr, "\n  from %s\n  to   %s\n",
 				old_hex, new_hex);
 		}
+		if (remote) {
+			struct refspec rs;
+			rs.src = ref->name;
+			remote_find_tracking(remote, &rs);
+			if (rs.dst) {
+				struct ref_lock *lock;
+				fprintf(stderr, " Also local %s\n", rs.dst);
+				if (will_delete_ref) {
+					if (delete_ref(rs.dst, NULL)) {
+						error("Failed to delete");
+					}
+				} else {
+					lock = lock_any_ref_for_update(rs.dst, NULL);
+					if (!lock)
+						error("Failed to lock");
+					else
+						write_ref_sha1(lock, ref->new_sha1,
+							       "update by push");
+				}
+				free(rs.dst);
+			}
+		}
 	}
 
 	packet_flush(out);
@@ -345,6 +368,8 @@ int main(int argc, char **argv)
 	char **heads = NULL;
 	int fd[2], ret;
 	pid_t pid;
+	char *remote_name = NULL;
+	struct remote *remote = NULL;
 
 	setup_git_directory();
 	git_config(git_default_config);
@@ -362,6 +387,10 @@ int main(int argc, char **argv)
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
@@ -394,10 +423,18 @@ int main(int argc, char **argv)
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
1.5.2.rc2.90.gc593-dirty
