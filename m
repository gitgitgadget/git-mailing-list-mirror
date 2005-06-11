From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH] Rewrite cg-diff colorization, add diffstat and reverse
Date: Sat, 11 Jun 2005 16:29:32 +0200
Message-ID: <42AAF54C.3010908@gmail.com>
References: <42A8280A.3070607@gmail.com> <42A826D7.1060507@gmail.com> <20050611000255.GI22111@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010601070506070307000701"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 16:25:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh6vf-0004c3-Me
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 16:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVFKOaA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 10:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVFKOaA
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 10:30:00 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:40017 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261713AbVFKO3i (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2005 10:29:38 -0400
Received: by wproxy.gmail.com with SMTP id 68so1015695wra
        for <git@vger.kernel.org>; Sat, 11 Jun 2005 07:29:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=e9m30FFrCRxceKmSCbmD7WIv+JymayNPfW5iVoB/HPKHAhWmG1/xYWMMb16+wjwClWlDXPYaKwFtp+sS+NjKvRqDgj5h4eoTwElNcolbJ1XO4pVharETBUZPoPurPDmUS66OQsQNObUxrAIb26rCQZwL4hTybpS/beLlojqARuE=
Received: by 10.54.46.2 with SMTP id t2mr1690829wrt;
        Sat, 11 Jun 2005 07:29:38 -0700 (PDT)
Received: from ?192.168.0.124? ([81.224.201.139])
        by mx.gmail.com with ESMTP id 12sm733012wrl.2005.06.11.07.29.35;
        Sat, 11 Jun 2005 07:29:38 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050611000255.GI22111@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------010601070506070307000701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Petr Baudis wrote:
> Dear diary, on Thu, Jun 09, 2005 at 01:24:07PM CEST, I got a letter
> where Dan Holmsand <holmsand@gmail.com> told me that...
> 
> I'm sorry, but those two patches are still way too big and therefore
> basically unreviewable. Could you please split them further to a
> per-feature patches?
> 
> A good place to start would be changing the [PATCH 2/6] color refactor
> to actually _replace_ the color stuff of cg-log and cg-diff with the new
> common cg-Xlib code - but please don't change the default colors in that
> patch yet (that is because you shouldn't assume in your earlier patches
> that later patches will be applied, or applied in the form you send
> them; I don't know about the less search thing yet, since I didn't test
> it, since I don't have a focused patch for it).,

Ok, here's another one to start with.

cg-diff only, this time around. It's much simpler, since cg-diff got a 
lot more similar to your stuff due to your excellent optparse-ification.

If this is still too big, I'm not really sure how to go about this.

And I'm gonna get into even more trouble with cg-log. My code is 
essentially a rewrite, in order to reduce the incredible amount of 
forking going on in the current code.

But let's take it one step at a time...

/dan

---

[PATCH] Rewrite cg-diff colorization, add diffstat and reverse

This collects all of the colorization logic into the setup_colors
method, in preparation for codesharing with cg-log. In the process, we 
go from awk to sed.

This also cleans up option handling, in order to provide better error 
checking and error messages. And skip the rather unncessary xargs usage.

diffstat and "reverse diff" output options are added. diffstat output 
requires a small fix of "pager" in cg-Xlib, in order not to lose leading 
whitespace when color isn't used.

Signed-off-by: Dan Holmsand <holmsand@gmail.com>

---

--------------010601070506070307000701
Content-Type: text/plain;
 name="diff.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.patch.txt"

 cg-Xlib |    2 -
 cg-diff |  166 ++++++++++++++++++++++++++++++---------------------------------
 2 files changed, 79 insertions(+), 89 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -24,7 +24,7 @@ usage() {
 pager () {
 	local line
 	# Invoke pager only if there's any actual output
-	if read -r line; then
+	if IFS='' read -r line; then
 		( echo "$line"; cat; ) | LESS="R$LESS" ${PAGER:-less} $PAGER_FLAGS
 	fi
 }
diff --git a/cg-diff b/cg-diff
--- a/cg-diff
+++ b/cg-diff
@@ -13,6 +13,9 @@
 # -c::
 #	Colorize the diff output
 #
+# -d, --diffstat::
+#	Show `diffstat' output before diff.
+#
 # -p::
 #	Instead of one ID denotes a parent commit to the specified ID
 #	(which must not be a tree, obviously).
@@ -26,7 +29,10 @@
 #
 # -m::
 #	Base the diff at the merge base of the -r arguments (defaulting
-#	to master and origin).
+#	to HEAD and origin).
+#
+# -R::
+#	Output diff in reverse.
 #
 # ENVIRONMENT VARIABLES
 # ---------------------
@@ -37,132 +43,116 @@
 #	Flags to pass to the pager. By default `R` is added to the `LESS`
 #	environment variable to allow displaying of colorized output.
 
-USAGE="cg-diff [-c] [-m] [-p] [-r FROM_ID[:TO_ID]] [FILE]..."
+USAGE="cg-diff [-c] [-d] [-m] [-p] [-R] [-r FROM_ID[:TO_ID]] [FILE]..."
 
 . ${COGITO_LIB}cg-Xlib
 
 
-id1=" "
-id2=" "
-parent=
-opt_color=
-mergebase=
+unset id1 id2 parent opt_color mergebase diffprog sedprog diffstat difftmp
+dtargs=()
 
 # TODO: Make cg-log use this too.
 setup_colors()
 {
-	local C="diffhdr=1;36:diffhdradd=1;32:diffadd=32:diffhdrmod=1;35:diffmod=35:diffhdrrem=1;31:diffrem=31:diffhunk=36:diffctx=34:diffcctx=33:default=0"
+	local C="diffhdr=1;36:diffhdradd=1;32:diffadd=32:diffhdrmod=1;35"
+	C="$C:diffmod=35:diffhdrrem=1;31:diffrem=31:diffhunk=36:diffctx=34"
+	C="$C:files=34:default=0"
 	[ -n "$COGITO_COLORS" ] && C="$C:$COGITO_COLORS"
 
 	C=${C//=/=\'$'\e'[}
 	C=col${C//:/m\'; col}m\'
-	#coldefault=$(tput op)
 	eval $C
+
+	color_rules="
+s,^+++.*,$coldiffhdradd&$coldefault,
+s,^new file mode.*,$coldiffhdradd&$coldefault,
+s,^---.*,$coldiffhdrrem&$coldefault,
+s,^deleted file mode.*,$coldiffhdrrem&$coldefault,
+s,^[+].*,$coldiffadd&$coldefault,
+s,^[-].*,$coldiffrem&$coldefault,
+s,^\\(@@.*@@\\)\\(.*\\),$coldiffhunk\\1$coldiffctx\\2$coldefault,
+s,^\\(diff\\) .*,$coldiffhdr&$coldefault,"
+}
+
+show_diffstat() {
+	[ -s "$difftmp" ] || return
+	git-apply --stat "$difftmp"
+	echo
+	cat "$difftmp"
 }
 
 while optparse; do
 	if optparse -c; then
 		opt_color=1
-		setup_colors
 	elif optparse -p; then
+		[ "$mergebase" ] && optconflict
 		parent=1
 	elif optparse -r=; then
-		if echo "$OPTARG" | grep -q ':'; then
-			id2=$(echo "$OPTARG" | cut -d : -f 2)
-			[ "$id2" ] || log_end="HEAD"
-			id1=$(echo "$OPTARG" | cut -d : -f 1)
-		elif [ "$id1" = " " ]; then
-			id1="$OPTARG"
+		if [ ! "${id1+set}" ]; then
+			id1=$OPTARG
+			if [[ "$id1" == *:* ]]; then
+				id2=${id1#*:}
+				id1=${id1%:*}
+			fi
 		else
-			id2="$OPTARG"
+			[ "${id2+set}" ] && die "too many revisions"
+			id2=$OPTARG
 		fi
 	elif optparse -m; then
+		[ "$parent" ] && optconflict
 		mergebase=1
+	elif optparse -d || optparse --diffstat; then
+		diffstat=1
+	elif optparse -R; then
+		dtargs[${#dtargs[@]}]="-R"
 	else
 		optfail
 	fi
 done
 
-colorize() {
-	if [ "$opt_color" ]; then
-		gawk '
-		{ if (/^(Index:|diff --git) /)
-		    print "'$coldiffhdr'" $0 "'$coldefault'"
-		  else if (/^======*$/)
-		    print "'$coldiffhdr'" $0 "'$coldefault'"
-		  else if (/^\+\+\+/)
-		    print "'$coldiffhdradd'" $0 "'$coldefault'"
-		  else if (/^\*\*\*/)
-		    print "'$coldiffhdrmod'" $0 "'$coldefault'"
-		  else if (/^---/)
-		    print "'$coldiffhdrrem'" $0 "'$coldefault'"
-		  else if (/^(\+|new( file)? mode )/)
-		    print "'$coldiffadd'" $0 "'$coldefault'"
-		  else if (/^(-|(deleted file|old) mode )/)
-		    print "'$coldiffrem'" $0 "'$coldefault'"
-		  else if (/^!/)
-		    print "'$coldiffmod'" $0 "'$coldefault'"
-		  else if (/^@@ \-[0-9]+(,[0-9]+)? \+[0-9]+(,[0-9]+)? @@/)
-		    print gensub(/^(@@[^@]*@@)([ \t]*)(.*)/,
-		         "'$coldiffhunk'" "\\1" "'$coldefault'" \
-			 "\\2" \
-			 "'$coldiffctx'" "\\3" "'$coldefault'", "")
-		  else if (/^\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/)
-		    print "'$coldiffcctx'" $0 "'$coldefault'"
-		  else
-		    print
-		}'
-	else
-		cat
-	fi
-}
-
 if [ "$parent" ]; then
+	[ "${id2+set}" ] && die "too many revisions"
 	id2="$id1"
-	id="$id2"; [ "$id" = " " ] && id=""
-	id1=$(parent-id "$id" | head -n 1) || exit 1
+	id1=$(parent-id "$id2" | head -n 1) || exit 1
+elif [ "$mergebase" ]; then
+	id1="$(commit-id "${id1:-HEAD}")" || exit 1
+	id2="$(commit-id "${id2:-origin}")" || exit 1
+	id1="$(git-merge-base "$id1" "$id2")" || exit 1
+else
+	id1=$(tree-id "$id1") || exit 1
 fi
 
-if [ "$mergebase" ]; then
-	[ "$id1" != " " ] || id1="master"
-	[ "$id2" != " " ] || id2="origin"
-	id1=$(git-merge-base $(commit-id "$id1") $(commit-id "$id2"))
-fi
-
-
-filter=$(mktemp -t gitdiff.XXXXXX)
-for file in "${ARGS[@]}"; do
-	echo "$file" >>$filter
-done
-
-if [ "$id2" = " " ]; then
-	if [ "$id1" != " " ]; then
-		tree=$(tree-id "$id1") || exit 1
-	else
-		tree=$(tree-id) || exit 1
-	fi
+diffprog=git-diff-tree
 
+if [ ! "${id2+set}" ]; then
 	# Ensure to only diff modified files
 	git-update-cache --refresh >/dev/null
-
-	# FIXME: Update ret based on what did we match. And take "$@"
-	# to account after all.
-	ret=
-	cat $filter | xargs git-diff-cache -r -p $tree | colorize | pager
-
-	rm $filter
-
-	[ "$ret" ] && die "no files matched"
-	exit $ret
+	diffprog=git-diff-cache
+else
+	id2=$(tree-id "$id2") || exit 1
 fi
 
-
-id1=$(tree-id "$id1") || exit 1
-id2=$(tree-id "$id2") || exit 1
-
 [ "$id1" = "$id2" ] && die "trying to diff $id1 against itself"
+diffopts=(-r -p "${dtargs[@]}" $id1 $id2 "${ARGS[@]}")
 
-cat $filter | xargs git-diff-tree -r -p $id1 $id2 | colorize | pager
+if [ "$diffstat" ]; then
+	difftmp=$(mktemp -t cgdiff.XXXXXX) || exit 1
+	trap "rm '$difftmp'" SIGTERM EXIT
+	$diffprog "${diffopts[@]}" > $difftmp
 
-rm $filter
-exit 0
+	diffprog=show_diffstat
+	diffopts=
+fi
+
+if [ "$opt_color" ]; then
+	setup_colors
+	sedprog="$color_rules"
+
+	[ "$diffstat" ] && sedprog="$sedprog
+s,^\\( [^ ].*\\)\\( |  *[0-9][0-9]* \\),$colfiles\\1$coldefault\\2,"
+
+	$diffprog "${diffopts[@]}" | sed -e "$sedprog" | pager
+	exit $PIPESTATUS
+else
+	$diffprog "${diffopts[@]}" | pager
+fi

--------------010601070506070307000701--
