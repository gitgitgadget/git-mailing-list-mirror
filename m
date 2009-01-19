From: ted@tedpavlic.com
Subject: [StGit PATCH] Added basic bash completion script for StGit.
Date: Mon, 19 Jan 2009 17:57:59 -0500
Message-ID: <1232405879-6188-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 20 00:00:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP35i-00039o-AY
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 23:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbZASW6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 17:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbZASW6J
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 17:58:09 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:50269 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750745AbZASW6I (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 17:58:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 528ED80D8037;
	Mon, 19 Jan 2009 17:52:13 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rgW9No3y-JKb; Mon, 19 Jan 2009 17:52:13 -0500 (EST)
Received: from localhost.localdomain (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id D905580D8035;
	Mon, 19 Jan 2009 17:52:12 -0500 (EST)
X-Mailer: git-send-email 1.6.1.87.g15624
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106398>

From: Ted Pavlic <ted@tedpavlic.com>

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
 contrib/completion/stg-completion.bash |  106 ++++++++++++++++++++++++++++++++
 1 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100755 contrib/completion/stg-completion.bash

diff --git a/contrib/completion/stg-completion.bash b/contrib/completion/stg-completion.bash
new file mode 100755
index 0000000..13cc792
--- /dev/null
+++ b/contrib/completion/stg-completion.bash
@@ -0,0 +1,106 @@
+#!bash
+#
+# bash completion support for Stacked Git (StGit).
+#
+# Copyright (c) 2009 by Theodore P. Pavlic <ted@tedpavlic.com>
+# Distributed under the GNU General Public License, version 2.0.
+#
+# Design is highly influenced by completion scripts for Mercurial and
+# git.
+#
+# To use these routines:
+#
+#    1) Copy this file to somewhere (e.g. ~/.stg-completion.sh).
+#    2) Added the following line to your .bashrc or .bash_profile:
+#        source ~/.stg-completion.sh
+#
+# To submit patches:
+#
+#    *) Read Documentation/SubmittingPatches
+#    *) Send all patches to the Git mailing list
+#
+#           git@vger.kernel.org
+#
+#       and CC the message to the StGit maintainer
+#
+#           catalin.marinas@gmail.com
+#
+#       Prefix the subject with something like "[StGit PATCH]",
+#       "[StGit PATCH i/n]", "[StGit PATCH RFC]", or similar. Patches
+#       should be "Signed-off-by:" you as described in
+#       Documentation/SubmittingPatches.
+#
+#       It is recommended that editors submit patches using utilities
+#       like
+#
+#           stg mail
+#           git send-email
+#           git format-patch
+#
+#       In the latter case, make sure e-amils submitted to the list do
+#       not have "format=flowed" and do not "word wrap" your patch.
+#
+
+# This 'extglob' bash option allows for
+#       if [[ $param == @(-h|--help) ]]
+# type statements. That is, the pattern is true if $param matches -h OR
+# --help
+shopt -s extglob
+
+__stg_commands()
+{
+    local commands
+    commands="$("$stg" help|grep '^ '|cut -f3 -d' ' 2>/dev/null)" || commands=""
+    COMPREPLY=(${COMPREPLY[@]:-} $(compgen -W '$commands' -- "$cur"))
+}
+
+__stg()
+{
+    local cur prev cmd
+    local stg="$1"
+
+    COMPREPLY=()
+    cur="$2"
+    prev="$3"
+
+    if [ $COMP_CWORD -gt 1 ]; then
+        # Try to complete the argument to an already complete stg command
+        # (e.g., "stg command partial<tab>")
+        cmd=${COMP_WORDS[${COMP_CWORD}-1]}
+        __stg_specific_command
+    else
+        # Try to complete an incomplete stg command (possibly blank)
+        # (e.g., "stg partial<tab>")
+        __stg_commands
+    fi
+
+}
+
+# Handle "stg command <tab>" completion
+__stg_specific_command()
+{
+    # Here, try to find (possibly user-defined) functions that match the
+    # command
+    if [ "$(type -t "__stg_cmd_$cmd")" = function ]; then
+        "__stg_cmd_$cmd"
+        return 0
+    fi
+
+    # Special handling of particular stg commands can be placed here
+    case "$cmd" in
+        help)
+            # Complete help with all possible help commands
+            __stg_commands
+            ;;
+        *)
+            # Bail out to normal bash completion
+            return 1
+            ;;
+   esac
+
+   return 0
+}
+
+# Use __stg for stg completion and bail out to normal bash completion
+complete -o bashdefault -o default -F __stg stg 2>/dev/null \
+    || complete -o default -F __stg stg
-- 
1.6.1.87.g15624
