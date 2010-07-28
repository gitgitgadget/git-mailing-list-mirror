From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCHv4 3/3] Add sample commands for git-shell
Date: Wed, 28 Jul 2010 00:43:04 -0700
Message-ID: <1280302984-1752-4-git-send-email-gdb@mit.edu>
References: <1280302984-1752-1-git-send-email-gdb@mit.edu>
To: jrnieder@gmail.com, j.sixt@viscovery.net, avarab@gmail.com,
	gitster@pobox.com, git@vger.kernel.org, gdb@mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 28 09:44:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe1JO-0001Jk-CT
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 09:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab0G1HoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 03:44:00 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:48285 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754191Ab0G1Hn5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 03:43:57 -0400
X-AuditID: 1209190f-b7b0aae000000a7d-22-4c4fdfc0fffd
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id 7D.CF.02685.0CFDF4C4; Wed, 28 Jul 2010 03:44:00 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o6S7hth5017141;
	Wed, 28 Jul 2010 03:43:55 -0400
Received: from localhost (76-191-199-59.dsl.dynamic.sonic.net [76.191.199.59])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6S7hrqR020130;
	Wed, 28 Jul 2010 03:43:54 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280302984-1752-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152053>

Provide a 'list' command to view available bare repositories ending in
.git and a 'help command to display usage.  Also add documentation in
a README

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 contrib/git-shell-commands/README |   18 ++++++++++++++++++
 contrib/git-shell-commands/help   |   16 ++++++++++++++++
 contrib/git-shell-commands/list   |   10 ++++++++++
 3 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 contrib/git-shell-commands/README
 create mode 100755 contrib/git-shell-commands/help
 create mode 100755 contrib/git-shell-commands/list

This differs from v3 in that:

* the 'find' command in 'list' discards its stderr.  This is useful for
  avoiding noise from inaccessible directories or non-git repositories with
  name matching '*.git'.
* the README does not mention that commands will be run from $(pwd)/git-shell-commands,
  because they will now be run from $HOME/git-shell-commands.

diff --git a/contrib/git-shell-commands/README b/contrib/git-shell-commands/README
new file mode 100644
index 0000000..438463b
--- /dev/null
+++ b/contrib/git-shell-commands/README
@@ -0,0 +1,18 @@
+Sample programs callable through git-shell.  Place a directory named
+'git-shell-commands' in the home directory of a user whose shell is
+git-shell.  Then anyone logging in as that user will be able to run
+executables in the 'git-shell-commands' directory.
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
index 0000000..ffc5ac4
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
+find -type d -name "*.git" -exec sh -c "$print_if_bare_repo" -- \{} \; -prune 2>/dev/null
-- 
1.7.0.4
