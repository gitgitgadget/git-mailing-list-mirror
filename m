From: Jamey Sharp <jamey@minilop.net>
Subject: [PATCHv6 4/4] Add documentation for ref namespaces
Date: Fri,  3 Jun 2011 17:11:43 -0700
Message-ID: <1307146303-4524-5-git-send-email-jamey@minilop.net>
References: <1307146303-4524-1-git-send-email-jamey@minilop.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 02:12:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSeTS-0004Xo-35
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 02:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab1FDAMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 20:12:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45154 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745Ab1FDAMI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 20:12:08 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so1013620pzk.19
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 17:12:07 -0700 (PDT)
Received: by 10.68.65.234 with SMTP id a10mr967136pbt.300.1307146327862;
        Fri, 03 Jun 2011 17:12:07 -0700 (PDT)
Received: from oh.minilop.net (host-242-103.pubnet.pdx.edu [131.252.242.103])
        by mx.google.com with ESMTPS id y2sm1811776pbi.83.2011.06.03.17.12.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 17:12:05 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QSeTE-0001Cv-TQ; Fri, 03 Jun 2011 17:12:04 -0700
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1307146303-4524-1-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175048>

From: Josh Triplett <josh@joshtriplett.org>

Document the namespace mechanism in a new gitnamespaces(7) page.
Reference it from receive-pack and upload-pack.

Document the new --namespace option and GIT_NAMESPACE environment
variable in git(1), and reference gitnamespaces(7).

Add a sample Apache configuration to http-backend(1) to support
namespaced repositories, and reference gitnamespaces(7).

Commit by Josh Triplett and Jamey Sharp.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
---
 Documentation/Makefile                 |    2 +-
 Documentation/git-http-backend.txt     |    8 +++
 Documentation/git-receive-pack.txt     |    2 +-
 Documentation/git-upload-pack.txt      |    4 ++
 Documentation/git.txt                  |   13 +++++-
 Documentation/gitnamespaces.txt        |   75 ++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |    2 +-
 7 files changed, 101 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/gitnamespaces.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 36989b7..2004fbe 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -6,7 +6,7 @@ MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
 	gitrepository-layout.txt
 MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
 	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
-	gitdiffcore.txt gitrevisions.txt gitworkflows.txt
+	gitdiffcore.txt gitnamespaces.txt gitrevisions.txt gitworkflows.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 277d9e1..f4e0741 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -119,6 +119,14 @@ ScriptAliasMatch \
 
 ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ----------------------------------------------------------------
++
+To serve multiple repositories from different linkgit:gitnamespaces[7] in a
+single repository:
++
+----------------------------------------------------------------
+SetEnvIf Request_URI "^/git/([^/]*)" GIT_NAMESPACE=$1
+ScriptAliasMatch ^/git/[^/]*(.*) /usr/libexec/git-core/git-http-backend/storage.git$1
+----------------------------------------------------------------
 
 Accelerated static Apache 2.x::
 	Similar to the above, but Apache can be used to return static
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index f34e0ae..3534ba0 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -149,7 +149,7 @@ if the repository is packed and is served via a dumb transport.
 
 SEE ALSO
 --------
-linkgit:git-send-pack[1]
+linkgit:git-send-pack[1], linkgit:gitnamespaces[7]
 
 GIT
 ---
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 4c0ca9d..61a9a04 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -33,6 +33,10 @@ OPTIONS
 <directory>::
 	The repository to sync from.
 
