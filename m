From: Junio C Hamano <junkio@cox.net>
Subject: Re: [WIP] Status update on merge-recursive in C
Date: Sun, 09 Jul 2006 00:34:23 -0700
Message-ID: <7vpsgfnse8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607081840280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<1152421230.2103.31.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 09:34:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzToG-0001In-CS
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 09:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWGIHe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 03:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWGIHe1
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 03:34:27 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:54450 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932375AbWGIHe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 03:34:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060709073424.GAXN554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Jul 2006 03:34:24 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1152421230.2103.31.camel@dv> (Pavel Roskin's message of "Sun, 09
	Jul 2006 01:00:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23528>

Pavel Roskin <proski@gnu.org> writes:

> Why do you list "recur" twice in all_strategies in the git-merge.sh?
> The second "recur" should probably be "recursive".
> ...
> Test for Python in the git-rebase.sh is probably wrong.  "recur" doesn't
> need Python - that's the whole point.  In fact, if I build git with
> NO_PYTHON, TEST fails in t3401-rebase-partial.sh

I noticed them as well but I understand that is why the patch is
marked as WIP.  I do not mind these details much at this point
yet.

I think it may make sense, during the development, to make
git-merge.sh notice an environment GIT_USE_RECUR_FOR_RECURSIVE
and have it automatically use git-merge-recur when the user and
scripts ask for recursive.  A preliminary patch (but it was
tested) is attached.

> I tries to run sparse of the C files, and it complains about two things
> - variable declarations in the middle of the code (allowed by c99 but
> not by ANSI C) and incomplete function declarations (no "void").  It's
> not C++, let's stick to the C standards.

I run, from time to time, with pedantic set of options (that is,

  -O2 -Werror -ansi -pedantic -std=c99 -D_XOPEN_SOURCE=500 -D_BSD_SOURCE

) just for fun, and noticed these problems as well, but left
them as they are, because I think Johannaes/Alex team would want
to update the TODO items first and I felt fixing these up at
this point would give me unnecessary conflicts to resolve.

> I'm attaching a patch that fixes everything except variable
> declarations.  There are so many of them that it could be done once the
> code stabilizes a bit.

Exactly.

-- >8 --
recur vs recursive: help testing without touching too many stuff.

During git-merge-recur development, you could set an environment
variable GIT_USE_RECUR_FOR_RECURSIVE to use WIP recur in place
of the recursive strategy.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/TEST b/TEST
index d530983..7286e2a 100755
--- a/TEST
+++ b/TEST
@@ -1,10 +1,14 @@
 #!/bin/sh -x
+
 cd t || exit
-./t3400-rebase.sh              "$@" && \
-./t6020-merge-df.sh            "$@" && \
-./t3401-rebase-partial.sh      "$@" && \
-./t6021-merge-criss-cross.sh   "$@" && \
-./t3402-rebase-merge.sh        "$@" && \
-./t6022-merge-rename.sh        "$@" && \
-./t6010-merge-base.sh          "$@" && \
+GIT_USE_RECUR_FOR_RECURSIVE=LetsTryIt
+export GIT_USE_RECUR_FOR_RECURSIVE
+
+./t3400-rebase.sh              "$@" &&
+./t6020-merge-df.sh            "$@" &&
+./t3401-rebase-partial.sh      "$@" &&
+./t6021-merge-criss-cross.sh   "$@" &&
+./t3402-rebase-merge.sh        "$@" &&
+./t6022-merge-rename.sh        "$@" &&
+./t6010-merge-base.sh          "$@" &&
 :
diff --git a/git-merge.sh b/git-merge.sh
index b26ca14..9b68115 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -9,8 +9,13 @@ USAGE='[-n] [--no-commit] [--squash] [-s
 LF='
 '
 
-all_strategies='recur recur octopus resolve stupid ours'
-default_twohead_strategies='recur'
+all_strategies='recursive recur octopus resolve stupid ours'
+case "${GIT_USE_RECUR_FOR_RECURSIVE}" in
+'')
+	default_twohead_strategies=recursive ;;
+?*)
+	default_twohead_strategies=recur ;;
+esac
 default_octopus_strategies='octopus'
 no_trivial_merge_strategies='ours'
 use_strategies=
@@ -110,6 +115,10 @@ do
 			strategy="$2"
 			shift ;;
 		esac
+		case "$strategy,${GIT_USE_RECUR_FOR_RECURSIVE}" in
+		recursive,?*)
+			strategy=recur ;;
+		esac
 		case " $all_strategies " in
 		*" $strategy "*)
 			use_strategies="$use_strategies$strategy " ;;
diff --git a/git-rebase.sh b/git-rebase.sh
index 2a4c8c8..8c5da72 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -35,7 +35,13 @@ If you would prefer to skip this patch, 
 To restore the original branch and stop rebasing run \"git rebase --abort\".
 "
 unset newbase
-strategy=recur
+case "${GIT_USE_RECUR_FOR_RECURSIVE}" in
+'')
+	strategy=recursive ;;
+?*)
+	strategy=recur ;;
+esac
+
 do_merge=
 dotest=$GIT_DIR/.dotest-merge
 prec=4
@@ -198,6 +204,11 @@ do
 	shift
 done
 
+case "$strategy,${GIT_USE_RECUR_FOR_RECURSIVE}" in
+recursive,?*)
+	strategy=recur ;;
+esac
+
 # Make sure we do not have .dotest
 if test -z "$do_merge"
 then
@@ -292,7 +303,7 @@ then
 	exit $?
 fi
 
-if test "@@NO_PYTHON@@" && test "$strategy" = "recur"
+if test "@@NO_PYTHON@@" && test "$strategy" = "recursive"
 then
 	die 'The recursive merge strategy currently relies on Python,
 which this installation of git was not configured with.  Please consider
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index b70e177..d34c6cf 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -51,7 +51,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'reference merge' '
-	git merge -s recur "reference merge" HEAD master
+	git merge -s recursive "reference merge" HEAD master
 '
 
 test_expect_success rebase '
