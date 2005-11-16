From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Add short help to Cogito commands
Date: Wed, 16 Nov 2005 18:18:45 +0100
Message-ID: <20051116171845.GA15533@diku.dk>
References: <20051115125516.GD13925@diku.dk> <20051115221756.GX30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 18:21:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcQvt-0006NO-A1
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 18:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbVKPRSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 12:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVKPRSt
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 12:18:49 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:7905 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1751488AbVKPRSs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 12:18:48 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id EEADB6DFCFD; Wed, 16 Nov 2005 18:18:19 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 55B9C6DFAAF; Wed, 16 Nov 2005 18:18:19 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0792B61356; Wed, 16 Nov 2005 18:18:45 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051115221756.GX30496@pasky.or.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-2.5 required=5.0 tests=BAYES_00,DONT_DELETE,
	REMOVE_REMOVAL_NEAR autolearn=no version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12030>

Captions for all 74 Cogito options are added to the script headers on
the same line as the option being documented. The preferred syntax is
now:

	# <option>:: <caption>
	#	<description>

The old help message (the complete user manual) is moved to --long-help
and -h and --help both will now show the short help message. Output of
cg-help <cmd> is untouched. In the progress, rewrite cg-Xlib's
print_help to use one built-in type -P instead of multiple which's.

Documentation scripts (to generate cg-manpages and the long help
messages) has been updated to ignore the option captions.

Missing description of cg-admin-ls -t option was added.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
Petr Baudis <pasky@suse.cz> wrote Tue, Nov 15, 2005:
>   Hi,
> 
> Dear diary, on Tue, Nov 15, 2005 at 01:55:16PM CET, I got a letter
> where Jonas Fonseca <fonseca@diku.dk> said that...
> > I hope I am not the only one feeling that -h can sometimes be a little
> > too verbose when you want to have a quick overview of a Cogito command.
> > I'd like to make -h show only a short summary of the available options
> > and keep the longer help text for --help. I have attached a patch that
> > does something like this. Example:
> 
> Good idea. Perhaps even make this default for --help as well and offer
> --long-help. cg-help would still default to the long help, unless -s or
> something would be passed to it.

Agree, I didn't do the cg-help -s switch. The patch is overloaded as it
is. ;)

> >  - Add a special line with the caption. Since we already 'filters' the
> >    help text in the script headers this could go after the '::'.
> >    Example:
> > 
> > 	# ...
> > 	#
> > 	# -r FROM_ID[..TO_ID]:: Specify revisions to diff
> > 	#	Specify the revisions to diff using either '-r rev1
> > 	#	...
> > 
> >    So that it will be easy to remove from the --help output and from the
> >    generated manpages.
> > 
> > The last option is less intrusive, but does make the syntax of the
> > script headers less clean. Comments?
> 
> I prefer the second option and don't think it's much less clean. I think
> it would be actually uglier the other way - strange without separating
> empty line, too long with the separating line.

It is easier to sed out too. Although it would be nice for it to "fall
back" to what ever was on the first line if somebody didn't write an
option caption. Sort of the best of both. Anyway here goes...

diff --git a/Documentation/make-cg-asciidoc b/Documentation/make-cg-asciidoc
index 7ea5c23..00e4ce7 100755
--- a/Documentation/make-cg-asciidoc
+++ b/Documentation/make-cg-asciidoc
@@ -42,7 +42,7 @@ CAPTION=$(echo "$HEADER" | head -n 1 | t
 # were referenced as "`cg-command`". This way references from cg-* combos in
 # code listings will be ignored.
 BODY=$(echo "$HEADER" | sed '0,/^$/d' \
-		      | sed 's/`\(cg-[a-z-]\+\)`/gitlink:\1[1]/')
+		      | sed 's/`\(cg-[a-z-]\+\)`/gitlink:\1[1]/;s/^\(-.*\)::.*/\1::/')
 
 DESCRIPTION=
 OPTIONS=
