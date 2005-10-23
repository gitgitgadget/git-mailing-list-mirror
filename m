From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: User-relative paths
Date: Sun, 23 Oct 2005 14:30:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510231427230.10477@g5.osdl.org>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net>
 <435B5AE0.1060400@op5.se> <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 23 23:32:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETnQm-0004DX-Cs
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 23:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVJWVa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 17:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVJWVa5
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 17:30:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750812AbVJWVa4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 17:30:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9NLUlFC022514
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 23 Oct 2005 14:30:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9NLUku4031112;
	Sun, 23 Oct 2005 14:30:46 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10505>



On Sun, 23 Oct 2005, Junio C Hamano wrote:
> 
> No, it is this one:
> 
>     http://marc.theaimsgroup.com/?l=git&m=112681457828137&w=2
> 
> But it is orthogonal to what you are doing in this patch.

Well, not necessarily.

It's quite arguable that sanity testing might be per-user and could be 
done by the shell. I'm not at all sure that srvside_chdir() should do any 
extra testing: if you have real ssh access, the user has the right to do 
anything he damn well pleases.

So it's quite possible that you should do testing in the thing that 
receives the request, ie in a restricted shell (or, as we already do, in 
git-daemon).

I tried to find my original unquote example and stupid shell, but 
couldn't.  So I wrote something untested as usual.

It's incomplete and almost certainly buggy and generally broken, but 
here's somethign that you _could_ install as "git-shell", and then put 
that as somebodys shell in /etc/passwd, and it's a start. A very rough 
start.

Somebody else gets to test it out ;)

		Linus

---
2906a25bbd1dedbd6bab9ed984a503340229b020
diff --git a/Makefile b/Makefile
index 7eacf61..34bbdb6 100644
--- a/Makefile
+++ b/Makefile
@@ -102,7 +102,7 @@ SCRIPT_PYTHON = \
 # The ones that do not have to link with lcrypto nor lz.
 SIMPLE_PROGRAMS = \
 	git-get-tar-commit-id$X git-mailinfo$X git-mailsplit$X \
-	git-stripspace$X git-var$X git-daemon$X
+	git-stripspace$X git-var$X git-daemon$X git-shell$X
 
 # ... and all the rest
 PROGRAMS = \
diff --git a/shell.c b/shell.c
new file mode 100644
index 0000000..676d398
--- /dev/null
+++ b/shell.c
@@ -0,0 +1,89 @@
+#include "cache.h"
+
+static char *dequote(char *arg)
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
+		switch (*++src) {
+		case '\0':
+			*dst = 0;
+			return arg;
+		case '\\':
+			if (*++src == '\'' &&
+			    *++src == '\'') {
+				*dst = '\'';
+				continue;
+			}
+		/* Fallthrough */
+		default:
+			return NULL;
+		}
+	}
+}
+
+static int do_receive_pack(char *arg)
+{
+	char cwd[1000];
+	char *my_argv[4];
+
+	arg = dequote(arg);
+	if (!arg)	
+		die("bad argument");
+
+	my_argv[0] = "git-receive-pack";
+	my_argv[1] = arg;
+	my_argv[2] = NULL;
+	return execvp("git-receive-pack", my_argv);
+}
+
+static struct commands {
+	const char *name;
+	int (*exec)(char *arg);
+} cmd_list[] = {
+	{ "git-receive-pack", do_receive_pack },
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
+		exit(cmd->exec(arg));
+	}
+	die("unrecognized command '%s'", prog);
+}
