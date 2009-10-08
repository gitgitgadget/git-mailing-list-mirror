From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH] Speedup bash completion loading
Date: Thu, 8 Oct 2009 17:27:18 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20091008132718.GA12161@tugrik.mns.mnsspb.ru>
References: <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org> <20091005165802.GA24402@tugrik.mns.mnsspb.ru> <4e0a90ed0910051218oaa64b94jd12a6678934523ac@mail.gmail.com> <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 15:34:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvt82-0006mf-QI
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 15:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758268AbZJHN2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 09:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbZJHN2r
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 09:28:47 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:52308 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbZJHN2p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 09:28:45 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1Mvt2J-0004rm-A2; Thu, 08 Oct 2009 17:28:03 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1Mvt1a-0003Zo-Rv; Thu, 08 Oct 2009 17:27:18 +0400
Content-Disposition: inline
In-Reply-To: <4e0a90ed0910051218oaa64b94jd12a6678934523ac@mail.gmail.com> <20091005152504.GE9261@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129691>

On Mon, Oct 05, 2009 at 08:25:04AM -0700, Shawn O. Pearce wrote:
> Kirill Smelkov <kirr@mns.spb.ru> wrote:
> > I've tracked down that the most time is spent warming up merge_strategy,
> > all_command & porcelain_command caches.
> 
> Nak.
> 
> The problem is, during completion when we modify the value the
> change doesn't persist beyond the current completion invocation.
> Thus there is no value in the cache, so every completion attempt
> which needs the list has to rerun the command to compute it.

> > Yes, my mistake.
> > 
> > To avoid spawning subshell on $(__git_porcelain_commands) I could come up
> > with "caching" at the upper level, as e.g.
> > 
> > @@ -2107,7 +2111,10 @@ _git ()
> >                         --help
> >                         "
> >                         ;;
> > -               *)     __gitcomp "$(__git_porcelain_commands) $(__git_aliases)" ;;
> > +               *)     __gitcomp "
> > +                       ${__git_porcelain_commandlist:=$(__git_porcelain_commands)}
> > +                       $(__git_aliases)
> > +                       " ;;
> > 
> > 
> > but that's ugly and not maintainable since e.g. __git_all_commands() is used in
> > several places.

On Mon, Oct 05, 2009 at 03:18:48PM -0400, Ted Pavlic wrote:
> > The other possibility is to pregenerate all these lists at git build time, but
> > are we going to do it for things under contrib/ ?
> 
> IIRC, that's what StGIT does with its completion script. As a
> consequence, StGIT completion is substantially faster than git
> completion.

Ok, it turned out that in bash, functions can't return values except
through their stdout, but then we are forever with spawning
subprocesses. So I've decided to go the pregenerate-it way.


[ While at it, I've also done chmod -x to git-completion.bash -- this
  script is never executed, only sourced, so it does not need to be
  executable. If needed I could split it in separate patch ]



---- 8< ----

>From 4178dcc2bd1005e26e069fe32a88b9a5b164ced6 Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Mon, 5 Oct 2009 13:36:15 +0400
Subject: [PATCH v2] Speedup bash completion loading

On my slow laptop (P3 700MHz), system-wide bash completions take too
much time to load (> 1s), and significant fraction of this time is spent
loading git-completion.bash:

    $ time bash -c '. git-completion.bash'  # before this patch

    real    0m0.317s
    user    0m0.250s
    sys     0m0.060s

I've tracked down that the most time is spent warming up merge_strategy,
all_command & porcelain_command caches.

Initially I thought that since git is not used in each and every
interactive xterm, it would be perfectly ok to load completion support
with cold caches, and then load needed thing lazily.

But for me this strategy turned out to be difficult to implement in
simple and maintainable way -- bash does not provide a way to return values
from inside functions, so one will have to use e.g.

    ${__git_all_commandlist:=$(__git_all_commands)}

everywhere in place where $(__git_all_commands) we used before, so as
also Ted Pavlic suggested let's pregenerate everything at build time so
that we have nothing to compute at runtime when git-completion.bash
script is loaded.

The result is that loading completion is significantly faster now:

    $ time bash -c '. git-completion.bash'  # after this patch

    real    0m0.068s
    user    0m0.060s
    sys     0m0.010s

Cc: Ted Pavlic <ted@tedpavlic.com>
Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 contrib/completion/.gitignore                      |    1 +
 contrib/completion/Makefile                        |   11 ++
 contrib/completion/git-completion.bash.generate    |  128 ++++++++++++++++
 ...{git-completion.bash => git-completion.bash.in} |  154 ++------------------
 4 files changed, 155 insertions(+), 139 deletions(-)
 create mode 100644 contrib/completion/.gitignore
 create mode 100644 contrib/completion/Makefile
 create mode 100755 contrib/completion/git-completion.bash.generate
 rename contrib/completion/{git-completion.bash => git-completion.bash.in} (90%)
 mode change 100755 => 100644

