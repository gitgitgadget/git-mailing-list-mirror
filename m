From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: update-ref logs: problem with committer info?
Date: Fri, 4 Aug 2006 22:01:34 +0100
Message-ID: <000501c6b809$2b18cd60$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 04 23:03:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G96nV-0007Hj-Qg
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 23:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161442AbWHDVB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 17:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161446AbWHDVB0
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 17:01:26 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:42510 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S1161442AbWHDVBY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 17:01:24 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-36.mail.demon.net with smtp (Exim 4.42)
	id 1G96nK-000M7y-Ku
	for git@vger.kernel.org; Fri, 04 Aug 2006 21:01:23 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24841>

Hi all,

As a follow-up to the previous (two) email, this concerns the ability
to override the committer info from the config file. As before, this
depends on the relative call sites of setup_ident() and git_config().

In particular, the call to setup_ident(), from log_ref_write(),
which in turn is called from write_ref_sha1() in file refs.c.
Here, the call to setup_ident() seems to me to be misplaced and to
almost guarantee that it will over-write the values set by an
earlier call to git_config(). It is possible, I suppose, that there
has been no previous call to git_config(); just not very likely, and
even if that were so, then it should be the responsibility of the
*callers* of write_ref_sha1() to ensure this happens.

Indeed, tracing the callers of write_ref_sha1(), we find cmd_update_ref()
in builtin-update-ref.c and pull() in fetch.c. Adding a call to
setup_ident() in cmd_update_ref() takes care of that route. The callers
of pull() are to be found in http-fetch.c, local-fetch.c and ssh-fetch.c.
Adding calls to setup_ident() in these callers is equally simple, so it
only remains to remove the call from refs.c.

Now, as in the previous email, I can't compile http-fetch.c or test
the result. (Yes, I could test a local fetch, but I'm feeling lazy!)
In addition, I feel that somebody who knows the code better than I
should take a look.

comments?

Ramsay

diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 00333c7..83094ab 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -12,6 +12,7 @@ int cmd_update_ref(int argc, const char 
 	unsigned char sha1[20], oldsha1[20];
 	int i;
 
+	setup_ident();
 	setup_git_directory();
 	git_config(git_default_config);
 
diff --git a/http-fetch.c b/http-fetch.c
index 44eba5f..fe3a4fd 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1222,6 +1222,7 @@ int main(int argc, char **argv)
 	int arg = 1;
 	int rc = 0;
 
+	setup_ident();
 	setup_git_directory();
 	git_config(git_default_config);
 
diff --git a/local-fetch.c b/local-fetch.c
index ffa4887..d059a51 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -207,6 +207,7 @@ int main(int argc, char **argv)
 	char *commit_id;
 	int arg = 1;
 
+	setup_ident();
 	setup_git_directory();
 	git_config(git_default_config);
 
diff --git a/refs.c b/refs.c
index 713ca46..a4060d8 100644
--- a/refs.c
+++ b/refs.c
@@ -379,7 +379,6 @@ static int log_ref_write(struct ref_lock
 			lock->log_file, strerror(errno));
 	}
 
-	setup_ident();
 	comitter = git_committer_info(1);
 	if (msg) {
 		maxlen = strlen(comitter) + strlen(msg) + 2*40 + 5;
diff --git a/ssh-fetch.c b/ssh-fetch.c
index 1e59cd2..a42d17e 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -131,6 +131,7 @@ int main(int argc, char **argv)
 	prog = getenv("GIT_SSH_PUSH");
 	if (!prog) prog = "git-ssh-upload";
 
+	setup_ident();
 	setup_git_directory();
 	git_config(git_default_config);
 
