From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-grep documentation
Date: Sat, 21 Jan 2006 00:09:07 -0800
Message-ID: <7vvewet330.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP07F7EA1F3B544C07AA01F8AE1F0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 09:09:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0DoH-0005fJ-5i
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 09:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWAUIJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 03:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWAUIJK
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 03:09:10 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:47870 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751094AbWAUIJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 03:09:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121080656.ORJH26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 03:06:56 -0500
To: sean <seanlkml@sympatico.ca>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14988>

sean <seanlkml@sympatico.ca> writes:

> It looks as though git-grep.sh was coded to allow git-ls-files
> options to be passed after a '--' marker...

I'd prefer to keep the options before path parameters if only
for the sanity's sake.  How about this instead?

-- >8 --
[PATCH] git-grep: clarification on parameters.

We forgot to make sure that there is no more than one pattern
parameter.  Also when looking for files in a directory called
'--others', it passed that path limiter without preceding the
end-of-options marker '--' to underlying git-ls-files, which
misunderstood it as one of its options instead.

	$ git grep --others -e Meta/Make Meta
	$ git grep -o -e Meta/Make Meta
	$ git grep -o Meta/Make Meta

look for a string "Meta/Make" from untracked files in Meta/
directory.

	$ git grep Meta/Make --others

looks for the same string from tracked files in ./--others
directory.

On the other hand,

	$ git grep -e Meta/Make --others

does not have a freestanding pattern, so everybody is parameter
and there is no path specifier.  It looks for the string in all
the untracked files without any path limiter.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/git-grep.txt |   25 ++++++++++++++++++++++---
 git-grep.sh                |   27 +++++++++++++++++++--------
 2 files changed, 41 insertions(+), 11 deletions(-)

b11f9315a792d65a0113e10e478e740ce4f8be73
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 2bfd8ed..55d3bed 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -8,7 +8,7 @@ git-grep - print lines matching a patter
 
 SYNOPSIS
 --------
-'git-grep' [<option>...] <pattern> [<path>...]
+'git-grep' [<option>...] [-e] <pattern> [<path>...]
 
 DESCRIPTION
 -----------
@@ -18,13 +18,32 @@ containing a match to the given pattern.
 
 OPTIONS
 -------
+`--`::
+	Signals the end of options; the rest of the parameters
+	are <path> limiters.
+
 <option>...::
 	Either an option to pass to `grep` or `git-ls-files`.
 	Some `grep` options, such as `-C` and `-m`, that take
-	parameters are known to `git-grep`.
+	parameters are known to `git-grep`.  Among options
+	applicable to git-ls-files`, `--others` and
+	`--exclude=*` (and other variants of exclusion) may be
+	of interest.  Only `-o` is recognized as an option to
+	`git-ls-files` in the short form (e.g. `-d` and `-m` are
+	given to `grep`, not to `git-ls-files` as synonym
+	for `--deleted` and `--modifed`), so you need to spell
+	out `git-ls-files` options in longer form
+	e.g. `--deleted`.
 
 <pattern>::
-	The pattern to look for.
+	The pattern to look for.  The first non option is taken
+	as the pattern; if your pattern begins with a dash, use
+	`-e <pattern>`.  When a pattern is found without `-e`, it
+	also terminates the option processing and the rest of
+	the parameters are used as the `<path>...`, and you do
+	not specifically add `--` to protect the path limiter
+	that happens to begin with a dash from being mistaken as
+	an option.
 
 <path>...::
 	Optional paths to limit the set of files to be searched;
diff --git a/git-grep.sh b/git-grep.sh
index 2ed8e95..23b1e03 100755
--- a/git-grep.sh
+++ b/git-grep.sh
@@ -3,22 +3,32 @@
 # Copyright (c) Linus Torvalds, 2005
 #
 
-USAGE='<option>... <pattern> <path>...'
+USAGE='[<option>...] [-e] <pattern> [<path>...]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
+got_pattern () {
+	if [ -z "$no_more_patterns" ]
+	then
+		pattern="$1" no_more_patterns=yes
+	else
+		die "git-grep: do not specify more than one pattern"
+	fi
+}
+
+no_more_patterns=
 pattern=
 flags=()
 git_flags=()
 while : ; do
 	case "$1" in
-	--cached|--deleted|--others|--killed|\
-	--ignored|--exclude=*|\
+	-o|--cached|--deleted|--others|--killed|\
+	--ignored|--modified|--exclude=*|\
 	--exclude-from=*|\--exclude-per-directory=*)
 		git_flags=("${git_flags[@]}" "$1")
 		;;
 	-e)
-		pattern="$2"
+		got_pattern "$2"
 		shift
 		;;
 	-A|-B|-C|-D|-d|-f|-m)
@@ -34,8 +44,9 @@ while : ; do
 		flags=("${flags[@]}" "$1")
 		;;
 	*)
-		if [ -z "$pattern" ]; then
-			pattern="$1"
+		if [ -z "$no_more_patterns" ]
+		then
+			got_pattern "$1"
 			shift
 		fi
 		break
@@ -46,5 +57,5 @@ done
 [ "$pattern" ] || {
 	usage
 }
-git-ls-files -z "${git_flags[@]}" "$@" |
-	xargs -0 grep "${flags[@]}" -e "$pattern"
+git-ls-files -z "${git_flags[@]}" -- "$@" |
+	xargs -0 grep "${flags[@]}" -e "$pattern" --
-- 
1.1.4.g5c4a-dirty
