From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Added hook in git-receive-pack
Date: Sun, 31 Jul 2005 21:17:43 +0200
Message-ID: <200507312117.43957.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 31 21:22:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzJNb-00051s-Qq
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 21:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVGaTVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 15:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVGaTSm
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 15:18:42 -0400
Received: from mail.gmx.de ([213.165.64.20]:63964 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261926AbVGaTR7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 15:17:59 -0400
Received: (qmail invoked by alias); 31 Jul 2005 19:17:58 -0000
Received: from p5496AE80.dip0.t-ipconnect.de (EHLO linux) [84.150.174.128]
  by mail.gmx.net (mp033) with SMTP; 31 Jul 2005 21:17:58 +0200
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Added hook in git-receive-pack

After successful update of a ref,

 $GIT_DIR/hooks/update refname old-sha1 new-sha2

is called if present. This allows e.g sending of a mail
with pushed commits on the remote repository.
Documentation update with example hook included.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
------------------------------------------------

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -20,10 +20,25 @@ This command is usually not invoked dire
 The UI for the protocol is on the 'git-send-pack' side, and the
 program pair is meant to be used to push updates to remote
 repository.  For pull operations, see 'git-fetch-pack' and
 'git-clone-pack'.

+The command allows for creation and fast forwarding of sha1 refs
+(heads/tags) on the local end. After each successful update, the
+following external hook script is called if it is present:
+
+       $GIT_DIR/hooks/update refname sha1-old sha1-new
+
+It is assured that sha1-old is an ancestor of sha1-new (otherwise,
+the update would have not been allowed). refname is relative to
+$GIT_DIR; e.g. for the master head this is "refs/heads/master".
+Using this hook, it is easy to generate mails on updates to
+the local repository. This example script sends a mail with
+the commits pushed to the repository:
+
+       #!/bin/sh
+       git-rev-list --pretty "$3" "^$2" |
+        mail -r $USER -s "New commits on $1" commit-list@mydomain

 OPTIONS
 -------
 <directory>::
        The repository to sync into.
diff --git a/receive-pack.c b/receive-pack.c
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -53,10 +53,53 @@ static int verify_old_ref(const char *na
        if (memcmp(buffer, hex_contents, 40))
                return -1;
        return 0;
 }

+static const char *update_hook = "hooks/update";
+
+static void updatehook(const char *name, unsigned char *old_sha1, unsigned char *new_sha1)
+{
+        if (access(update_hook, X_OK) < 0) return;
+       fprintf(stderr, "executing update hook for %s\n", name);
+
+       pid_t pid = fork();
+
+       if (pid < 0)
+               die("hook fork failed");
+       if (!pid) {
+               execlp(update_hook, update_hook, name, old_sha1, new_sha1, NULL);
+               die("hook execute failed");
+       }
+
+       for (;;) {
+               int status, code;
+               int retval = waitpid(pid, &status, 0);
+
+               if (retval < 0) {
+                       if (errno == EINTR)
+                               continue;
+                       die("waitpid failed (%s)", strerror(retval));
+               }
+               if (retval != pid)
+                       die("waitpid is confused");
+               if (WIFSIGNALED(status)) {
+                   fprintf(stderr, "%s died of signal %d",
+                           update_hook, WTERMSIG(status));
+                   return;
+               }
+               if (!WIFEXITED(status))
+                       die("%s died out of really strange complications",
+                           update_hook);
+               code = WEXITSTATUS(status);
+               if (code)
+                   fprintf(stderr, "%s exited with error code %d",
+                           update_hook, code);
+               return;
+       }
+}
+
 static void update(const char *name, unsigned char *old_sha1, unsigned char *new_sha1)
 {
        char new_hex[60], *old_hex, *lock_name;
        int newfd, namelen, written;

@@ -93,10 +136,12 @@ static void update(const char *name, uns
        if (rename(lock_name, name) < 0) {
                unlink(lock_name);
                die("unable to replace %s", name);
        }
        fprintf(stderr, "%s: %s -> %s\n", name, old_hex, new_hex);
+
+       updatehook(name, old_hex, new_hex);
 }


 /*
  * This gets called after(if) we've successfully
