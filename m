From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 08/23] remote-helpers: export GIT_DIR variable to helpers
Date: Sat, 16 Jul 2011 15:03:28 +0200
Message-ID: <1310821424-4750-9-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:04:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4Y7-0005EN-RW
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab1GPNEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:04:40 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37348 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567Ab1GPNEj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:04:39 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so996059ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JVuageNkrOcUll+G4hliwQ49ZsW7hNnCaxsG2yNN8hU=;
        b=IljeTY0C43Pld3L1Nn8+kxvVQeAAjOr15LT2zaheTVfbfQenYePmkVQ4CTxST3wR6P
         YUkkTRuyc4qiffYihNEVAJKoP9pJ2kZ9fP4QmGGJm9SW/b7d56up6Z0FcqU4zsP5JXgy
         QTyHeZ6D9btHa5sA59+PsYZZB45tB6VZZ24+U=
Received: by 10.213.33.79 with SMTP id g15mr580363ebd.39.1310821478704;
        Sat, 16 Jul 2011 06:04:38 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177259>

From: Dmitry Ivankov <divanorama@gmail.com>

The gitdir capability is recognized by git and can be used to tell
the helper where the .git directory is. But it is not mentioned in
the documentation and considered worse than if gitdir was passed
via GIT_DIR environment variable.

Remove support for the gitdir capability and export GIT_DIR instead.
Teach testgit to use env instead of the now-removed gitdir command.

[sr: fixed up documentation]

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  New in this series.

 Documentation/git-remote-helpers.txt |    3 +++
 git-remote-testgit.py                |   14 +-------------
 transport-helper.c                   |   15 ++++++++++-----
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 58f6ad4..18b8341 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -47,6 +47,9 @@ arguments. The first argument specifies a remote repository as in git;
 it is either the name of a configured remote or a URL. The second
 argument specifies a URL; it is usually of the form
 '<transport>://<address>', but any arbitrary string is possible.
+The 'GIT_DIR' environment variable is set up for the remote helper
+and can be used to determine where to store additional data or from
+which directory to invoke auxiliary git commands.
 
 When git encounters a URL of the form '<transport>://<address>', where
 '<transport>' is a protocol that it cannot handle natively, it
diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index e4a99a3..b0c1e9b 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -35,7 +35,7 @@ def get_repo(alias, url):
     prefix = 'refs/testgit/%s/' % alias
     debug("prefix: '%s'", prefix)
 
-    repo.gitdir = ""
+    repo.gitdir = os.environ["GIT_DIR"]
     repo.alias = alias
     repo.prefix = prefix
 
@@ -70,7 +70,6 @@ def do_capabilities(repo, args):
 
     print "import"
     print "export"
-    print "gitdir"
     print "refspec refs/heads/*:%s*" % repo.prefix
 
     print # end capabilities
@@ -150,22 +149,11 @@ def do_export(repo, args):
     repo.non_local.push(repo.gitdir)
 
 
-def do_gitdir(repo, args):
-    """Stores the location of the gitdir.
-    """
-
-    if not args:
-        die("gitdir needs an argument")
-
-    repo.gitdir = ' '.join(args)
-
-
 COMMANDS = {
     'capabilities': do_capabilities,
     'list': do_list,
     'import': do_import,
     'export': do_export,
-    'gitdir': do_gitdir,
 }
 
 
diff --git a/transport-helper.c b/transport-helper.c
index 34d18aa..6cccb20 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -105,6 +105,12 @@ static struct child_process *get_helper(struct transport *transport)
 	int refspec_alloc = 0;
 	int duped;
 	int code;
+	char git_dir_buf[sizeof(GIT_DIR_ENVIRONMENT) + PATH_MAX + 1];
+	const char *helper_env[] = {
+		git_dir_buf,
+		NULL
+	};
+
 
 	if (data->helper)
 		return data->helper;
@@ -120,6 +126,10 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->argv[2] = remove_ext_force(transport->url);
 	helper->git_cmd = 0;
 	helper->silent_exec_failure = 1;
+
+	snprintf(git_dir_buf, sizeof(git_dir_buf), "%s=%s", GIT_DIR_ENVIRONMENT, get_git_dir());
+	helper->env = helper_env;
+
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
 		die("Unable to find remote helper for '%s'", data->name);
@@ -174,11 +184,6 @@ static struct child_process *get_helper(struct transport *transport)
 			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
-		} else if (!strcmp(buf.buf, "gitdir")) {
-			struct strbuf gitdir = STRBUF_INIT;
-			strbuf_addf(&gitdir, "gitdir %s\n", get_git_dir());
-			sendline(data, &gitdir);
-			strbuf_release(&gitdir);
 		} else if (mandatory) {
 			die("Unknown mandatory capability %s. This remote "
 			    "helper probably needs newer version of Git.\n",
-- 
1.7.5.1.292.g728120
