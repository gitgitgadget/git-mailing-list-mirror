From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-commit: revamp the git-commit semantics.
Date: Sun, 05 Feb 2006 02:24:03 -0800
Message-ID: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 11:24:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5h49-0001EE-67
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 11:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWBEKYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 05:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWBEKYI
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 05:24:08 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8065 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750711AbWBEKYH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 05:24:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060205102305.FHWO3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Feb 2006 05:23:05 -0500
To: Alan Chandler <alan@chandlerfamily.org.uk>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Keith Packard <keithp@keithp.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Michael Fischer <michael@visv.net>,
	Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15629>

I am addressing people who participated with their valuable
inputs to the earlier "git commit" discussion.

Here is my first cut.  I'd appreciate to hear from both
git-experienced people and git newcomers how comfortable this
new implementation is.  Improvement patches on top of this are
certainly appreciated.

The main focus of this patch is to reduce the confusion factor
while not disrupting experienced git users with trained fingers,
but it unfortunately does introduce two incompatible changes:

 - When the command decides not to create a commit for whatever
   reason, the updates made to the index file, either because of
   --all option or "-i paths..." option, are forgotten.

 - Traditional "git commit paths..." _must_ be spelled as "git
   commit -i paths...".  "git commit paths..." means a
   completely different thing now.

I think the first incompatibility would not break anybody's work
habit and I am hoping that everybody considers this to be purely
an improvement.  It reduces major confusion factor in the
current implementation when you do:

	$ edit foo
        $ git commit -a

and cause the commit to abort by giving it an empty log
message.  In the current implementation, "git diff" would not
show anything after that, but with this you would see the edit
of foo.

The second one is not something I am too happy about, but many
people seem to have been confused that running "git update-index
foo" and then "git commit bar" commits both foo and bar.  To
prevent this change from burning index-aware people too much,
this form refuses to run during a merge.  Also to reduce
confusion for people who forget differences between "git diff" and
"git diff HEAD", it refuses to run when the paths involved do
not match between the index and HEAD.

-- >8 --
[PATCH] git-commit: revamp the git-commit semantics.

 - "git commit" without _any_ parameter keeps the traditional
   behaviour.  It commits the current index.

   We commit the whole index even when this form is run from a
   subdirectory.

 - "git commit --include paths..." (or "git commit -i paths...")
   is equivalent to:

   	git update-index --remove paths...
        git commit

 - "git commit paths..." acquires a new semantics.  This is an
   incompatible change that needs user training, which I am
   still a bit reluctant to swallow, but enough people seem to
   have complained that it is confusing to them.  It

   1. refuses to run if $GIT_DIR/MERGE_HEAD exists, and reminds
      trained git users that the traditional semantics now needs
      -i flag.

   2. refuses to run if named paths... are different in HEAD and
      the index (ditto about reminding).  Added paths are OK.

   3. reads HEAD commit into a temporary index file.

   4. updates named paths... from the working tree in this
      temporary index.

   5. does the same updates of the paths... from the working
      tree to the real index.

   6. makes a commit using the temporary index that has the
      current HEAD as the parent, and updates the HEAD with this
      new commit.

 - "git commit --all" can run from a subdirectory, but it updates
   the index with all the modified files and does a whole tree
   commit.

 - In all cases, when the command decides not to create a new
   commit, the index is left as it was before the command is
   run.  This means that the two "git diff" in the following
   sequence:

       $ git diff
       $ git commit -a
       $ git diff

   would show the same diff if you abort the commit process by
   making the commit log message empty.

This commit also introduces much requested --author option.

	$ git commit --author 'A U Thor <author@example.com>'

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/core-tutorial.txt |    6 -
 Documentation/git-commit.txt    |   61 ++++++
 git-commit.sh                   |  403 ++++++++++++++++++++++++++++-----------
 t/t1200-tutorial.sh             |    6 -
 4 files changed, 354 insertions(+), 122 deletions(-)

551045c2a2eefdc85307de5f4b72ba720d095106
diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 4513ad6..4e6ec0e 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -858,7 +858,7 @@ that branch, and do some work there.
 ------------------------------------------------
 $ git checkout mybranch
 $ echo "Work, work, work" >>hello
