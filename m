From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] shell: allow 'help' command to disable interactive shell
Date: Sun, 10 Feb 2013 17:20:16 -0800
Message-ID: <20130211012016.GA13243@elie.Belkin>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 02:20:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4i4m-0007Qy-7Z
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 02:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715Ab3BKBU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 20:20:29 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:33447 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab3BKBU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 20:20:28 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so470048pbc.24
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 17:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Tr/Joe3th7r9/6qk9rXxTwb9F51fabhJXx+vqLLx2Po=;
        b=T3eoi2VQ+m7/IOX2RlbJuluNvledlImwHNp6HIrJk3+OaDrIayWLs3M45MEhnLbjNV
         9Tng1MQ2Q064fYDSQEGkbLOr4KzfZvQqskVjyFq7Id19ziIM/MhZHQYSB44VGCKZh6zK
         Plyu1/4UeZihfRslwgQPve+dTaJIAqjEPINhOzjhYfnhTUStp8i/qqEZzsGGLrLHKQn7
         XI7Xh8skEVXjgHV2ce2DmZ5RIIwISo47Axd2nBdeIOUPWsLbJ3gq4ZbM2V+HvRu3QOuL
         BLf7/YW6zuYKtcw+7iwtJ49DiSGPKrGATh8F857v8m2jUYbaazDmh2siB2Ue5cXGDAQL
         AbfQ==
X-Received: by 10.66.86.201 with SMTP id r9mr37773452paz.14.1360545627588;
        Sun, 10 Feb 2013 17:20:27 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id p6sm5891664pbc.39.2013.02.10.17.20.24
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 17:20:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215975>

If I disable git-shell's interactive mode by removing the
~/git-shell-commands directory, then attempts to use 'ssh' with the
git account interactively produce an error message intended for the
administrator:

	$ ssh git@myserver
	fatal: Interactive git shell is not enabled.
	hint: ~/git-shell-commands should exist and have read and execute access.
	$

It is better to give the user a friendly hint that she is on the
right track, like GitHub does:

	Hi <username>! You've successfully authenticated, but
	GitHub does not provide shell access.

An appropriate greeting might even include more complex information,
like a list of repositories the user has access to.  A
git-shell-commands directory with only a "help" script can get us most
of the way there, but it unfortunately it produces a "git>" prompt
where the user can do nothing but ask for more help or exit.  So allow
the "help" script to abort the shell by exiting with nonzero status.

Downside: this will prevent interactive git-shell logins in existing
setups where the "help" script exits with nonzero status by mistake.
Hopefully those are rare enough to not cause much trouble in practice.

Reported-by: Ethan Reesor <firelizzard@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sitaram Chamarty wrote:

> Indeed!  In gitolite, I borrowed that idea added to it by making it
> print a list of repos you have access to, along with what permissions
> (R or RW) you have :-)
>
> I'm not suggesting git should do that, but instead of a fixed string,
> a default command to be executed would be better.

Good call.

[...]
> This of course now means that the ~/git-shell-commands should not be
> empty, since that is where this default command also will be present.

How about this?

A patch on top could change the default "git-shell-commands is not
present" message if that seems worthwhile.

 Documentation/git-shell.txt | 26 ++++++++++++++++++++++++++
 shell.c                     | 10 ++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 9b925060..758083ff 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -29,6 +29,32 @@ read and execute permissions to the directory in order to execute the
 programs in it. The programs are executed with a cwd of $HOME, and
 <argument> is parsed as a command-line string.
 
+When run interactively (with no arguments), 'git-shell' will
+automatically run `~/git-shell-commands/help` on startup, provided it
+exists.  If the 'help' command fails then the interactive shell is
+aborted.
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
+SEE ALSO
+--------
+contrib/git-shell-commands/README
+
 GIT
 ---
 Part of the linkgit:git[1] suite
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
