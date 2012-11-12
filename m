From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Fwd: [PATCH] Add tcsh-completion support to contrib by using git-completion.bash
Date: Mon, 12 Nov 2012 15:07:46 -0500
Message-ID: <CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
References: <CAFj1UpE6OtJEojaED1_DZJD0kU=nVsFE_w8xa0oJE-6auCU2rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 21:08:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY0Ib-0000Bu-IR
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 21:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab2KLUHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 15:07:47 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37287 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab2KLUHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 15:07:46 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so9632503iea.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 12:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=69sm5U3YExmvzzezkYBId5+IP9M0WJ9RWke51n11eEo=;
        b=HfS01iY+ln5zRjq4/Oa5jkZpa0e8Vv9pnGi/nJ1NUXr+9lFmWqqByH+N+ficHWbBb8
         /+f1cWznwLwHUEGzQcT8xnLdkbpp0/Xn7zRJTv0D+hbuu3Fb6MiDY0kh9luiDMGihqDV
         BXw3QiyMarYfx5oNhVF0I8ypnJOTajPUFNmWtg7zGikD2GAjkHukN/pjURnC00riyiae
         lBKVq3KZqlmdGQ5q/hQXmPvMGphAvPcP03COwU3PgnoO7mr4VdTreozrLna5fycAktBH
         w72xMoLEKJrCuMAuY8h/HDb0j+pUhtuECN6VbDWD2CyEEnDx+bm6vz9tPx+gmgbbtXCI
         CdBg==
Received: by 10.42.68.68 with SMTP id w4mr19380660ici.30.1352750866201; Mon,
 12 Nov 2012 12:07:46 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Mon, 12 Nov 2012 12:07:46 -0800 (PST)
In-Reply-To: <CAFj1UpE6OtJEojaED1_DZJD0kU=nVsFE_w8xa0oJE-6auCU2rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209514>

Hi,

this patch allows tcsh-users to get the benefits of the awesome
git-completion.bash script.  It could also help other shells do the same.

==

The current tcsh-completion support for Git, as can be found on the
internet, takes the approach of defining the possible completions
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
       3- requires the user to explicitly make the script executable
          when using tcsh (for tcsh users only)
       4- requires script to have a fixed name and location:
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

==

With the changes applied, tcsh users should:

#    1) Copy both this file and the bash completion script to your
${HOME} directory
#       using the names ${HOME}/.git-completion.tcsh and
${HOME}/.git-completion.bash.
#    2) Add the following line to your .tcshrc/.cshrc:
#        source ${HOME}/.git-completion.tcsh

The code can be found on GitHub.
Option (A):
https://github.com/marckhouzam/git/commit/86d3a8e740ae85b4b4462c997a0fd969b1b2d24c

Option (B):
https://github.com/marckhouzam/git/commit/e64606541682eaf66c0a56aceff279ca6e1d06cd

Option (C):
https://github.com/marckhouzam/git/commit/59792455f1e6a98d3ffeb828f4cff1ded0e4ed37

Thanks

Marc

---
 contrib/completion/git-completion.bash |   53 +++++++++++++++++++++++++++++++-
 contrib/completion/git-completion.tcsh |   34 ++++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletions(-)
 create mode 100755 contrib/completion/git-completion.tcsh

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index be800e0..6d4b57a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1,4 +1,6 @@
-#!bash
+#!/bin/bash
+# The above line is important as this script can be executed when used
+# with another shell such as tcsh
 #
 # bash/zsh completion support for core Git.
 #
@@ -2481,3 +2483,52 @@ __git_complete gitk __gitk_main
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
+_git_complete_with_output ()
+{
+       # Set COMP_WORDS to the command-line as bash would.
+       COMP_WORDS=($1)
+
+       # Set COMP_CWORD to the cursor location as bash would.
+       if [ -n "$2" ]; then
+               COMP_CWORD=$2
+       else
+               # Assume the cursor is at the end of parameter #1.
+               # We must check for a space as the last character which will
+               # tell us that the previous word is complete and the cursor
+               # is on the next word.
+               if [ "${1: -1}" == " " ]; then
+                       # The last character is a space, so our
location is at the end
+                       # of the command-line array
+                       COMP_CWORD=${#COMP_WORDS[@]}
+               else
+                       # The last character is not a space, so our
location is on the
+                       # last word of the command-line array, so we
must decrement the
+                       # count by 1
+                       COMP_CWORD=$((${#COMP_WORDS[@]}-1))
+               fi
+       fi
+
+       # Call _git() or _gitk() of the bash script, based on the first
+       # element of the command-line
+       _${COMP_WORDS[0]}
+
+       # Print the result that is stored in the bash variable ${COMPREPLY}
+       for i in ${COMPREPLY[@]}; do
+               echo "$i"
+       done
+}
+
+if [ -n "$1" ] ; then
+  # If there is an argument, we know the script is being executed
+  # so go ahead and run the _git_complete_with_output function
+  _git_complete_with_output "$1" "$2"
+fi
diff --git a/contrib/completion/git-completion.tcsh
b/contrib/completion/git-completion.tcsh
new file mode 100755
index 0000000..7b7baea
--- /dev/null
+++ b/contrib/completion/git-completion.tcsh
@@ -0,0 +1,34 @@
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
+#    1) Copy both this file and the bash completion script to your
${HOME} directory
+#       using the names ${HOME}/.git-completion.tcsh and
${HOME}/.git-completion.bash.
+#    2) Add the following line to your .tcshrc/.cshrc:
+#        source ${HOME}/.git-completion.tcsh
+
+# One can change the below line to use a different location
+set __git_tcsh_completion_script = ${HOME}/.git-completion.bash
+
+# Check that the user put the script in the right place
+if ( ! -e ${__git_tcsh_completion_script} ) then
+       echo "ERROR in git-completion.tcsh script.  Cannot find:
${__git_tcsh_completion_script}.  Git completion will not work."
+       exit
+endif
+
+# Make the script executable if it is not
+if ( ! -x ${__git_tcsh_completion_script} ) then
+       chmod u+x ${__git_tcsh_completion_script}
+endif
+
+complete git  'p/*/`${__git_tcsh_completion_script} "${COMMAND_LINE}"
| sort | uniq`/'
+complete gitk 'p/*/`${__git_tcsh_completion_script} "${COMMAND_LINE}"
| sort | uniq`/'
+
--
1.7.0.4