+SEE ALSO
+--------
+linkgit:gitnamespaces[7]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 65317cc..297590f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git' [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
-    [-p|--paginate|--no-pager] [--no-replace-objects]
-    [--bare] [--git-dir=<path>] [--work-tree=<path>]
+    [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
+    [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
     [-c <name>=<value>]
     [--help] <command> [<args>]
 
@@ -324,6 +324,11 @@ help ...`.
 	variable (see core.worktree in linkgit:git-config[1] for a
 	more detailed discussion).
 
+--namespace=<path>::
+	Set the git namespace.  See linkgit:gitnamespaces[7] for more
+	details.  Equivalent to setting the `GIT_NAMESPACE` environment
+	variable.
+
 --bare::
 	Treat the repository as a bare repository.  If GIT_DIR
 	environment is not set, it is set to the current working
@@ -588,6 +593,10 @@ git so take care if using Cogito etc.
 	This can also be controlled by the '--work-tree' command line
 	option and the core.worktree configuration variable.
 
+'GIT_NAMESPACE'::
+	Set the git namespace; see linkgit:gitnamespaces[7] for details.
+	The '--namespace' command-line option also sets this value.
+
 'GIT_CEILING_DIRECTORIES'::
 	This should be a colon-separated list of absolute paths.
 	If set, it is a list of directories that git should not chdir
diff --git a/Documentation/gitnamespaces.txt b/Documentation/gitnamespaces.txt
new file mode 100644
index 0000000..ed8924e
--- /dev/null
+++ b/Documentation/gitnamespaces.txt
@@ -0,0 +1,75 @@
+gitnamespaces(7)
+================
+
+NAME
+----
+gitnamespaces - Git namespaces
+
+DESCRIPTION
+-----------
+
+Git supports dividing the refs of a single repository into multiple
+namespaces, each of which has its own branches, tags, and HEAD.  Git can
+expose each namespace as an independent repository to pull from and push
+to, while sharing the object store, and exposing all the refs to
+operations such as linkgit:git-gc[1].
+
+Storing multiple repositories as namespaces of a single repository
+avoids storing duplicate copies of the same objects, such as when
+storing multiple branches of the same source.  The alternates mechanism
+provides similar support for avoiding duplicates, but alternates do not
+prevent duplication between new objects added to the repositories
+without ongoing maintenance, while namespaces do.
+
+To specify a namespace, set the `GIT_NAMESPACE` environment variable to
+the namespace.  For each ref namespace, git stores the corresponding
+refs in a directory under `refs/namespaces/`.  For example,
+`GIT_NAMESPACE=foo` will store refs under `refs/namespaces/foo/`.  You
+can also specify namespaces via the `--namespace` option to
+linkgit:git[1].
+
+Note that namespaces which include a `/` will expand to a hierarchy of
+namespaces; for example, `GIT_NAMESPACE=foo/bar` will store refs under
+`refs/namespaces/foo/refs/namespaces/bar/`.  This makes paths in
+`GIT_NAMESPACE` behave hierarchically, so that cloning with
+`GIT_NAMESPACE=foo/bar` produces the same result as cloning with
+`GIT_NAMESPACE=foo` and cloning from that repo with `GIT_NAMESPACE=bar`.  It
+also avoids ambiguity with strange namespace paths such as `foo/refs/heads/`,
+which could otherwise generate directory/file conflicts within the `refs`
+directory.
+
+linkgit:git-upload-pack[1] and linkgit:git-receive-pack[1] rewrite the
+names of refs as specified by `GIT_NAMESPACE`.  git-upload-pack and
+git-receive-pack will ignore all references outside the specified
+namespace.
+
+The smart HTTP server, linkgit:git-http-backend[1], will pass
+GIT_NAMESPACE through to the backend programs; see
+linkgit:git-http-backend[1] for sample configuration to expose
+repository namespaces as repositories.
+
+For a simple local test, you can use linkgit:git-remote-ext[1]:
+
+----------
+git clone ext::'git --namespace=foo %s /tmp/prefixed.git'
+----------
+
+SECURITY
+--------
+
+Anyone with access to any namespace within a repository can potentially
+access objects from any other namespace stored in the same repository.
+You can't directly say "give me object ABCD" if you don't have a ref to
+it, but you can do some other sneaky things like:
+
+. Claiming to push ABCD, at which point the server will optimize out the
+  need for you to actually send it. Now you have a ref to ABCD and can
+  fetch it (claiming not to have it, of course).
+
+. Requesting other refs, claiming that you have ABCD, at which point the
+  server may generate deltas against ABCD.
+
+None of this causes a problem if you only host public repositories, or
+if everyone who may read one namespace may also read everything in every
+other namespace (for instance, if everyone in an organization has read
+permission to every repository).
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b10a1ec..ec1c986 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1469,7 +1469,7 @@ _git_help ()
 	__gitcomp "$__git_all_commands $(__git_aliases)
 		attributes cli core-tutorial cvs-migration
 		diffcore gitk glossary hooks ignore modules
-		repository-layout tutorial tutorial-2
+		namespaces repository-layout tutorial tutorial-2
 		workflows
 		"
 }
-- 
1.7.5.3
