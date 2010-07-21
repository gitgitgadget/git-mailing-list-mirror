From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH 3/3] Add sample commands for git-shell
Date: Wed, 21 Jul 2010 11:15:55 -0400
Message-ID: <1279725355-23016-4-git-send-email-gdb@mit.edu>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
Cc: Greg Brockman <gdb@mit.edu>
To: j.sixt@viscovery.net, gitster@pobox.com, avarab@gmail.com,
	jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 17:16:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obb2M-0005U8-Ep
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 17:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab0GUPQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 11:16:35 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:43022 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752742Ab0GUPQc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 11:16:32 -0400
X-AuditID: 1209190f-b7b0aae000000a7d-77-4c470f529a48
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id 58.F1.02685.25F074C4; Wed, 21 Jul 2010 11:16:35 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o6LFGVBY005499;
	Wed, 21 Jul 2010 11:16:31 -0400
Received: from localhost (dhcp-18-111-45-125.dyn.mit.edu [18.111.45.125])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6LFGTj8005879;
	Wed, 21 Jul 2010 11:16:30 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1279725355-23016-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151400>

Provide a 'list' command to view available bare repositories ending in
.git and a 'help command to display usage.  Also add documentation in
a README

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 contrib/git-shell-commands/README |   23 +++++++++++++++++++++++
 contrib/git-shell-commands/help   |   16 ++++++++++++++++
 contrib/git-shell-commands/list   |   10 ++++++++++
 3 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100644 contrib/git-shell-commands/README
 create mode 100755 contrib/git-shell-commands/help
 create mode 100755 contrib/git-shell-commands/list

diff --git a/contrib/git-shell-commands/README b/contrib/git-shell-commands/README
new file mode 100644
index 0000000..57d7a79
--- /dev/null
+++ b/contrib/git-shell-commands/README
@@ -0,0 +1,23 @@
+Sample programs callable through git-shell.  Place a directory named
+'git-shell-commands' in the home directory of a user whose shell is
+git-shell.  Then anyone logging in as that user will be able to run
+executables in the 'git-shell-commands' directory.
+
+Note that git-shell assumes its CWD is the user's home directory, so
+trying to 'su' to a user whose shell is git-shell would result in
+running commands out of "$(cwd)/git-shell-commands", which may not be
+desired behavior.
+
+Provided commands:
+
+help: Prints out the names of available commands.  When run
+interactively, git-shell will automatically run 'help' on startup,
+provided it exists.
+
+list: Displays any bare repository whose name ends with ".git" under
+user's home directory.  No other git repositories are visible,
+although they might be clonable through git-shell.  'list' is designed
+to minimize the number of calls to git that must be made in finding
+available repositories; if your setup has additional repositories that
+should be user-discoverable, you may wish to modify 'list'
+accordingly.
diff --git a/contrib/git-shell-commands/help b/contrib/git-shell-commands/help
new file mode 100755
index 0000000..a43fcd6
--- /dev/null
+++ b/contrib/git-shell-commands/help
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+if tty -s; then
+    echo "Run 'help' for help, or 'exit' to leave.  Available commands:"
+else
+    echo "Run 'help' for help.  Available commands:"
+fi
+
+cd "$(dirname "$0")"
+
+for cmd in *; do
+    case "$cmd" in
+	help) ;;
+	*) [ -f "$cmd" ] && [ -x "$cmd" ] && echo "$cmd" ;;
+    esac
+done
diff --git a/contrib/git-shell-commands/list b/contrib/git-shell-commands/list
new file mode 100755
index 0000000..4654535
--- /dev/null
+++ b/contrib/git-shell-commands/list
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+print_if_bare_repo='
+       if "$(git --git-dir="$1" rev-parse --is-bare-repository)" = true
+       then
+               printf "%s\n" "${1#./}"
+       fi
+'
+
+find -type d -name "*.git" -exec sh -c "$print_if_bare_repo" -- \{} \; -prune
-- 
1.7.0.4
