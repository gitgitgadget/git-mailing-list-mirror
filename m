From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] shell: pay attention to exit status from 'help' command
Date: Sun, 10 Feb 2013 21:58:47 -0800
Message-ID: <20130211055847.GG15329@elie.Belkin>
References: <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin>
 <20130211041714.GA12281@sigill.intra.peff.net>
 <20130211042609.GC15329@elie.Belkin>
 <20130211043322.GA12735@sigill.intra.peff.net>
 <20130211055604.GE15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 06:59:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4mQB-0000xX-40
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 06:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab3BKF64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 00:58:56 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:44192 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3BKF6z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 00:58:55 -0500
Received: by mail-da0-f51.google.com with SMTP id n15so2544879dad.38
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 21:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9fJhV80UiPQAdLM2WCtYdWb0O9Dap69CKqlRJUK19fs=;
        b=XnMee7FCH4Egg1OjrJ0UeeT8TdHw+mdm2vCJ2dIgQ+/Nu093e2ia8vYiEMG93NFu6l
         2Yb+qx4UVYoKCENbSWbsO9foo+ZB0BwZ5UwBFjsAZuhtq74dAw8wqPZzWwhDMZ7YRf8p
         A2sHTRys+tFFh8Nc69Jp3Js9kIH0uZCosfMPsMJhCqXZZyYwCrZvgfI1TsYF/zZuwNA4
         JiUclG83pa1YX32E4ZLQglsreV46H2TK3uEdbTS2bdL2DtCrZzkgnwKF+9TXu0e+3I3r
         WpztPD6Tz1TAPPRnQPGLAPzc0FkesRfvogQ34zwgnXH0XVyocU++y8Eu6IwuOXMrdjFT
         h3hw==
X-Received: by 10.66.52.1 with SMTP id p1mr25087420pao.22.1360562335267;
        Sun, 10 Feb 2013 21:58:55 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id a4sm65835866paw.21.2013.02.10.21.58.52
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 21:58:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130211055604.GE15329@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215996>

If I disable git-shell's interactive mode by removing the
~/git-shell-commands directory, then attempts to use 'ssh' with the
git account interactively produce an error message intended for the
administrator:

	$ ssh git@myserver
	fatal: Interactive git shell is not enabled.
	hint: ~/git-shell-commands should exist and have read and execute access.
	$

That is helpful for the new admin who is wondering "What? Why isn't
the git-shell I just set up working?", but once the site setup is
finished, it is better to give the user a friendly hint that she is on
the right track, like GitHub does:

	Hi <username>! You've successfully authenticated, but
	GitHub does not provide shell access.

An appropriate greeting might even include more complex information,
like a list of repositories the user has access to.  If the
git-shell-commands directory exists and contains a "help" script, we
already run it when the shell is run without any commands, giving the
server a chance to provide a custom message.  Unfortunately, the
presence of the git-shell-commands directory means we also enter an
interactive mode, prompting and accepting commands (of which there may
be none) from the user, which many servers would not want.  To solve
this, we abort the interactive shell on a non-zero exit code from the
"help" script.  This lets the server say whatever it likes, and then
hang up.

Downside: this will prevent interactive git-shell logins in existing
setups where the "help" script exits with nonzero status by mistake.
Hopefully those are rare enough to not cause much trouble in practice.

Reported-by: Ethan Reesor <firelizzard@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Jeff King <peff@peff.net>
---
 Documentation/git-shell.txt | 20 ++++++++++++++++++++
 shell.c                     | 10 ++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 4fe93203..60051e63 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -59,6 +59,26 @@ users to list repositories they have access to, create, delete, or
 rename repositories, or change repository descriptions and
 permissions.
 
+If the `help` command exists and exits with nonzero status, the
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
+$ cat >$HOME/git-shell-commands/help <<\EOF
+#!/bin/sh
+printf '%s\n' "Hi $USER! You've successfully authenticated, but I do not"
+printf '%s\n' "provide interactive shell access."
+exit 128
+EOF
+$ chmod +x $HOME/git-shell-commands/help
+----------------
+
 SEE ALSO
 --------
 ssh(1),
diff --git a/shell.c b/shell.c
index 84b237fe..3abc2b84 100644
--- a/shell.c
+++ b/shell.c
@@ -63,10 +63,16 @@ static void cd_to_homedir(void)
 
 static void run_shell(void)
 {
-	int done = 0;
+	int done = 0, status;
 	static const char *help_argv[] = { HELP_COMMAND, NULL };
 	/* Print help if enabled */
-	run_command_v_opt(help_argv, RUN_SILENT_EXEC_FAILURE);
+	status = run_command_v_opt(help_argv, RUN_SILENT_EXEC_FAILURE);
+	if (!status)
+		; /* success */
+	else if (status == -1 && errno == ENOENT)
+		; /* help disabled */
+	else
+		exit(status);
 
 	do {
 		struct strbuf line = STRBUF_INIT;
-- 
1.8.1.3
