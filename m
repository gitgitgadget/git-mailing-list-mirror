From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] send-pack/receive-pack: allow errors to be reported back to pusher.
Date: Sun, 25 Dec 2005 23:25:05 -0800
Message-ID: <7v7j9sl3qm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@suse.cz
X-From: git-owner@vger.kernel.org Mon Dec 26 08:25:29 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqmjS-0003FP-2z
	for gcvg-git@gmane.org; Mon, 26 Dec 2005 08:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVLZHZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 02:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVLZHZL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 02:25:11 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:24467 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751034AbVLZHZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 02:25:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051226072413.VHJS20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Dec 2005 02:24:13 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14051>

This updates the protocol between git-send-pack/git-receive-pack
in a backward compatible way to allow failures at the receiving
end to be propagated back to the sender.  Most notably, versions
of git-push before this could not notice if the update hook on
the receiving end refused to update the ref for its own policy
reasons.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is something I've been meaning to do since I saw Pasky's
   patch to allow Cogito to notice the failure from
   git-send-pack.

   I am reasonably sure that the protocol is backward compatible
   and you should be able run older git-receive-pack with this
   git-send-pack (the older one does not identify itself of
   capable to report status, and the sender does not ask for
   it), and this git-receive-pack can be driven with older
   git-send-pack (the older one will ignore the funny ref that
   hides the capability string).  Tests and comments are very
   much appreciated.

 connect.c      |    8 ++---
 receive-pack.c |   98 ++++++++++++++++++++++++++++++++++++++++++--------------
 send-pack.c    |   59 ++++++++++++++++++++++++++++++++--
 3 files changed, 134 insertions(+), 31 deletions(-)

