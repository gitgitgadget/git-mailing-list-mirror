From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 3/3] remote-helpers: export GIT_DIR variable to helpers
Date: Wed, 13 Jul 2011 23:10:55 +0600
Message-ID: <1310577055-6347-3-git-send-email-divanorama@gmail.com>
References: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 19:10:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh2xT-00060v-Ou
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 19:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385Ab1GMRKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 13:10:37 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33439 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab1GMRKg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 13:10:36 -0400
Received: by ewy4 with SMTP id 4so2267664ewy.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=q1Q0WZtkYpEGvPSDvbLcRTiSiC1Vnaj11Tuv8QBglo8=;
        b=AbO/V+VZfNUtB9UWG0/ajMCCd2sfVIh5gqedfL+LXMJcG+5keY7xWU6FSPJYx0Zfoq
         XuZbHcvLJcy2eNnxzMxYrGmM8Rm4DQmJDq3R5OSjqW8fVZ1O5eB2fZhROg1oDEIzuJ5F
         9ZE4kimLDmA8jTJGVXRNKdVKbH4y5tsALiv6U=
Received: by 10.213.102.72 with SMTP id f8mr1438670ebo.32.1310577034468;
        Wed, 13 Jul 2011 10:10:34 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id z14sm9432354eef.13.2011.07.13.10.10.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 10:10:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177062>

The gitdir capability is recognized by git and can be used to tell
the helper where the .git directory is. But it is not mentioned in
the documentation and considered worse than if gitdir was passed
via GIT_DIR environment variable.

Do export GIT_DIR for a remote helper. Switch testgit to use env
instead of less favoured capability gitdir.

Mention it's possible uses in documentation: data storage, auxiliary
git commands needed by a helper.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
Instead of documenting capability gitdir export GIT_DIR. Turned out
to be quite straightforward.

 Documentation/git-remote-helpers.txt |   18 ++++++++++++++++++
 git-remote-testgit.py                |   14 +-------------
 transport-helper.c                   |   10 ++++++++++
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 58f6ad4..394fc8e 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -47,6 +47,9 @@ arguments. The first argument specifies a remote repository as in git;
 it is either the name of a configured remote or a URL. The second
 argument specifies a URL; it is usually of the form
 '<transport>://<address>', but any arbitrary string is possible.
+'GIT_DIR' environment variable is set up for the remote helper and
+can be used to store some additional data or to invoke auxiliary git
+commands.
 
 When git encounters a URL of the form '<transport>://<address>', where
 '<transport>' is a protocol that it cannot handle natively, it
@@ -159,6 +162,14 @@ Supported if the helper has the "import" capability.
 +
 Supported if the helper has the "connect" capability.
 
+'gitdir' <path>::
+	Tells helper the location of current repository .git
+	directory. The path is absolute. The command is issued
+	immediately after "gitdir" capability line is read by
+	the caller.
++
+Supported if the helper has the "gitdir" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
@@ -175,6 +186,7 @@ CAPABILITIES
 'push'::
 'import'::
 'connect'::
+'gitdir'::
 	This helper supports the corresponding command with the same name.
 
 'refspec' 'spec'::
@@ -187,6 +199,12 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "{asterisk}:{asterisk}"
 
+'gitdir'::
+	The helper wants to know .git directory location. The gitdir
+	command is sent immediately after reading this capability.
+	The helper can read it immediately too or it can proceed with
+	reporting other capabilities and read it as a next command.
+
 REF LIST ATTRIBUTES
 -------------------
 
diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index df9d512..df3e37f 100644
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
index 660147f..3282693 100644
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
-- 
1.7.3.4
