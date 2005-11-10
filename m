From: Junio C Hamano <junkio@cox.net>
Subject: merge-one-file: use common as base, instead of emptiness.
Date: Wed, 09 Nov 2005 20:41:10 -0800
Message-ID: <7v64r16ro9.fsf_-_@assigned-by-dhcp.cox.net>
References: <E1EZKOB-0002j5-VY@jdl.com>
	<7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
	<20051108095600.GA1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 05:42:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea4FR-0000e0-Fi
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 05:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbVKJElN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 23:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbVKJElN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 23:41:13 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31180 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751473AbVKJElM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 23:41:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110044025.OUQD29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 23:40:25 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051108095600.GA1431@pasky.or.cz> (Petr Baudis's message of
	"Tue, 8 Nov 2005 10:56:00 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11462>

Petr Baudis <pasky@suse.cz> writes:

> I think having
>
> 	<<<<<
> 	file1
> 	=====
> 	file2
> 	>>>>>
>
> is an awful PITA to resolve, especially when the files actually are
> similar. Running some vimdiff (or just diff and possibly applying either
> way) on two separate files is much more convenient.

You are right.

How about something like this?  This adds a specialized hackery
flag, --no-add, to git-apply, and uses it to compute common base
to be used for 2-file merge, instead of using /dev/null.

On top of the previous round.

 -- >8 -- cut here -- >8 --
Unlike the previous round that merged the path added differently
in each branches using emptiness as the base, compute a common
version and use it as input to 'merge' program.

This would show the resulting (still conflicting) file left in
the working tree as:

	common file contents...
	<<<<<< FILENAME
	version from our branch...
	======
	version from their branch...
	>>>>>> .merge_file_XXXXXX
	more common file contents...

when both sides added similar contents.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 apply.c               |   11 +++++++++--
 git-merge-one-file.sh |    6 ++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

applies-to: 75c7cdf0addfcb4df5ed093f9b57bb98432489e1
f158ab58fd3846a784805849bd9228bf060e4b2d
diff --git a/apply.c b/apply.c
index 3e53b34..7584888 100644
--- a/apply.c
+++ b/apply.c
@@ -23,6 +23,7 @@ static int numstat = 0;
 static int summary = 0;
 static int check = 0;
 static int apply = 1;
+static int no_add = 0;
 static int show_index_info = 0;
 static int line_termination = '\n';
 static const char apply_usage[] =
@@ -1099,8 +1100,10 @@ static int apply_one_fragment(struct buf
 				break;
 		/* Fall-through for ' ' */
 		case '+':
-			memcpy(new + newsize, patch + 1, plen);
-			newsize += plen;
+			if (*patch != '+' || !no_add) {
+				memcpy(new + newsize, patch + 1, plen);
+				newsize += plen;
+			}
 			break;
 		case '@': case '\\':
 			/* Ignore it, we already handled it */
@@ -1697,6 +1700,10 @@ int main(int argc, char **argv)
 			excludes = x;
 			continue;
 		}
+		if (!strcmp(arg, "--no-add")) {
+			no_add = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--stat")) {
 			apply = 0;
 			diffstat = 1;
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 32e17cb..d9ee458 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -57,18 +57,20 @@ case "${1:-.}${2:-.}${3:-.}" in
 # Modified in both, but differently.
 #
 "$1$2$3" | ".$2$3")
+	src2=`git-unpack-file $3`
 	case "$1" in
 	'')
 		echo "Added $4 in both, but differently."
+		# This extracts OUR file in $orig, and uses git-apply to
+		# remove lines that are unique to ours.
 		orig=`git-unpack-file $2`
-		: >$orig
+		diff -u -La/$orig -Lb/$orig $orig $src2 | git-apply --no-add 
 		;;
 	*)
 		echo "Auto-merging $4."
 		orig=`git-unpack-file $1`
 		;;
 	esac
-	src2=`git-unpack-file $3`
 
 	# We reset the index to the first branch, making
 	# git-diff-file useful
---
0.99.9.GIT
