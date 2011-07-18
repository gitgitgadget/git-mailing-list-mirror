From: Jeff King <peff@peff.net>
Subject: [PATCH 11/14] docs: end-user documentation for the credential
 subsystem
Date: Mon, 18 Jul 2011 03:52:47 -0400
Message-ID: <20110718075247.GK12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:52:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiidI-00057V-JW
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab1GRHwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:52:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54108
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab1GRHwt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:52:49 -0400
Received: (qmail 19969 invoked by uid 107); 18 Jul 2011 07:53:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:53:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:52:47 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177354>

The credential API and helper format is already defined in
technical/api-credentials.txt.  This presents the end-user
view.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/Makefile           |    1 +
 Documentation/config.txt         |   11 +++
 Documentation/gitcredentials.txt |  139 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/gitcredentials.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 36989b7..88e7f47 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -7,6 +7,7 @@ MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
 MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
 	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
 	gitdiffcore.txt gitrevisions.txt gitworkflows.txt
+MAN7_TXT += gitcredentials.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
diff --git a/Documentation/config.txt b/Documentation/config.txt
index b56959b..13c13f4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -823,6 +823,17 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
 	specified user's home directory.
 
+credential.helper::
+	Specify an external helper to be called when a username or
+	password credential is needed; the helper may consult external
+	storage to avoid prompting the user for the credentials. See
+	linkgit:gitcredentials[7] for details.
+
+credential.<context>.username::
+	Specify a default username to be used instead of prompting the
+	user when getting credentials for `<context>`. See
+	linkgit:gitcredentials[7] for details.
+
 include::diff-config.txt[]
 
 difftool.<tool>.path::
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
new file mode 100644
index 0000000..74136ee
--- /dev/null
+++ b/Documentation/gitcredentials.txt
@@ -0,0 +1,139 @@
+gitcredentials(7)
+=================
+
+NAME
+----
+gitcredentials - providing usernames and passwords to git
+
+SYNOPSIS
+--------
+------------------
+git config credential.https:example.com.username myusername
+git config credential.helper "$helper $options"
+------------------
+
+DESCRIPTION
+-----------
+
+Git will sometimes need credentials from the user in order to perform
+operations; for example, it may need to ask for a username and password
+in order to access a remote repository over HTTP. This manual describes
+the mechanisms git uses to request these credentials, as well as some
+features to avoid inputting these credentials repeatedly.
+
+REQUESTING CREDENTIALS
+----------------------
+
+Without any credential helpers defined, git will try the following
+strategies to ask the user for usernames and passwords:
+
+1. If the `GIT_ASKPASS` environment variable is set, the program
+   specified by the variable is invoked. A suitable prompt is provided
+   to the program on the command line, and the user's input is read
+   from its standard output.
+
+2. Otherwise, if the `core.askpass` configuration variable is set, its
+   value is used as above.
+
+3. Otherwise, if the `SSH_ASKPASS` environment variable is set, its
+   value is used as above.
+
+4. Otherwise, the user is prompted on the terminal.
+
+AVOIDING REPETITION
+-------------------
+
+It can be cumbersome to input the same credentials over and over.  Git
+provides two methods to reduce this annoyance:
+
+1. Static configuration of usernames for a given authentication context.
+
+2. Credential helpers to cache or store passwords, or to interact with
+   a system password wallet or keychain.
+
+STATIC CONFIGURATION
+--------------------
+
+Git can look for credential information in your git config files. Note
+that it only makes sense to store usernames, not passwords, as git
+config files are not encrypted or usually even protected by filesystem
+permissions.
+
+For a given credential request, git uses a unique token to represent the
+context of a request. For example, a request to
+`https://example.com/repo.git` would have the context
+`https:example.com`. See `CONTEXT TOKENS` below for a full list.
+
+To statically configure a username, set the configuration variable
+`credential.$token.username`. For example, in this instance git will
+prompt only for the password, not the username:
+
+--------------------------------------------------------------
+$ git config --global credential.https:example.com.username me
+$ git push https://example.com/repo.git
+Password:
+--------------------------------------------------------------
+
+CREDENTIAL HELPERS
+------------------
+
+Credential helpers are external programs from which git can request
+usernames and passwords.
+
+To use a helper, you must first select one to use.  Git does not yet
+include any credential helpers, but you may have third-party helpers
+installed; search for `credential-*` in the output of `git help -a`, and
+consult the documentation of individual helpers.  Once you have selected
+a helper, you can tell git to use it by putting its name into the
+credential.helper variable.
+
+1. Find a helper.
++
+-------------------------------------------
+$ git help -a | grep credential-
+credential-foo
+-------------------------------------------
+
+2. Read its description.
++
+-------------------------------------------
+$ git help credential-foo
+-------------------------------------------
+
+3. Tell git to use it.
++
+-------------------------------------------
+$ git config --global credential.helper foo
+-------------------------------------------
+
+If there are multiple instances of the `credential.helper` configuration
+variable, each helper will be tried in turn, and may provide a username,
+password, or nothing. Once git has acquired both a username and a
+password, no more helpers will be tried.
+
+CUSTOM HELPERS
+--------------
+
+You can write your own custom helpers to interface with any system in
+which you keep credentials. See the documentation for git's
+link:technical/api-credentials.html[credentials API] for details.
+
+CONTEXT TOKENS
+--------------
+
+The full set of unique context tokens provided by git to credential
+helpers is:
+
+`$protocol:$hostname`::
+
+	A network request to a specific host. `$protocol` is
+	either `http` or `https`, and `$hostname` is the hostname
+	provided to git (which may not be fully qualified).
+
+`cert:$filename`::
+
+	A password to decrypt a certificate on disk.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.7.6.rc1.12.g65e2
