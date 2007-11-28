From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH v3] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 14:14:03 -0800
Message-ID: <20071128221403.GA3256@midwinter.com>
References: <C1321BD5-8F6B-47F9-9BDB-C2BF819D6F17@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVAo-0001uP-AO
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbXK1WOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757490AbXK1WOG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:14:06 -0500
Received: from tater.midwinter.com ([216.32.86.90]:49752 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757379AbXK1WOE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:14:04 -0500
Received: (qmail 3401 invoked by uid 1001); 28 Nov 2007 22:14:03 -0000
Content-Disposition: inline
In-Reply-To: <C1321BD5-8F6B-47F9-9BDB-C2BF819D6F17@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66439>

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

	This is on top of "next". It doesn't do any automatic fetching,
	just prints a status message.

 Documentation/git-receive-pack.txt |    8 +++-
 builtin-send-pack.c                |   65 +++++++++++++++++++++++++++-------
 cache.h                            |    1 +
 receive-pack.c                     |   68 +++++++++++++++++++++++-------------
 4 files changed, 103 insertions(+), 39 deletions(-)

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
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 25ae1fe..4ba716a 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -164,7 +164,9 @@ static int receive_status(int in, struct ref *refs)
 	hint = NULL;
 	while (1) {
 		char *refname;
+		char *newsha1_hex;
 		char *msg;
+		unsigned char newsha1[20];
 		len = packet_read_line(in, line, sizeof(line));
 		if (!len)
 			break;
@@ -177,7 +179,16 @@ static int receive_status(int in, struct ref *refs)
 
 		line[strlen(line)-1] = '\0';
 		refname = line + 3;
-		msg = strchr(refname, ' ');
+		newsha1_hex = strchr(refname, ' ');
+		if (newsha1_hex) {
+			*newsha1_hex++ = '\0';
+			if (get_sha1_hex(newsha1_hex, newsha1)) {
+				fprintf(stderr, "protocol error: bad sha1 %s\n",
+					newsha1_hex);
+				newsha1_hex = NULL;
+			}
+		}
+		msg = strchr(newsha1_hex, ' ');
 		if (msg)
 			*msg++ = '\0';
 
@@ -197,8 +208,16 @@ static int receive_status(int in, struct ref *refs)
 			continue;
 		}
 
-		if (line[0] == 'o' && line[1] == 'k')
-			hint->status = REF_STATUS_OK;
+		if (line[0] == 'o' && line[1] == 'k') {
+			if (newsha1_hex != NULL &&
+			    hashcmp(hint->new_sha1, newsha1)) {
+				hint->status = REF_STATUS_REMOTE_CHANGED;
+				hashcpy(hint->new_sha1, newsha1);
+			}
+			else {
+				hint->status = REF_STATUS_OK;
+			}
+		}
 		else {
 			hint->status = REF_STATUS_REMOTE_REJECT;
 			ret = -1;
@@ -215,21 +234,34 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 {
 	struct refspec rs;
 
-	if (ref->status != REF_STATUS_OK)
+	if (ref->status != REF_STATUS_OK &&
+	    ref->status != REF_STATUS_REMOTE_CHANGED)
 		return;
 
 	rs.src = ref->name;
 	rs.dst = NULL;
 
 	if (!remote_find_tracking(remote, &rs)) {
-		if (args.verbose)
-			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
-		if (ref->deletion) {
-			if (delete_ref(rs.dst, NULL))
-				error("Failed to delete");
-		} else
-			update_ref("update by push", rs.dst,
-					ref->new_sha1, NULL, 0, 0);
+		if (ref->status == REF_STATUS_REMOTE_CHANGED) {
+			if (args.verbose) {
+				fprintf(stderr, "local tracking ref '%s' "
+					"needs to be fetched\n", rs.dst);
+			}
+		}
+		else {
+			if (args.verbose) {
+				fprintf(stderr, "updating local tracking "
+					"ref '%s'\n", rs.dst);
+			}
+			if (ref->deletion) {
+				if (delete_ref(rs.dst, NULL))
+					error("Failed to delete");
+			}
+			else {
+				update_ref("update by push", rs.dst,
+						ref->new_sha1, NULL, 0, 0);
+			}
+		}
 		free(rs.dst);
 	}
 }
@@ -329,6 +361,10 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count)
 				ref->deletion ? NULL : ref->peer_ref,
 				"remote failed to report status");
 		break;
+	case REF_STATUS_REMOTE_CHANGED:
+		print_ref_status('+', "[changed]", ref, ref->peer_ref,
+				"remote made changes to revisions");
+		break;
 	case REF_STATUS_OK:
 		print_ok_ref_status(ref);
 		break;
@@ -349,12 +385,14 @@ static void print_push_status(const char *dest, struct ref *refs)
 	}
 
 	for (ref = refs; ref; ref = ref->next)
-		if (ref->status == REF_STATUS_OK)
+		if (ref->status == REF_STATUS_OK ||
+		    ref->status == REF_STATUS_REMOTE_CHANGED)
 			n += print_one_push_status(ref, dest, n);
 
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
+		    ref->status != REF_STATUS_REMOTE_CHANGED &&
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n);
 	}
@@ -522,6 +560,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		switch (ref->status) {
 		case REF_STATUS_NONE:
 		case REF_STATUS_UPTODATE:
+		case REF_STATUS_REMOTE_CHANGED:
 		case REF_STATUS_OK:
 			break;
 		default:
diff --git a/cache.h b/cache.h
index 4e59646..ae2427d 100644
--- a/cache.h
+++ b/cache.h
@@ -516,6 +516,7 @@ struct ref {
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT,
+		REF_STATUS_REMOTE_CHANGED,
 	} status;
 	char *remote_status;
 	struct ref *peer_ref; /* when renaming */
diff --git a/receive-pack.c b/receive-pack.c
index ed44b89..1101e18 100644
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
@@ -194,28 +201,41 @@ static const char *update(struct command *cmd)
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
 		return NULL; /* good */
+
+	default:
+		error("hook declined to update %s", name);
+		return "hook declined";
 	}
 }
 
@@ -415,8 +435,8 @@ static void report(const char *unpack_status)
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
-- 
1.5.3.6.2040.g97735-dirty
