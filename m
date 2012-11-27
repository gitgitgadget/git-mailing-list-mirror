From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: [PATCH] Support for git aliasing for tcsh completion
Date: Mon, 26 Nov 2012 23:13:41 -0500
Message-ID: <CAFj1UpE5V5fKtt0fFOXLPrsQdOL8xpvzT=66Qi3=cMHit092Rg@mail.gmail.com>
References: <1353989472-4142-1-git-send-email-marc.khouzam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>
To: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 05:17:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdCbp-0005fs-NN
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 05:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306Ab2K0ENn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 23:13:43 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35223 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab2K0ENn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 23:13:43 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so7594220iea.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 20:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dl5NYmSHBoAdpvV0/GISQaeM+0QtvrjMgqFVSBtQhZs=;
        b=E7c4P7YKxaLMExQen20c/3bHEsyX+hw8+aaUKNziZ+9ofkXK5p8DNlMkWA7tR8nJaA
         6sh2sortM+iQqT9O5S8RTA3XX0lYe/0p01Bg66IIA2tk1ljdc97tcAGN0ty5ihEKjUSY
         eQwDbrZ+tr4qGo4KCqrmkzDucwSpoL/qMqPzubbdCIbEoNdUCmLpabsemwosVIBBlgUm
         fih4+Jdsty9Lk/KpKSh2Oczx6SBu95ZOX7A1NTzYEz54MUMwQ9kpxQxO14pwFlS+RwR1
         p96qn7XPfCyXHuz60JTEVLMJEw0PNr6HuWOHNgfC9paUVAZb0Yat/AXIIYs9P4uvdllW
         /fbg==
Received: by 10.42.176.194 with SMTP id bf2mr12679556icb.50.1353989621614;
 Mon, 26 Nov 2012 20:13:41 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Mon, 26 Nov 2012 20:13:41 -0800 (PST)
In-Reply-To: <1353989472-4142-1-git-send-email-marc.khouzam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210529>

tcsh users sometimes alias the 'git' command to another name.  In
this case, the user expects to only have to issue a new 'complete'
command using the alias name.

However, the tcsh script currently uses the command typed by the
user to call the appropriate function in git-completion.bash, either
_git() or _gitk().  When using an alias, this technique no longer
works.

This change specifies the real name of the command (either 'git' or
'gitk') as a parameter to the script handling tcsh completion.  This
allows the user to use any alias for the 'git' or 'gitk' commands,
while still getting completion to work.

A check for the presence of ${HOME}/.git-completion.bash is also
added to help the user make use of the script properly.

Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>
---

This issue was reported by someone already making use of the tcsh
completion script.

Thanks for considering this fix.

Marc

 contrib/completion/git-completion.tcsh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.tcsh
b/contrib/completion/git-completion.tcsh
index dc5678c..44bd544 100644
--- a/contrib/completion/git-completion.tcsh
+++ b/contrib/completion/git-completion.tcsh
@@ -23,6 +23,12 @@
 set __git_tcsh_completion_original_script = ${HOME}/.git-completion.bash
 set __git_tcsh_completion_script = ${HOME}/.git-completion.tcsh.bash

+# Check that the user put the script in the right place
+if ( ! -e ${__git_tcsh_completion_original_script} ) then
+       echo "git-completion.tcsh: Cannot find:
${__git_tcsh_completion_original_script}.  Git completion will not work."
+       exit
+endif
+
 cat << EOF > ${__git_tcsh_completion_script}
 #!bash
 #
@@ -34,13 +40,13 @@ cat << EOF > ${__git_tcsh_completion_script}
 source ${__git_tcsh_completion_original_script}

 # Set COMP_WORDS in a way that can be handled by the bash script.
-COMP_WORDS=(\$1)
+COMP_WORDS=(\$2)

 # The cursor is at the end of parameter #1.
 # We must check for a space as the last character which will
 # tell us that the previous word is complete and the cursor
 # is on the next word.
-if [ "\${1: -1}" == " " ]; then
+if [ "\${2: -1}" == " " ]; then
        # The last character is a space, so our location is at the end
        # of the command-line array
        COMP_CWORD=\${#COMP_WORDS[@]}
@@ -51,13 +57,12 @@ else
        COMP_CWORD=\$((\${#COMP_WORDS[@]}-1))
 fi

-# Call _git() or _gitk() of the bash script, based on the first
-# element of the command-line
-_\${COMP_WORDS[0]}
+# Call _git() or _gitk() of the bash script, based on the first argument
+_\${1}

 IFS=\$'\n'
 echo "\${COMPREPLY[*]}" | sort | uniq
 EOF

-complete git  'p/*/`bash ${__git_tcsh_completion_script}
"${COMMAND_LINE}"`/'
-complete gitk 'p/*/`bash ${__git_tcsh_completion_script}
"${COMMAND_LINE}"`/'
+complete git  'p/*/`bash ${__git_tcsh_completion_script} git
"${COMMAND_LINE}"`/'
+complete gitk 'p/*/`bash ${__git_tcsh_completion_script} gitk
"${COMMAND_LINE}"`/'
--
1.8.0.1.g9fe2839
