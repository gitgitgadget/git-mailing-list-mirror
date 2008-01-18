From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Fri, 18 Jan 2008 15:51:25 +0100
Message-ID: <4790BCED.4050207@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 15:52:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFsZY-00051I-0e
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 15:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbYAROv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 09:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbYAROv1
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 09:51:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:64344 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbYAROv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 09:51:26 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1058554fga.17
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 06:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:sender;
        bh=rcPsG+EMZR8upepaZW6cMHvV9kkFCjBuVQRMywNDunk=;
        b=tAfBA2cNjxbYyO7KAbdSp/xU1Zb7K4C4Awc92tz+9fjHvqVRfUeMXvmPF0lZDXhS+JZKDlfuK3BBVBnP0schxkRQqk9SIh6fhW3FPHflg+dECJpzVcb5PSmbs0QRLJdhrUGYGzPDh6w8iMTnZxTbI54Atzf1YOZxEcEqcgcIqYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:sender;
        b=Kgx69QllxnmEINHUbQpdLcozPKPRvMNNuXxxSkWulI+4Bl0M7uQaziuhXRtLjrXQkiukG9X9dR24pyRQ7BxMbOJxNjTsiDuvAjHGqpq5XSs9mgRVh0/03af0/yXQrnW/SkWtl5jpnE9X9Ayli8cwoeAgufQdC8BAvJgZTsuCVqE=
Received: by 10.86.100.7 with SMTP id x7mr3168887fgb.7.1200667884401;
        Fri, 18 Jan 2008 06:51:24 -0800 (PST)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id 3sm5892412fge.7.2008.01.18.06.51.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jan 2008 06:51:23 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71024>

The prepare-commit-msg hook is run whenever a "fresh" commit message
(i.e. not one taken from another commit with -c) is shown in the editor.
It can modify the commit message in-place and/or abort the commit.

While the default hook just adds a Signed-Off-By line at the bottom
of the commit messsage, the hook is more intended to build a template
for the commit message following project standards.

Signed-Off-By: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-commit.txt        |   13 ++++++++-----
 Documentation/hooks.txt             |   21 +++++++++++++++++++++
 builtin-commit.c                    |    3 +++
 templates/hooks--commit-msg         |    3 +++
 templates/hooks--prepare-commit-msg |   14 ++++++++++++++
 5 files changed, 49 insertions(+), 5 deletions(-)
 create mode 100644 templates/hooks--prepare-commit-msg

	The real motivation for this is building the commit message
	from GNU ChangeLogs.  But I figured that putting it in the
	real commit message rather than a cover letter would have
	implied rejection of the patch...

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c3725b2..c68191b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -62,18 +62,21 @@ OPTIONS
 	and the authorship information (including the timestamp)
 	when creating the commit.  With '-C', the editor is not
 	invoked; with '-c' the user can further edit the commit
-	message.
+	message.  In either case, the prepare-commit-msg hook is
+	bypassed.

 -F <file>::
 	Take the commit message from the given file.  Use '-' to
-	read the message from the standard input.
+	read the message from the standard input.  This option
+	bypasses the prepare-commit-msg hook.

 --author <author>::
 	Override the author name used in the commit.  Use
 	`A U Thor <author@example.com>` format.

 -m <msg>|--message=<msg>::
-	Use the given <msg> as the commit message.
+	Use the given <msg> as the commit message.  This option
+	bypasses the prepare-commit-msg hook.

 -t <file>|--template=<file>::
 	Use the contents of the given file as the initial version
@@ -280,8 +283,8 @@ order).

 HOOKS
 -----
-This command can run `commit-msg`, `pre-commit`, and
-`post-commit` hooks.  See link:hooks.html[hooks] for more
+This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
+and `post-commit` hooks.  See link:hooks.html[hooks] for more
 information.


diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index f110162..2ef5567 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -61,6 +61,27 @@ The default 'pre-commit' hook, when enabled, catches introduction
 of lines with trailing whitespaces and aborts the commit when
 such a line is found.

+prepare-commit-msg
+------------------
+
+This hook is invoked by `git-commit` right before starting the editor
+with an empty log message.  It is not executed if the commit message is
+specified otherwise, such as with the `\-m`, `\-F`, `\-c`, `\-C` options.
+It takes a single parameter, the name of the file that holds git's own
+template commit log message.  Exiting with non-zero status causes
+`git-commit` to abort.
+
+The hook is allowed to edit the message file in place, and
+can be used to augment the default commit message with some
+project standard information.  It can also be used for the same
+purpose as the pre-commit message, if the verification has
+to be skipped for automatic commits (e.g. during rebasing).
+
+The default 'prepare-commit-msg' hook adds a Signed-Off-By line
+(doing it with a hook is not necessarily a good idea, but doing
+it in 'commit-msg' is worse because you are not reminded in
+the editor).
+
 commit-msg
 ----------

diff --git a/builtin-commit.c b/builtin-commit.c
index 0227936..1de0d02 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -869,6 +869,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		char index[PATH_MAX];
 		const char *env[2] = { index, NULL };
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
+		if (!edit_message) {
+			run_hook(index_file, "prepare-commit-msg", git_path(commit_editmsg));
+		}
 		launch_editor(git_path(commit_editmsg), NULL, env);
 	}
 	if (!no_verify &&
diff --git a/templates/hooks--commit-msg b/templates/hooks--commit-msg
index c5cdb9d..4ef86eb 100644
--- a/templates/hooks--commit-msg
+++ b/templates/hooks--commit-msg
@@ -9,6 +9,9 @@
 # To enable this hook, make this file executable.

 # Uncomment the below to add a Signed-off-by line to the message.
+# Doing this in a hook is a bad idea in general, but the prepare-commit-msg
+# hook is more suited to it.
+#
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
 # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"

diff --git a/templates/hooks--prepare-commit-msg b/templates/hooks--prepare-commit-msg
new file mode 100644
index 0000000..176283b
--- /dev/null
+++ b/templates/hooks--prepare-commit-msg
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# An example hook script to prepare the commit log message.
+# Called by git-commit with one argument, the name of the file
+# that has the commit message.  The hook should exit with non-zero
+# status after issuing an appropriate message if it wants to stop the
+# commit.  The hook is allowed to edit the commit message file.
+#
+# To enable this hook, make this file executable.
+
+# This example adds a Signed-off-by line to the message, that can
+# still be edited.
+SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
+grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
-- 
1.5.3.4.910.gc5122-dirty
