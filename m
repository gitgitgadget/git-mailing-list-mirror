From: Junio C Hamano <junkio@cox.net>
Subject: Re: minor problems in git.c
Date: Thu, 01 Dec 2005 17:07:09 -0800
Message-ID: <7v1x0wb936.fsf@assigned-by-dhcp.cox.net>
References: <72499e3b0512010400i1de76ed2la22cd745f811007f@mail.gmail.com>
	<81b0412b0512010448u7fcdddacnd7de5df217ab3ca@mail.gmail.com>
	<20051201135113.GW8383MdfPADPa@greensroom.kotnet.org>
	<81b0412b0512010602l63ecev1ba03fb90d06e071@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 02:08:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhzOX-0006uu-Cw
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 02:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbVLBBHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 20:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbVLBBHW
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 20:07:22 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:61152 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932685AbVLBBHV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 20:07:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202010600.JIDF17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 20:06:00 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13094>

Alex Riesen <raa.lkml@gmail.com> writes:

>> Shouldn't you check the return value of snprintf
>
> Probably. For the case where length of a git-command-name +
> --exec-prefix together are longer than PATH_MAX.

Combined, something like this.

-- >8 --
Subject: git wrapper: more careful argument stuffing
From: Alex Riesen <raa.lkml@gmail.com>
Date: Thu, 1 Dec 2005 13:48:35 +0100

 - Use stderr for error output
 - Build git_command more careful
 - ENOENT is good enough for check of failed exec to show usage, no
   access() check needed

[jc: Originally from Alex Riesen with inputs from Sven
 Verdoolaege mixed in.]

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

6e3f1bf88fdce10ba5c0274e017667d21bb68359
diff --git a/git.c b/git.c
index 0b10b6e..878c359 100644
--- a/git.c
+++ b/git.c
@@ -283,16 +283,21 @@ int main(int argc, char **argv, char **e
 	len = strlen(git_command);
 	prepend_to_path(git_command, len);
 
-	strncat(&git_command[len], "/git-", sizeof(git_command) - len);
-	len += 5;
-	strncat(&git_command[len], argv[i], sizeof(git_command) - len);
-
-	if (access(git_command, X_OK))
-		usage(exec_path, "'%s' is not a git-command", argv[i]);
+	len += snprintf(git_command + len, sizeof(git_command) - len,
+			"/git-%s", argv[i]);
+	if (sizeof(git_command) <= len) {
+		fprintf(stderr, "git: command name given is too long (%d)\n", len);
+		exit(1);
+	}
 
 	/* execve() can only ever return if it fails */
 	execve(git_command, &argv[i], envp);
-	printf("Failed to run command '%s': %s\n", git_command, strerror(errno));
+
+	if (errno == ENOENT)
+		usage(exec_path, "'%s' is not a git-command", argv[i]);
+
+	fprintf(stderr, "Failed to run command '%s': %s\n",
+		git_command, strerror(errno));
 
 	return 1;
 }
-- 
0.99.9.GIT
