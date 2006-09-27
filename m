From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-split: Split the history of a git repository by subdirectories and ranges
Date: Wed, 27 Sep 2006 12:31:22 -0700
Message-ID: <7v1wpxayyd.fsf@assigned-by-dhcp.cox.net>
References: <451A30E4.50801@freedesktop.org>
	<7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
	<451A6788.5030808@shadowen.org>
	<7vr6xxb00m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 21:31:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSf7u-0003oe-PH
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 21:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030664AbWI0TbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 15:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030673AbWI0TbY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 15:31:24 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54240 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030664AbWI0TbX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 15:31:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927193123.FAMY18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Sep 2006 15:31:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TXXQ1V00m1kojtg0000000
	Wed, 27 Sep 2006 15:31:25 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <7vr6xxb00m.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 27 Sep 2006 12:08:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27923>

Junio C Hamano <junkio@cox.net> writes:

> However, you can do:
>
> $ git rev-list --parents --pretty=raw
>
> which would give you "commit $this_commit $its $parents" lines
> and "parent $true_parent" lines at the same time.
>
> And they will be inconsistent when you have grafts or path
> limiter.  The former honor grafts and path limiter, and the
> latter show the true set of parents.

-- >8 --
An illustration of rev-list --parents --pretty=raw

This script creates two separate histories, A and B, each of
which does:

      (A0, B0): create fileA and subdir/fileB
      (A1, B1): modify fileA
      (A2, B2): modify subdir/fileB

and then grafts them together to make B0 a child of A2.  So
the final history looks like (time flows from top to bottom):

		true parent	touches subdir?

	A0	none		yes (creates it)
        A1      A0		no
        A2	A1		yes
        B0	none		yes (different from what's in A2)
        B1	B0		no
        B2	B1		yes

"git rev-list --parents --pretty=raw B2" would give "fake"
parents on the "commit " header lines while "parent " header
lines show the parent as recorded in the commit object (i.e. B0
appears to have A2 as its parent on "commit " header but there
is no "parent A2" header line in it).

When you have path limiters, we simplify history to omit
commits that do not affect the specified paths.  

So "git rev-list --parents --pretty=raw B2 subdir" would return
"B2 B0 A2 A0" (because B1 and A1 do not touch the path).  When
it does so, the "commit " header lines have "fake" parents
(i.e. B2 appears to have B0 as its parent on "commit " header),
but you can still get the true parents by looking at "parent "
header.

---
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
new file mode 100755
index 0000000..08a6cff
--- /dev/null
+++ b/t/t6001-rev-list-graft.sh
@@ -0,0 +1,113 @@
+#!/bin/sh
+
+test_description='Revision traversal vs grafts and path limiter'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir subdir &&
+	echo >fileA fileA &&
+	echo >subdir/fileB fileB &&
+	git add fileA subdir/fileB &&
+	git commit -a -m "Initial in one history." &&
+	A0=`git rev-parse --verify HEAD` &&
+
+	echo >fileA fileA modified &&
+	git commit -a -m "Second in one history." &&
+	A1=`git rev-parse --verify HEAD` &&
+
+	echo >subdir/fileB fileB modified &&
+	git commit -a -m "Third in one history." &&
+	A2=`git rev-parse --verify HEAD` &&
+
+	rm -f .git/refs/heads/master .git/index &&
+	
+	echo >fileA fileA again &&
+	echo >subdir/fileB fileB again &&
+	git add fileA subdir/fileB &&
+	git commit -a -m "Initial in alternate history." &&
+	B0=`git rev-parse --verify HEAD` &&
+
+	echo >fileA fileA modified in alternate history &&
+	git commit -a -m "Second in alternate history." &&
+	B1=`git rev-parse --verify HEAD` &&
+
+	echo >subdir/fileB fileB modified in alternate history &&
+	git commit -a -m "Third in alternate history." &&
+	B2=`git rev-parse --verify HEAD` &&
+	: done
+'
+
+check () {
+	type=$1
+	shift
+
+	arg=
+	which=arg
+	rm -f test.expect
+	for a
+	do
+		if test "z$a" = z--
+		then
+			which=expect
+			child=
+			continue
+		fi
+		if test "$which" = arg
+		then
+			arg="$arg$a "
+			continue
+		fi
+		if test "$type" = basic
+		then
+			echo "$a"
+		else
+			if test "z$child" != z
+			then
+				echo "$child $a"
+			fi
+			child="$a"
+		fi
+	done >test.expect
+	if test "$type" != basic && test "z$child" != z
+	then
+		echo >>test.expect $child
+	fi
+	if test $type = basic
+	then
+		git rev-list $arg >test.actual
+	elif test $type = parents
+	then
+		git rev-list --parents $arg >test.actual
+	elif test $type = parents-raw
+	then
+		git rev-list --parents --pretty=raw $arg |
+		sed -n -e 's/^commit //p' >test.actual
+	fi
+	diff test.expect test.actual
+}
+
+for type in basic parents parents-raw
+do
+	test_expect_success 'without grafts' "
+		rm -f .git/info/grafts
+		check $type $B2 -- $B2 $B1 $B0
+	"
+
+	test_expect_success 'with grafts' "
+		echo '$B0 $A2' >.git/info/grafts
+		check $type $B2 -- $B2 $B1 $B0 $A2 $A1 $A0
+	"
+
+	test_expect_success 'without grafts, with pathlimit' "
+		rm -f .git/info/grafts
+		check $type $B2 subdir -- $B2 $B0
+	"
+
+	test_expect_success 'with grafts, with pathlimit' "
+		echo '$B0 $A2' >.git/info/grafts
+		check $type $B2 subdir -- $B2 $B0 $A2 $A0
+	"
+
+done
+test_done