diff --git a/contrib/completion/.gitignore b/contrib/completion/.gitignore
new file mode 100644
index 0000000..578e6a8
--- /dev/null
+++ b/contrib/completion/.gitignore
@@ -0,0 +1 @@
+git-completion.bash
diff --git a/contrib/completion/Makefile b/contrib/completion/Makefile
new file mode 100644
index 0000000..a0fbb66
--- /dev/null
+++ b/contrib/completion/Makefile
@@ -0,0 +1,11 @@
+all	: git-completion.bash
+
+
+git-completion.bash: git-completion.bash.in git-completion.bash.generate
+	# Generate completions for binaries we have just built
+	PATH="$(shell pwd)/..:$$PATH" ./git-completion.bash.generate
+
+
+clean:
+	rm -f git-completion.bash
+
diff --git a/contrib/completion/git-completion.bash.generate b/contrib/completion/git-completion.bash.generate
new file mode 100755
index 0000000..fa998dc
--- /dev/null
+++ b/contrib/completion/git-completion.bash.generate
@@ -0,0 +1,128 @@
+#!/bin/bash
+#
+# Generate bash completion for git.
+#
+# Precompute everything that can be known in advance at build time, so that
+# actual bash completion script is loaded faster.
+
+__git_merge_strategies ()
+{
+	git merge -s help 2>&1 |
+	sed -n -e '/[Aa]vailable strategies are: /,/^$/{
+		s/\.$//
+		s/.*://
+		s/^[ 	]*//
+		s/[ 	]*$//
+		p
+	}'
+}
+
+__git_all_commands ()
+{
+	local i IFS=" "$'\n'
+	for i in $(git help -a|egrep '^ ')
+	do
+		case $i in
+		*--*)             : helper pattern;;
+		*) echo $i;;
+		esac
+	done
+}
+
+
+__git_porcelain_commands ()
+{
+	local i IFS=" "$'\n'
+	for i in "help" $(__git_all_commands)
+	do
+		case $i in
+		*--*)             : helper pattern;;
+		applymbox)        : ask gittus;;
+		applypatch)       : ask gittus;;
+		archimport)       : import;;
+		cat-file)         : plumbing;;
+		check-attr)       : plumbing;;
+		check-ref-format) : plumbing;;
+		checkout-index)   : plumbing;;
+		commit-tree)      : plumbing;;
+		count-objects)    : infrequent;;
+		cvsexportcommit)  : export;;
+		cvsimport)        : import;;
+		cvsserver)        : daemon;;
+		daemon)           : daemon;;
+		diff-files)       : plumbing;;
+		diff-index)       : plumbing;;
+		diff-tree)        : plumbing;;
+		fast-import)      : import;;
+		fast-export)      : export;;
+		fsck-objects)     : plumbing;;
+		fetch-pack)       : plumbing;;
+		fmt-merge-msg)    : plumbing;;
+		for-each-ref)     : plumbing;;
+		hash-object)      : plumbing;;
+		http-*)           : transport;;
+		index-pack)       : plumbing;;
+		init-db)          : deprecated;;
+		local-fetch)      : plumbing;;
+		lost-found)       : infrequent;;
+		ls-files)         : plumbing;;
+		ls-remote)        : plumbing;;
+		ls-tree)          : plumbing;;
+		mailinfo)         : plumbing;;
+		mailsplit)        : plumbing;;
+		merge-*)          : plumbing;;
+		mktree)           : plumbing;;
+		mktag)            : plumbing;;
+		pack-objects)     : plumbing;;
+		pack-redundant)   : plumbing;;
+		pack-refs)        : plumbing;;
+		parse-remote)     : plumbing;;
+		patch-id)         : plumbing;;
+		peek-remote)      : plumbing;;
+		prune)            : plumbing;;
+		prune-packed)     : plumbing;;
+		quiltimport)      : import;;
+		read-tree)        : plumbing;;
+		receive-pack)     : plumbing;;
+		reflog)           : plumbing;;
+		repo-config)      : deprecated;;
+		rerere)           : plumbing;;
+		rev-list)         : plumbing;;
+		rev-parse)        : plumbing;;
+		runstatus)        : plumbing;;
+		sh-setup)         : internal;;
+		shell)            : daemon;;
+		show-ref)         : plumbing;;
+		send-pack)        : plumbing;;
+		show-index)       : plumbing;;
+		ssh-*)            : transport;;
+		stripspace)       : plumbing;;
+		symbolic-ref)     : plumbing;;
+		tar-tree)         : deprecated;;
+		unpack-file)      : plumbing;;
+		unpack-objects)   : plumbing;;
+		update-index)     : plumbing;;
+		update-ref)       : plumbing;;
+		update-server-info) : daemon;;
+		upload-archive)   : plumbing;;
+		upload-pack)      : plumbing;;
+		write-tree)       : plumbing;;
+		var)              : infrequent;;
+		verify-pack)      : infrequent;;
+		verify-tag)       : plumbing;;
+		*) echo $i;;
+		esac
+	done
+}
+
+
+__git_merge_strategylist=$(__git_merge_strategies | tr '\n' ' ')
+__git_all_commandlist="$(__git_all_commands | tr '\n' ' ')"
+__git_porcelain_commandlist="$(__git_porcelain_commands | tr '\n' ' ')"
+
+
+sed -e "s/__GIT_MERGE_STRATEGYLIST/\"$__git_merge_strategylist\"/"	\
+    -e "s/__GIT_ALL_COMMANDLIST/\"$__git_all_commandlist\"/"	\
+    -e "s/__GIT_PORCELAIN_COMMANDLIST/\"$__git_porcelain_commandlist\"/"	\
+    git-completion.bash.in > git-completion.bash
+
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash.in
old mode 100755
new mode 100644
similarity index 90%
rename from contrib/completion/git-completion.bash
rename to contrib/completion/git-completion.bash.in
index 88b1b3c..cf1b5fd
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash.in
@@ -21,13 +21,7 @@
 #    2) Added the following line to your .bashrc:
 #        source ~/.git-completion.sh
 #
