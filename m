From: Teemu Matilainen <teemu.matilainen@iki.fi>
Subject: [PATCH 1/2] bash: Enable completion for external subcommands
Date: Tue, 23 Feb 2010 16:43:12 +0200
Message-ID: <1266936193-10644-1-git-send-email-teemu.matilainen@iki.fi>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 15:43:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjvzB-0007zl-E4
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 15:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab0BWOng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 09:43:36 -0500
Received: from mx.reaktor.fi ([82.203.205.80]:60448 "EHLO mx.reaktor.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217Ab0BWOnf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 09:43:35 -0500
Received: from localhost.localdomain (v16-6.openvpn.reaktor.fi [10.1.16.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.reaktor.fi (Postfix) with ESMTPSA id 70832255E3;
	Tue, 23 Feb 2010 16:43:32 +0200 (EET)
X-Mailer: git-send-email 1.7.0.83.g241b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140804>

Now the parameter completion is only available for subcommands
delivered with git.  Providers of external subcommands do not have
a way to supply bash completion for their commands (other than
instructing users to hack their git-completion.bash file).

This makes it possible to have completion also for external git
subcommands.  It can be provided by specifying a function (or a
command in PATH) '_git_<subcommand>' that sets the environment
variable COMPREPLY.

All dashes (-) in the subcommand name are replaced with underscores
(_).  E.g. completion for command 'git foo-bar' can be provided by
'_git_foo_bar'.

Signed-off-by: Teemu Matilainen <teemu.matilainen@iki.fi>
---
 contrib/completion/git-completion.bash |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fe93747..c7ac727 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -14,6 +14,9 @@
 #    *) git 'subcommands'
 #    *) tree paths within 'ref:path/to/file' expressions
 #    *) common --long-options
+#    *) completion for external 'git <sub-command>' can be provided by
+#       specifying function (or command in PATH) '_git_<sub_command>'
+#       that sets COMPREPLY
 #
 # To use these routines:
 #
@@ -2257,7 +2260,10 @@ _git ()
 	svn)         _git_svn ;;
 	tag)         _git_tag ;;
 	whatchanged) _git_log ;;
-	*)           COMPREPLY=() ;;
+	*)
+		local f="_git_${command//-/_}"
+		type -t "$f" >/dev/null && "$f" || COMPREPLY=()
+		;;
 	esac
 }
 
-- 
1.7.0.83.g241b9
