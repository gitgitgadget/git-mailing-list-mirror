From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: [PATCH] tcsh-completion re-using git-completion.bash
Date: Thu, 15 Nov 2012 06:51:09 -0500
Message-ID: <1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
Cc: Marc Khouzam <marc.khouzam@gmail.com>
To: szeder@ira.uka.de, git@vger.kernel.org, felipe.contreras@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 15 12:52:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYxzI-0005fE-5v
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 12:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767653Ab2KOLvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 06:51:48 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:61948 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993197Ab2KOLvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 06:51:35 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so947423iay.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 03:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=M//W+OcbnAQd+ZdDOOOqzOquKkX4gRtvfXmmxRpsYfE=;
        b=nPLjdcv0hrHW+XNyLQ1RSWeXejThTaXTEvkQXEssKzlPyOEDFFEKC7VGgi1GHmcwz3
         WNtGYRHxytiLOb+AlUZAJxNf+qr2ympHSM7e8FoJK1C8Kgr+oXUXXT/Z8Q9XKZ12+uak
         TwA9/V2twOIwe5OCEv0adCJb0iOL7rdMF2GVPGWbwzOrMK07VudWyFOJzViQDuQlT0kk
         CrrTDoFADr75jFIb8XMiFFI+laY7SRmiQRSf6sICWAnUMCEwwp6uiHDgE1tZ+DQJf6AV
         kievanON/s/GRpLCmj5AZHveT51C6RFnpZyGAbuOutTd0zxcjJyaxUxpww0mvRceIrdY
         70nA==
Received: by 10.50.237.103 with SMTP id vb7mr642407igc.29.1352980294842;
        Thu, 15 Nov 2012 03:51:34 -0800 (PST)
Received: from khouz.dyn.lmc.ericsson.se (modemcable168.70-160-184.mc.videotron.ca. [184.160.70.168])
        by mx.google.com with ESMTPS id we6sm3475311igb.8.2012.11.15.03.51.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 03:51:34 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.g9fe2839
In-Reply-To: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209817>

The current tcsh-completion support for Git, as can be found on the
Internet, takes the approach of defining the possible completions
explicitly.  This has the obvious draw-back to require constant
updating as the Git code base evolves.

The approach taken by this commit is to to re-use the advanced bash
completion script and use its result for tcsh completion.  This is
achieved by executing (versus sourcing) the bash script and
outputting the completion result for tcsh consumption.

Three solutions were looked at to implement this approach with (A)
being retained:

  A) Modifications:
          git-completion.bash and new git-completion.tcsh

     Modify the existing git-completion.bash script to support
     being sourced using bash (as now), but also executed using bash.
     When being executed, the script will output the result of the
     computed completion to be re-used elsewhere (e.g., in tcsh).

     The modification to git-completion.bash is made not to be
     tcsh-specific, but to allow future users to also re-use its
     output.  Therefore, to be general, git-completion.bash accepts a
     second optional parameter, which is not used by tcsh, but could
     prove useful for other users.

     Pros:
       1- allows the git-completion.bash script to easily be re-used
       2- tcsh support is mostly isolated in git-completion.tcsh
     Cons (for tcsh users only):
       1- requires the user to copy both git-completion.tcsh and
          git-completion.bash to ${HOME}
       2- requires bash script to have a fixed name and location:
          ${HOME}/.git-completion.bash

  B) Modifications:
          git-completion.bash

     Modify the existing git-completion.bash script to support
     being sourced using bash (as now), but also executed using bash,
     and sourced using tcsh.

     Pros:
       1- only requires the user to deal with a single file
       2- maintenance more obvious for tcsh since it is entirely part
          of the same git-completion.bash script.
     Cons:
       1- tcsh support could affect bash support as they share the
          same script
       2- small tcsh section must use syntax suitable for both tcsh
          and bash and must be at the beginning of the script
       3- requires script to have a fixed name and location:
          ${HOME}/.git-completion.sh (for tcsh users only)

  C) Modifications:
          New git-completion.tcsh

     Provide a short tcsh script that converts git-completion.bash
     into an executable script suitable to be used by tcsh.

     Pros:
       1- tcsh support is entirely isolated in git-completion.tcsh
       2- new tcsh script can be as complex as needed
     Cons (for tcsh users only):
       1- requires the user to copy both git-completion.tcsh and
          git-completion.bash to ${HOME}
       2- requires bash script to have a fixed name and location:
          ${HOME}/.git-completion.bash
       3- sourcing the new script will generate a third script