-$ git commit -m 'Some work.' hello
+$ git commit -m 'Some work.' -i hello
 ------------------------------------------------
 
 Here, we just added another line to `hello`, and we used a shorthand for
@@ -881,7 +881,7 @@ hasn't happened in the `master` branch a
 ------------
 $ echo "Play, play, play" >>hello
 $ echo "Lots of fun" >>example
-$ git commit -m 'Some fun.' hello example
+$ git commit -m 'Some fun.' -i hello example
 ------------
 
 since the master branch is obviously in a much better mood.
@@ -946,7 +946,7 @@ Work, work, work
 and once you're happy with your manual merge, just do a
 
 ------------
-$ git commit hello
+$ git commit -i hello
 ------------
 
 which will very loudly warn you that you're now committing a merge
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 72f96fc..53b64fa 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,8 +8,8 @@ git-commit - Record your changes
 SYNOPSIS
 --------
 [verse]
-'git-commit' [-a] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>]
-	   [-e] [--] <file>...
+'git-commit' [-a] [-i] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>]
+	   [-e] [--author <author>] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -40,6 +40,10 @@ OPTIONS
 	Take the commit message from the given file.  Use '-' to
 	read the message from the standard input.
 
+--author <author>::
+	Override the author name used in the commit.  Use
+	`A U Thor <author@example.com>` format.
+
 -m <msg>::
 	Use the given <msg> as the commit message.
 
@@ -63,17 +67,66 @@ OPTIONS
 	commit log message unmodified.  This option lets you
 	further edit the message taken from these sources.
 
+-i|--include::
+	Instead of committing only the files specified on the
+	command line, update them in the index file and then
+	commit the whole index.  This is the traditional
+	behaviour.
+
 --::
 	Do not interpret any more arguments as options.
 
 <file>...::
-	Update specified paths in the index file before committing.
-
+	Commit only the files specified on the command line.
+	This format cannot be used during a merge, nor when the
+	index and the latest commit does not match on the
+	specified paths to avoid confusion.
 
 If you make a commit and then found a mistake immediately after
 that, you can recover from it with gitlink:git-reset[1].
 
 
+Discussion
+----------
+
+`git commit` without _any_ parameter commits the tree structure
+recorded by the current index file.  This is a whole-tree commit
+even the command is invoked from a subdirectory.
+
+`git commit --include paths...` is equivalent to
+
+	git update-index --remove paths...
+	git commit
+
+That is, update the specified paths to the index and then commit
+the whole tree.
+
+`git commit paths...` largely bypasses the index file and
+commits only the changes made to the specified paths.  It has
+however several safety valves to prevent confusion.
+
+. It refuses to run during a merge (i.e. when
+  `$GIT_DIR/MERGE_HEAD` exists), and reminds trained git users
+  that the traditional semantics now needs -i flag.
+
+. It refuses to run if named `paths...` are different in HEAD
+  and the index (ditto about reminding).  Added paths are OK.
+  This is because an earlier `git diff` (not `git diff HEAD`)
+  would have shown the differences since the last `git
+  update-index paths...` to the user, and an inexperienced user
+  may mistakenly think that the changes between the index and
+  the HEAD (i.e. earlier changes made before the last `git
+  update-index paths...` was done) are not being committed.
+
+. It reads HEAD commit into a temporary index file, updates the
+  specified `paths...` and makes a commit.  At the same time,
+  the real index file is also updated with the same `paths...`.
+
+`git commit --all` updates the index file with _all_ changes to
+the working tree, and makes a whole-tree commit, regardless of
+which subdirectory the command is invoked in.
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org> and
diff --git a/git-commit.sh b/git-commit.sh
index 10946ed..d3325bc 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -1,85 +1,170 @@
 #!/bin/sh
 #
 # Copyright (c) 2005 Linus Torvalds
-#
+# Copyright (c) 2006 Junio C Hamano
+
+USAGE='[-a] [-i] [-s] [-v | --no-verify]  [-m <message> | -F <logfile> | (-C|-c) <commit>] [-e] [--author <author>] [<path>...]'
 
