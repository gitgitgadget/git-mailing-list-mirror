From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC PATCH 1/3] Add "vcs" config option in remotes
Date: Sun, 11 Jan 2009 15:12:05 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901110332580.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 21:13:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6gv-0008Ht-Rp
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbZAKUMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754423AbZAKUML
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:12:11 -0500
Received: from iabervon.org ([66.92.72.58]:48381 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154AbZAKUMG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:12:06 -0500
Received: (qmail 30915 invoked by uid 1000); 11 Jan 2009 20:12:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jan 2009 20:12:05 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105216>

This will indicate to programs using the remote that it should be
accessed through a VCS helper. Until programs support it, have them
fail it the option is set.

Clone doesn't have a way to end up with a foreign remote, and I didn't 
touch "git remote".

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/config.txt |    4 ++++
 builtin-fetch.c          |    4 ++++
 builtin-ls-remote.c      |    2 ++
 builtin-push.c           |    3 +++
 remote.c                 |    2 ++
 remote.h                 |    2 ++
 6 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7408bb2..3159e8c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1205,6 +1205,10 @@ remote.<name>.tagopt::
 	Setting this value to \--no-tags disables automatic tag following when
 	fetching from remote <name>
 
+remote.<name>.vcs::
+	Setting this to a value <vcs> will cause git to interact with
+	the remote with the git-vcs-<vcs> helper.
+
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
diff --git a/builtin-fetch.c b/builtin-fetch.c
index de6f307..7b46f8f 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -635,6 +635,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	else
 		remote = remote_get(argv[0]);
 
+	if (remote->foreign_vcs) {
+		die("Using foreign VCSes for fetch is not yet supported.");
+	}
+
 	transport = transport_get(remote, remote->url[0]);
 	if (verbosity >= 2)
 		transport->verbose = 1;
diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 78a88f7..d910be9 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -87,6 +87,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		}
 	}
 	remote = nongit ? NULL : remote_get(dest);
+	if (remote && remote->foreign_vcs)
+		die("ls-remote not supported for foreign VCSes");
 	if (remote && !remote->url_nr)
 		die("remote %s has no configured URL", dest);
 	transport = transport_get(remote, remote ? remote->url[0] : dest);
diff --git a/builtin-push.c b/builtin-push.c
index 122fdcf..3fdedba 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -53,6 +53,9 @@ static int do_push(const char *repo, int flags)
 	int i, errs;
 	struct remote *remote = remote_get(repo);
 
+	if (remote->foreign_vcs)
+		die("Pushing with foreign VCSes not supported.");
+
 	if (!remote)
 		die("bad repository '%s'", repo);
 
diff --git a/remote.c b/remote.c
index 570e112..02135ce 100644
--- a/remote.c
+++ b/remote.c
@@ -406,6 +406,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 	} else if (!strcmp(subkey, ".proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
+	} else if (!strcmp(subkey, ".vcs")) {
+		return git_config_string(&remote->foreign_vcs, key, value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index a46a5be..625c7de 100644
--- a/remote.h
+++ b/remote.h
@@ -11,6 +11,8 @@ struct remote {
 	const char *name;
 	int origin;
 
+	const char *foreign_vcs;
+
 	const char **url;
 	int url_nr;
 	int url_alloc;
-- 
1.6.0.6