@@ -100,7 +100,10 @@ OPTIONS
 $OPTIONS
 
 -h, --help::
-	Print usage help.
+	Print usage summary.
+
+--long-help::
+	Print user manual. The same as found in $TITLE.
 
 $MISC
 
diff --git a/Documentation/make-cogito-asciidoc b/Documentation/make-cogito-asciidoc
index fbd88ff..3bd0e9f 100755
--- a/Documentation/make-cogito-asciidoc
+++ b/Documentation/make-cogito-asciidoc
@@ -83,7 +83,7 @@ individual commands, do e.g.
 
 or
 
-	cg-log --help
+	cg-log --long-help
 
 Regular commands
 ~~~~~~~~~~~~~~~~
diff --git a/cg b/cg
index f501fb4..08aaf22 100755
--- a/cg
+++ b/cg
@@ -18,7 +18,7 @@
 #
 # OPTIONS
 # -------
-# --version::
+# --version:: Show the Cogito toolkit version
 #	Show the version of the Cogito toolkit. Equivalent to the output
 #	of `cg-version`.
 
diff --git a/cg-Xlib b/cg-Xlib
index fa3a059..dedbb62 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -347,18 +347,41 @@ deprecated_alias()
 
 print_help()
 {
-	which "cg-$1" >/dev/null 2>&1 || exit 1
+	_cg_cmd=$(type -P "cg-$2")
+	[ -n "$_cg_cmd" ] || exit 1
+
 	sed -n '/^USAGE=/,0s/.*"\(.*\)"/Usage: \1/p;
-	        /^deprecated_alias/,0s/^deprecated_alias \([^ ]*\)/\1 is the new name for/p' < $(which cg-$1) 
+	        /^deprecated_alias/,0s/^deprecated_alias \([^ ]*\)/\1 is the new name for/p' < "$_cg_cmd"
 	echo
-	sed -n '3,/^$/s/^# *//p' < $(which cg-$1)
+	if [ x"$1" = xlong ]; then
+		# TODO: Reduce this to just one sed if possible.
+		sed -n '3,/^$/s/^# *//p' < "$_cg_cmd" | sed 's/^\(-.*\)::.*/\1::/'
+		exit
+	fi
+
+	echo "Options:"
+	_cg_fmt="  %-20s %s\n"
+	sed -n 's/# \(-.*\)::[^A-Za-z0-9]\(.*\)/\1\n\2/p' < "$_cg_cmd" | while read line; do
+		case "$line" in
+		-*)
+			_cg_option="$line"
+			;;
+		*)
+			printf "$_cg_fmt" "$_cg_option" "$line"
+			;;
+		esac
+	done
+	printf "$_cg_fmt" "-h, --help" "Print usage summary"
+	printf "$_cg_fmt" "--long-help" "Print user manual"
 	exit
 }
 
 for option in "$@"; do
 	[ x"$option" = x-- ] && break