-USAGE='[-a] [-s] [-v | --no-verify]  [-m <message> | -F <logfile> | (-C|-c) <commit>] [-e] [<path>...]'
+SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
-all= logfile= use_commit= no_edit= log_given= log_message= verify=t signoff=
+git-rev-parse --verify HEAD >/dev/null 2>&1 ||
+initial_commit=t
+
+refuse_partial () {
+	echo >&2 "$1"
+	echo >&2 "Experienced git users:"
+	echo >&2 "You might have meant to say 'git commit -i paths...', perhaps?"
+	exit 1
+}
+
+all=
+also=
+logfile=
+use_commit=
+no_edit=
+log_given=
+log_message=
+verify=t
+signoff=
+force_author=
 while case "$#" in 0) break;; esac
 do
   case "$1" in
+  -F|--F|-f|--f|--fi|--fil|--file)
+      case "$#" in 1) usage ;; esac
+      shift
+      no_edit=t
+      log_given=t$log_given
+      logfile="$1"
+      shift
+      ;;
+  -F*|-f*)
+      no_edit=t
+      log_given=t$log_given
+      logfile=`expr "$1" : '-[Ff]\(.*\)'`
+      shift
+      ;;
+  --F=*|--f=*|--fi=*|--fil=*|--file=*)
+      no_edit=t
+      log_given=t$log_given
+      logfile=`expr "$1" : '-[^=]*=\(.*\)'`
+      shift
+      ;;
   -a|--a|--al|--all)
-    all=t
-    shift ;;
-  -F=*|--f=*|--fi=*|--fil=*|--file=*)
-    log_given=t$log_given
-    logfile=`expr "$1" : '-[^=]*=\(.*\)'`
-    no_edit=t
-    shift ;;
-  -F|--f|--fi|--fil|--file)
-    case "$#" in 1) usage ;; esac; shift
-    log_given=t$log_given
-    logfile="$1"
-    no_edit=t
-    shift ;;
-  -m=*|--m=*|--me=*|--mes=*|--mess=*|--messa=*|--messag=*|--message=*)
-    log_given=t$log_given
-    log_message=`expr "$1" : '-[^=]*=\(.*\)'`
-    no_edit=t
-    shift ;;
+      all=t
+      shift
+      ;;
+  --au=*|--aut=*|--auth=*|--autho=*|--author=*)
+      force_author=`expr "$1" : '-[^=]*=\(.*\)'`
+      shift
+      ;;
+  --au|--aut|--auth|--autho|--author)
+      case "$#" in 1) usage ;; esac
+      shift
+      force_author="$1"
+      shift
+      ;;
+  -e|--e|--ed|--edi|--edit)
+      no_edit=
+      shift
+      ;;
+  -i|--i|--in|--inc|--incl|--inclu|--includ|--include)
+      also=t
+      shift
+      ;;
   -m|--m|--me|--mes|--mess|--messa|--messag|--message)
-    case "$#" in 1) usage ;; esac; shift
-    log_given=t$log_given
-    log_message="$1"
-    no_edit=t
-    shift ;;
-  -c=*|--ree=*|--reed=*|--reedi=*|--reedit=*|--reedit-=*|--reedit-m=*|\
+      case "$#" in 1) usage ;; esac
+      shift
+      log_given=t$log_given
+      log_message="$1"
+      no_edit=t
+      shift
+      ;;
+  -m*)
+      log_given=t$log_given
+      log_message=`expr "$1" : '-m\(.*\)'`
+      no_edit=t
+      shift
+      ;;
+  --m=*|--me=*|--mes=*|--mess=*|--messa=*|--messag=*|--message=*)
+      log_given=t$log_given
+      log_message=`expr "$1" : '-[^=]*=\(.*\)'`
+      no_edit=t
+      shift
+      ;;
+  -n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|--no-verify)
+      verify=
+      shift
+      ;;
+  -c)
+      case "$#" in 1) usage ;; esac
+      shift
+      log_given=t$log_given
+      use_commit="$1"
+      no_edit=
+      shift
+      ;;
+  --ree=*|--reed=*|--reedi=*|--reedit=*|--reedit-=*|--reedit-m=*|\
   --reedit-me=*|--reedit-mes=*|--reedit-mess=*|--reedit-messa=*|\
   --reedit-messag=*|--reedit-message=*)
