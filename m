From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: [PATCH] bash completion: Support "unpushed commits" warnings in __git_ps1
Date: Sun, 06 Jun 2010 01:05:20 +0100
Message-ID: <4C0AE640.3040503@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 06 02:05:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL3Mv-0000ke-Q9
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 02:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933842Ab0FFAFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 20:05:33 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:24032 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933840Ab0FFAFc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 20:05:32 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100606000522.JMDY3266.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Sun, 6 Jun 2010 01:05:22 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100606000522.MSGA1586.aamtaout02-winn.ispmail.ntl.com@[192.168.1.5]>;
          Sun, 6 Jun 2010 01:05:22 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
X-Cloudmark-Analysis: v=1.1 cv=ZtHxNT4mZm3rCuM0SmWmgWxeBwJsziC8EqOrwwVkrhA= c=1 sm=0 a=QhTB5avu2K0A:10 a=Lw_SFsgOoS4A:10 a=8nJEP1OIZ-IA:10 a=qOz2pZ_4AAAA:8 a=ZNpkEB24mIRGRLtqxGYA:9 a=Px76xpnyYzKKCsigSfGNZRLXTW0A:4 a=wPNLvfGTeEIA:10 a=7qzHkXPk5l4A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148505>

People working in small teams sometimes forget to push their changes, causing
general confusion.  A gentle reminder in the command prompt should help.

Users migrating from centralised version control systems are especially likely
to forget, so I've included git-svn support as a special case.  Only SVN is
supported because it's the only centralised version control system I have any
experience with.  The code is designed to make adding other version control
systems easy for anyone that's interested.

Signed-off-by: Andrew Sayers <andrew-git@pileofstuff.org>
---
 contrib/completion/git-completion.bash |   33 ++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d3fec32..4bb0fee 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -48,6 +48,12 @@
 #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
 #       untracked files, then a '%' will be shown next to the branch name.
 #
+#       If you would like to see if there're unpushed commits, then
+#       you can set GIT_PS1_SHOWUNPUSHED to a nonempty value. If
+#       there're unpushed commits, then a '!' will be shown next to
+#       the branch name.  Setting GIT_PS1_SHOWUNPUSHED=svn will look
+#       for unpushed git-svn commits.
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -138,6 +144,7 @@ __git_ps1 ()
 		local s
 		local u
 		local c
+		local p
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
 			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
@@ -167,12 +174,34 @@ __git_ps1 ()
 			      u="%"
 			   fi
 			fi
+
+			if [ -n "${GIT_PS1_SHOWUNPUSHED-}" ]; then
+			   local head
+			   local upstream
+			   if [ "${GIT_PS1_SHOWUNPUSHED-}" = "svn" ]; then # git-svn upstream checking
+			      local remote_branch=$( git config --get svn-remote.svn.url | sed 's/\//\\\//g' )
+			      upstream=$( git log | sed -ne "/^    git-svn-id: / { s/^    git-svn-id: $remote_branch\/\([^@]*\).*/\1/p ; q }" )
+			   else # git upstream checking
+			      upstream="@{upstream}"
+			   fi
+
+			   if git rev-parse --quiet "$upstream" HEAD 2>/dev/null | {
+			      read upstream
+			      read head
+			      [ -n "$head" -a -n "$upstream" -a "$head" != "$upstream" ]
+			   }; then
+			       p='!'
+			   else
+			       p=
+			   fi
+			fi
+
 		fi
 
 		if [ -n "${1-}" ]; then
-			printf "$1" "$c${b##refs/heads/}$w$i$s$u$r"
+			printf "$1" "$c${b##refs/heads/}$w$i$s$u$r$p"
 		else
-			printf " (%s)" "$c${b##refs/heads/}$w$i$s$u$r"
+			printf " (%s)" "$c${b##refs/heads/}$w$i$s$u$r$p"
 		fi
 	fi
 }