-	if [ x"$option" = x"-h" -o x"$option" = x"--help" ]; then
-		print_help ${_cg_cmd##cg-}
+	if [ x"$option" = x"-h" ] || [ x"$option" = x"--help" ]; then
+		print_help short ${_cg_cmd##cg-}
+	elif [ x"$option" = x"--long-help" ]; then
+		print_help long ${_cg_cmd##cg-}
 	fi
 done
 
diff --git a/cg-add b/cg-add
index fda4500..a50c0ac 100755
--- a/cg-add
+++ b/cg-add
@@ -17,11 +17,12 @@
 #
 # OPTIONS
 # -------
-# -N::
+# -N::	Update the lowlevel cache file
 #	Only update the cache: do not copy the data into the object database.
 #	This is for special purposes when you might not actually _have_ any
 #	object database. This option is normally not interesting.
-# -r::
+#
+# -r::	Add files recursively
 #	If you pass cg-add this flag and any directory names, it will try
 #	to add files in those directories recursively (with regard to your
 #	ignore rules - see cg-status documentation for more detailed
diff --git a/cg-admin-cat b/cg-admin-cat
index 8435bf2..89016d9 100755
--- a/cg-admin-cat
+++ b/cg-admin-cat
@@ -8,7 +8,7 @@
 #
 # OPTIONS
 # -------
-# -r TREE_ID::
+# -r TREE_ID:: Look for file in the given revision or tree
 #	ID of the revision or tree where to look for the file, instead of
 #	HEAD.
 
diff --git a/cg-admin-ls b/cg-admin-ls
index 57e3ffb..240d927 100755
--- a/cg-admin-ls
+++ b/cg-admin-ls
@@ -6,6 +6,13 @@
 # Optionally takes a commit or tree ID as a parameter, defaulting to
 # 'HEAD'.
 #
+# OPTIONS
+# -------
+# -t TREE_ID:: List content of the given TREE_ID
+#	List the content of the given TREE_ID.
+#
+# OUTPUT FORMAT
+# -------------
 # Each line in the output has the following format:
 #
 #	<mode>	<type>	<sha1>	<name>
diff --git a/cg-admin-setuprepo b/cg-admin-setuprepo
index 5affa7f..34d387f 100755
--- a/cg-admin-setuprepo
+++ b/cg-admin-setuprepo
@@ -28,7 +28,7 @@
 #
 # OPTIONS
 # -------
-# -g GROUP::
+# -g GROUP:: Specify group ownership for the repository 
 #	Name of the UNIX group covering the users authorized to push into
 #	the repository. If unspecified, only you (who ran this command) will
 #	have write (push) access.
diff --git a/cg-admin-uncommit b/cg-admin-uncommit
index 9357394..cc67ec2 100755
--- a/cg-admin-uncommit
+++ b/cg-admin-uncommit
@@ -11,7 +11,7 @@
 #
 # OPTIONS
 # -------
-# -t::
+# -t:: Restore the working copy of the previous commit
 #	This optional parameter makes `cg-admin-uncommit` to roll back
 #	the tree as well to the previous commit. Without this option
 #	(by default) 'Cogito' keeps the tree in its current state,
diff --git a/cg-clean b/cg-clean
index 1cc1ae8..6e2d1df 100755
--- a/cg-clean
+++ b/cg-clean
@@ -9,16 +9,16 @@
 #
 # OPTIONS
 # -------
-# -d::
+# -d:: Clean directories
 #	Also clean directories and their contents.
 #
-# -D::
+# -D:: Clean directories more thoroughly
 #	Same as -d but try harder (change permissions first).
 #
-# -q::
+# -q:: Silence progress reporting
 #	Quiet - don't report what's being cleaned.
 #
-# -x::
+# -x:: Clean files ignored by cg-status
 #	Also clean files ignored by cg-status, such as object files.
 
 USAGE="cg-clean [-d] [-D] [-q] [-x]"
diff --git a/cg-clone b/cg-clone
index c677ecd..f9f3f22 100755
--- a/cg-clone
+++ b/cg-clone
@@ -13,7 +13,7 @@
 #
 # OPTIONS
 # -------
-# -l::
+# -l::	Symlink the object database when cloning locally
 #	Symlink the object database when cloning locally, instead of
 #	hardlinking all the objects. This is suitable for very fast
 #	cloning of arbitrarily big repositories, but might be a trouble
@@ -23,7 +23,8 @@
 #	as well. The choice is yours.
 #	Note that you MUST NOT prune repository containing a symlink
 #	or being symlinked to.
-# -s::
+#
+# -s::	Clone into the current directory
 #	Clone in the current directory instead of creating a new one.
 #	Specifying both -s and a destination directory makes no sense.
 
diff --git a/cg-commit b/cg-commit
index 33bb17d..f413396 100755
--- a/cg-commit
+++ b/cg-commit
@@ -17,44 +17,44 @@
 #
 # OPTIONS
 # -------
-# -c COMMIT_ID::
+# -c COMMIT_ID:: Copy author info and commit message from COMMIT_ID
 #	Copy the commit from a given commit ID (that is the author information
 #	and the commit message - NOT committer information). This option
 #	is typically used when replaying commits from one lineage or
 #	repository to another.
 #
-# -C::
+# -C:: Ignore cache
 #	Make `cg-commit` ignore the cache and just commit the thing as-is.
 #	Note, this is used internally by 'Cogito' when merging, and it is
 #	also useful when you are performing the initial commit manually. This
 #	option does not make sense when files are given on the command line.
 #
-# -m MESSAGE::
+# -m MESSAGE:: Specify commit message
 #	Specify the commit message, which is used instead of starting
 #	up an editor (if the input is not `stdin`, the input is appended
 #	after all the '-m' messages). Multiple '-m' parameters are appended
 #	to a single commit message, each as separate paragraph.
 #
-# -e::
+# -e:: Force message editing of messages given with -m
 #	Force the editor to be brought up even when '-m' parameters were
 #	passed to `cg-commit`.
 #
-# -E::
+# -E:: Force message editing and commit the result
 #	Force the editor to be brought up and do the commit even if
 #	the default commit message is not changed.
 #
-# -f::
+# -f:: Force commit when no changes has been made
 #	Force the commit even when there's "nothing to commit", that is
 #	the tree is the same as the last time you committed, no changes
 #	happened.
 #
-# -N::
+# -N:: Only update the cache
 #	Don't add the files to the object database, just update the caches
 #	and the commit information. This is for special purposes when you
 #	might not actually _have_ any object database. This option is
 #	normally not interesting.
 #
-# -q::
+# -q:: Be very very quiet
 #	Be quiet in case there's "nothing to commit", and silently exit
 #	returning success. In a sense, this is the opposite to '-f'.
 #
diff --git a/cg-diff b/cg-diff
index 628be53..0572170 100755
--- a/cg-diff
+++ b/cg-diff
@@ -10,26 +10,26 @@
 #
 # OPTIONS
 # -------
-# -c::
+# -c:: Colorize
 #	Colorize the diff output
 #
-# -p::
+# -p:: Use ID parent
 #	Show diff to the parent of the current commit (or the commit
 #	specified by the -r parameter).
 #
-# -s::
+# -s:: Summarize and show diff stat
 #	Summarize the diff by showing a histogram for removed and added
 #	lines (similar to the output of diffstat(1)) and information
 #	about added and renamed files and mode changes.
 #
-# -r FROM_ID[..TO_ID]::
+# -r FROM_ID[..TO_ID]:: Limit to revision range
 #	Specify the revisions to diff using either '-r rev1..rev2' or
 #	'-r rev1 -r rev2'. If no revision is specified, the current
 #	working tree is implied. Note that no revision is different from
 #	empty revision which means '-r rev..' compares between 'rev' and
 #	'HEAD', while '-r rev' compares between 'rev' and working tree.
 #
-# -m::
+# -m:: Base the diff at the merge base
 #	Base the diff at the merge base of the -r arguments (defaulting
 #	to HEAD and origin).
 #
diff --git a/cg-fetch b/cg-fetch
index c406c9a..5a2039f 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -25,10 +25,10 @@
 #
 # OPTIONS
 # -------
-# -f::
+# -f:: Force the complete fetch even if the heads are the same.
 #	Force the complete fetch even if the heads are the same.
 #
-# -v::
+# -v:: Enable verbosity
 #	Display more verbose output.
 #
 # ENVIRONMENT
diff --git a/cg-help b/cg-help
index ddec1b9..6ba7657 100755
--- a/cg-help
+++ b/cg-help
@@ -13,7 +13,7 @@
 #
 # OPTIONS
 # -------
-# -c::
+# -c::	Colorize
 #	Colorize the output.
 
 USAGE="cg-help [-c] [cg-COMMAND | COMMAND]"
@@ -33,6 +33,7 @@ setup_colors()
 	local copyright="$(tput setaf 4)"
 
 	apply_colors="
+	s/^\(-.*\)::.*/$desclist\1$color_none:/
 	s/^\(.*\)::/$desclist\1$color_none:/
 	s/\`\(cg-[a-z-]*\)\`/$cgcmd\1$color_none/g
 	s/\`\([^\`]*\)\`/$codesnippet&$color_none/g
@@ -90,7 +91,7 @@ elif [ "$ARGS" = "tag" ]; then
 	exit
 elif [ "$ARGS" ]; then
 	cmd=$(echo "${ARGS[0]}" | sed 's/^cg-//')
-	print_help $cmd | colorize
+	print_help long $cmd | colorize
 	[ "${PIPESTATUS[0]}" -eq 0 ] && exit
 	echo "cg-help: no help available for command \"${ARGS[0]}\""
 	echo "Call cg-help without any arguments for the list of available commands"
@@ -126,6 +127,6 @@ These expressions can be used interchang
 
 For details on individual commands, do e.g.:
 	cg-help cg-log
-	cg-log --help
+	cg-log --long-help
 (both variants are equivalent)
 __END__
diff --git a/cg-init b/cg-init
index 0ee264e..a0a7372 100755
--- a/cg-init
+++ b/cg-init
@@ -13,22 +13,22 @@
 #
 # OPTIONS
 # -------
-# -e EXCLUDEPATTERN::
+# -e EXCLUDEPATTERN:: Ignore files matching EXCLUDEPATTERN
 #	Ignore files matching this pattern when importing files for the
 #	initial commit. Note that if you are importing any .gitignore
 #	files, they will be considered as well. If you want to make
 #	en even more custom choice of files to be imported, use the -I
 #	parameter and add and perform the initial commit manually.
 #
-# -I::
+# -I:: No initial commit
 #	Do not perform the initial commit. You can perform the initial commit
 #	manually later, but you will need to pass cg-commit the -C parameter.
 #
-# -m MESSAGE::
+# -m MESSAGE:: Specify initial commit message
 #	Specify the commit message for the initial commit. See `cg-commit`
 #	documentation for details.
 #
-# -N::
+# -N:: Only update the cache
 #	Only update the cache: do not copy the data into the object database.
 #	This is for special purposes when you might not actually _have_ any
 #	object database. This option is normally not interesting.
diff --git a/cg-log b/cg-log
index 710ce7b..89fe063 100755
--- a/cg-log
+++ b/cg-log
@@ -13,7 +13,7 @@
 # Arguments not interpreted as options will be interpreted as filenames;
 # cg-log then displays only changes in those files.
 #
-# -c::
+# -c::	Colorize
 #	Colorize the output. The used colors are listed below together
 #	with information about which log output (summary, full or both)
 #	they apply to:
@@ -26,10 +26,10 @@
 #		- `date`:	'green'		(summary)
 #		- `trim_mark`:	'magenta'	(summary)
 #
-# -f::
+# -f::	List affected files
 #	List affected files. (No effect when passed along `-s`.)
 #
-# -r FROM_ID[..TO_ID]::
+# -r FROM_ID[..TO_ID]:: Limit to a set of revisions
 #	Limit the log information to a set of revisions using either
 #	'-r FROM_ID[..TO_ID]' or '-r FROM_ID -r TO_ID'. In both cases the
 #	option expects IDs which resolve to commits and will include the
@@ -37,31 +37,31 @@
 #	to the initial commit is shown. If no revisions is specified,
 #	the log information starting from 'HEAD' will be shown.
 #
-# -d DATE::
+# -d DATE:: Limit to revisions newer than given DATE
 #	Limit the log information to revisions newer than given DATE,
 #	and on second time further restrain it to revisions older than
 #	given date. Therefore, '-d "2 days ago" -d "yesterday"' will
 #	show all the commits from the day before yesterday.
 #
-# -m::
+# -m::	End the log at the merge base of the revision set
 #	End the log listing at the merge base of the -r arguments
 #	(defaulting to HEAD and origin).
 #
-# -M, --no-merges::
+# -M, --no-merges:: Ignore merge commits
 #	Don't display merge commits in the log.
 #
-# -s::
+# -s::	Summarize the log entries
 #	Show a one line summary for each log entry. The summary contains
 #	information about the commit date, the author, the first line
 #	of the commit log and the commit ID. Long author names and commit
 #	IDs are trimmed and marked with an ending tilde (~).
 #
-# --summary::
+# --summary:: Group commits by title
 #	Generate the changes summary, listing the commit titles grouped
 #	by their author. This is also known as a "shortlog", suitable
 #	e.g. for contribution summaries of announcements.
 #
-# -uUSERNAME::
+# -uUSERNAME:: Limit to commit where author/committer matches USERNAME
 #	List only commits where author or committer contains 'USERNAME'.
 #	The search for 'USERNAME' is case-insensitive.
 #
diff --git a/cg-merge b/cg-merge
index 0e6066d..1087951 100755
--- a/cg-merge
+++ b/cg-merge
@@ -34,17 +34,17 @@
 #
 # OPTIONS
 # -------
-# -b BASE_COMMIT::
+# -b BASE_COMMIT:: Specify the base commit for the merge
 #	Parameter specifies the base commit for the merge. Otherwise, the
 #	least common ancestor is automatically selected.
 #
-# -c::
+# -c:: Disable autocommitting
 #	Parameter specifies that you want to have tree merge never
 #	autocommitted, but want to review and commit it manually. This will
 #	basically make cg-merge always behave like there were conflicts
 #	during the merge.
 #
-# -j::
+# -j:: Join current branch with BRANCH_NAME
 #	Join the current branch and BRANCH_NAME together. This makes sense
 #	when the branches have no common history, meaning they are actually
 #	not branches related at all as far as GIT is concerned. Merging such
@@ -52,7 +52,7 @@
 #	you do not want; but equally likely, you may actually WANT to join
 #	the projects together, which is what this option does.
 #
-# --squash::
+# --squash:: Use "squash" merge to record pending commits as a single merge commit
 #	"Squash" merge - condense all the to-be-merged commits to a single
 #	merge commit. This means "throw away history of the branch I'm
 #	merging", essentially like in CVS or SVN, with the same problem -
diff --git a/cg-mkpatch b/cg-mkpatch
index afaeff1..8982056 100755
--- a/cg-mkpatch
+++ b/cg-mkpatch
@@ -13,14 +13,14 @@
 #
 # OPTIONS
 # -------
-# -d DIRNAME::
+# -d DIRNAME:: Create patches in the DIRNAME directory
 #	Split the patches to separate files with their names in the
 #	format "%02d.patch", created in directory DIRNAME (will be
 #	created if non-existent). Note that this makes sense only
 #	when generating patch series, that is when you use the -r
 #	argument.
 #
-# -f FORMAT::
+# -f FORMAT:: Specify patch file name format
 #	Format string used for generating the patch filename when
 #	outputting the split-out patches (that is, passed the -d
 #	option). This is by default "%s/%02d-%s.patch". The first %s
@@ -28,11 +28,11 @@
 #	sequence number. The last %s is mangled first line of the
 #	commit message - kind of patch title.
 #
-# -m::
+# -m::	Base the diff at the merge base
 #	Base the patches at the merge base of the -r arguments
 #	(defaulting to HEAD and origin).
 #
-# -r FROM_ID[..TO_ID]::
+# -r FROM_ID[..TO_ID]::	Limit to revision range
 #	Specify a set of commits to make patches from using either
 #	'-r FROM_ID[..TO_ID]' or '-r FROM_ID -r TO_ID'. In both cases the
 #	option expects IDs which resolve to commits and will include the
@@ -40,7 +40,7 @@
 #	from 'FROM_ID' to the initial commit will be generated. If no
 #	`-r` option is given the commit ID defaults to 'HEAD'.
 #
-# -s::
+# -s:: Omit patch header
 #	Specify whether to print a short version of the patch without
 #	a patch header with meta info such as author and committer.
 #
diff --git a/cg-object-id b/cg-object-id
index fde2e2b..f2cb54e 100755
--- a/cg-object-id
+++ b/cg-object-id
@@ -8,22 +8,22 @@
 #
 # OPTIONS
 # -------
-# -c::
+# -c:: Get commit ID
 #	Get ID of commit matching the object ID (error out if it is not
 #	a commit). This is the default if you do not pass any parameter
 #	as well, but that is only for the human usage. For clarity, all
 #	scripted usage of cg-object-id should use -c explicitly if it
 #	wants a commit.
 #
-# -n::
+# -n:: Disable object type checking
 #	Normalize only - don't check the object type.
 #
-# -p::
+# -p:: Get parent commit ID(s)
 #	Get ID of the first parent commit of a given revision or HEAD.
 #	NOTE: Multiple SHA1s separated by newlines will be returned for
 #	commits with multiple parents.
 #
-# -t::
+# -t:: Get tree ID
 #	Get ID of tree associated with given commit or HEAD.
 #
 # OBJECT_ID::
diff --git a/cg-patch b/cg-patch
index 153376e..d567b8e 100755
--- a/cg-patch
+++ b/cg-patch
@@ -12,7 +12,7 @@
 #
 # OPTIONS
 # -------
-# -R::
+# -R:: Apply in reverse
 #	Applies the patch in reverse (therefore effectively unapplies it)
 #
 # Takes the diff on stdin.
diff --git a/cg-push b/cg-push
index d63fb65..b4361e3 100755
--- a/cg-push
+++ b/cg-push
@@ -14,7 +14,7 @@
 #
 # OPTIONS
 # -------
-# -t TAG::
+# -t TAG:: Push the given TAG
 #	Tells cg-push to also push the given tag. Note that in the
 #	future, cg-push should push tags automatically. Also note
 #	that even if you pass `cg-push` the '-t' arguments, your
diff --git a/cg-reset b/cg-reset
index f2e92eb..eb25fb1 100755
--- a/cg-reset
+++ b/cg-reset
@@ -16,7 +16,7 @@
 #
 # OPTIONS
 # -------
-# --adds-removes::
+# --adds-removes:: Only reset info about added and removed files
 #	Reset ONLY the so-called "index" file. This effectively means that
 #	any adds and removes you did will be unrecorded (but if you removed
 #	the file physically as well, that will not be undone - run
diff --git a/cg-restore b/cg-restore
index f864b64..348f552 100755
--- a/cg-restore
+++ b/cg-restore
@@ -23,12 +23,13 @@
 #
 # OPTIONS
 # -------
-# -f::
+# -f:: Undo local changes since last commit
 #	Restore even locally modified files to the version as of
 #	the last commit. Take care!
-# -r COMMIT_ID::
-# -r TREE_ID::
-# -r BLOB_ID::
+#
+# -r COMMIT_ID:: Restore files to given COMMIT_ID
+# -r TREE_ID:: Restore files to given TREE_ID
+# -r BLOB_ID:: Restore files to given BLOB_ID
 #	Restore the file to the state appropriate to the given ID.
 #	The list of files to recover is mandatory in this case.
 
diff --git a/cg-rm b/cg-rm
index 4b7e5ee..2fea342 100755
--- a/cg-rm
+++ b/cg-rm
@@ -8,9 +8,10 @@
 #
 # OPTIONS
 # -------
-# -f::
+# -f:: Force removal of the physical files
 #	Also delete the files from the tree physically.
-# -n::
+#
+# -n:: Keep the physical files
 #	Do not delete the files from the tree physically, if they are
 #	still there. So it effectively just makes Cogito to stop caring
 #	about the file. This is the default.
diff --git a/cg-status b/cg-status
index 2cb86be..61c41c8 100755
--- a/cg-status
+++ b/cg-status
@@ -34,21 +34,21 @@
 # If neither -g or -w is passed, both is shown; otherwise, only the
 # corresponding parts are shown.
 #
-# -g::
+# -g:: Show the GIT repository information
 #	Show the GIT repository information.
 #
-# -n::
+# -n:: Do not show status flags
 #	Do not show status flags. This is probably useful only when you filter
 #	the flags for a single specific flag using the '-s' option.
 #
-# -s STATUS::
+# -s STATUS:: Limit to files matching the STATUS flags
 #	Show only files with the given status flag, e.g. '-s D'. You can list
 #	multiple flags ('-s MmA') to filter for all of them.
 #
-# -w::
+# -w:: Show working files
 #	Show the working tree file list.
 #
-# -x::
+# -x:: Disable file exclusion
 #	Don't exclude any files from listing.
 #
 # DIRPATH::
diff --git a/cg-switch b/cg-switch
index 4f7994b..4ab160c 100755
--- a/cg-switch
+++ b/cg-switch
@@ -11,19 +11,19 @@
 #
 # OPTIONS
 # -------
-# -f::
+# -f:: Enable overwriting of existing branches
 #	Force the branch's head pointer update even if the branch
 #	already exists. WARNING: The pointer to the original contents
 #	of the branch will be lost! The contents itself will not be
 #	deleted, `git-fsck-objects --unreachable` might help you to
 #	find it.
 #
-# -n::
+# -n:: No switch; only create and update the branch
 #	Do not switch your current branch to the given branch. This
 #	will make cg-switch to only create or update the branch, but
 #	leave your working copy alone.
 #
-# -r COMMIT_ID::
+# -r COMMIT_ID:: Branch off the given COMMIT_ID
 #	Point the branch at the given commit. Defaults to the current
 #	commit when creating a new branch; when switching to an existing
 #	branch, the branch pointer is not modified if no '-r' is passed.
diff --git a/cg-tag b/cg-tag
index 00ce8d4..da4f2d5 100755
--- a/cg-tag
+++ b/cg-tag
@@ -13,12 +13,15 @@
 #
 # OPTIONS
 # -------
-# -d DESCRIPTION::
+# -d DESCRIPTION:: Specify tag description
 #	Description of the tag.
-# -k KEYNAME::
+#
+# -k KEYNAME:: Use the given KEYNAME to sign the tag
 #	Use the given key to sign the tag, instead of the default one.
-# -s::
+#
+# -s:: Sign the tag by your private key using GPG.
 #	Sign the tag by your private key using GPG.
+#
 # OBJECT_ID::
 #	This is most usually the ID of the commit to tag. Tagging
 #	other objects than commits is possible, but rather "unusual".
diff --git a/cg-update b/cg-update
index aaed291..39b1949 100755
--- a/cg-update
+++ b/cg-update
@@ -18,10 +18,10 @@
 #
 # OPTIONS
 # -------
-# -f::
+# -f:: Force the complete fetch even if the heads are the same.
 #	Force the complete fetch even if the heads are the same.
 #
-# --squash::
+# --squash:: Use "squash" merge to record pending commits as a single merge commit
 #	"Squash" merge - condense all the to-be-merged commits to a single
 #	merge commit. This is not to be used lightly; see the cg-merge
 #	documenation for further details.

-- 
Jonas Fonseca
