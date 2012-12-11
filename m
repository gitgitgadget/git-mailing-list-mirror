From: Marc Khouzam <marc.khouzam@ericsson.com>
Subject: [PATCH] Add file completion to tcsh git completion.
Date: Tue, 11 Dec 2012 21:36:57 +0000
Message-ID: <E59706EF8DB1D147B15BECA3322E4BDC0384ED@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'felipe.contreras@gmail.com'" <felipe.contreras@gmail.com>,
	"'szeder@ira.uka.de'" <szeder@ira.uka.de>
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 22:54:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiXmV-0002dG-57
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 22:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032Ab2LKVyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 16:54:04 -0500
Received: from imr4.ericy.com ([198.24.6.9]:60325 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755025Ab2LKVyB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2012 16:54:01 -0500
X-Greylist: delayed 1004 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2012 16:54:01 EST
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id qBBLlPsR011329;
	Tue, 11 Dec 2012 15:47:33 -0600
Received: from EUSAAHC007.ericsson.se (147.117.188.93) by
 eusaamw0707.eamcs.ericsson.se (147.117.20.32) with Microsoft SMTP Server
 (TLS) id 8.3.279.1; Tue, 11 Dec 2012 16:36:59 -0500
Received: from EUSAAMB103.ericsson.se ([147.117.188.120]) by
 EUSAAHC007.ericsson.se ([147.117.188.93]) with mapi id 14.02.0318.001; Tue,
 11 Dec 2012 16:36:59 -0500
Thread-Topic: [PATCH] Add file completion to tcsh git completion.
Thread-Index: AQHN1+VtPlvwS4Yr50qYIAX6nXdPtg==
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.117.188.134]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211301>

For bash completion, the option '-o bashdefault' is used to indicate
that when no other choices are available, file completion should be
performed.  Since this option is not available in tcsh, no file
completion is ever performed.  Therefore, commands like 'git add ',
'git send-email ', etc, require the user to manually type out
the file name.  This can be quite annoying.

To improve the user experience we try to simulate file completion
directly in this script (although not perfectly).

The known issues with the file completion simulation are:
- Possible completions are shown with their directory prefix.
- Completions containing shell variables are not handled.
- Completions with ~ as the first character are not handled.

Signed-off-by: Marc Khouzam <marc.khouzam@ericsson.com>
---

Beyond the described fix, this commit also improves minor aspects
of the script.  Normally I would submit these things in different
commits, but I felt it would be wasting the reviewers/maintainer
time as they are very minor.  If you do prefer different commits, 
just let me know.  The minor improvements are:
	- update header to recommend setting a tcsh variable
	- all missing tabs have been added
	- use ',' instead of '/' in 'complete' command for users that
        prefer to hard-code the path which also contains a '/' and
	  would cause a conflict.
	- unset a variable to avoid polluting the user's env.

Thanks

Marc

 contrib/completion/git-completion.tcsh | 69 ++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.tcsh b/contrib/completion/git-completion.tcsh
index 471f47b..8aafb63 100644
--- a/contrib/completion/git-completion.tcsh
+++ b/contrib/completion/git-completion.tcsh
@@ -19,23 +19,26 @@
 #       (e.g. ~/.git-completion.tcsh and ~/.git-completion.bash).
 #    2) Add the following line to your .tcshrc/.cshrc:
 #        source ~/.git-completion.tcsh
+#    3) For completion similar to bash, it is recommended to also
+#       add the following line to your .tcshrc/.cshrc:
+#        set autolist=ambiguous
+#       It will tell tcsh to list the possible completion choices.
 
 set __git_tcsh_completion_original_script = ${HOME}/.git-completion.bash
 set __git_tcsh_completion_script = ${HOME}/.git-completion.tcsh.bash
 
 # Check that the user put the script in the right place
 if ( ! -e ${__git_tcsh_completion_original_script} ) then