-    log_given=t$log_given
-    use_commit=`expr "$1" : '-[^=]*=\(.*\)'`
-    shift ;;
-  -c|--ree|--reed|--reedi|--reedit|--reedit-|--reedit-m|--reedit-me|\
+      log_given=t$log_given
+      use_commit=`expr "$1" : '-[^=]*=\(.*\)'`
+      no_edit=
+      shift
+      ;;
+  --ree|--reed|--reedi|--reedit|--reedit-|--reedit-m|--reedit-me|\
   --reedit-mes|--reedit-mess|--reedit-messa|--reedit-messag|--reedit-message)
-    case "$#" in 1) usage ;; esac; shift
-    log_given=t$log_given
-    use_commit="$1"
-    shift ;;
-  -C=*|--reu=*|--reus=*|--reuse=*|--reuse-=*|--reuse-m=*|--reuse-me=*|\
+      case "$#" in 1) usage ;; esac
+      shift
+      log_given=t$log_given
+      use_commit="$1"
+      no_edit=
+      shift
+      ;;
+  -C)
+      case "$#" in 1) usage ;; esac
+      shift
+      log_given=t$log_given
+      use_commit="$1"
+      no_edit=t
+      shift
+      ;;
+  --reu=*|--reus=*|--reuse=*|--reuse-=*|--reuse-m=*|--reuse-me=*|\
   --reuse-mes=*|--reuse-mess=*|--reuse-messa=*|--reuse-messag=*|\
   --reuse-message=*)
-    log_given=t$log_given
-    use_commit=`expr "$1" : '-[^=]*=\(.*\)'`
-    no_edit=t
-    shift ;;
-  -C|--reu|--reus|--reuse|--reuse-|--reuse-m|--reuse-me|--reuse-mes|\
+      log_given=t$log_given
+      use_commit=`expr "$1" : '-[^=]*=\(.*\)'`
+      no_edit=t
+      shift
+      ;;
+  --reu|--reus|--reuse|--reuse-|--reuse-m|--reuse-me|--reuse-mes|\
   --reuse-mess|--reuse-messa|--reuse-messag|--reuse-message)
-    case "$#" in 1) usage ;; esac; shift
-    log_given=t$log_given
-    use_commit="$1"
-    no_edit=t
-    shift ;;
-  -e|--e|--ed|--edi|--edit)
-    no_edit=
-    shift ;;
+      case "$#" in 1) usage ;; esac
+      shift
+      log_given=t$log_given
+      use_commit="$1"
+      no_edit=t
+      shift
+      ;;
   -s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
-    signoff=t
-    shift ;;
-  -n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|--no-verify)
-    verify=
-    shift ;;
+      signoff=t
+      shift
+      ;;
   -v|--v|--ve|--ver|--veri|--verif|--verify)
-    verify=t
-    shift ;;
+      verify=t
+      shift
+      ;;
   --)
-    shift
-    break ;;
+      shift
+      break
+      ;;
   -*)
-     usage ;;
+      usage
+      ;;
   *)
-    break ;;
+      break
+      ;;
   esac
 done
 
@@ -88,30 +173,92 @@ tt*)
   die "Only one of -c/-C/-F/-m can be used." ;;
 esac
 
-case "$all,$#" in
-t,0)
-	git-diff-files --name-only -z |
-	git-update-index --remove -z --stdin
-	;;
-t,*)
-	die "Cannot use -a and explicit files at the same time."
-	;;
-,0)
+TOP=`git-rev-parse --show-cdup`
+
+case "$all,$also" in
+t,t)
+	die "Cannot use -a and -i at the same time." ;;
+t,)
+	SAVE_INDEX="$GIT_DIR/save-index$$" &&
+	cp "$GIT_DIR/index" "$SAVE_INDEX" &&
+	(
+		if test '' != "$TOP"
+		then
+			cd "$TOP"
+		fi &&
+		git-diff-files --name-only -z |
+		git-update-index --remove -z --stdin
+	)
 	;;
-*)
-	git-diff-files --name-only -z -- "$@" |
+,t)
+	case "$#" in
+	0) die "No paths with -i does not make sense." ;;
+	esac
+	SAVE_INDEX="$GIT_DIR/save-index$$" &&
+	cp "$GIT_DIR/index" "$SAVE_INDEX" &&
+	git-diff-files --name-only -z -- "$@"  |
 	git-update-index --remove -z --stdin
 	;;
