From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [RFC] Single system account for multiple git users
Date: Mon, 30 Jun 2008 19:11:14 +0400
Message-ID: <20080630151113.GO5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 17:12:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDL3C-0002A2-KA
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 17:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYF3PLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 11:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbYF3PLV
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 11:11:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:35773 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbYF3PLU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 11:11:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so769132fgg.17
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 08:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=4H3fxgnVlQmj2KikyfmjD1luSQH8+PyuaQmtJSNoVPw=;
        b=izdStrGmcYeY0OIfdJcm4++IerFKD8qLLTDRaQQAcYcmdlU0sLyQTHoJyHEM/3ZZs4
         EuAVBjpGAFqQhOAs0QI2a/6bKivRPb/kHaTQHK3gqLfm4e12lEPO8vJgjOJfTN8K83l/
         HajuMPSn85Yw0w6K5lVTBkJ0BgEUQiHHIRbH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=PeUhxIyzSAlernpxMOZhdyu28cj3BWxVnv4AQXVPJA+tdlKi66Gv4QRjg1ZCZTq/Dr
         N2zMicgWfGp45ApUoj7V1UiSF4AtJWdMnjrfG0WYG6Z0ASP+VZYt0yiimqv1UUznE02v
         RZe5Is++qs/yqcGCiIPMmP/lNAvLIvI9VTYPk=
Received: by 10.86.33.19 with SMTP id g19mr3207437fgg.30.1214838678528;
        Mon, 30 Jun 2008 08:11:18 -0700 (PDT)
Received: from localhost ( [83.237.187.69])
        by mx.google.com with ESMTPS id l12sm9129441fgb.6.2008.06.30.08.11.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Jun 2008 08:11:17 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86915>

Hi,

Using SSH access with restricted git-shell as login shell and using
the script from the update-hook-example.txt works fine, but it requres
that every Git user has a separate system account on the server, which
is often frowned upon by system administrators, who would prefer to have
a single system account for access to Git repo.

I have looked on gitosis, but it requires normal shell account for
the git user, which was vetoed by sysadmin. Also, I found its
configuration more complex than necessary and not flexible enough
to differentiate what branches can have non-fast-forward pushes on
it and what cannot.

In fact, the simple solution for me would be to have authorized_key
for the git user being like this:

environment="GIT_USER=user1" ssh-rsa USER1-SSH-PUBLIC-KEY
environment="GIT_USER=user2" ssh-rsa USER2-SSH-PUBLIC-KEY
...

In this case, with one line change to update-hook-example from
username=$(id -u -n)
to
username="$GIT_USER"
I would get exactly what I want.

However, the environment option in authorized_key works only if
PermitUserEnvironment is set in sshd configuration, and this option
will allow _all_ users to overwrite their environment, which may be
not desirable in some settings for security reasons.

So, instead, I have to write a simple program, which is placed as
the login shell and interprets the given command as user name, sets
GIT_USER to it, and invokes git-shell with SSH_ORIGINAL_COMMAND.
Thus authorized_key looks like that:

command="git-su user1" ssh-rsa USER1-SSH-PUBLIC-KEY
command="git-su user2" ssh-rsa USER2-SSH-PUBLIC-KEY
...

But then I realized that it is simpler and more efficient to add
some built-in command to git-shell to do that.

You can see my patch below. I hope it will be useful for people
who wants to user git on server with a single system account for
all git users.

Dmitry

-- 8< --
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Wed, 25 Jun 2008 08:14:22 +0400
Subject: [PATCH] git-shell: add git-su command

git-su interprets the given command as a user name that must be set to the
GIT_USER environment variable and then executing SSH_ORIGINAL_COMMAND as
it were the command given to git-shell. This allows to have different
values for GIT_USER variable for different ssh public keys, which is
necessary to have a single system for many Git users. With this command
the typical authorized_key will for git user will be look like this:

command="git-su user1" ssh-rsa USER1-SSH-PUBLIC-KEY
command="git-su user2" ssh-rsa USER2-SSH-PUBLIC-KEY
...

The alternative of using the "environment" option in authorized_key may be
problematic as it requires that the PermitUserEnvironment option was set
in sshd_config and by default this option is not enabled, because it may
allow some users to bypass access restrictions.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

I moved command parsing logic from main() to a separate function,
(which makes the patch a bit bigger than it actually is) and then
added do_su_cmd(), which reuses this functionality.

 shell.c |   51 ++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/shell.c b/shell.c
index 91ca7de..05bd3cc 100644
--- a/shell.c
+++ b/shell.c
@@ -41,6 +41,19 @@ static int do_cvs_cmd(const char *me, char *arg)
 	return execv_git_cmd(cvsserver_argv);
 }
 
+static int exec_cmd(char *prog);
+
+static int do_su_cmd(const char *me, char *arg)
+{
+	char *cmd = getenv("SSH_ORIGINAL_COMMAND");
+	if (!cmd)
+		die("SSH_ORIGINAL_COMMAND is not set");
+	if (setenv("GIT_USER", arg, 1))
+		die ("setenv failed: %s", strerror(errno));
+	if (unsetenv("SSH_ORIGINAL_COMMAND"))
+		die ("unsetenv failed: %s", strerror(errno));
+	return exec_cmd(cmd);
+}
 
 static struct commands {
 	const char *name;
@@ -49,28 +62,14 @@ static struct commands {
 	{ "git-receive-pack", do_generic_cmd },
 	{ "git-upload-pack", do_generic_cmd },
 	{ "cvs", do_cvs_cmd },
+	{ "git-su", do_su_cmd },
 	{ NULL },
 };
 
-int main(int argc, char **argv)
+static int exec_cmd(char *prog)
 {
-	char *prog;
 	struct commands *cmd;
 
-	/*
-	 * Special hack to pretend to be a CVS server
-	 */
-	if (argc == 2 && !strcmp(argv[1], "cvs server"))
-		argv--;
-
-	/*
-	 * We do not accept anything but "-c" followed by "cmd arg",
-	 * where "cmd" is a very limited subset of git commands.
-	 */
-	else if (argc != 3 || strcmp(argv[1], "-c"))
-		die("What do you think I am? A shell?");
-
-	prog = argv[2];
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
@@ -91,7 +90,25 @@ int main(int argc, char **argv)
 		default:
 			continue;
 		}
-		exit(cmd->exec(cmd->name, arg));
+		return cmd->exec(cmd->name, arg);
 	}
 	die("unrecognized command '%s'", prog);
 }
+
+int main(int argc, char **argv)
+{
+	/*
+	 * Special hack to pretend to be a CVS server
+	 */
+	if (argc == 2 && !strcmp(argv[1], "cvs server"))
+		argv--;
+
+	/*
+	 * We do not accept anything but "-c" followed by "cmd arg",
+	 * where "cmd" is a very limited subset of git commands.
+	 */
+	else if (argc != 3 || strcmp(argv[1], "-c"))
+		die("What do you think I am? A shell?");
+
+	return exec_cmd(argv[2]);
+}
-- 
1.5.6.1
