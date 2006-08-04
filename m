From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [RFC][PATCH] Branch history
Date: Fri, 04 Aug 2006 13:24:47 -0600
Message-ID: <m1mzakpam8.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Aug 04 21:26:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G95JI-00080W-Sy
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 21:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161381AbWHDTZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 15:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161380AbWHDTZ5
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 15:25:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10467 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161379AbWHDTZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 15:25:56 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k74JOnSr032055;
	Fri, 4 Aug 2006 13:24:49 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k74JOlHh032054;
	Fri, 4 Aug 2006 13:24:48 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: <git@vger.kernel.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24826>


The problem:
git-rebase, stgit and the like destructively edit the commit history
on a branch.  Making it a challenge to go back to a known good point.

revlog and the like sort of help this but they don't address the
issues that they capture irrelevant points and are not git-prune safe.

With current git the best technique I have found is to always make
a new branch before I would call git-rebase.




After thinking about the problem some more I believe I have found
a rather simple solution to the problem of keeping branch history.

For each branch you want to keep the history of keep 2 branches.
A normal working branch, and a second archive branch that records
the history of the branch you are editing.

The history can be kept simply by placing an additional commit on the
top of each branch.  The new commit on top of each branch will point
to the same tree object as the previous top commit on the branch but
it will have 2 parent commit objects.  The first parent commit object
is the previous top commit object of the branch.  The second parent
commit object is the commit object on top of the previous version of
this branch.

The work flow is you edit a branch to your hearts comment then when
you get to an interesting point you commit the branch to your archive
branch so you can keep track of things.

To gitk and friends the archive branch looks like a series of branch
merges where one input branch is always the same as the merge result.
So all of the git tools work normally.

The implementation is trivial.

The neat thing is that it gives an immutable history of a branch that
is actively being edited.  So if you export your archive branch people
will never see time roll backward.



Below is my patch to implement this idea.  Currently I am storing
the archive branch in .git/refs/archive/$branchname.  And calling
the command to commit a branch git-archive-branch.

I think my initial naming is most likely lacking so suggestions
for something better would be appreciated.

Comments?


Eric

diff --git a/Makefile b/Makefile
index 700c77f..411ae95 100644
--- a/Makefile
+++ b/Makefile
@@ -150,7 +150,7 @@ SCRIPT_SH = \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
-	git-lost-found.sh git-quiltimport.sh
+	git-lost-found.sh git-quiltimport.sh git-archive-branch.sh
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
diff --git a/git-archive-branch.sh b/git-archive-branch.sh
new file mode 100755
index 0000000..00638de
--- /dev/null
+++ b/git-archive-branch.sh
@@ -0,0 +1,131 @@
+#!/bin/sh
+
+USAGE='[-m <message> | -F logfile] [-e]'
+
+. git-sh-setup
+
+headref=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
+headsha1=$(git-rev-parse "$headref")
+archiveref="refs/archive/$headref"
+
+
+logfile=
+edit_flag=
+no_edit=
+log_given=
+log_message=
+while case "$#" in 0) break;; esac
+do
+  case "$1" in
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
+      logfile=`expr "z$1" : 'z-[Ff]\(.*\)'`
+      shift
+      ;;
+  --F=*|--f=*|--fi=*|--fil=*|--file=*)
+      no_edit=t
+      log_given=t$log_given
+      logfile=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+      shift
+      ;;
+  -e|--e|--ed|--edi|--edit)
+      edit_flag=t
+      shift
+      ;;
+  -m|--m|--me|--mes|--mess|--messa|--messag|--message)
+      case "$#" in 1) usage ;; esac
+      shift
+      log_given=m$log_given
+      if test "$log_message" = ''
+      then
+          log_message="$1"
+      else
+          log_message="$log_message
+
+$1"
+      fi
+      no_edit=t
+      shift
+      ;;
+  -m*)
+      log_given=m$log_given
+      if test "$log_message" = ''
+      then
+          log_message=`expr "z$1" : 'z-m\(.*\)'`
+      else
+          log_message="$log_message
+
+`expr "z$1" : 'z-m\(.*\)'`"
+      fi
+      no_edit=t
+      shift
+      ;;
+  --m=*|--me=*|--mes=*|--mess=*|--messa=*|--messag=*|--message=*)
+      log_given=m$log_given
+      if test "$log_message" = ''
+      then
+          log_message=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+      else
+          log_message="$log_message
+
+`expr "z$1" : 'zq-[^=]*=\(.*\)'`"
+      fi
+      no_edit=t
+      shift
+      ;;
+  esac
+done
+case "$edit_flag" in t) no_edit= ;; esac
+
+if test "$log_message" != ""
+then
+	echo "$log_message"
+elif test "$logfile" != ""
+then
+	if test "$logfile" = -
+	then
+		test -t 0 &&
+		echo >&2 "(read log message from standard input)"
+		cat
+	else
+		cat <"$logfile"
+	fi
+fi | git-stripspace > "$GIT_DIR"/COMMIT_EDITMSG
+
+case "$no_edit" in
+'')
+	case "${VISUAL:-$EDITOR},$TERM" in
+	,dumb)
+		echo >&2 "Terminal is dumb but no VISUAL nor EDITOR defined."
+		echo >&2 "Please supply the commit log message using either"
+		echo >&2 "-m or -F option.  A boilerplate log message has"
+		echo >&2 "been prepared in $GIT_DIR/COMMIT_EDITMSG"
+		exit 1
+		;;
+	esac
+	git-var GIT_AUTHOR_IDENT > /dev/null || die
+	git-var GIT_COMMITTER_IDENT > /dev/null || die
+	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG"
+	;;
+esac
+
+cat $GIT_DIR/COMMIT_EDITMSG | git-stripspace > "$GIT_DIR"/COMMIT_MSG
+
+parents="-p $headsha1"
+if git-rev-parse --verify $archiveref > /dev/null 2> /dev/null; then
+	parents="$parents -p $(git-rev-parse $archiveref)"
+fi
+
+tree=$(git-cat-file commit $headsha1 | sed -n -e 's/^tree \(.*\)$/\1/p') &&
+commit=$(cat $GIT_DIR/COMMIT_MSG | git-commit-tree $tree $parents) 
+git-update-ref "$archiveref" $commit 
+rm -f "$GIT_DIR/COMMIT_MSG" "$GIT_DIR/COMMIT_EDITMSG"
