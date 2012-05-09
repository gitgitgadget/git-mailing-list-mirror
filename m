From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 19/19] bash prompt: alternative git prompt without command
	substitution
Date: Wed,  9 May 2012 02:44:50 +0200
Message-ID: <1336524290-30023-20-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:47:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv4N-0005dk-51
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757485Ab2EIAru convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:47:50 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:59178 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756935Ab2EIArs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:47:48 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MAXB0-1SHQPC04TK-00B7pD; Wed, 09 May 2012 02:47:44 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:RTGEV5BXBl1XXUkOJUvvwhVm5Px7sTf/FrVZzd3eZWp
 jrRCbQBC3cAgxW3gZYwerQKD7fzjSe5L6VLQpoltd9aopifUl3
 SHnvM1+qSvVnQpxUaLCLveA/eWgz4kumZjPk33wOvr9q0MNISO
 7V/bhGFF31yeX3JwXgZVBmVqMGhB6qqmFqH3T0vlxG0ThYXPZn
 ShDu+eyBs3YkBxFzIbRgEfCOoYyHkVXsX4O/mvESktajFMD1GP
 y9hWA3cTmBLHuH8su0eSJLK4TMYNS4E/vRYdF6rqDAsVCt/h8j
 s56ICtEZtzmRUwi9fp4Z1VYq0/fV/7/3MGcdOT2dqgqX4h3R2h
 01P6dOKrk7GUD5EEoHyg77GDg6iffqI8r85+/9tNWtLBnCarPh
 ZrXKtRkZJTUTg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197450>

__git_ps1() prints the branch name, status indicators, etc. to stdout,
therefore it has to be included in $PS1 through a command substitution
to display that information in the prompt.  The configuration is
straightforward, but it imposes the overhead of fork()ing a subshell
for the command substitution.

However, bash has the $PROMPT_COMMAND shell variable, which "if set,
the value is executed as a command prior to issuing each primary
prompt" (quoted from bash man page).  Its value isn't executed in a
subshell but in the context of the "main" shell, hence (non-local)
variables set in invoked shell functions are available when expanding
$PS1.  We can use this facility to avoid that command substitution for
__git_ps1().

So split out the meat of __git_ps1() into the new
__git_prompt_command() function, which stores the branch name & co.
in the $__git_ps1_string variable.  This function, as its name
suggests, should be included in $PROMPT_COMMAND, and $__git_ps1_string
should in turn be included in $PS1 with a bit of a twist to put the
parentheses around it:

   PROMPT_COMMAND=3D__git_prompt_command
   PS1=3D'[\u@\h \W${__git_ps1_string:+ ($__git_ps1_string)}]\$ '

Turn __git_ps1() into a wrapper around __git_prompt_command() such
that it's functionality remains unaltered, so already configured
prompts won't break.

The whole series speeds up the bash prompt on Windows/MinGW
immensely, in many cases brings it down to around 10ms on my
machine while in powersave mode.  Here are some timing results in
three common scenarios (repeated 10 times, because the after cases
were too fast to measure a single execution accurately with 'time'):

In my home directory, i.e. not in a git repository, before:

    /c/Users/szeder
    $ time for i in {0..9} ; do prompt=3D$(__git_ps1) ; done

    real    0m0.952s
    user    0m0.214s
    sys     0m0.444s

  After:

    /c/Users/szeder
    $ time for i in {0..9} ; do __git_prompt_command ;
           prompt=3D${__git_ps1_string:+ ($__git_ps1_string)} ; done

    real    0m0.718s
    user    0m0.136s
    sys     0m0.354s

  After, with discovery across filesystems enabled:

    /c/Users/szeder
    $ time for i in {0..9} ; do __git_prompt_command ;
           prompt=3D${__git_ps1_string:+ ($__git_ps1_string)} ; done

    real    0m0.078s
    user    0m0.016s
    sys     0m0.062s

At the top of a work tree, before:

    /c/Users/szeder/repo (master)
    $ time for i in {0..9} ; do prompt=3D$(__git_ps1) ; done

    real    0m2.901s
    user    0m0.391s
    sys     0m1.468s

  After:

    /c/Users/szeder/repo (master)
    $ time for i in {0..9} ; do __git_prompt_command ;
           prompt=3D${__git_ps1_string:+ ($__git_ps1_string)} ; done

    real    0m0.094s
    user    0m0.047s
    sys     0m0.047s

In a subdirectory, stash indicator enabled, before:

    /c/Users/szeder/repo/subdir (master $)
    $ time for i in {0..9} ; do prompt=3D$(__git_ps1) ; done

    real    0m4.118s
    user    0m0.468s
    sys     0m2.056s

  After:

    /c/Users/szeder/repo/subdir (master $)
    $ time for i in {0..9} ; do __git_prompt_command ;
           prompt=3D${__git_ps1_string:+ ($__git_ps1_string)} ; done

    real    0m0.858s
    user    0m0.152s
    sys     0m0.322s

  After, discovery across filesystems enabled:

    /c/Users/szeder/repo/subdir (master $)
    $ time for i in {0..9} ; do __git_prompt_command ;
           prompt=3D${__git_ps1_string:+ ($__git_ps1_string)} ; done

    real    0m0.109s
    user    0m0.047s
    sys     0m0.063s

Well, that's about 97% improvement.

The performance gain on Linux is smaller, the latter case goes down
from 0.264s to 0.047, but since it was fast enough to begin with I
won't lengthen this commit message with further timing results on
Linux.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

We had some discussions recently about putting user-facing functions in=
to
a separate "namespace".  This patch doesn't take that into account, but
once a consensus is reached __git_prompt_command() should be put in tha=
t
namespace.

 contrib/completion/git-completion.bash | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 5ea19018..1c29f3d0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -29,6 +29,11 @@
 #       are currently in a git repository.  The %s token will be
 #       the name of the current branch.
 #
+#       Alternatively, to make the above Bash prompt a bit faster:
+#               PROMPT_COMMAND=3D__git_prompt_command
+#               PS1=3D'[\u@\h \W${__git_ps1_string:+ ($__git_ps1_strin=
g)}]\$ '
+#               GIT_DISCOVERY_ACROSS_FILESYSTEM=3Dtrue
+#
 #       In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty
 #       value, unstaged (*) and staged (+) changes will be shown next
 #       to the branch name.  You can configure this per-repository
@@ -258,11 +263,12 @@ __git_ps1_show_upstream ()
 }
=20
=20
-# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
-# returns text to add to bash PS1 prompt (includes branch name)
-__git_ps1 ()
+# Stores the text to be added to the bash prompt (branch name, status
+# indicators, etc.) in the $__git_ps1_string variable.
+__git_prompt_command ()
 {
 	local __git_dir=3D""
+	__git_ps1_string=3D""
 	__gitdir >/dev/null
 	if [ -z "$__git_dir" ]; then
 		return
@@ -365,7 +371,18 @@ __git_ps1 ()
 	fi
=20
 	local f=3D"$w$i$s$u"
-	printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
+	__git_ps1_string=3D"$c${b##refs/heads/}${f:+ $f}$r$p"
+}
+
+# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
+# returns text to add to bash PS1 prompt (includes branch name)
+__git_ps1 ()
+{
+	local __git_ps1_string
+	__git_prompt_command
+	if [ -n "$__git_ps1_string" ]; then
+		printf -- "${1:- (%s)}" "$__git_ps1_string"
+	fi
 }
=20
 __gitcomp_1 ()
--=20
1.7.10.1.541.gb1be298
