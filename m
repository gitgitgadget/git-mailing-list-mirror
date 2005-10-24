From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add git-shell.
Date: Sun, 23 Oct 2005 17:21:55 -0700
Message-ID: <7vhdb7vk64.fsf_-_@assigned-by-dhcp.cox.net>
References: <435ABB99.5020908@op5.se>
	<7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se>
	<7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510231427230.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 24 02:22:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETq6H-0005u5-WB
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 02:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVJXAV7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 20:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVJXAV7
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 20:21:59 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:3233 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750838AbVJXAV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 20:21:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024002124.QFJV776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Oct 2005 20:21:24 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510231427230.10477@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 23 Oct 2005 14:30:45 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10514>

This adds a very git specific restricted shell, that can be
added to /etc/shells and set to the pw_shell in the /etc/passwd
file, to give users ability to push into repositories over ssh
without giving them full interactive shell acount.

[jc: I updated Linus' patch to match what the current sq_quote()
 does.]

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

   This one has the '!' dequoting I mentioned earlier, and
   actually has been tested twice.

   The system administrator should set things up so that the
   system default PATH environment variable lets users run the
   supported commands.

   We currently rely on the user to have a full shell access for
   repository administrative actions (e.g. git-init-db to create
   a repository, git-repack, and hooks management).  Probably
   some of them may need to become accessible from git-shell,
   but I do not know which ones offhand:

   - Creating a repository.  Probably wherever the user has
     write privilege, or maybe only under the home directory --
     the policy would be up to the system administrator, with
     usual filesystem quota applied.

   - I think setting up hooks should be forbidden -- the user
     can execute arbitrary commands if we allowed it.  Instead,
     the administrator can set things up for people, and would
     probably make creative use of hooks/update to implement
     access control (e.g. forbidding non-fast-forward pushes).

   - Similarly, packing can be left to hooks/post-update or cron
     job, either of which is under administrator control.

 Makefile |    2 +-
 quote.c  |   41 ++++++++++++++++++++++++++++++++++++++++-
 quote.h  |    6 ++++++
 shell.c  |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100644 shell.c

applies-to: c043f0993afe5c057409ef748ce313c89c20c7dc
f176536e2cd5949fa134d8b24dc07dd1f0744b6f
diff --git a/Makefile b/Makefile
index 5bdf3cc..5b0306d 100644
--- a/Makefile
+++ b/Makefile
@@ -116,7 +116,7 @@ PROGRAMS = \
 	git-merge-index$X git-mktag$X git-pack-objects$X git-patch-id$X \
 	git-peek-remote$X git-prune-packed$X git-read-tree$X \
 	git-receive-pack$X git-rev-list$X git-rev-parse$X \
-	git-send-pack$X git-show-branch$X \
+	git-send-pack$X git-show-branch$X git-shell$X \
 	git-show-index$X git-ssh-fetch$X \
 	git-ssh-upload$X git-tar-tree$X git-unpack-file$X \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
diff --git a/quote.c b/quote.c
index 009e694..e662a7d 100644
--- a/quote.c
+++ b/quote.c
@@ -15,6 +15,11 @@
 #undef EMIT
 #define EMIT(x) ( (++len < n) && (*bp++ = (x)) )
 
+static inline int need_bs_quote(char c)
+{
+	return (c == '\'' || c == '!');
+}
+
 size_t sq_quote_buf(char *dst, size_t n, const char *src)
 {
 	char c;
@@ -23,7 +28,7 @@ size_t sq_quote_buf(char *dst, size_t n,
 
 	EMIT('\'');
 	while ((c = *src++)) {
-		if (c == '\'' || c == '!') {
+		if (need_bs_quote(c)) {
 			EMIT('\'');
 			EMIT('\\');
 			EMIT(c);
@@ -52,6 +57,40 @@ char *sq_quote(const char *src)
 	return buf;
 }
 
+char *sq_dequote(char *arg)
+{
+	char *dst = arg;
+	char *src = arg;
+	char c;
+
+	if (*src != '\'')
+		return NULL;
+	for (;;) {
+		c = *++src;
+		if (!c)
+			return NULL;
+		if (c != '\'') {
+			*dst++ = c;
+			continue;
+		}
+		/* We stepped out of sq */
+		switch (*++src) {
+		case '\0':
+			*dst = 0;
+			return arg;
+		case '\\':
+			c = *++src;
+			if (need_bs_quote(c) && *++src == '\'') {
+				*dst++ = c;
+				continue;
+			}
+		/* Fallthrough */
+		default:
+			return NULL;
+		}
+	}
+}
+
 /*
  * C-style name quoting.
  *
diff --git a/quote.h b/quote.h
index 2fdde3b..2486e6e 100644
--- a/quote.h
+++ b/quote.h
@@ -31,6 +31,12 @@
 extern char *sq_quote(const char *src);
 extern size_t sq_quote_buf(char *dst, size_t n, const char *src);
 
+/* This unwraps what sq_quote() produces in place, but returns
+ * NULL if the input does not look like what sq_quote would have
+ * produced.
+ */
+extern char *sq_dequote(char *);
+
 extern int quote_c_style(const char *name, char *outbuf, FILE *outfp,
 			 int nodq);
 extern char *unquote_c_style(const char *quoted, const char **endp);
diff --git a/shell.c b/shell.c
new file mode 100644
index 0000000..2c4789e
--- /dev/null
+++ b/shell.c
@@ -0,0 +1,59 @@
+#include "cache.h"
+#include "quote.h"
+
+static int do_generic_cmd(const char *me, char *arg)
+{
+	const char *my_argv[4];
+
+	arg = sq_dequote(arg);
+	if (!arg)
+		die("bad argument");
+
+	my_argv[0] = me;
+	my_argv[1] = arg;
+	my_argv[2] = NULL;
+
+	return execvp(me, (char**) my_argv);
+}
+
+static struct commands {
+	const char *name;
+	int (*exec)(const char *me, char *arg);
+} cmd_list[] = {
+	{ "git-receive-pack", do_generic_cmd },
+	{ "git-upload-pack", do_generic_cmd },
+	{ NULL },
+};
+
+int main(int argc, char **argv)
+{
+	char *prog;
+	struct commands *cmd;
+
+	/* We want to see "-c cmd args", and nothing else */
+	if (argc != 3 || strcmp(argv[1], "-c"))
+		die("What do you think I am? A shell?");
+
+	prog = argv[2];
+	argv += 2;
+	argc -= 2;
+	for (cmd = cmd_list ; cmd->name ; cmd++) {
+		int len = strlen(cmd->name);
+		char *arg;
+		if (strncmp(cmd->name, prog, len))
+			continue;
+		arg = NULL;
+		switch (prog[len]) {
+		case '\0':
+			arg = NULL;
+			break;
+		case ' ':
+			arg = prog + len + 1;
+			break;
+		default:
+			continue;
+		}
+		exit(cmd->exec(cmd->name, arg));
+	}
+	die("unrecognized command '%s'", prog);
+}
---
0.99.8.GIT