-esac || exit 1
+,)
+	case "$#" in
+	0)
+	    ;; # commit as-is
+	*)
+	    if test -f "$GIT_DIR/MERGE_HEAD"
+	    then
+		refuse_partial "Cannot do a partial commit during a merge."
+	    fi
+	    TMP_INDEX="$GIT_DIR/tmp-index$$"
+	    if test -z "$initial_commit"
+	    then
+		# make sure index is clean at the specified paths, or
+		# they are additions.
+		dirty_in_index=`git-diff-index --cached --name-status \
+			--diff-filter=DMTXU HEAD -- "$@"`
+		test -z "$dirty_in_index" ||
+		refuse_partial "Cannot do a partial commit of paths dirty in index:
+
+$dirty_in_index"
+	    fi
+	    commit_only=`git-ls-files -- "$@"` ;;
+	esac
+	;;
+esac
+
 git-update-index -q --refresh || exit 1
 
-case "$verify" in
-t)
-	if test -x "$GIT_DIR"/hooks/pre-commit
+trap '
+	test -f "$TMP_INDEX" && rm -f "$TMP_INDEX"
+	test -f "$SAVE_INDEX" && mv -f "$SAVE_INDEX" "$GIT_DIR/index"
+' 0
+
+if test "$TMP_INDEX"
+then
+	if test -z "$initial_commit"
 	then
-		"$GIT_DIR"/hooks/pre-commit || exit
-	fi
-esac
+		GIT_INDEX_FILE="$TMP_INDEX" git-read-tree HEAD
+	else
+		rm -f "$TMP_INDEX"
+	fi || exit
+	echo "$commit_only" |
+	GIT_INDEX_FILE="$TMP_INDEX" git-update-index --add --remove --stdin &&
+	echo "$commit_only" |
+	git-update-index --remove --stdin ||
+	exit
+else
+	#
+	:
+fi
+
+if test t = "$verify" && test -x "$GIT_DIR"/hooks/pre-commit
+then
+	if test "$TMP_INDEX"
+	then
+		GIT_INDEX_FILE="$TMP_INDEX" "$GIT_DIR"/hooks/pre-commit
+	else
+		"$GIT_DIR"/hooks/pre-commit
+	fi || exit
+fi
 
 if test "$log_message" != ''
 then
@@ -155,42 +302,52 @@ if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
 	echo "#"
 fi >>"$GIT_DIR"/COMMIT_EDITMSG
 
+# Author
+if test '' != "$use_commit"
+then
+	pick_author_script='
+	/^author /{
+		s/'\''/'\''\\'\'\''/g
+		h
+		s/^author \([^<]*\) <[^>]*> .*$/\1/
+		s/'\''/'\''\'\'\''/g
+		s/.*/GIT_AUTHOR_NAME='\''&'\''/p
+
+		g
+		s/^author [^<]* <\([^>]*\)> .*$/\1/
+		s/'\''/'\''\'\'\''/g
+		s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
+
+		g
+		s/^author [^<]* <[^>]*> \(.*\)$/\1/
+		s/'\''/'\''\'\'\''/g
+		s/.*/GIT_AUTHOR_DATE='\''&'\''/p
+
+		q
+	}
+	'
+	set_author_env=`git-cat-file commit "$use_commit" |
+	LANG=C LC_ALL=C sed -ne "$pick_author_script"`
+	eval "$set_author_env"
+	export GIT_AUTHOR_NAME
+	export GIT_AUTHOR_EMAIL
+	export GIT_AUTHOR_DATE
+elif test '' != "$force_author"
+then
+	GIT_AUTHOR_NAME=`expr "$force_author" : '\(.*[^ ]\) *<.*'` &&
+	GIT_AUTHOR_EMAIL=`expr "$force_author" : '.*\(<.*\)'` &&
+	test '' != "$GIT_AUTHOR_NAME" &&
+	test '' != "$GIT_AUTHOR_EMAIL" ||
+	die "malformatted --author parameter"
+	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+fi
+
 PARENTS="-p HEAD"
-if GIT_DIR="$GIT_DIR" git-rev-parse --verify HEAD >/dev/null 2>&1
+if test -z "$initial_commit"
 then
 	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
 		PARENTS="-p HEAD "`sed -e 's/^/-p /' "$GIT_DIR/MERGE_HEAD"`
 	fi
