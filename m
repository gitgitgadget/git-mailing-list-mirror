From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] shell: new no-interactive-login command to print a
 custom message
Date: Sat, 9 Mar 2013 14:00:11 -0800
Message-ID: <20130309220011.GC24777@elie.Belkin>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130309215237.GA24777@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Ethan Reesor <firelizzard@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 23:00:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UERos-0008OM-CV
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 23:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab3CIWAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 17:00:19 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37830 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab3CIWAR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 17:00:17 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so2419582pbc.33
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 14:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0MEQAuuOpG+Wi8D7DQN0jPqY+dFh1TkfANUHr0OWjVs=;
        b=Iqpy3FSjLEgWtIZZJDymkHPoE2j4nwBpGu9vzIpIXHQKiBOn5uRIoUxQxh38oR2jOj
         XjLIvYi4C2i/jTujUMFW6a1TeSt/lcp98/Enz0ee4DNJM//Rzuz3v36tAIdKb1SV4HUK
         /EPSmCNCawvT38HnJHdcdawHojXTffEc+AYTgn96DwIEEne6c/jY6tX8F0QOcYUd9LT1
         Mj70Y4oQ1KH6WBk4238kbw16TeQsVK8pmKxsXsQkVTuRhCeFaU8PQkTuT4NuIC+j1uQ6
         S/LKrDERvW8StEqm94Ny28sN5uipnxEH4CLrcvY9hZl2owDIT9ZBPNh+OGUKrXPPQ+ES
         KPpg==
X-Received: by 10.68.138.225 with SMTP id qt1mr8166352pbb.82.1362866417218;
        Sat, 09 Mar 2013 14:00:17 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id rr14sm12045447pbb.34.2013.03.09.14.00.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 14:00:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130309215237.GA24777@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217768>

If I disable git-shell's interactive mode by removing the
~/git-shell-commands directory, attempts to use 'ssh' in produce a
message intended for the administrator:

	$ ssh git@myserver
	fatal: Interactive git shell is not enabled.
	hint: ~/git-shell-commands should exist and have read and execute access.
	$

That is helpful for the new admin who is wondering "What? Why isn't
the git-shell I just set up working?", but once the site setup is
complete, it would be better to give the user a friendly hint that she
is on the right track, like GitHub does.

	Hi <username>! You've successfully authenticated, but
	GitHub does not provide shell access.

An appropriate greeting might even include more complex dynamic
information, like gitolite's list of repositories the user has access
to.  Add support for a ~/git-shell-commands/no-interactive-login
command that generates an arbitrary greeting.  When the user tries to
log in:

 * If the file ~/git-shell-commands/no-interactive-login exists,
   run no-interactive-login to let the server say what it likes,
   then hang up.

 * Otherwise, if ~/git-shell-commands/ is present, start an
   interactive read-eval-print loop.

 * Otherwise, print the usual configuration hint and hang up.

Reported-by: Ethan Reesor <firelizzard@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Jeff King <peff@peff.net>
---
v2 jammed this functionality into the "help" command, which was kind
of silly.  Hopefully this version's better.

This is not urgent at all.  If it looks like a good change, I'd be
happy to see it be a part of the 1.8.3 cycle.

Thoughts?
Jonathan

 Documentation/git-shell.txt | 20 ++++++++++++++++++++
 shell.c                     | 13 +++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 544b21aa..c35051ba 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -59,6 +59,26 @@ users to list repositories they have access to, create, delete, or
 rename repositories, or change repository descriptions and
 permissions.
 
+If a `no-interactive-login` command exists, then it is run and the
+interactive shell is aborted.
+
+EXAMPLE
+-------
+
+To disable interactive logins, displaying a greeting instead:
++
+----------------
+$ chsh -s /usr/bin/git-shell
+$ mkdir $HOME/git-shell-commands
+$ cat >$HOME/git-shell-commands/no-interactive-login <<\EOF
+#!/bin/sh
+printf '%s\n' "Hi $USER! You've successfully authenticated, but I do not"
+printf '%s\n' "provide interactive shell access."
+exit 128
+EOF
+$ chmod +x $HOME/git-shell-commands/no-interactive-login
+----------------
+
 SEE ALSO
 --------
 ssh(1),
diff --git a/shell.c b/shell.c
index 84b237fe..1429870a 100644
--- a/shell.c
+++ b/shell.c
@@ -6,6 +6,7 @@
 
 #define COMMAND_DIR "git-shell-commands"
 #define HELP_COMMAND COMMAND_DIR "/help"
+#define NOLOGIN_COMMAND COMMAND_DIR "/no-interactive-login"
 
 static int do_generic_cmd(const char *me, char *arg)
 {
@@ -65,6 +66,18 @@ static void run_shell(void)
 {
 	int done = 0;
 	static const char *help_argv[] = { HELP_COMMAND, NULL };
+
+	if (!access(NOLOGIN_COMMAND, F_OK)) {
+		/* Interactive login disabled. */
+		const char *argv[] = { NOLOGIN_COMMAND, NULL };
+		int status;
+
+		status = run_command_v_opt(argv, 0);
+		if (status < 0)
+			exit(127);
+		exit(status);
+	}
+
 	/* Print help if enabled */
 	run_command_v_opt(help_argv, RUN_SILENT_EXEC_FAILURE);
 
-- 
1.8.2.rc3