be754924ffb9824453e8c8c6567e80789c552999
diff --git a/connect.c b/connect.c
index 6b6d613..d6f4e4c 100644
--- a/connect.c
+++ b/connect.c
@@ -34,10 +34,6 @@ struct ref **get_remote_heads(int in, st
 			die("protocol error: expected sha/ref, got '%s'", buffer);
 		name = buffer + 41;
 
-		if (ignore_funny && 45 < len && !memcmp(name, "refs/", 5) &&
-		    check_ref_format(name + 5))
-			continue;
-
 		name_len = strlen(name);
 		if (len != name_len + 41) {
 			if (server_capabilities)
@@ -45,6 +41,10 @@ struct ref **get_remote_heads(int in, st
 			server_capabilities = strdup(name + name_len + 1);
 		}
 
+		if (ignore_funny && 45 < len && !memcmp(name, "refs/", 5) &&
+		    check_ref_format(name + 5))
+			continue;
+
 		if (nr_match && !path_match(name, nr_match, match))
 			continue;
 		ref = xcalloc(1, sizeof(*ref) + len - 40);
diff --git a/receive-pack.c b/receive-pack.c
index 92878ec..6963545 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -8,20 +8,26 @@ static const char receive_pack_usage[] =
 
 static const char unpacker[] = "git-unpack-objects";
 
+static int report_status = 0;
+
 static int show_ref(const char *path, const unsigned char *sha1)
 {
 	packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
 	return 0;
 }
 
+static char capabilities[] = "report-status";
+
 static void write_head_info(void)
 {
+	packet_write(1, "%s capabilities^{}%c%s\n",
+		     sha1_to_hex(null_sha1), 0, capabilities);
 	for_each_ref(show_ref);
 }
 
 struct command {
 	struct command *next;
-	unsigned char updated;
+	const char *error_string;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
 	char ref_name[0];
@@ -89,15 +95,20 @@ static int run_update_hook(const char *r
 	}
 }
 
-static int update(const char *name,
-		  unsigned char *old_sha1, unsigned char *new_sha1)
+static int update(struct command *cmd)
 {
+	const char *name = cmd->ref_name;
+	unsigned char *old_sha1 = cmd->old_sha1;
+	unsigned char *new_sha1 = cmd->new_sha1;
 	char new_hex[60], *old_hex, *lock_name;
 	int newfd, namelen, written;
 
-	if (!strncmp(name, "refs/", 5) && check_ref_format(name + 5))
+	cmd->error_string = NULL;
+	if (!strncmp(name, "refs/", 5) && check_ref_format(name + 5)) {
+		cmd->error_string = "funny refname";
 		return error("refusing to create funny ref '%s' locally",
 			     name);
+	}
 
 	namelen = strlen(name);
 	lock_name = xmalloc(namelen + 10);
@@ -106,16 +117,19 @@ static int update(const char *name,
 
 	strcpy(new_hex, sha1_to_hex(new_sha1));
 	old_hex = sha1_to_hex(old_sha1);
-	if (!has_sha1_file(new_sha1))
+	if (!has_sha1_file(new_sha1)) {
+		cmd->error_string = "bad pack";
 		return error("unpack should have generated %s, "
 			     "but I can't find it!", new_hex);
-
+	}
 	safe_create_leading_directories(lock_name);
 
 	newfd = open(lock_name, O_CREAT | O_EXCL | O_WRONLY, 0666);
-	if (newfd < 0)
+	if (newfd < 0) {
+		cmd->error_string = "can't lock";
 		return error("unable to create %s (%s)",
 			     lock_name, strerror(errno));
+	}
 
 	/* Write the ref with an ending '\n' */
 	new_hex[40] = '\n';
@@ -127,18 +141,22 @@ static int update(const char *name,
 	close(newfd);
 	if (written != 41) {
 		unlink(lock_name);
+		cmd->error_string = "can't write";
 		return error("unable to write %s", lock_name);
 	}
 	if (verify_old_ref(name, old_hex) < 0) {
 		unlink(lock_name);
+		cmd->error_string = "raced";
 		return error("%s changed during push", name);
 	}
 	if (run_update_hook(name, old_hex, new_hex)) {
 		unlink(lock_name);
+		cmd->error_string = "hook declined";
 		return error("hook declined to update %s\n", name);
 	}
 	else if (rename(lock_name, name) < 0) {
 		unlink(lock_name);
+		cmd->error_string = "can't rename";
 		return error("unable to replace %s", name);
 	}
 	else {
@@ -158,7 +176,7 @@ static void run_update_post_hook(struct 
 	if (access(update_post_hook, X_OK) < 0)
 		return;
 	for (argc = 1, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
-		if (!cmd_p->updated)
+		if (cmd_p->error_string)
 			continue;
 		argc++;
 	}
@@ -166,7 +184,7 @@ static void run_update_post_hook(struct 
 	argv[0] = update_post_hook;
 
 	for (argc = 1, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
-		if (!cmd_p->updated)
+		if (cmd_p->error_string)
 			continue;
 		argv[argc] = xmalloc(strlen(cmd_p->ref_name) + 1);
 		strcpy(argv[argc], cmd_p->ref_name);
@@ -185,8 +203,7 @@ static void execute_commands(void)
 	struct command *cmd = commands;
 
 	while (cmd) {
-		cmd->updated = !update(cmd->ref_name,
-				       cmd->old_sha1, cmd->new_sha1);
+		update(cmd);
 		cmd = cmd->next;
 	}
 	run_update_post_hook(commands);
@@ -199,7 +216,8 @@ static void read_head_info(void)
 		static char line[1000];
 		unsigned char old_sha1[20], new_sha1[20];
 		struct command *cmd;
-		int len;
+		char *refname;
+		int len, reflen;
 
 		len = packet_read_line(0, line, sizeof(line));
 		if (!len)
@@ -211,38 +229,66 @@ static void read_head_info(void)
 		    line[81] != ' ' ||
 		    get_sha1_hex(line, old_sha1) ||
 		    get_sha1_hex(line + 41, new_sha1))
-			die("protocol error: expected old/new/ref, got '%s'", line);
+			die("protocol error: expected old/new/ref, got '%s'",
+			    line);
+
+		refname = line + 82;
+		reflen = strlen(refname);
+		if (reflen + 82 < len) {
+			if (strstr(refname + reflen + 1, "report-status"))
+				report_status = 1;
+		}
 		cmd = xmalloc(sizeof(struct command) + len - 80);
 		memcpy(cmd->old_sha1, old_sha1, 20);
 		memcpy(cmd->new_sha1, new_sha1, 20);
 		memcpy(cmd->ref_name, line + 82, len - 81);
+		cmd->error_string = "n/a (unpacker error)";
 		cmd->next = NULL;
 		*p = cmd;
 		p = &cmd->next;
 	}
 }
 
-static void unpack(void)
+static const char *unpack(int *error_code)
 {
 	int code = run_command(unpacker, NULL);
+
+	*error_code = 0;
 	switch (code) {
 	case 0:
-		return;
+		return NULL;
 	case -ERR_RUN_COMMAND_FORK:
-		die("unpack fork failed");
+		return "unpack fork failed";
 	case -ERR_RUN_COMMAND_EXEC:
-		die("unpack execute failed");
+		return "unpack execute failed";
 	case -ERR_RUN_COMMAND_WAITPID:
-		die("waitpid failed");
+		return "waitpid failed";
 	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
-		die("waitpid is confused");
+		return "waitpid is confused";
 	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-		die("%s died of signal", unpacker);
+		return "unpacker died of signal";
 	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
-		die("%s died strangely", unpacker);
+		return "unpacker died strangely";
 	default:
-		die("%s exited with error code %d", unpacker, -code);
+		*error_code = -code;
+		return "unpacker exited with error code";
+	}
+}
+
+static void report(const char *unpack_status)
+{
+	struct command *cmd;
+	packet_write(1, "unpack %s\n",
+		     unpack_status ? unpack_status : "ok");
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (!cmd->error_string)
+			packet_write(1, "ok %s\n",
+				     cmd->ref_name);
+		else
+			packet_write(1, "ng %s %s\n",
+				     cmd->ref_name, cmd->error_string);
 	}
+	packet_flush(1);
 }
 
 int main(int argc, char **argv)
@@ -275,8 +321,12 @@ int main(int argc, char **argv)
 
 	read_head_info();
 	if (commands) {
-		unpack();
-		execute_commands();
+		int code;
+		const char *unpack_status = unpack(&code);
+		if (!unpack_status)
+			execute_commands();
+		if (report_status)
+			report(unpack_status);
 	}
 	return 0;
 }
diff --git a/send-pack.c b/send-pack.c
index 0d41f9a..cd36193 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -176,16 +176,53 @@ static void get_local_heads(void)
 	for_each_ref(one_local_ref);
 }
 
+static int receive_status(int in)
+{
+	char line[1000];
+	int ret = 0;
+	int len = packet_read_line(in, line, sizeof(line));
+	if (len < 10 || memcmp(line, "unpack ", 7)) {
+		fprintf(stderr, "did not receive status back\n");
+		return -1;
+	}
+	if (memcmp(line, "unpack ok\n", 10)) {
+		fputs(line, stderr);
+		ret = -1;
+	}
+	while (1) {
+		len = packet_read_line(in, line, sizeof(line));
+		if (!len)
+			break;
+		if (len < 3 ||
+		    (memcmp(line, "ok", 2) && memcmp(line, "ng", 2))) {
+			fprintf(stderr, "protocol error: %s\n", line);
+			ret = -1;
+			break;
+		}
+		if (!memcmp(line, "ok", 2))
+			continue;
+		fputs(line, stderr);
+		ret = -1;
+	}
+	return ret;
+}
+
 static int send_pack(int in, int out, int nr_refspec, char **refspec)
 {
 	struct ref *ref;
 	int new_refs;
 	int ret = 0;
+	int ask_for_status_report = 0;
+	int expect_status_report = 0;
 
 	/* No funny business with the matcher */
 	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, 1);
 	get_local_heads();
 
+	/* Does the other end support the reporting? */
+	if (server_supports("report-status"))
+		ask_for_status_report = 1;
+
 	/* match them up */
 	if (!remote_tail)
 		remote_tail = &remote_refs;
@@ -260,7 +297,17 @@ static int send_pack(int in, int out, in
 		new_refs++;
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
 		new_hex = sha1_to_hex(ref->new_sha1);
-		packet_write(out, "%s %s %s", old_hex, new_hex, ref->name);
+
+		if (ask_for_status_report) {
+			packet_write(out, "%s %s %s%c%s",
+				     old_hex, new_hex, ref->name, 0,
+				     "report-status");
+			ask_for_status_report = 0;
+			expect_status_report = 1;
+		}
+		else
+			packet_write(out, "%s %s %s",
+				     old_hex, new_hex, ref->name);
 		fprintf(stderr, "updating '%s'", ref->name);
 		if (strcmp(ref->name, ref->peer_ref->name))
 			fprintf(stderr, " using '%s'", ref->peer_ref->name);
@@ -270,9 +317,15 @@ static int send_pack(int in, int out, in
 	packet_flush(out);
 	if (new_refs)
 		pack_objects(out, remote_refs);
-	else if (ret == 0)
-		fprintf(stderr, "Everything up-to-date\n");
 	close(out);
+
+	if (expect_status_report) {
+		if (receive_status(in))
+			ret = -4;
+	}
+
+	if (!new_refs && ret == 0)
+		fprintf(stderr, "Everything up-to-date\n");
 	return ret;
 }
 
-- 
1.0.GIT
