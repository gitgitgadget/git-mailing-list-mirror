From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] send pack switch to using git rev list stdin v2
Date: Wed, 6 Sep 2006 13:40:22 +0100
Message-ID: <20060906124022.GA30861@shadowen.org>
References: <44FEBFD6.10709@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 06 14:41:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKwiA-0000Su-T6
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 14:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWIFMkr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 08:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWIFMkq
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 08:40:46 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:63107
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750807AbWIFMkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 08:40:45 -0400
Received: from apw by localhost.localdomain with local (Exim 4.62)
	(envelope-from <apw@shadowen.org>)
	id 1GKwha-00081q-DZ; Wed, 06 Sep 2006 13:40:22 +0100
To: git@vger.kernel.org
Content-Disposition: inline
InReply-To: <44FEBFD6.10709@shadowen.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26518>

send-pack: switch to using git-rev-list --stdin v2

When we are generating packs to update remote repositories we
want to supply as much information as possible about the revisions
that already exist to rev-list in order optimise the pack as much
as possible.  We need to pass two revisions for each branch we are
updating in the remote repository and one for each additional branch.
Where the remote repository has numerous branches we can run out
of command line space to pass them.

Utilise the git-rev-list --stdin mode to allow unlimited numbers
of revision constraints.  This allows us to move back to the much
simpler unordered revision selection code.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/send-pack.c b/send-pack.c
index ac4501d..b403ee9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -38,9 +38,8 @@ static void exec_pack_objects(void)
 
 static void exec_rev_list(struct ref *refs)
 {
-	struct ref *ref;
-	static const char *args[1000];
-	int i = 0, j;
+	static const char *args[4];
+	int i = 0;
 
 	args[i++] = "rev-list";	/* 0 */
 	if (use_thin_pack)	/* 1 */
@@ -48,43 +47,29 @@ static void exec_rev_list(struct ref *re
 	else
 		args[i++] = "--objects";
 
-	/* First send the ones we care about most */
-	for (ref = refs; ref; ref = ref->next) {
-		if (900 < i)
-			die("git-rev-list environment overflow");
-		if (!is_zero_sha1(ref->new_sha1)) {
-			char *buf = xmalloc(100);
-			args[i++] = buf;
-			snprintf(buf, 50, "%s", sha1_to_hex(ref->new_sha1));
-			buf += 50;
-			if (!is_zero_sha1(ref->old_sha1) &&
-			    has_sha1_file(ref->old_sha1)) {
-				args[i++] = buf;
-				snprintf(buf, 50, "^%s",
-					 sha1_to_hex(ref->old_sha1));
-			}
-		}
-	}
+	args[i++] = "--stdin";
 
-	/* Then a handful of the remainder
-	 * NEEDSWORK: we would be better off if used the newer ones first.
-	 */
-	for (ref = refs, j = i + 16;
-	     i < 900 && i < j && ref;
-	     ref = ref->next) {
-		if (is_zero_sha1(ref->new_sha1) &&
-		    !is_zero_sha1(ref->old_sha1) &&
-		    has_sha1_file(ref->old_sha1)) {
-			char *buf = xmalloc(42);
-			args[i++] = buf;
-			snprintf(buf, 42, "^%s", sha1_to_hex(ref->old_sha1));
-		}
-	}
 	args[i] = NULL;
 	execv_git_cmd(args);
 	die("git-rev-list exec failed (%s)", strerror(errno));
 }
 
+static void builtin_rev_list_generate(struct ref *refs)
+{
+	while (refs) {
+		if (!is_zero_sha1(refs->old_sha1) &&
+		    has_sha1_file(refs->old_sha1)) {
+			printf("^%s\n", sha1_to_hex(refs->old_sha1));
+		}
+		if (!is_zero_sha1(refs->new_sha1)) {
+			printf("%s\n", sha1_to_hex(refs->new_sha1));
+		}
+		refs = refs->next;
+	}
+
+	exit(0);
+}
+
 static void rev_list(int fd, struct ref *refs)
 {
 	int pipe_fd[2];
@@ -111,13 +96,38 @@ static void rev_list(int fd, struct ref 
 	exec_rev_list(refs);
 }
 
+static void rev_list_generate(int fd, struct ref *refs)
+{
+	int pipe_fd[2];
+	pid_t rev_list_generate_pid;
+
+	if (pipe(pipe_fd) < 0)
+		die("rev-list-generate setup: pipe failed");
+	rev_list_generate_pid = fork();
+	if (!rev_list_generate_pid) {
+		dup2(pipe_fd[0], 0);
+		dup2(fd, 1);
+		close(pipe_fd[0]);
+		close(pipe_fd[1]);
+		close(fd);
+		rev_list(fd, refs);
+		die("rev-list setup failed");
+	}
+	if (rev_list_generate_pid < 0)
+		die("rev-list-generate fork failed");
+	dup2(pipe_fd[1], 1);
+	close(pipe_fd[0]);
+	close(pipe_fd[1]);
+	close(fd);
+	builtin_rev_list_generate(refs);
+}
 static void pack_objects(int fd, struct ref *refs)
 {
 	pid_t rev_list_pid;
 
 	rev_list_pid = fork();
 	if (!rev_list_pid) {
-		rev_list(fd, refs);
+		rev_list_generate(fd, refs);
 		die("rev-list setup failed");
 	}
 	if (rev_list_pid < 0)
