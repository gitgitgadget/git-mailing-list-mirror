From: Jamey Sharp <jamey@minilop.net>
Subject: [PATCH v3 3/3] Add documentation for virtual repositories
Date: Tue, 24 May 2011 17:46:32 -0700
Message-ID: <1306284392-12034-3-git-send-email-jamey@minilop.net>
References: <1306284392-12034-1-git-send-email-jamey@minilop.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 02:47:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP2Ff-0003XP-PY
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 02:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933361Ab1EYAq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 20:46:57 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:65477 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271Ab1EYAq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 20:46:56 -0400
Received: by pxi16 with SMTP id 16so4727658pxi.4
        for <git@vger.kernel.org>; Tue, 24 May 2011 17:46:55 -0700 (PDT)
Received: by 10.143.96.7 with SMTP id y7mr1235985wfl.30.1306284415667;
        Tue, 24 May 2011 17:46:55 -0700 (PDT)
Received: from oh.minilop.net (host-247-13.pubnet.pdx.edu [131.252.247.13])
        by mx.google.com with ESMTPS id w27sm5887912wfh.21.2011.05.24.17.46.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2011 17:46:55 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QP2FS-00039K-6a; Tue, 24 May 2011 17:46:54 -0700
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1306284392-12034-1-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174363>

From: Josh Triplett <josh@joshtriplett.org>

Add a new gitvirtual(5) document, and cross-reference it from
git-http-backend(1).

Thanks to Jeff King for providing the material for the SECURITY section
and inspiring the CONVENTIONS section.

Commit by Josh Triplett and Jamey Sharp.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
---
v3: add patch 3/3 with documentation for virtual repositories, and
    incorporated feedback from Jeff King and Junio C Hamano.

 Documentation/Makefile                 |    2 +-
 Documentation/git-http-backend.txt     |    4 +-
 Documentation/gitvirtual.txt           |   76 ++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |    2 +-
 4 files changed, 80 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/gitvirtual.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 36989b7..4b4bd2f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -6,7 +6,7 @@ MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
 	gitrepository-layout.txt
 MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
 	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
-	gitdiffcore.txt gitrevisions.txt gitworkflows.txt
+	gitdiffcore.txt gitrevisions.txt gitvirtual.txt gitworkflows.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 4e0b243..4a7c42b 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -120,8 +120,8 @@ ScriptAliasMatch \
 ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ----------------------------------------------------------------
 +
-To serve multiple virtual repositories from a single storage
-repository:
+To serve multiple virtual repositories (linkgit:gitvirtual[7]) from a
+single storage repository:
 +
 ----------------------------------------------------------------
 SetEnvIf Request_URI "^/git/([^/]*)" GIT_REF_PREFIX=$1/ GIT_HEAD=$1-HEAD
diff --git a/Documentation/gitvirtual.txt b/Documentation/gitvirtual.txt
new file mode 100644
index 0000000..ed5a4c5
--- /dev/null
+++ b/Documentation/gitvirtual.txt
@@ -0,0 +1,76 @@
+gitvirtual(7)
+=============
+
+NAME
+----
+gitvirtual - Git virtual repositories
+
+DESCRIPTION
+-----------
+
+Given many repositories with copies of the same objects (such as
+branches of the same source), sharing a common object store will avoid
+duplication.  Alternates provide a single baseline, but don't handle
+ongoing activity in the various repositories.  Furthermore, operations
+such as linkgit:git-gc[1] need to know about all of the refs.
+
+Git supports storing multiple virtual repositories within the object
+store and references of a single underlying repository.  The underlying
+repository stores the objects for all of the virtual repositories, and
+includes all the refs and heads of the virtual repositories using
+prefixed names.
+
+linkgit:git-upload-pack[1] and linkgit:git-receive-pack[1] rewrite the
+names of refs and heads as specified by the --ref-prefix and --head
+options.  For instance, --ref-prefix=`virtual/reponame/` will use
++pass:[refs/virtual/reponame/heads/*]+ and
++pass:[refs/virtual/reponame/tags/*]+.  git-upload-pack and
+git-receive-pack will ignore any references that do not match the
+specified prefix.
+
+These options implement the underlying mechanism for virtual
+repositories.  The smart HTTP server, linkgit:git-http-backend[1], can
+accept a ref prefix and HEAD path via environment variables, and pass
+them to the backend programs.  For a simple local test, you can use
+git-remote-ext:
+
+----------
+git clone ext::'git %s --ref-prefix=virtual/prefix/ --head=prefix-HEAD /tmp/prefixed.git'
+----------
+
+CONVENTIONS
+-----------
+
+The --ref-prefix and --head options provide quite a bit of flexibility
+in organizing the refs of virtual repositories within those of the
+underlying repository.  In the absence of a strong reason to do
+otherwise, consider following these conventions:
+
+--ref-prefix=`virtual/reponame/`::
+	This puts refs under `refs/virtual/reponame/`, which avoids a
+	namespace conflict between `reponame` and built-in ref
+	directories such as `heads` and `tags`.
+
+--head=`virtual-HEAD/reponame`::
+	This puts HEADs under `virtual-HEAD/` to avoid namespace
+	conflicts with top-level filenames in a git repository.
+
+SECURITY
+--------
+
+Anyone with access to any virtual repository can potentially access
+objects from any other virtual repository stored in the same underlying
+repository.  You can't directly say "give me object ABCD" if you don't
+have a ref to it, but you can do some other sneaky things like:
+
+. Claiming to push ABCD, at which point the server will optimize out the
+  need for you to actually send it. Now you have a ref to ABCD and can
+  fetch it (claiming not to have it, of course).
+
+. Requesting other refs, claiming that you have ABCD, at which point the
+  server may generate deltas against ABCD.
+
+None of this causes a problem if you only host public repositories, or
+if everyone who may read one virtual repo may also read everything in
+every other virtual repo (for instance, if everyone in an organization
+has read permission to every repository).
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bb8d7d0..a58d27e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1469,7 +1469,7 @@ _git_help ()
 		attributes cli core-tutorial cvs-migration
 		diffcore gitk glossary hooks ignore modules
 		repository-layout tutorial tutorial-2
-		workflows
+		virtual workflows
 		"
 }
 
-- 
1.7.5.1
