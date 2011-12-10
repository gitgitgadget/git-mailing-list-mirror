From: Jeff King <peff@peff.net>
Subject: [PATCHv3 09/13] docs: end-user documentation for the credential
 subsystem
Date: Sat, 10 Dec 2011 05:31:38 -0500
Message-ID: <20111210103137.GI16529@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:31:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKDc-00061c-2z
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307Ab1LJKbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:31:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47021
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab1LJKbk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:31:40 -0500
Received: (qmail 14045 invoked by uid 107); 10 Dec 2011 10:38:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:38:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:31:38 -0500
Content-Disposition: inline
In-Reply-To: <20111210102827.GA16460@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186741>

The credential API and helper format is already defined in
technical/api-credentials.txt.  This presents the end-user
view.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/Makefile           |    1 +
 Documentation/config.txt         |   23 +++++
 Documentation/gitcredentials.txt |  171 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/gitcredentials.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 304b31e..116f175 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -7,6 +7,7 @@ MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
 MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
 	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
 	gitdiffcore.txt gitnamespaces.txt gitrevisions.txt gitworkflows.txt
+MAN7_TXT += gitcredentials.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8a7d2d4..c6630c7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -834,6 +834,29 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
 	specified user's home directory.
 
+credential.helper::
+	Specify an external helper to be called when a username or
+	password credential is needed; the helper may consult external
+	storage to avoid prompting the user for the credentials. See
+	linkgit:gitcredentials[7] for details.
+
+credential.useHttpPath::
+	When acquiring credentials, consider the "path" component of an http
+	or https URL to be important. Defaults to false. See
+	linkgit:gitcredentials[7] for more information.
+
+credential.username::
+	If no username is set for a network authentication, use this username
+	by default. See credential.<context>.* below, and
+	linkgit:gitcredentials[7].
+
+credential.<url>.*::
+	Any of the credential.* options above can be applied selectively to
+	some credentials. For example "credential.https://example.com.username"
+	would set the default username only for https connections to
+	example.com. See linkgit:gitcredentials[7] for details on how URLs are
+	matched.
+
 include::diff-config.txt[]
 
 difftool.<tool>.path::
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
new file mode 100644
index 0000000..07f6596
--- /dev/null
+++ b/Documentation/gitcredentials.txt
@@ -0,0 +1,171 @@
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
+git config credential.https://example.com.username myusername
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
+The first is simple and appropriate if you do not have secure storage available
+for a password. It is generally configured by adding this to your config:
+
+---------------------------------------
+[credential "https://example.com"]
+	username = me
+---------------------------------------
+
+Credential helpers, on the other hand, are external programs from which git can
+request both usernames and passwords; they typically interface with secure
+storage provided by the OS or other programs.
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
+
+CREDENTIAL CONTEXTS
+-------------------
+
+Git considers each credential to have a context defined by a URL. This context
+is used to look up context-specific configuration, and is passed to any
+helpers, which may use it as an index into secure storage.
+
+For instance, imagine we are accessing `https://example.com/foo.git`. When git
+looks into a config file to see if a section matches this context, it will
+consider the two a match if the context is a more-specific subset of the
+pattern in the config file. For example, if you have this in your config file:
+
+--------------------------------------
+[credential "https://example.com"]
+	username = foo
+--------------------------------------
+
+then we will match: both protocols are the same, both hosts are the same, and
+the "pattern" URL does not care about the path component at all. However, this
+context would not match:
+
+--------------------------------------
+[credential "https://kernel.org"]
+	username = foo
+--------------------------------------
+
+because the hostnames differ. Nor would it match `foo.example.com`; git
+compares hostnames exactly, without considering whether two hosts are part of
+the same domain. Likewise, a config entry for `http://example.com` would not
+match: git compares the protocols exactly.
+
+
+CONFIGURATION OPTIONS
+---------------------
+
+Options for a credential context can be configured either in
+`credential.\*` (which applies to all credentials), or
+`credential.<url>.\*`, where <url> matches the context as described
+above.
+
+The following options are available in either location:
+
+helper::
+
+	The name of an external credential helper, and any associated options.
+	If the helper name is not an absolute path, then the string `git
+	credential-` is prepended. The resulting string is executed by the
+	shell (so, for example, setting this to `foo --option=bar` will execute
+	`git credential-foo --option=bar` via the shell. See the manual of
+	specific helpers for examples of their use.
+
+username::
+
+	A default username, if one is not provided in the URL.
+
+useHttpPath::
+
+	By default, git does not consider the "path" component of an http URL
+	to be worth matching via external helpers. This means that a credential
+	stored for `https://example.com/foo.git` will also be used for
+	`https://example.com/bar.git`. If you do want to distinguish these
+	cases, set this option to `true`.
+
+
+CUSTOM HELPERS
+--------------
+
+You can write your own custom helpers to interface with any system in
+which you keep credentials. See the documentation for git's
+link:technical/api-credentials.html[credentials API] for details.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.7.8.rc2.40.gaf387
