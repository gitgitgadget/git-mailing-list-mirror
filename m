From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] guilt(1): simplifications...
Date: Thu, 14 Jun 2007 14:50:58 +0200
Message-ID: <11818254621458-git-send-email-madcoder@debian.org>
References: <11818254621527-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 14:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyonR-0003Jt-Un
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 14:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbXFNMvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 08:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXFNMvH
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 08:51:07 -0400
Received: from pan.madism.org ([88.191.52.104]:60889 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbXFNMvE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 08:51:04 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3790CD991;
	Thu, 14 Jun 2007 14:51:03 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 709259294F; Thu, 14 Jun 2007 14:51:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818254621527-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50191>

  + using awk to avoid local variables
  + more clever with sed
  + reimplement munge_hash_range with case

  and some whitespace problems.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 guilt |  132 ++++++++++++++++++++++++++++-------------------------------------
 1 files changed, 57 insertions(+), 75 deletions(-)

diff --git a/guilt b/guilt
index 80f3faf..44273f3 100755
--- a/guilt
+++ b/guilt
@@ -44,14 +44,7 @@ silent()
 
 guilt_commands()
 {
-	local command
-	for command in $0-*
-	do
-		if [ -f "$command" -a -x "$command" ]
-		then
-			echo ${command##$0-}
-		fi
-	done
+	find "`dirname $0`" -maxdepth 1 -name "guilt-*" -type f -perm /111 | sed -e "s/.*\\/`basename $0`-//"
 }
 
 if [ "`basename $0`" = "guilt" ]; then
@@ -97,9 +90,7 @@ if [ "`basename $0`" = "guilt" ]; then
 	echo "Guilt v$GUILT_VERSION"
 	echo ""
 	echo "Pick a command:"
-	for x in `dirname $0`/guilt-*; do
-		[ -x $x ] && echo -e ${x##$0-}
-	done | sort | column | column -t | sed -e $'s/^/\t/'
+	guilt_commands | sort | column | column -t | sed -e 's/^/\t/'
 
 	echo ""
 	echo "Example:"
@@ -173,34 +164,29 @@ get_series()
 	#	- whitespace only
 	#	- optional whitespace followed by '#' followed by more
 	#	  optional whitespace
-	grep -ve '^[[:space:]]*\(#.*\)*$' < "$series"
+	grep -ve '^[[:space:]]*\(#.*\)*$' "$series"
 }
 
 # usage: do_make_header <hash>
 do_make_header()
 {
-	# which revision do we want to work with?
-	local rev="$1"
-
 	# we should try to work with commit objects only
-	if [ `git-cat-file -t "$rev"` != "commit" ]; then
-		echo "Hash $rev is not a commit object" >&2
+	if [ `git-cat-file -t "$1"` != "commit" ]; then
+		echo "Hash $1 is not a commit object" >&2
 		echo "Aborting..." >&2
 		exit 2
 	fi
 
-	# get the author line from the commit object
-	local author=`git-cat-file -p "$rev" | grep -e '^author ' | head -1`
-
-	# strip the timestamp & '^author ' string
-	author=`echo "$author" | sed -e 's/^author //' -e 's/ [0-9]* [+-]*[0-9][0-9]*$//'`
-
-	git-cat-file -p "$rev" | awk "
-BEGIN{ok=0}
-(ok==1){print \$0; print \"\nFrom: $author\"; ok=2; next}
-(ok==2){print \$0}
-/^\$/ && (ok==0){ok=1}
-"
+	git-cat-file -p "$1" | sed -e \
+		'1,/^$/ {
+			/^author/ {
+				s/^author /From: /
+				s/ [0-9]* [+-]*[0-9][0-9]*$//
+				p
+			}
+			/^$/p
+			d
+		}'
 }
 
 # usage: do_get_header patchfile
@@ -260,17 +246,12 @@ head_check()
 # usage: series_insert_patch <patchname>
 series_insert_patch()
 {
-	local top=`get_top | sed -e 's,/,\\\\/,g'`
-	local new=`echo "$1" | sed -e 's,/,\\\\/,g'` 
-
-	if [ ! -z "$top" ]; then
-		sed -i -e "s/^$top\$/$top\n$new/" "$series"
-	else
-		# don't use $new here as it would only complicate things
-		echo "$1" > "$series.tmp"
-		cat "$series" >> "$series.tmp"
-		mv "$series.tmp" "$series"
-	fi
+	awk -v top="`get_top`" -v new="$1" '{
+			if (top == "" && NR == 1) print new;
+			print $0;
+			if (top != "" && top == $0) print new;
+		}' "$series" > "$series.tmp"
+	mv "$series.tmp" "$series"
 }
 
 # usage: series_remove_patch <patchname>
@@ -283,10 +264,11 @@ series_remove_patch()
 # usage: series_rename_patch <oldname> <newname>
 series_rename_patch()
 {
-	local old=`echo "$1" | sed -e 's,/,\\\\/,g'`
-	local new=`echo "$2" | sed -e 's,/,\\\\/,g'` 
+	awk -v old="$1" -v new="$2" \
+		'{ if ($0 == old) print new; else print $0 }' \
+		"$series.tmp" > "$series"
 
-	sed -i -e "s/^$old\$/$new/" "$series"
+	mv "$series.tmp" "$series"
 }
 
 # Beware! This is one of the few (only?) places where we modify the applied
@@ -295,10 +277,15 @@ series_rename_patch()
 # usage: applied_rename_patch <oldname> <newname>
 applied_rename_patch()
 {
-	local old=`echo "$1" | sed -e 's,/,\\\\/,g'`
-	local new=`echo "$2" | sed -e 's,/,\\\\/,g'` 
+	awk -v old="$1" -v new="$2" \
+			'BEGIN{FS=":"}
+			{ if ($1 ~ /^[0-9a-f]*$/ && length($1) == 40 && substr($0, 42) == old)
+				print substr($0, 0, 41) new;
+			else
+				print;
+			}' "$applied" > "$applied.new"
 
-	sed -i -e "s/^\\([0-9a-f]\\{40\\}\\):$old\$/\\1:$new/" "$applied"
+	mv "$applied.tmp" "$applied"
 }
 
 # usage: pop_many_patches <commitish> <number of patches>
@@ -307,11 +294,11 @@ pop_many_patches()
 	assert_head_check
 
 	(
-	cd "$TOP_DIR"
+		cd "$TOP_DIR"
 
-	git-reset --hard "$1" > /dev/null
-	head -n "-$2" < "$applied" > "$applied.tmp"
-	mv "$applied.tmp" "$applied"
+		git-reset --hard "$1" > /dev/null
+		head -n "-$2" < "$applied" > "$applied.tmp"
+		mv "$applied.tmp" "$applied"
 	)
 
 	# update references to top, bottom, and base
@@ -490,7 +477,7 @@ __refresh_patch()
 
 	(
 		cd "$TOP_DIR"
-			p="$GUILT_DIR/$branch/$1"
+		p="$GUILT_DIR/$branch/$1"
 
 		git-diff-files --name-only | (while read n; do git-update-index "$n" ; done)
 
@@ -524,30 +511,25 @@ __refresh_patch()
 # The output of this function is suitable to be passed to git-rev-list
 munge_hash_range()
 {
-	[ -z "$1" ] && return 1
-
-	local l=`echo "$1" | sed -e 's/\.\./ /'`
-
-	local h1=`echo "$l" | cut -s -d' ' -f 1`
-	local h2=`echo "$l" | cut -s -d' ' -f 2`
-
-	if [ -z "$h1" -a -z "$h2" ]; then
-		# e.g., "v0.19"
-		echo "$l^..$l"
-	elif [ -z "$h1" ]; then
-		# e.g., "..v0.10"
-		echo "$h2"
-	elif [ -z "$h2" ]; then
-		# e.g., "v0.19.."
-		echo "$h1..HEAD"
-	elif [ ! -z "$h1" -a ! -z "$h2" ]; then
-		# e.g., "v0.19-rc1..v0.19"
-		echo "$h1..$h2"
-	else
-		# unknown hash range format
-		return 1
-	fi
-
+	case "$1" in
+		*..*..*|*\ *)
+			# double .. or space is illegal
+			return 1;;
+		..*)
+			# e.g., "..v0.10"
+			echo ${1#..};;
+		*..)
+			# e.g., "v0.19.."
+			echo ${1%..}..HEAD;;
+		*..*)
+			# e.g., "v0.19-rc1..v0.19"
+			echo ${1%%..*}..${1#*..};;
+		?*)
+			# e.g., "v0.19"
+			echo $1^..$1;;
+		*)  # empty
+			return 1;;
+	esac
 	return 0
 }
 
-- 
1.5.2.1