-#    3) You may want to make sure the git executable is available
-#       in your PATH before this script is sourced, as some caching
-#       is performed while the script loads.  If git isn't found
-#       at source time then all lookups will be done on demand,
-#       which may be slightly slower.
-#
-#    4) Consider changing your PS1 to also show the current branch:
+#    3) Consider changing your PS1 to also show the current branch:
 #        PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
 #
 #       The argument to __git_ps1 will be displayed only if you
@@ -84,6 +78,14 @@ __gitdir ()
 	fi
 }
 
+
+# pregenerated stuff (to save load time)
+__git_merge_strategylist=__GIT_MERGE_STRATEGYLIST
+__git_all_commandlist=__GIT_ALL_COMMANDLIST
+__git_porcelain_commandlist=__GIT_PORCELAIN_COMMANDLIST
+
+
+
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
 # returns text to add to bash PS1 prompt (includes branch name)
 __git_ps1 ()
@@ -324,23 +326,6 @@ __git_remotes ()
 	done
 }
 
-__git_merge_strategies ()
-{
-	if [ -n "${__git_merge_strategylist-}" ]; then
-		echo "$__git_merge_strategylist"
-		return
-	fi
-	git merge -s help 2>&1 |
-	sed -n -e '/[Aa]vailable strategies are: /,/^$/{
-		s/\.$//
-		s/.*://
-		s/^[ 	]*//
-		s/[ 	]*$//
-		p
-	}'
-}
-__git_merge_strategylist=
-__git_merge_strategylist=$(__git_merge_strategies 2>/dev/null)
 
 __git_complete_file ()
 {
@@ -476,128 +461,19 @@ __git_complete_strategy ()
 {
 	case "${COMP_WORDS[COMP_CWORD-1]}" in
 	-s|--strategy)
-		__gitcomp "$(__git_merge_strategies)"
+		__gitcomp "$__git_merge_strategylist"
 		return 0
 	esac
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--strategy=*)
-		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
+		__gitcomp "$__git_merge_strategylist" "" "${cur##--strategy=}"
 		return 0
 		;;
 	esac
 	return 1
 }
 
