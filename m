From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] http-push: add support for deleting remote branches
Date: Mon, 20 Mar 2006 10:31:06 -0800
Message-ID: <20060320183106.GL3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 20 19:31:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLP9s-0004bb-7F
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 19:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWCTSbI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 13:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWCTSbI
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 13:31:08 -0500
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:11294 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751067AbWCTSbH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 13:31:07 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2KIV6Mu008399
	for <git@vger.kernel.org>; Mon, 20 Mar 2006 10:31:06 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2KIV6lq008397
	for git@vger.kernel.org; Mon, 20 Mar 2006 10:31:06 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17760>

Processes new command-line arguments -d and -D to remove a remote branch
if the following conditions are met:
- one branch name is present on the command line
- the specified branch name matches exactly one remote branch name
- the remote HEAD is a symref
- the specified branch is not the remote HEAD
- the remote HEAD resolves to an object that exists locally (-d only)
- the specified branch resolves to an object that exists locally (-d only)
- the specified branch is an ancestor of the remote HEAD (-d only)

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-push.c |  219 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 218 insertions(+), 1 deletions(-)

245873d765d8d380a146c7b77d09c1e9c2645daa
diff --git a/http-push.c b/http-push.c
index 42b0d59..e44310f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -7,6 +7,7 @@
 #include "http.h"
 #include "refs.h"
 #include "revision.h"
+#include "exec_cmd.h"
 
 #include <expat.h>
 
@@ -32,6 +33,7 @@ enum XML_Status {
 #define DAV_PROPFIND "PROPFIND"
 #define DAV_PUT "PUT"
 #define DAV_UNLOCK "UNLOCK"
+#define DAV_DELETE "DELETE"
 
 /* DAV lock flags */
 #define DAV_PROP_LOCKWR (1u << 0)
@@ -64,6 +66,9 @@ enum XML_Status {
 #define FETCHING (1u << 7)
 #define PUSHING  (1u << 8)
 
+/* We allow "recursive" symbolic refs. Only within reason, though */
+#define MAXDEPTH 5
+
 static int pushing = 0;
 static int aborted = 0;
 static char remote_dir_exists[256];
@@ -2103,6 +2108,197 @@ static int remote_exists(const char *pat
 	return -1;
 }
 
+static void fetch_symref(char *path, char **symref, unsigned char *sha1)
+{
+	char *url;
+	struct buffer buffer;
+	struct active_request_slot *slot;
+	struct slot_results results;
+
+	url = xmalloc(strlen(remote->url) + strlen(path) + 1);
+	sprintf(url, "%s%s", remote->url, path);
+
+	buffer.size = 4096;
+	buffer.posn = 0;
+	buffer.buffer = xmalloc(buffer.size);
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK) {
+			die("Couldn't get %s for remote symref\n%s",
+			    url, curl_errorstr);
+		}
+	} else {
+		die("Unable to start remote symref request");
+	}
+	free(url);
+
+	if (*symref != NULL)
+		free(*symref);
+	*symref = NULL;
+	memset(sha1, 0, 20);
+
+	if (buffer.posn == 0)
+		return;
+
+	/* If it's a symref, set the refname; otherwise try for a sha1 */
+	if (!strncmp((char *)buffer.buffer, "ref: ", 5)) {
+		*symref = xcalloc(buffer.posn - 5, 1);
+		strncpy(*symref, (char *)buffer.buffer + 5, buffer.posn - 6);
+	} else {
+		get_sha1_hex(buffer.buffer, sha1);
+	}
+
+	free(buffer.buffer);
+}
+
+static int verify_merge_base(unsigned char *head_sha1, unsigned char *branch_sha1)
+{
+	int pipe_fd[2];
+	pid_t merge_base_pid;
+	char line[PATH_MAX + 20];
+	unsigned char merge_sha1[20];
+	int verified = 0;
+
+	if (pipe(pipe_fd) < 0)
+		die("Verify merge base: pipe failed");
+
+	merge_base_pid = fork();
+	if (!merge_base_pid) {
+		static const char *args[] = {
+			"merge-base",
+			"-a",
+			NULL,
+			NULL,
+			NULL
+		};
+		args[2] = strdup(sha1_to_hex(head_sha1));
+		args[3] = sha1_to_hex(branch_sha1);
+
+		dup2(pipe_fd[1], 1);
+		close(pipe_fd[0]);
+		close(pipe_fd[1]);
+		execv_git_cmd(args);
+		die("merge-base setup failed");
+	}
+	if (merge_base_pid < 0)
+		die("merge-base fork failed");
+
+	dup2(pipe_fd[0], 0);
+	close(pipe_fd[0]);
+	close(pipe_fd[1]);
+	while (fgets(line, sizeof(line), stdin) != NULL) {
+		if (get_sha1_hex(line, merge_sha1))
+			die("expected sha1, got garbage:\n %s", line);
+		if (!memcmp(branch_sha1, merge_sha1, 20)) {
+			verified = 1;
+			break;
+		}
+	}
+
+	return verified;
+}
+
+static int delete_remote_branch(char *pattern, int force)
+{
+	struct ref *refs = remote_refs;
+	struct ref *remote_ref = NULL;
+	unsigned char head_sha1[20];
+	char *symref = NULL;
+	int match;
+	int patlen = strlen(pattern);
+	int i;
+	struct active_request_slot *slot;
+	struct slot_results results;
+	char *url;
+
+	/* Find the remote branch(es) matching the specified branch name */
+	for (match = 0; refs; refs = refs->next) {
+		char *name = refs->name;
+		int namelen = strlen(name);
+		if (namelen < patlen ||
+		    memcmp(name + namelen - patlen, pattern, patlen))
+			continue;
+		if (namelen != patlen && name[namelen - patlen - 1] != '/')
+			continue;
+		match++;
+		remote_ref = refs;
+	}
+	if (match == 0)
+		return error("No remote branch matches %s", pattern);
+	if (match != 1)
+		return error("More than one remote branch matches %s",
+			     pattern);
+
+	/*
+	 * Remote HEAD must be a symref (not exactly foolproof; a remote
+	 * symlink to a symref will look like a symref)
+	 */
+	fetch_symref("HEAD", &symref, head_sha1);
+	if (!symref)
+		return error("Remote HEAD is not a symref");
+
+	/* Remote branch must not be the remote HEAD */
+	for (i=0; symref && i<MAXDEPTH; i++) {
+		if (!strcmp(remote_ref->name, symref))
+			return error("Remote branch %s is the current HEAD",
+				     remote_ref->name);
+		fetch_symref(symref, &symref, head_sha1);
+	}
+
+	/* Run extra sanity checks if delete is not forced */
+	if (!force) {
+		/* Remote HEAD must resolve to a known object */
+		if (symref)
+			return error("Remote HEAD symrefs too deep");
+		if (is_zero_sha1(head_sha1))
+			return error("Unable to resolve remote HEAD");
+		if (!has_sha1_file(head_sha1))
+			return error("Remote HEAD resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", sha1_to_hex(head_sha1));
+
+		/* Remote branch must resolve to a known object */
+		if (is_zero_sha1(remote_ref->old_sha1))
+			return error("Unable to resolve remote branch %s",
+				     remote_ref->name);
+		if (!has_sha1_file(remote_ref->old_sha1))
+			return error("Remote branch %s resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", remote_ref->name, sha1_to_hex(remote_ref->old_sha1));
+
+		/* Remote branch must be an ancestor of remote HEAD */
+		if (!verify_merge_base(head_sha1, remote_ref->old_sha1)) {
+			return error("The branch '%s' is not a strict subset of your current HEAD.\nIf you are sure you want to delete it, run:\n\t'git http-push -D %s %s'", remote_ref->name, remote->url, pattern);
+		}
+	}
+
+	/* Send delete request */
+	fprintf(stderr, "Removing remote branch '%s'\n", remote_ref->name);
+	url = xmalloc(strlen(remote->url) + strlen(remote_ref->name) + 1);
+	sprintf(url, "%s%s", remote->url, remote_ref->name);
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_DELETE);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		free(url);
+		if (results.curl_result != CURLE_OK)
+			return error("DELETE request failed (%d/%ld)\n",
+				     results.curl_result, results.http_code);
+	} else {
+		free(url);
+		return error("Unable to start DELETE request");
+	}
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	struct transfer_request *request;
@@ -2112,6 +2308,8 @@ int main(int argc, char **argv)
 	struct remote_lock *ref_lock = NULL;
 	struct remote_lock *info_ref_lock = NULL;
 	struct rev_info revs;
