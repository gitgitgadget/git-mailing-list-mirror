From: Paul Ebermann <Paul-Ebermann@gmx.de>
Subject: [PATCH/WIP] completion: complete git diff with only changed files.
Date: Wed, 18 May 2011 02:15:03 +0200
Message-ID: <4DD30F87.2000807@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 02:15:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMUQ0-0001U3-Fa
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 02:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756443Ab1ERAPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2011 20:15:10 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:42263 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932512Ab1ERAPH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 20:15:07 -0400
Received: (qmail invoked by alias); 18 May 2011 00:15:04 -0000
Received: from stilgar.mathematik.hu-berlin.de (EHLO [141.20.50.149]) [141.20.50.149]
  by mail.gmx.net (mp019) with SMTP; 18 May 2011 02:15:04 +0200
X-Authenticated: #2289940
X-Provags-ID: V01U2FsdGVkX18OVptMBwMOQpd/kdfxH+zGB5uTGZaV4qMgr9lj8d
	I+OPiTg3jixZ3r
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.19) Gecko/20110420 SUSE/2.0.14-0.2.1 SeaMonkey/2.0.14
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173832>

The bash completion script for git diff completes either for
references or for file names. If there was a -- given, it uses
the default bash filename completion.

The completion for hg diff completes only changed file names
here - this is quite useful if we want to see changes in only
some file (or directory). (This was mentioned on stackoverflow,
which gave me the idea: http://stackoverflow.com/q/6034472/600500 )

I ported this idea to git. Now
   git diff -- <tab>
will complete any changed files. It also works for the other ways
of calling git diff, except the .. and ... notations (as I'm
not sure how to do this).

Signed-off-by: Pa=C5=ADlo Ebermann <Paul-Ebermann@gmx.de>
---

Hello,
this is my first contribution to git at all, and I only joined the
mailing list some hours ago (right before starting to code this), so I =
hope
I'm not making any mistakes here. (I read the SubmittingPatches documen=
t,
though.)


I only made this work after the --, while the usual file completion alr=
eady
seems to work if there is no --. I'm not really sure what is wanted her=
e.

I'm checking the non-option arguments on being commits (or tags), and p=
ass
only the matching ones to the nested `git diff` call.
It might be easier to ommit this check and pass everything that does no=
t
start with a `-`. Then it would also easily work for the .. and ... syn=
tax,
I think.
Opinions?

The same completion function or a variation might also be useful for ot=
her
commands like git add (completing changed or new files) or git rm
(completing already removed files). Input is welcome here.

This patch is based on the current master branch, I hope this is the ri=
ght
one.


 contrib/completion/git-completion.bash |   72 ++++++++++++++++++++++++=
+++++++-
 1 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index bb8d7d0..c529bdf 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -663,6 +663,69 @@ __git_compute_merge_strategies ()
 	: ${__git_merge_strategies:=3D$(__git_list_merge_strategies)}
 }
=20
+
+# Completion for the file argument for git diff.
+# It completes only files actually changed. This might be useful
+# as completion for other commands as well.
+#
+# The idea comes from the bash completion for Mercurial (hg),
+# which does something similar (but more simple, only difference of
+# working directory to HEAD and/or index, if I understand right).
+# It (the idea) was brought to us by the question
+#      http://stackoverflow.com/q/6034472/600500
+#  from "olt".
+__git_complete_changed_files()
+{
+  #
+  # We use "git diff --name-only --relative" to generate the list,
+  # but this needs the same --cached and <commit> arguments as the
+  # command line being constructed.
+  #
+
+
+    # first grab arguments like --cached and any commit arguments.
+
+    local -a args=3D()
+    local finish=3Dfalse
+
+    for (( i=3D1 ; i < cword ; i++)) do
+    local current_arg=3D${words[$i]}
+    #  echo checking $current_arg >&2
+       case $current_arg in
+           --cached)
+               args+=3D( $current_arg )
+               ;;
+           --)
+               # finish parsing arguments, the rest are file names
+               break
+               ;;
+           -*)
+               # other options are ignored
+               ;;
+           *)
+               if git cat-file -e $current_arg 2> /dev/null
+               then
+                   case $( git cat-file -t $current_arg ) in
+                       commit|tag)
+                       # commits and tags are added to the command lin=
e.
+                           args+=3D( $current_arg )
+                           # echo adding $current_arg >&2
+                           ;;
+                       *)
+                   esac
+               fi
+               ;;
+       esac
+    done
+
+    # now we can call `git diff`
+
+    COMPREPLY=3D( $( compgen \
+        -W "$( git diff --name-only --relative "${args[@]}" -- )" -- $=
cur ) )
+}
+
+
+
 __git_complete_revlist_file ()
 {
 	local pfx ls ref cur_=3D"$cur"
@@ -1314,10 +1377,14 @@ __git_diff_common_options=3D"--stat --numstat -=
-shortstat --summary
 			--dirstat-by-file=3D --cumulative
 "
=20
+
 _git_diff ()
 {
-	__git_has_doubledash && return
-
+    if __git_has_doubledash
+    then
+        # complete for the file part: only changed files
+        __git_complete_changed_files
+    else
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
@@ -1328,6 +1395,7 @@ _git_diff ()
 		;;
 	esac
 	__git_complete_revlist_file
+    fi
 }
=20
 __git_mergetools_common=3D"diffuse ecmerge emerge kdiff3 meld opendiff