-       echo "git-completion.tcsh: Cannot find: ${__git_tcsh_completion_original_script}.  Git completion will not work."
-       exit
+	echo "git-completion.tcsh: Cannot find: ${__git_tcsh_completion_original_script}.  Git completion will not work."
+	exit
 endif
 
 cat << EOF > ${__git_tcsh_completion_script}
 #!bash
 #
 # This script is GENERATED and will be overwritten automatically.
-# Do not modify it directly.  Instead, modify the git-completion.tcsh
-# script provided by Git core.
-#
+# Do not modify it directly.  Instead, modify git-completion.tcsh
+# and source it again.
 
 source ${__git_tcsh_completion_original_script}
 
@@ -47,22 +50,58 @@ COMP_WORDS=(\$2)
 # tell us that the previous word is complete and the cursor
 # is on the next word.
 if [ "\${2: -1}" == " " ]; then
-       # The last character is a space, so our location is at the end
-       # of the command-line array
-       COMP_CWORD=\${#COMP_WORDS[@]}
+	# The last character is a space, so our location is at the end
+	# of the command-line array
+	COMP_CWORD=\${#COMP_WORDS[@]}
 else
-       # The last character is not a space, so our location is on the
-       # last word of the command-line array, so we must decrement the
-       # count by 1
-       COMP_CWORD=\$((\${#COMP_WORDS[@]}-1))
+	# The last character is not a space, so our location is on the
+	# last word of the command-line array, so we must decrement the
+	# count by 1
+	COMP_CWORD=\$((\${#COMP_WORDS[@]}-1))
 fi
 
 # Call _git() or _gitk() of the bash script, based on the first argument
 _\${1}
 
 IFS=\$'\n'
-echo "\${COMPREPLY[*]}" | sort | uniq
+if [ \${#COMPREPLY[*]} -gt 0 ]; then
+	echo "\${COMPREPLY[*]}" | sort | uniq
+else
+	# No completions suggested.  In this case, we want tcsh to perform
+	# standard file completion.  However, there does not seem to be way
+	# to tell tcsh to do that.  To help the user, we try to simulate
+	# file completion directly in this script.
+	#
+	# Known issues:
+	#     - Possible completions are shown with their directory prefix.
+	#     - Completions containing shell variables are not handled.
+	#     - Completions with ~ as the first character are not handled.
+
+	# No file completion should be done unless we are completing beyond
+	# the git sub-command.  An improvement on the bash completion :)
+	if [ \${COMP_CWORD} -gt 1 ]; then
+		TO_COMPLETE="\${COMP_WORDS[\${COMP_CWORD}]}"
+
+		# We don't support ~ expansion: too tricky.
+		if [ "\${TO_COMPLETE:0:1}" != "~" ]; then
+			# Use ls so as to add the '/' at the end of directories.
+			RESULT=(\`ls -dp \${TO_COMPLETE}* 2> /dev/null\`)
+			echo \${RESULT[*]}
+
+			# If there is a single completion and it is a directory,
+			# we output it a second time to trick tcsh into not adding a space
+			# after it.
+			if [ \${#RESULT[*]} -eq 1 ] && [ "\${RESULT[0]: -1}" == "/" ]; then
+				echo \${RESULT[*]}
+			fi
+		fi
+	fi
+fi
+
 EOF
 
-complete git  'p/*/`bash ${__git_tcsh_completion_script} git "${COMMAND_LINE}"`/'
-complete gitk 'p/*/`bash ${__git_tcsh_completion_script} gitk "${COMMAND_LINE}"`/'
+# Don't need this variable anymore, so don't pollute the users environment
+unset __git_tcsh_completion_original_script
+
+complete git  'p,*,`bash ${__git_tcsh_completion_script} git "${COMMAND_LINE}"`,'
+complete gitk 'p,*,`bash ${__git_tcsh_completion_script} gitk "${COMMAND_LINE}"`,'
-- 
1.8.0.1.g9fe2839