-__git_all_commands ()
-{
-	if [ -n "${__git_all_commandlist-}" ]; then
-		echo "$__git_all_commandlist"
-		return
-	fi
-	local i IFS=" "$'\n'
-	for i in $(git help -a|egrep '^ ')
-	do
-		case $i in
-		*--*)             : helper pattern;;
-		*) echo $i;;
-		esac
-	done
-}
-__git_all_commandlist=
-__git_all_commandlist="$(__git_all_commands 2>/dev/null)"
-
-__git_porcelain_commands ()
-{
-	if [ -n "${__git_porcelain_commandlist-}" ]; then
-		echo "$__git_porcelain_commandlist"
-		return
-	fi
-	local i IFS=" "$'\n'
-	for i in "help" $(__git_all_commands)
-	do
-		case $i in
-		*--*)             : helper pattern;;
-		applymbox)        : ask gittus;;
-		applypatch)       : ask gittus;;
-		archimport)       : import;;
-		cat-file)         : plumbing;;
-		check-attr)       : plumbing;;
-		check-ref-format) : plumbing;;
-		checkout-index)   : plumbing;;
-		commit-tree)      : plumbing;;
-		count-objects)    : infrequent;;
-		cvsexportcommit)  : export;;
-		cvsimport)        : import;;
-		cvsserver)        : daemon;;
-		daemon)           : daemon;;
-		diff-files)       : plumbing;;
-		diff-index)       : plumbing;;
-		diff-tree)        : plumbing;;
-		fast-import)      : import;;
-		fast-export)      : export;;
-		fsck-objects)     : plumbing;;
-		fetch-pack)       : plumbing;;
-		fmt-merge-msg)    : plumbing;;
-		for-each-ref)     : plumbing;;
-		hash-object)      : plumbing;;
-		http-*)           : transport;;
-		index-pack)       : plumbing;;
-		init-db)          : deprecated;;
-		local-fetch)      : plumbing;;
-		lost-found)       : infrequent;;
-		ls-files)         : plumbing;;
-		ls-remote)        : plumbing;;
-		ls-tree)          : plumbing;;
-		mailinfo)         : plumbing;;
-		mailsplit)        : plumbing;;
-		merge-*)          : plumbing;;
-		mktree)           : plumbing;;
-		mktag)            : plumbing;;
-		pack-objects)     : plumbing;;
-		pack-redundant)   : plumbing;;
-		pack-refs)        : plumbing;;
-		parse-remote)     : plumbing;;
-		patch-id)         : plumbing;;
-		peek-remote)      : plumbing;;
-		prune)            : plumbing;;
-		prune-packed)     : plumbing;;
-		quiltimport)      : import;;
-		read-tree)        : plumbing;;
-		receive-pack)     : plumbing;;
-		reflog)           : plumbing;;
-		repo-config)      : deprecated;;
-		rerere)           : plumbing;;
-		rev-list)         : plumbing;;
-		rev-parse)        : plumbing;;
-		runstatus)        : plumbing;;
-		sh-setup)         : internal;;
-		shell)            : daemon;;
-		show-ref)         : plumbing;;
-		send-pack)        : plumbing;;
-		show-index)       : plumbing;;
-		ssh-*)            : transport;;
-		stripspace)       : plumbing;;
-		symbolic-ref)     : plumbing;;
-		tar-tree)         : deprecated;;
-		unpack-file)      : plumbing;;
-		unpack-objects)   : plumbing;;
-		update-index)     : plumbing;;
-		update-ref)       : plumbing;;
-		update-server-info) : daemon;;
-		upload-archive)   : plumbing;;
-		upload-pack)      : plumbing;;
-		write-tree)       : plumbing;;
-		var)              : infrequent;;
-		verify-pack)      : infrequent;;
-		verify-tag)       : plumbing;;
-		*) echo $i;;
-		esac
-	done
-}
-__git_porcelain_commandlist=
-__git_porcelain_commandlist="$(__git_porcelain_commands 2>/dev/null)"
-
 __git_aliases ()
 {
 	local i IFS=$'\n'
@@ -1077,7 +953,7 @@ _git_help ()
 		return
 		;;
 	esac
-	__gitcomp "$(__git_all_commands)
+	__gitcomp "$__git_all_commandlist
 		attributes cli core-tutorial cvs-migration
 		diffcore gitk glossary hooks ignore modules
 		repository-layout tutorial tutorial-2
@@ -1423,7 +1299,7 @@ _git_config ()
 		return
 		;;
 	pull.twohead|pull.octopus)
-		__gitcomp "$(__git_merge_strategies)"
+		__gitcomp "$__git_merge_strategylist"
 		return
 		;;
 	color.branch|color.diff|color.interactive|\
@@ -1524,7 +1400,7 @@ _git_config ()
 	pager.*)
 		local pfx="${cur%.*}."
 		cur="${cur#*.}"
-		__gitcomp "$(__git_all_commands)" "$pfx" "$cur"
+		__gitcomp "$__git_all_commandlist" "$pfx" "$cur"
 		return
 		;;
 	remote.*.*)
@@ -2116,7 +1992,7 @@ _git ()
 			--help
 			"
 			;;
-		*)     __gitcomp "$(__git_porcelain_commands) $(__git_aliases)" ;;
+		*)     __gitcomp "$__git_porcelain_commandlist $(__git_aliases)" ;;
 		esac
 		return
 	fi
-- 
1.6.5.rc2.18.g84f98.dirty