Approach (A) was selected to keep the tcsh completion support well
isolated without introducing excessive complexity.

Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>
---

Here is the updated version of the patch.
I got git send-email to work, so I hope the formatting will be correct.

Thanks in advance.

Marc

 contrib/completion/git-completion.bash |   47 ++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.tcsh |   29 +++++++++++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 contrib/completion/git-completion.tcsh

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index be800e0..d71a016 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2481,3 +2481,50 @@ __git_complete gitk __gitk_main
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
 __git_complete git.exe __git_main
 fi
+
+# Method that will output the result of the completion done by
+# the bash completion script, so that it can be re-used in another
+# context than the bash complete command.
+# It accepts 1 to 2 arguments:
+# 1: The command-line to complete
+# 2: The index of the word within argument #1 in which the cursor is
+#    located (optional). If parameter 2 is not provided, it will be
+#    determined as best possible using parameter 1.
+__git_complete_with_output ()
+{
+	# Set COMP_WORDS in a way that can be handled by the bash script.
+	COMP_WORDS=($1)
+
+	# Set COMP_CWORD to the cursor location as bash would.
+	if [ -n "${2-}" ]; then
+		COMP_CWORD=$2
+	else
+		# Assume the cursor is at the end of parameter #1.
+		# We must check for a space as the last character which will
+		# tell us that the previous word is complete and the cursor
+		# is on the next word.
+		if [ "${1: -1}" == " " ]; then
+			# The last character is a space, so our location is at the end
+			# of the command-line array
+			COMP_CWORD=${#COMP_WORDS[@]}
+		else
+			# The last character is not a space, so our location is on the
+			# last word of the command-line array, so we must decrement the
+			# count by 1
+			COMP_CWORD=$((${#COMP_WORDS[@]}-1))
+		fi
+	fi
+
+	# Call _git() or _gitk() of the bash script, based on the first
+	# element of the command-line
+	_${COMP_WORDS[0]}
+
+	local IFS=$'\n'
+	echo "${COMPREPLY[*]}"
+}
+
+if [ -n "${1-}" ] ; then
+  # If there is an argument, we know the script is being executed
+  # so go ahead and run the _git_complete_with_output function
+  __git_complete_with_output "${1-}" "${2-}"
+fi
diff --git a/contrib/completion/git-completion.tcsh b/contrib/completion/git-completion.tcsh
new file mode 100644
index 0000000..6096ea8
--- /dev/null
+++ b/contrib/completion/git-completion.tcsh
@@ -0,0 +1,29 @@
+#!tcsh
+#
+# tcsh completion support for core Git.
+#
+# Copyright (C) 2012 Marc Khouzam <marc.khouzam@gmail.com>
+# Distributed under the GNU General Public License, version 2.0.
+#
+# This script makes use of the git-completion.bash script to
+# determine the proper completion for git commands under tcsh.
+#
+# To use this completion script:
+#
+#    1) Copy both this file and the bash completion script to your ${HOME} directory
+#       using the names ${HOME}/.git-completion.tcsh and ${HOME}/.git-completion.bash.
+#    2) Add the following line to your .tcshrc/.cshrc:
+#        source ${HOME}/.git-completion.tcsh
+
+# One can change the below line to use a different location
+set __git_tcsh_completion_script = ${HOME}/.git-completion.bash
+
+# Check that the user put the script in the right place
+if ( ! -e ${__git_tcsh_completion_script} ) then
+	echo "ERROR in git-completion.tcsh script.  Cannot find: ${__git_tcsh_completion_script}.  Git completion will not work."
+	exit
+endif
+
+complete git  'p/*/`bash ${__git_tcsh_completion_script} "${COMMAND_LINE}" | sort | uniq`/'
+complete gitk 'p/*/`bash ${__git_tcsh_completion_script} "${COMMAND_LINE}" | sort | uniq`/'
+
-- 
1.7.0.4