-	if test "$use_commit" != ""
-	then
-		pick_author_script='
-		/^author /{
-			s/'\''/'\''\\'\'\''/g
-			h
-			s/^author \([^<]*\) <[^>]*> .*$/\1/
-			s/'\''/'\''\'\'\''/g
-			s/.*/GIT_AUTHOR_NAME='\''&'\''/p
-
-			g
-			s/^author [^<]* <\([^>]*\)> .*$/\1/
-			s/'\''/'\''\'\'\''/g
-			s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
-
-			g
-			s/^author [^<]* <[^>]*> \(.*\)$/\1/
-			s/'\''/'\''\'\'\''/g
-			s/.*/GIT_AUTHOR_DATE='\''&'\''/p
-
-			q
-		}
-		'
-		set_author_env=`git-cat-file commit "$use_commit" |
-		LANG=C LC_ALL=C sed -ne "$pick_author_script"`
-		eval "$set_author_env"
-		export GIT_AUTHOR_NAME
-		export GIT_AUTHOR_EMAIL
-		export GIT_AUTHOR_DATE
-	fi
 else
 	if [ -z "$(git-ls-files)" ]; then
 		echo Nothing to commit 1>&2
@@ -198,10 +355,21 @@ else
 	fi
 	PARENTS=""
 fi
-git-status >>"$GIT_DIR"/COMMIT_EDITMSG
+
+(
+	if test '' != "$TOP"
+	then
+		cd "$TOP"
+	fi &&
+	git-status >>"$GIT_DIR"/COMMIT_EDITMSG
+)
 if [ "$?" != "0" -a ! -f "$GIT_DIR/MERGE_HEAD" ]
 then
 	rm -f "$GIT_DIR/COMMIT_EDITMSG"
+	if test '' != "$TOP"
+	then
+		cd "$TOP"
+	fi &&
 	git-status
 	exit 1
 fi
@@ -213,7 +381,8 @@ case "$no_edit" in
 		echo >&2 "Please supply the commit log message using either"
 		echo >&2 "-m or -F option.  A boilerplate log message has"
 		echo >&2 "been prepared in $GIT_DIR/COMMIT_EDITMSG"
-		exit 1 ;;
+		exit 1
+		;;
 	esac
 	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG"
 	;;
@@ -235,7 +404,13 @@ if cnt=`grep -v -i '^Signed-off-by' "$GI
 	wc -l` &&
    test 0 -lt $cnt
 then
-	tree=$(git-write-tree) &&
+	if test -z "$TMP_INDEX"
+	then
+		tree=$(git-write-tree)
+	else
+		tree=$(GIT_INDEX_FILE="$TMP_INDEX" git-write-tree) &&
+		rm -f "$TMP_INDEX"
+	fi &&
 	commit=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS) &&
 	git-update-ref HEAD $commit $current &&
 	rm -f -- "$GIT_DIR/MERGE_HEAD"
@@ -250,4 +425,8 @@ if test -x "$GIT_DIR"/hooks/post-commit 
 then
 	"$GIT_DIR"/hooks/post-commit
 fi
+if test 0 -eq "$ret"
+then
+	rm -f "$SAVE_INDEX"
+fi
 exit "$ret"
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 8ff5dd9..c8a85f9 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -95,13 +95,13 @@ test_expect_success 'git branch' 'cmp br
 
 git checkout mybranch
 echo "Work, work, work" >>hello
-git commit -m 'Some work.' hello
+git commit -m 'Some work.' -i hello
 
 git checkout master
 
 echo "Play, play, play" >>hello
 echo "Lots of fun" >>example
-git commit -m 'Some fun.' hello example
+git commit -m 'Some fun.' -i hello example
 
 test_expect_failure 'git resolve now fails' 'git resolve HEAD mybranch "Merge work in mybranch"'
 
@@ -112,7 +112,7 @@ Play, play, play
 Work, work, work
 EOF
 
-git commit -m 'Merged "mybranch" changes.' hello
+git commit -m 'Merged "mybranch" changes.' -i hello
 
 cat > show-branch.expect << EOF
 * [master] Merged "mybranch" changes.
-- 
1.1.6.g9e4e