+	int delete_branch = 0;
+	int force_delete = 0;
 	int objects_to_send;
 	int rc = 0;
 	int i;
@@ -2138,7 +2336,15 @@ int main(int argc, char **argv)
 				push_verbosely = 1;
 				continue;
 			}
-			usage(http_push_usage);
+			if (!strcmp(arg, "-d")) {
+				delete_branch = 1;
+				continue;
+			}
+			if (!strcmp(arg, "-D")) {
+				delete_branch = 1;
+				force_delete = 1;
+				continue;
+			}
 		}
 		if (!remote->url) {
 			remote->url = arg;
@@ -2158,6 +2364,9 @@ int main(int argc, char **argv)
 	if (!remote->url)
 		usage(http_push_usage);
 
+	if (delete_branch && nr_refspec != 1)
+		die("You must specify only one branch name when deleting a remote branch");
+
 	memset(remote_dir_exists, -1, 256);
 
 	http_init();
@@ -2193,6 +2402,14 @@ int main(int argc, char **argv)
 	fprintf(stderr, "Fetching remote heads...\n");
 	get_dav_remote_heads();
 
+	/* Remove a remote branch if -d or -D was specified */
+	if (delete_branch) {
+		if (delete_remote_branch(refspec[0], force_delete) == -1)
+			fprintf(stderr, "Unable to delete remote branch %s\n",
+				refspec[0]);
+		goto cleanup;
+	}
+
 	/* match them up */
 	if (!remote_tail)
 		remote_tail = &remote_refs;
-- 
1.2.4.g55c6-dirty
