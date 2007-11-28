From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 11:41:59 -0800
Message-ID: <20071128194159.GA25977@midwinter.com>
References: <7vmysy5h5k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 20:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxSnh-00006c-S2
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 20:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbXK1TmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 14:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754577AbXK1TmB
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 14:42:01 -0500
Received: from tater.midwinter.com ([216.32.86.90]:39116 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751719AbXK1TmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 14:42:00 -0500
Received: (qmail 26333 invoked by uid 1001); 28 Nov 2007 19:41:59 -0000
Content-Disposition: inline
In-Reply-To: <7vmysy5h5k.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66415>

This is useful in cases where a hook needs to modify an incoming commit
in some way, e.g., adding an annotation to the commit message, noting
the location of output from a profiling tool, or committing to an svn
repository using git-svn.

recieve-pack will now send the post-update SHA1 back to send-pack. If
it's different than the one that was pushed, git-push won't do the
fake update of the local tracking ref and will instead inform the user
that the tracking ref needs to be fetched.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

	The protocol was much easier to tweak than I expected. It
	seems like a reasonable extension to always send back the
	resulting SHA1; won't stop other people from adding more
	information later.

	It would IMO be better still if git-push were to fetch
	automatically here rather than just printing a message, but
	I'm not sure if that would smack too much of automagic behavior
	to people. Comments welcome.

 Documentation/git-receive-pack.txt |    8 +++-
 receive-pack.c                     |   72 +++++++++++++++++++++++-------------
 remote.c                           |    2 +-
 remote.h                           |    2 +
 send-pack.c                        |   64 +++++++++++++++++++++++++++-----
 5 files changed, 109 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 2633d94..115ae97 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -74,8 +74,12 @@ Note that the hook is called before the refname is updated,
 so either sha1-old is 0\{40} (meaning there is no such ref yet),
 or it should match what is recorded in refname.
 
-The hook should exit with non-zero status if it wants to disallow
-updating the named ref.  Otherwise it should exit with zero.
+The hook may optionally choose to update the ref on its own, e.g.,
+if it needs to modify incoming revisions in some way. If it updates
+the ref, it should exit with a status of 100.  The hook should exit
+with a status between 1 and 99 if it wants to disallow updating the
+named ref.  Otherwise it should exit with zero, and the ref will be
+updated automatically.
 
 Successful execution (a zero exit status) of this hook does not
 ensure the ref will actually be updated, it is only a prerequisite.
diff --git a/receive-pack.c b/receive-pack.c
index 38e35c0..d07dd6d 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -18,6 +18,9 @@ static int report_status;
 static char capabilities[] = " report-status delete-refs ";
 static int capabilities_sent;
 
+/* Update hook exit code: hook has updated ref on its own */
+#define EXIT_CODE_REF_UPDATED 100
+
 static int receive_pack_config(const char *var, const char *value)
 {
 	if (strcmp(var, "receive.denynonfastforwards") == 0) {
@@ -70,8 +73,11 @@ static struct command *commands;
 static const char pre_receive_hook[] = "hooks/pre-receive";
 static const char post_receive_hook[] = "hooks/post-receive";
 
-static int hook_status(int code, const char *hook_name)
+static int hook_status(int code, const char *hook_name, int ok_start)
 {
+	if (ok_start && -code >= ok_start)
+		return -code;
+
 	switch (code) {
 	case 0:
 		return 0;
@@ -121,7 +127,7 @@ static int run_hook(const char *hook_name)
 
 	code = start_command(&proc);
 	if (code)
-		return hook_status(code, hook_name);
+		return hook_status(code, hook_name, 0);
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string) {
 			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
@@ -132,7 +138,7 @@ static int run_hook(const char *hook_name)
 				break;
 		}
 	}
-	return hook_status(finish_command(&proc), hook_name);
+	return hook_status(finish_command(&proc), hook_name, 0);
 }
 
 static int run_update_hook(struct command *cmd)
@@ -155,7 +161,8 @@ static int run_update_hook(struct command *cmd)
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
 
-	return hook_status(run_command(&proc), update_hook);
+	return hook_status(run_command(&proc), update_hook,
+			   EXIT_CODE_REF_UPDATED);
 }
 
 static const char *update(struct command *cmd)
@@ -194,32 +201,45 @@ static const char *update(struct command *cmd)
 			return "non-fast forward";
 		}
 	}
