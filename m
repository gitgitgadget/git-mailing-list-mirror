From: Jeff King <peff@peff.net>
Subject: Re: [RFC] send-pack: allow skipping delta when sending pack
Date: Sun, 21 May 2006 04:14:35 -0400
Message-ID: <20060521081435.GA4526@coredump.intra.peff.net>
References: <20060521054827.GA18530@coredump.intra.peff.net> <7vy7wvx5o9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 10:14:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhj5E-0006Db-Vq
	for gcvg-git@gmane.org; Sun, 21 May 2006 10:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWEUIOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 04:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWEUIOh
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 04:14:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:13782 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751501AbWEUIOh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 04:14:37 -0400
Received: (qmail 99238 invoked from network); 21 May 2006 08:14:35 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 21 May 2006 08:14:35 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 May 2006 04:14:35 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vy7wvx5o9.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20436>

On Sat, May 20, 2006 at 11:17:42PM -0700, Junio C Hamano wrote:

> base delta for that object to skip computation".  What you want
> here is "if the object we are going to send is not a delta in
> the source, and there are sufficient number of other objects the
> object could have been deltified against, then it is very likely
> that it was not worth deltifying when it was packed; so it is
> probably not worth deltifying it now".

I think we can make a stronger statement in many cases: "if the object
we are going to send is not a delta in the source, and there are no
other objects it could be deltified against, then it is not worth
deltifying." That is, in the case that we just packed we KNOW that it's
not worth it, since we're not sending anything that isn't already
packed.

Following this logic, I believe we could always turn off deltification
if there are no loose objects. It seems a bit special case, but it
optimizes the "repack -d then push" workflow which I suspect may be
relatively common.

The patch below runs git-rev-list with --unpacked; if there are no
objects returned, it tells pack-objects to set depth=0 (is that really
what we want? It's OK to use existing deltas; we just don't want to
compute any new ones. I'm not sure how --depth behaves in that respect).

-Peff

---

f3e7fb4a5025cc8157557f3da6f9dc7d0a89395f
 send-pack.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 58 insertions(+), 14 deletions(-)

f3e7fb4a5025cc8157557f3da6f9dc7d0a89395f
diff --git a/send-pack.c b/send-pack.c
index 409f188..0bddc0a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -25,18 +25,7 @@ static int is_zero_sha1(const unsigned c
 	return 1;
 }
 
-static void exec_pack_objects(void)
-{
-	static const char *args[] = {
-		"pack-objects",
-		"--stdout",
-		NULL
-	};
-	execv_git_cmd(args);
-	die("git-pack-objects exec failed (%s)", strerror(errno));
-}
-
-static void exec_rev_list(struct ref *refs)
+static void exec_rev_list(struct ref *refs, int unpacked)
 {
 	struct ref *ref;
 	static const char *args[1000];
@@ -47,6 +36,8 @@ static void exec_rev_list(struct ref *re
 		args[i++] = "--objects-edge";
 	else
 		args[i++] = "--objects";
+	if(unpacked)
+		args[i++] = "--unpacked";
 
 	/* First send the ones we care about most */
 	for (ref = refs; ref; ref = ref->next) {
@@ -85,6 +76,59 @@ static void exec_rev_list(struct ref *re
 	die("git-rev-list exec failed (%s)", strerror(errno));
 }
 
+static int rev_list_loose_objects(struct ref *refs)
+{
+	int fd[2];
+	pid_t pid;
+
+	if(pipe(fd) < 0)
+		die("rev-list setup: pipe failed");
+	pid = fork();
+	if(pid < 0)
+		die("rev-list setup: fork failed");
+	if(!pid) {
+		dup2(fd[1], 1);
+		close(fd[0]);
+		close(fd[1]);
+		exec_rev_list(refs, 1);
+		die("rev-list failed");
+	}
+	close(fd[1]);
+	return fd[0];
+}
+
+static int count_loose_objects(struct ref *refs)
+{
+	int fd = rev_list_loose_objects(refs);
+	unsigned count = 0;
+	char buf[4096];
+	int len;
+
+	while((len = read(fd, buf, sizeof buf)) > 0) {
+		int i;
+		for(i = 0; i < len; i++)
+			if(buf[i] == '\n')
+				count++;
+	}
+	if(len < 0)
+		die("rev-list read failed");
+	return count;
+}
+
+static void exec_pack_objects(struct ref *refs)
+{
+	static const char *args[] = {
+		"pack-objects",
+		"--stdout",
+		NULL,
+		NULL
+	};
+	if(count_loose_objects(refs) == 0)
+		args[2] = "--depth=0";
+	execv_git_cmd(args);
+	die("git-pack-objects exec failed (%s)", strerror(errno));
+}
+
 static void rev_list(int fd, struct ref *refs)
 {
 	int pipe_fd[2];
@@ -99,7 +143,7 @@ static void rev_list(int fd, struct ref 
 		close(pipe_fd[0]);
 		close(pipe_fd[1]);
 		close(fd);
-		exec_pack_objects();
+		exec_pack_objects(refs);
 		die("pack-objects setup failed");
 	}
 	if (pack_objects_pid < 0)
@@ -108,7 +152,7 @@ static void rev_list(int fd, struct ref 
 	close(pipe_fd[0]);
 	close(pipe_fd[1]);
 	close(fd);
-	exec_rev_list(refs);
+	exec_rev_list(refs, 0);
 }
 
 static int pack_objects(int fd, struct ref *refs)
-- 
1.3.3.gf1cf-dirty
