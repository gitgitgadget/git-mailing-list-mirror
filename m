From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] shell: allow git command with --namespace option
Date: Fri, 15 Nov 2013 17:49:40 +0800
Message-ID: <0469850db334fb22b7cf15848897c7e1b1a8b291.1384508792.git.worldhello.net@gmail.com>
References: <CANYiYbGiXkBQdXMGbcGV6WjtG82ax6z94TMatP2ZTQ54=KgMjg@mail.gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 15 10:50:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhG2b-0004UE-1D
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 10:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757961Ab3KOJuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 04:50:12 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35105 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590Ab3KOJuH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 04:50:07 -0500
Received: by mail-pd0-f173.google.com with SMTP id x10so3272530pdj.18
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 01:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nh0p6gvmElZmTduQRpDXg0J+9GYd/myawDlNR1j18X0=;
        b=Bkcpk2vE1pdb97F0IaDk6Y/Ag/O7iLwPHNtlOAr4Sy+3vTYbOgD6WRsn/IELo/UIXq
         63tNn4Hi7SuSAxZg0R8WGwR9HfHBrKlD1iQO3JeZ9+Y/akIgyz7ZVSJ5QYE+jFjVu2U6
         2S2qEiun+0giQ8Eo4UzN28NRgY/HwSj0kMLZTQOfo13qVChdQCfenaGYZ2T3xNvJU2uu
         y2AtdyXC/jT0DYxyYfsgAr/BDl1tiHulAylvOQsZDIV+MOSMW6de81ItHumXjzUwsxzr
         EP4yQZT/CpalnIVbLI8jXyNaKB4h3hk/i3DFdaBd7G7p16JtV4i7Gg2uRvz+os5DPP9q
         MmHQ==
X-Received: by 10.68.113.195 with SMTP id ja3mr1399892pbb.176.1384509005701;
        Fri, 15 Nov 2013 01:50:05 -0800 (PST)
Received: from localhost.localdomain ([114.248.136.10])
        by mx.google.com with ESMTPSA id xn12sm3673325pac.12.2013.11.15.01.50.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 15 Nov 2013 01:50:04 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc2.2.g0469850
In-Reply-To: <CANYiYbGiXkBQdXMGbcGV6WjtG82ax6z94TMatP2ZTQ54=KgMjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237895>

GIT_NAMESPACE is designed to be used mainly on the server side, that
the server can serve multiple git repositories while share one single
repository storage using different GIT_NAMESPACE settings.

Since we know that one remote repository hosts multiple namespaces,
can we handle different namespaces in one local repository? Or can
we access the proper namespace of the remote repository without
complicated server settings?

We can access namespace of remote repository using a proper formated
URL or with the help of settings of "remote.<name>.receivepack" and
"remote.<name>.uploadpack". E.g.

Use remote-ext style URL to access specific namespace of the remote:

    $ git remote add foo \
        'ext::ssh git@server git --namespace foo %s path/to/repo.git'

    $ git remote add bar \
        'ext::ssh git@server git --namespace bar %s path/to/repo.git'

Or set "remote.<name>.receivepack" and "remote.<name>.uploadpack".

    [remote "foo"]
        url = ssh://git@server/path/to/repo.git
        receivepack = git --namespace foo receive-pack
        uploadpack = git --namespace foo upload-pack
        fetch = +refs/heads/*:refs/remotes/foo/*

    [remote "bar"]
        url = ssh://git@server/path/to/repo.git
        receivepack = git --namespace bar receive-pack
        uploadpack = git --namespace bar upload-pack
        fetch = +refs/heads/*:refs/remotes/foo/*

But if the remote ssh server use a limit shell (such as git-shell
or gitolite), the above URLs won't work. This is because these git
specific shell (git-shell or gitolite) do not like options.

This patch makes git-shell aware of the "--namespace" option.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 shell.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/shell.c b/shell.c
index 66350b2..a619577 100644
--- a/shell.c
+++ b/shell.c
@@ -25,6 +25,50 @@ static int do_generic_cmd(const char *me, char *arg)
 	return execv_git_cmd(my_argv);
 }
 
+static int do_git_with_opts_cmd(const char *me, char *arg)
+{
+	const char *allowed_cmds[] = {
+		"receive-pack",
+		"upload-pack",
+		"upload-archive",
+		NULL,
+	};
+	const char **user_argv, **p;
+	const char *cmd = NULL;
+	int count;
+
+	count = split_cmdline(arg, &user_argv);
+	if (count < 0) {
+		die ("Invalid command format '%s'\n", arg);
+	}
+
+	if (count == 3 && !strncmp("--namespace=", *user_argv, 12)) {
+		cmd = user_argv[1];
+		p = user_argv + 2;
+	} else if (count == 4 && !strcmp("--namespace", *user_argv)) {
+		cmd = user_argv[2];
+		p = user_argv + 3;
+	} else {
+		cmd = user_argv[0];
+		p = user_argv + 1;
+	}
+
+	if (cmd) {
+		/* last arg is path of repository */
+		if (!*p || *(p+1))
+			die("bad argument");
+
+		for (p = allowed_cmds; *p; p++) {
+			if (strcmp(*p, cmd))
+				continue;
+			setup_path();
+			return execv_git_cmd(user_argv);
+		}
+	}
+
+	die("bad command");
+}
+
 static int do_cvs_cmd(const char *me, char *arg)
 {
 	const char *cvsserver_argv[3] = {
@@ -138,6 +182,7 @@ static struct commands {
 	{ "git-receive-pack", do_generic_cmd },
 	{ "git-upload-pack", do_generic_cmd },
 	{ "git-upload-archive", do_generic_cmd },
+	{ "git", do_git_with_opts_cmd },
 	{ "cvs", do_cvs_cmd },
 	{ NULL },
 };
@@ -185,7 +230,7 @@ int main(int argc, char **argv)
 	}
 
 	prog = xstrdup(argv[2]);
-	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
+	if (!strncmp(prog, "git", 3) && isspace(prog[3]) && isalpha(prog[4]))
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
 
-- 
1.8.5.rc2.2.g0469850
