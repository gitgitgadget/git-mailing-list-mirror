From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/6] git-peek-remote: show tags and heads from a remote repository.
Date: Sat, 23 Jul 2005 17:54:03 -0700
Message-ID: <7vll3xkor8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 02:54:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwUku-0004N2-Un
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 02:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVGXAyH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 20:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVGXAyG
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 20:54:06 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:21409 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261747AbVGXAyF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 20:54:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724005359.FXAH16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 20:53:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add a git-peek-remote command that talks with upload-pack the
same way git-fetch-pack and git-clone-pack do, to show the
references the remote side has on the standard output.

A later patch introduces git-ls-remote that implements a UI to
store tag values retrieved using this command.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile      |    3 ++-
 peek-remote.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletions(-)
 create mode 100644 peek-remote.c

06377142267dd3d0c7a37794b3d117531867cf04
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -49,7 +49,7 @@ PROG=   git-update-cache git-diff-files 
 	git-diff-stages git-rev-parse git-patch-id git-pack-objects \
 	git-unpack-objects git-verify-pack git-receive-pack git-send-pack \
 	git-prune-packed git-fetch-pack git-upload-pack git-clone-pack \
-	git-show-index git-daemon git-var
+	git-show-index git-daemon git-var git-peek-remote
 
 all: $(PROG)
 
@@ -150,6 +150,7 @@ git-send-pack: send-pack.c
 git-prune-packed: prune-packed.c
 git-fetch-pack: fetch-pack.c
 git-var: var.c
+git-peek-remote: peek-remote.c
 
 git-http-pull: LIBS += -lcurl
 git-rev-list: LIBS += -lssl
diff --git a/peek-remote.c b/peek-remote.c
new file mode 100644
--- /dev/null
+++ b/peek-remote.c
@@ -0,0 +1,55 @@
+#include "cache.h"
+#include "refs.h"
+#include "pkt-line.h"
+#include <sys/wait.h>
+
+static const char peek_remote_usage[] =
+"git-peek-remote [--exec=upload-pack] [host:]directory";
+static const char *exec = "git-upload-pack";
+
+static int peek_remote(int fd[2])
+{
+	struct ref *ref;
+
+	get_remote_heads(fd[0], &ref, 0, NULL);
+	packet_flush(fd[1]);
+
+	while (ref) {
+		printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
+		ref = ref->next;
+	}
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int i, ret;
+	char *dest = NULL;
+	int fd[2];
+	pid_t pid;
+
+	for (i = 1; i < argc; i++) {
+		char *arg = argv[i];
+
+		if (*arg == '-') {
+			if (!strncmp("--exec=", arg, 7))
+				exec = arg + 7;
+			else
+				usage(peek_remote_usage);
+			continue;
+		}
+		dest = arg;
+		break;
+	}
+	if (!dest || i != argc - 1)
+		usage(peek_remote_usage);
+
+	pid = git_connect(fd, dest, exec);
+	if (pid < 0)
+		return 1;
+	ret = peek_remote(fd);
+	close(fd[0]);
+	close(fd[1]);
+	finish_connect(pid);
+	return ret;
+}
