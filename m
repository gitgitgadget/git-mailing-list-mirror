From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH] Speedup bash completion loading
Date: Fri, 9 Oct 2009 20:08:56 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20091009160856.GA26833@tugrik.mns.mnsspb.ru>
References: <20091005165802.GA24402@tugrik.mns.mnsspb.ru> <4e0a90ed0910051218oaa64b94jd12a6678934523ac@mail.gmail.com> <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org> <20091008132718.GA12161@tugrik.mns.mnsspb.ru> <20091008150206.GD9261@spearce.org> <20091009090958.GA4758@tugrik.mns.mnsspb.ru> <20091009144606.GT9261@spearce.org> <20091009152149.GA26171@tugrik.mns.mnsspb.ru> <20091009153936.GV9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 18:16:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwI8N-0000xi-Tv
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 18:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933583AbZJIQK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 12:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933474AbZJIQK2
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 12:10:28 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:51814 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932659AbZJIQK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 12:10:27 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1MwI2O-0001Qz-LQ; Fri, 09 Oct 2009 20:09:48 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1MwI1Y-0007Ie-Io; Fri, 09 Oct 2009 20:08:56 +0400
Content-Disposition: inline
In-Reply-To: <20091009153936.GV9261@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129821>

On Fri, Oct 09, 2009 at 08:39:36AM -0700, Shawn O. Pearce wrote:
> Kirill Smelkov <kirr@mns.spb.ru> wrote:
> > On Fri, Oct 09, 2009 at 07:46:06AM -0700, Shawn O. Pearce wrote:
> > > 
> > > Squash this into the first patch and add the egrep change made by
> > > Stephen Boyd "[PATCH 1/2] completion: fix completion of git <TAB><TAB>".
> > 
> > While it is technically easy to do so, isn't this a bad idea to squash
> > semantic changes and fixes into something which should be as close as
> > code movement?
> 
> The ejection forces the code to build with /bin/bash, unless you
> apply the trivial fixes related to IFS to make it work with dash.
> As they are trivial the tiny semantic change during the code move
> is just cleaner.
> 
> > Especially Stephen's fix?
> 
> I expect Junio to apply his patch first, and then yours.  Since he
> is changing a region you are moving, you need to account for it in
> your patch, otherwise we have a conflict and/or a regression.

Now I see, OK. Here is the patch which should be applied on top of
Stephen's 1/2:

---- 8< ----

From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Mon, 5 Oct 2009 13:36:15 +0400
Subject: [PATCH v4] Speedup bash completion loading

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

NOTE
----

As Shawn O. Pearce suggested, git-completion.bash.generate code is now
used at compile time, so we shouldn't assume bash is avalable there.

Hence, IFS tweak (not needed in the first place) in __git_all_commands()
was removed, for compile-time code to be bashism free.

Cc: Ted Pavlic <ted@tedpavlic.com>
Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 contrib/completion/.gitignore                      |    1 +
 contrib/completion/Makefile                        |   11 ++
 contrib/completion/git-completion.bash.generate    |  128 ++++++++++++++++
 ...{git-completion.bash => git-completion.bash.in} |  161 +++-----------------
 4 files changed, 162 insertions(+), 139 deletions(-)
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
index 0000000..90aa225
--- /dev/null
+++ b/contrib/completion/Makefile
@@ -0,0 +1,11 @@
+all	: git-completion.bash
+
+
+git-completion.bash: git-completion.bash.in git-completion.bash.generate
+	# Generate completions for binaries we have just built
+	PATH="$(shell pwd)/../..:$$PATH" ./git-completion.bash.generate
+
+
+clean:
+	rm -f git-completion.bash
+
diff --git a/contrib/completion/git-completion.bash.generate b/contrib/completion/git-completion.bash.generate
new file mode 100755
index 0000000..ff64202
--- /dev/null
+++ b/contrib/completion/git-completion.bash.generate
@@ -0,0 +1,128 @@
+#!/bin/sh
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
+	local i
+	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
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
+	local i
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
index 652a47c..67d03c3
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
@@ -60,6 +54,21 @@
 #       git@vger.kernel.org
 #
 
+
+# pregenerated stuff (to save load time)
+__git_merge_strategylist=__GIT_MERGE_STRATEGYLIST
+__git_all_commandlist=__GIT_ALL_COMMANDLIST
+__git_porcelain_commandlist=__GIT_PORCELAIN_COMMANDLIST
+
+# remind folks that git-completion.bash.in can't be sourced
+case "$__git_merge_strategylist" in
+__GIT*)
+	echo "E: git-completion.bash.in can't be sourced"
+	return 1 ;;
+esac
+
+
+
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
@@ -324,23 +333,6 @@ __git_remotes ()
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
@@ -476,128 +468,19 @@ __git_complete_strategy ()
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
-	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
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
@@ -1077,7 +960,7 @@ _git_help ()
 		return
 		;;
 	esac
-	__gitcomp "$(__git_all_commands)
+	__gitcomp "$__git_all_commandlist
 		attributes cli core-tutorial cvs-migration
 		diffcore gitk glossary hooks ignore modules
 		repository-layout tutorial tutorial-2
@@ -1423,7 +1306,7 @@ _git_config ()
 		return
 		;;
 	pull.twohead|pull.octopus)
-		__gitcomp "$(__git_merge_strategies)"
+		__gitcomp "$__git_merge_strategylist"
 		return
 		;;
 	color.branch|color.diff|color.interactive|\
@@ -1524,7 +1407,7 @@ _git_config ()
 	pager.*)
 		local pfx="${cur%.*}."
 		cur="${cur#*.}"
-		__gitcomp "$(__git_all_commands)" "$pfx" "$cur"
+		__gitcomp "$__git_all_commandlist" "$pfx" "$cur"
 		return
 		;;
 	remote.*.*)
@@ -2116,7 +1999,7 @@ _git ()
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
