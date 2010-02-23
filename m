From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 3/4] bash: support user-supplied completion scripts for aliases
Date: Tue, 23 Feb 2010 22:02:59 +0100
Message-ID: <aa69c6475cf011192f9e721cf07a2b569e51acf6.1266958460.git.szeder@ira.uka.de>
References: <20100131191936.GA30466@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Rhodes Clymer <david@zettazebra.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:03:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk1vB-0002Ue-An
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab0BWVDz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 16:03:55 -0500
Received: from francis.fzi.de ([141.21.7.5]:22973 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753043Ab0BWVDx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:03:53 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Feb 2010 22:03:50 +0100
X-Mailer: git-send-email 1.7.0.119.g9b76
In-Reply-To: <20100131191936.GA30466@neumann>
In-Reply-To: <cover.1266958460.git.szeder@ira.uka.de>
References: <cover.1266958460.git.szeder@ira.uka.de>
X-OriginalArrivalTime: 23 Feb 2010 21:03:50.0893 (UTC) FILETIME=[B30EC1D0:01CAB4CB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140835>

Shell command aliases can get rather complex, and the completion
script can not always determine correctly the git command invoked by
such an alias.  For such cases users might want to provide custom
completion scripts the same way like for their custom commands made
possible by the previous patch.

The current completion script does not allow this, because if it
encounters an alias, then it will unconditionally perform completion
for the aliased git command (in case it can determine the aliased git
command, of course).  With this patch the completion script will first
search for a completion function for the command given on the command
line, be it a git command, a custom git command of the user, or an
alias, and invoke that function to perform the completion.  This has
no effect on git commands, because they can not be aliased anyway.  If
it is an alias and there is a completion function for that alias (e.g.
_git_foo() for the alias 'foo'), then it will be invoked to perform
completion, allowing users to provide custom completion functions for
aliases.  If such a completion function can not be found, only then
will the completion script check whether the command given on the
command line is an alias or not, and proceed as usual (i.e. find out
the aliased git command and provide completion for it).

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 2ac3567..8593fd7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2216,11 +2216,14 @@ _git ()
 		return
 	fi
=20
-	local expansion=3D$(__git_aliased_command "$command")
-	[ "$expansion" ] && command=3D"$expansion"
-
 	local completion_func=3D"_git_${command//-/_}"
-	declare -F $completion_func >/dev/null && $completion_func
+	declare -F $completion_func >/dev/null && $completion_func && return
+
+	local expansion=3D$(__git_aliased_command "$command")
+	if [ -n "$expansion" ]; then
+		completion_func=3D"_git_${expansion//-/_}"
+		declare -F $completion_func >/dev/null && $completion_func
+	fi
 }
=20
 _gitk ()
--=20
1.7.0.119.g9b76
