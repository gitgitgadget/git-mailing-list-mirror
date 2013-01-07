From: Marc Khouzam <marc.khouzam@ericsson.com>
Subject: [PATCH] Prevent space after directories in tcsh completion
Date: Mon, 7 Jan 2013 19:07:10 +0000
Message-ID: <E59706EF8DB1D147B15BECA3322E4BDC06997E@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'felipe.contreras@gmail.com'" <felipe.contreras@gmail.com>,
	"'szeder@ira.uka.de'" <szeder@ira.uka.de>
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 20:07:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsI32-00067g-4o
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 20:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132Ab3AGTH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 14:07:29 -0500
Received: from imr4.ericy.com ([198.24.6.9]:57135 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755100Ab3AGTH2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2013 14:07:28 -0500
Received: from EUSAAHC001.ericsson.se ([147.117.188.75])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r07JLefW015871;
	Mon, 7 Jan 2013 13:21:41 -0600
Received: from EUSAAMB103.ericsson.se ([147.117.188.120]) by
 EUSAAHC001.ericsson.se ([147.117.188.75]) with mapi id 14.02.0318.004; Mon, 7
 Jan 2013 14:07:11 -0500
Thread-Topic: [PATCH] Prevent space after directories in tcsh completion
Thread-Index: Ac3tCjHJO/pRxRuMS+qOOXNfptcVng==
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.117.188.134]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212914>

If git-completion.bash returns a single directory as a completion,
tcsh will automatically add a space after it, which is not what the
user wants.

This commit prevents tcsh from doing this.

Also, a check is added to make sure the tcsh version used is recent
enough to allow completion to work as expected.

Signed-off-by: Marc Khouzam <marc.khouzam@ericsson.com>
---

This update is meant to have tcsh completion work better if the
feature "git-completion.bash: add support for path completion"
is accepted.
See http://www.mail-archive.com/git@vger.kernel.org/msg14137.html
This commit does not depend on that other feature though and can
be applied right away.

Furthermore, based on feedback I received, some users are running
versions of tcsh that are over 5 years old and don't provide the
proper support for this script.  I've added a check to let the user
know of such (sad) situation nicely.

Thanks

Marc

 contrib/completion/git-completion.tcsh | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.tcsh b/contrib/completion/git-completion.tcsh
index 8aafb63..3e3889f 100644
--- a/contrib/completion/git-completion.tcsh
+++ b/contrib/completion/git-completion.tcsh
@@ -13,6 +13,7 @@
 #
 # To use this completion script:
 #
+#    0) You need tcsh 6.16.00 or newer.
 #    1) Copy both this file and the bash completion script to ${HOME}.
 #       You _must_ use the name ${HOME}/.git-completion.bash for the
 #       bash script.
@@ -24,6 +25,15 @@
 #        set autolist=ambiguous
 #       It will tell tcsh to list the possible completion choices.
 
+set __git_tcsh_completion_version = `\echo ${tcsh} | \sed 's/\./ /g'`
+if ( ${__git_tcsh_completion_version[1]} < 6 || \
+     ( ${__git_tcsh_completion_version[1]} == 6 && \
+       ${__git_tcsh_completion_version[2]} < 16 ) ) then
+	echo "git-completion.tcsh: Your version of tcsh is too old, you need version 6.16.00 or newer.  Git completion will not work."
+	exit
+endif
+unset __git_tcsh_completion_version
+
 set __git_tcsh_completion_original_script = ${HOME}/.git-completion.bash
 set __git_tcsh_completion_script = ${HOME}/.git-completion.tcsh.bash
 
@@ -64,9 +74,7 @@ fi
 _\${1}
 
 IFS=\$'\n'
-if [ \${#COMPREPLY[*]} -gt 0 ]; then
-	echo "\${COMPREPLY[*]}" | sort | uniq
-else
+if [ \${#COMPREPLY[*]} -eq 0 ]; then
 	# No completions suggested.  In this case, we want tcsh to perform
 	# standard file completion.  However, there does not seem to be way
 	# to tell tcsh to do that.  To help the user, we try to simulate
@@ -85,19 +93,20 @@ else
 		# We don't support ~ expansion: too tricky.
 		if [ "\${TO_COMPLETE:0:1}" != "~" ]; then
 			# Use ls so as to add the '/' at the end of directories.
-			RESULT=(\`ls -dp \${TO_COMPLETE}* 2> /dev/null\`)
-			echo \${RESULT[*]}
-
-			# If there is a single completion and it is a directory,
-			# we output it a second time to trick tcsh into not adding a space
-			# after it.
-			if [ \${#RESULT[*]} -eq 1 ] && [ "\${RESULT[0]: -1}" == "/" ]; then
-				echo \${RESULT[*]}
-			fi
+			COMPREPLY=(\`ls -dp \${TO_COMPLETE}* 2> /dev/null\`)
 		fi
 	fi
 fi
 
+# tcsh does not automatically remove duplicates, so we do it ourselves
+echo "\${COMPREPLY[*]}" | sort | uniq
+
+# If there is a single completion and it is a directory, we output it
+# a second time to trick tcsh into not adding a space after it.
+if [ \${#COMPREPLY[*]} -eq 1 ] && [ "\${COMPREPLY[0]: -1}" == "/" ]; then
+	echo "\${COMPREPLY[*]}"
+fi
+
 EOF
 
 # Don't need this variable anymore, so don't pollute the users environment
-- 
1.8.1.367.g8e14972.dirty