-	if (run_update_hook(cmd)) {
-		error("hook declined to update %s", name);
-		return "hook declined";
-	}
-
-	if (is_null_sha1(new_sha1)) {
-		if (delete_ref(name, old_sha1)) {
-			error("failed to delete %s", name);
-			return "failed to delete";
+	switch (run_update_hook(cmd)) {
+	case 0:
+		if (is_null_sha1(new_sha1)) {
+			if (delete_ref(name, old_sha1)) {
+				error("failed to delete %s", name);
+				return "failed to delete";
+			}
+			fprintf(stderr, "%s: %s -> deleted\n", name,
+				sha1_to_hex(old_sha1));
 		}
-		fprintf(stderr, "%s: %s -> deleted\n", name,
-			sha1_to_hex(old_sha1));
-		return NULL; /* good */
-	}
-	else {
-		lock = lock_any_ref_for_update(name, old_sha1, 0);
-		if (!lock) {
-			error("failed to lock %s", name);
-			return "failed to lock";
+		else {
+			lock = lock_any_ref_for_update(name, old_sha1, 0);
+			if (!lock) {
+				error("failed to lock %s", name);
+				return "failed to lock";
+			}
+			if (write_ref_sha1(lock, new_sha1, "push")) {
+				return "failed to write"; /* error() already called */
+			}
+			fprintf(stderr, "%s: %s -> %s\n", name,
+				sha1_to_hex(old_sha1), sha1_to_hex(new_sha1));
 		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
+		return NULL; /* good */
+
+	case EXIT_CODE_REF_UPDATED:
+		/* hook has taken care of updating ref, which means it
+		   might be a different revision than we think. */
+		if (! resolve_ref(name, new_sha1, 1, NULL)) {
+			error("can't resolve ref %s after hook updated it",
+				name);
+			return "ref not resolvable";
 		}
 		fprintf(stderr, "%s: %s -> %s\n", name,
 			sha1_to_hex(old_sha1), sha1_to_hex(new_sha1));
 		return NULL; /* good */
+
+	default:
+		error("hook declined to update %s", name);
+		return "hook declined";
 	}
 }
 
@@ -419,8 +439,8 @@ static void report(const char *unpack_status)
 		     unpack_status ? unpack_status : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string)
-			packet_write(1, "ok %s\n",
-				     cmd->ref_name);
+			packet_write(1, "ok %s %s\n",
+				     cmd->ref_name, sha1_to_hex(cmd->new_sha1));
 		else
 			packet_write(1, "ng %s %s\n",
 				     cmd->ref_name, cmd->error_string);
diff --git a/remote.c b/remote.c
index bec2ba1..07558c1 100644
--- a/remote.c
+++ b/remote.c
@@ -684,7 +684,7 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 	return -errs;
 }
 
-static struct ref *find_ref_by_name(struct ref *list, const char *name)
+struct ref *find_ref_by_name(struct ref *list, const char *name)
 {
 	for ( ; list; list = list->next)
 		if (!strcmp(list->name, name))
diff --git a/remote.h b/remote.h
index 878b4ec..e822f3c 100644
--- a/remote.h
+++ b/remote.h
@@ -56,6 +56,8 @@ void ref_remove_duplicates(struct ref *ref_map);
 
 struct refspec *parse_ref_spec(int nr_refspec, const char **refspec);
 
+struct ref *find_ref_by_name(struct ref *list, const char *name);
+
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, char **refspec, int all);
 
diff --git a/send-pack.c b/send-pack.c
index b74fd45..bf564ae 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -147,9 +147,31 @@ static void get_local_heads(void)
 	for_each_ref(one_local_ref, NULL);
 }
 
-static int receive_status(int in)
+/* Verifies that a remote ref matches the revision we pushed. */
+static void verify_tracking_ref(const char *refname, const char *newsha1_hex, struct ref *remote_refs)
+{
+	struct ref *ref;
+	unsigned char newsha1[20];
+	if (get_sha1_hex(newsha1_hex, newsha1)) {
+		fprintf(stderr, "protocol error: bad sha1 %s\n", newsha1_hex);
+		return;
+	}
+	ref = find_ref_by_name(remote_refs, refname);
+	if (ref != NULL) {
+		if (hashcmp(ref->new_sha1, newsha1)) {
+			hashcpy(ref->new_sha1, newsha1);
+			ref->force = 1;
+		}
+		else {
+			ref->force = 0;
+		}
+	}
+}
+
+static int receive_status(int in, struct ref *remote_refs)
 {
 	char line[1000];
+	char *sha1;
 	int ret = 0;
 	int len = packet_read_line(in, line, sizeof(line));
 	if (len < 10 || memcmp(line, "unpack ", 7)) {
@@ -170,8 +192,22 @@ static int receive_status(int in)
 			ret = -1;
 			break;
 		}
-		if (!memcmp(line, "ok", 2))
+		if (!memcmp(line, "ok", 2)) {
+			/* If the result looks like "ok refname sha1", we can
+			 * compare the actual SHA1 for the remote ref with the
+			 * one we pushed; if they differ then the remote
+			 * may have rewritten our commits and we will need to
+			 * do a real fetch rather than just updating the
+			 * tracking refs.
+			 */
+			if (line[2] == ' ' &&
+			    (sha1 = strchr(line+3, ' '))) {
+				/* null-terminate refname */
+				*sha1++ = '\0';
+				verify_tracking_ref(line+3, sha1, remote_refs);
+			}
 			continue;
+		}
 		fputs(line, stderr);
 		ret = -1;
 	}
@@ -196,13 +232,21 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 		return;
 
 	if (!remote_find_tracking(remote, &rs)) {
-		fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
-		if (is_null_sha1(ref->peer_ref->new_sha1)) {
-			if (delete_ref(rs.dst, NULL))
-				error("Failed to delete");
-		} else
-			update_ref("update by push", rs.dst,
-					ref->new_sha1, NULL, 0, 0);
+		if (ref->force) {
+			fprintf(stderr,
+				"local tracking ref '%s' needs to be fetched\n",
+				rs.dst);
+		}
+		else {
+			fprintf(stderr, "updating local tracking ref '%s'\n",
+				rs.dst);
+			if (is_null_sha1(ref->peer_ref->new_sha1)) {
+				if (delete_ref(rs.dst, NULL))
+					error("Failed to delete");
+			} else
+				update_ref("update by push", rs.dst,
+						ref->new_sha1, NULL, 0, 0);
+		}
 		free(rs.dst);
 	}
 }
@@ -343,7 +387,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 	close(out);
 
 	if (expect_status_report) {
-		if (receive_status(in))
+		if (receive_status(in, remote_refs))
 			ret = -4;
 	}
 
-- 
1.5.3.6.862.gb50ba-dirty
