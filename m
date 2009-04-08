From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 14/14] difftool/mergetool: refactor commands to use
 git-mergetool--lib
Date: Tue, 07 Apr 2009 23:09:36 -0700
Message-ID: <7vtz4zr80v.fsf@gitster.siamese.dyndns.org>
References: <1239145213-76701-1-git-send-email-davvid@gmail.com>
 <200904080733.01030.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, charles@hashpling.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Wed Apr 08 08:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrR0R-0007wJ-5g
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 08:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761518AbZDHGJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 02:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760572AbZDHGJs
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 02:09:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760140AbZDHGJr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 02:09:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 50018BE80;
	Wed,  8 Apr 2009 02:09:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BABBDBE7A; Wed, 
 8 Apr 2009 02:09:38 -0400 (EDT)
In-Reply-To: <200904080733.01030.markus.heidelberg@web.de> (Markus
 Heidelberg's message of "Wed, 8 Apr 2009 07:33:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB769F5C-2403-11DE-9C0F-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116041>

Markus Heidelberg <markus.heidelberg@web.de> writes:

>> +	fi
>> +	if echo "${VISUAL:-$EDITOR}" | grep emacs > /dev/null 2>&1; then
>> +		# $EDITOR is emacs so add emerge as a candidate
>> +		tools="$tools emerge vimdiff"
>> +	elif echo "${VISUAL:-$EDITOR}" | grep vim > /dev/null 2>&1; then
>> +		# $EDITOR is vim so add vimdiff as a candidate
>> +		tools="$tools vimdiff emerge"
>> +	else
>> +		tools="$tools emerge vimdiff"
>> +	fi
>> +	tools="$(echo "$tools" | sed -e 's/ +/ /g')"
>
> Doesn't work for me. For me 's/ \+/ /g' works.
> ...like this: 's/[ 	]\+/ /g' (space and tab)

Pleae don't.  "s/  */ /g' should be the most portable (the point being "do
not use one-or-more +").

> Looks good to me, after these last 2 issues are adjusted.
> Maybe resend the whole series then, so that Junio can apply them easily?

Thanks.  I've replaced the series with the following applied on top of the
'master', but I won't be merging them to 'next' for tonight, I guess.

[PATCH 01/14] doc/merge-config: list ecmerge as a built-in merge
[PATCH 02/14] git-mergetool/difftool: make (g)vimdiff workable under
[PATCH 03/14] git-mergetool: add new merge tool TortoiseMerge
[PATCH 04/14] difftool: remove merge options for opendiff, tkdiff,
[PATCH 05/14] difftool: remove the backup file feature
[PATCH 06/14] difftool: use perl built-ins when testing for msys
[PATCH v2 07/14] difftool: add a -y shortcut for --no-prompt
[PATCH 08/14] difftool/mergetool: add diffuse as merge and diff tool
[PATCH v2 09/14] difftool: move 'git-difftool' out of contrib
[PATCH v3 10/14] difftool: add various git-difftool tests
[PATCH v2 11/14] difftool: add support for a difftool.prompt config variable
[PATCH 12/14] bash completion: add git-difftool
[PATCH 13/14] mergetool: use $( ... ) instead of `backticks`
[PATCH v4 14/14] difftool/mergetool: refactor commands to use git-mergetool--lib

It appears that, assuming that up to 13/14 above is what you two expected
me to pick up, we would perhaps need to only replace 14/14?

As the final sanity check, please eyeball the attached interdiff, created
this way:

 $ git checkout master^0
 $ git am -s ./+da-fourteen-patches
 $ A=$(git rev-parse HEAD)
 $ git reset --hard master
 $ git merge da/difftool ;# old series
 $ git diff --stat -p HEAD $A ;# what's new in the new series?

 Documentation/config.txt               |    3 +-
 Documentation/git-mergetool.txt        |    2 +-
 Documentation/merge-config.txt         |    6 +-
 command-list.txt                       |    1 -
 contrib/completion/git-completion.bash |    2 +-
 git-mergetool--lib.sh                  |  237 ++++++++++++++++++--------------
 t/t7800-difftool.sh                    |    4 +-
 7 files changed, 144 insertions(+), 111 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e29623..d427daf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -670,7 +670,8 @@ diff.suppressBlankEmpty::
 diff.tool::
 	Controls which diff tool is used.  `diff.tool` overrides
 	`merge.tool` when used by linkgit:git-difftool[1] and has
-	the same valid values as `merge.tool`.
+	the same valid values as `merge.tool` minus "tortoisemerge"
+	and plus "kompare".
 
 difftool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index c3a8092..ff9700d 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -27,7 +27,7 @@ OPTIONS
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge,
-	diffuse and opendiff
+	diffuse, tortoisemerge and opendiff
 +
 If a merge resolution program is not specified, 'git-mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index c4fc3eb..4832bc7 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -23,9 +23,9 @@ merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
 	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
-	"diffuse" and "opendiff".  Any other value is treated as a custom
-	merge tool and there must be a corresponding mergetool.<tool>.cmd
-	option.
+	"diffuse", "ecmerge", "tortoisemerge", and
+	"opendiff".  Any other value is treated is custom merge tool
+	and there must be a corresponding mergetool.<tool>.cmd option.
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/command-list.txt b/command-list.txt
index fd66395..fb03a2e 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -69,7 +69,6 @@ git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
 git-merge-one-file                      purehelpers
 git-mergetool                           ancillarymanipulators
-git-mergetool--lib                      purehelpers
 git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6f96d75..069e19e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1192,7 +1192,7 @@ _git_mergetool ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--tool=*)
-		__gitcomp "$__git_mergetools_common" "" "${cur##--tool=}"
+		__gitcomp "$__git_mergetools_common tortoisemerge" "" "${cur##--tool=}"
 		return
 		;;
 	--*)
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 3d3edda..95cc355 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -1,10 +1,10 @@
 # git-mergetool--lib is a library for common merge tool functions
 diff_mode() {
-	test $TOOL_MODE = "diff"
+	test "$TOOL_MODE" = diff
 }
 
 merge_mode() {
-	test $TOOL_MODE = "merge"
+	test "$TOOL_MODE" = merge
 }
 
 translate_merge_tool_path () {
@@ -30,36 +30,36 @@ translate_merge_tool_path () {
 }
 
 check_unchanged () {
-	if merge_mode; then
-		if test "$MERGED" -nt "$BACKUP"; then
-			status=0
-		else
-			while true; do
-				echo "$MERGED seems unchanged."
-				printf "Was the merge successful? [y/n] "
-				read answer < /dev/tty
-				case "$answer" in
-				y*|Y*) status=0; break ;;
-				n*|N*) status=1; break ;;
-				esac
-			done
-		fi
-	else
+	if test "$MERGED" -nt "$BACKUP"; then
 		status=0
+	else
+		while true; do
+			echo "$MERGED seems unchanged."
+			printf "Was the merge successful? [y/n] "
+			read answer < /dev/tty
+			case "$answer" in
+			y*|Y*) status=0; break ;;
+			n*|N*) status=1; break ;;
+			esac
+		done
 	fi
-	return $status
 }
 
 valid_tool () {
 	case "$1" in
-	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge | diffuse | tortoisemerge)
-		if test "$1" = "kompare" && ! diff_mode; then
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
+	emerge | vimdiff | gvimdiff | ecmerge | diffuse)
+		;; # happy
+	tortoisemerge)
+		if ! merge_mode; then
 			return 1
 		fi
-		if test "$1" = "tortoisemerge" && ! merge_mode; then
+		;;
+	kompare)
+		if ! diff_mode; then
 			return 1
 		fi
-		;; # happy
+		;;
 	*)
 		if test -z "$(get_merge_tool_cmd "$1")"; then
 			return 1
@@ -79,160 +79,182 @@ get_merge_tool_cmd () {
 
 run_merge_tool () {
 	base_present="$2"
-	if diff_mode; then
-		base_present="false"
-	fi
-	if test -z "$base_present"; then
-		base_present="true"
-	fi
+	status=0
 
 	case "$1" in
 	kdiff3)
-		if $base_present; then
-			("$merge_tool_path" --auto \
-			 --L1 "$MERGED (Base)" --L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" \
-			 -o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
-		else
-			if merge_mode; then
+		if merge_mode; then
+			if $base_present; then
 				("$merge_tool_path" --auto \
-				 --L1 "$MERGED (Local)" \
-				 --L2 "$MERGED (Remote)" \
-				 -o "$MERGED" "$LOCAL" "$REMOTE" \
+					--L1 "$MERGED (Base)" \
+					--L2 "$MERGED (Local)" \
+					--L3 "$MERGED (Remote)" \
+					-o "$MERGED" \
+					"$BASE" "$LOCAL" "$REMOTE" \
 				> /dev/null 2>&1)
 			else
 				("$merge_tool_path" --auto \
-				 --L1 "$MERGED (A)" \
-				 --L2 "$MERGED (B)" \
-				 "$LOCAL" "$REMOTE" \
+					--L1 "$MERGED (Local)" \
+					--L2 "$MERGED (Remote)" \
+					-o "$MERGED" \
+					"$LOCAL" "$REMOTE" \
 				> /dev/null 2>&1)
 			fi
+			status=$?
+		else
+			("$merge_tool_path" --auto \
+			 --L1 "$MERGED (A)" \
+			 --L2 "$MERGED (B)" "$LOCAL" "$REMOTE" \
+			 > /dev/null 2>&1)
 		fi
-		status=$?
 		;;
 	kompare)
 		"$merge_tool_path" "$LOCAL" "$REMOTE"
-		status=$?
 		;;
 	tkdiff)
-		if $base_present; then
-			"$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"
-		else
-			if merge_mode; then
-				"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
+		if merge_mode; then
+			if $base_present; then
+				"$merge_tool_path" -a "$BASE" \
+					-o "$MERGED" "$LOCAL" "$REMOTE"
 			else
-				"$merge_tool_path" "$LOCAL" "$REMOTE"
+				"$merge_tool_path" \
+					-o "$MERGED" "$LOCAL" "$REMOTE"
 			fi
+			status=$?
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE"
 		fi
-		status=$?
 		;;
 	meld)
 		if merge_mode; then
 			touch "$BACKUP"
 			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+			check_unchanged
 		else
 			"$merge_tool_path" "$LOCAL" "$REMOTE"
 		fi
-		check_unchanged
 		;;
 	diffuse)
 		if merge_mode; then
 			touch "$BACKUP"
-		fi
-		if $base_present; then
-			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE" "$BASE" | cat
-		else
-			if merge_mode; then
-				"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE" | cat
+			if $base_present; then
+				"$merge_tool_path" \
+					"$LOCAL" "$MERGED" "$REMOTE" \
+					"$BASE" | cat
 			else
-				"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
+				"$merge_tool_path" \
+					"$LOCAL" "$MERGED" "$REMOTE" | cat
 			fi
+			check_unchanged
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
 		fi
-		check_unchanged
 		;;
 	vimdiff)
 		if merge_mode; then
 			touch "$BACKUP"
-			"$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
+			"$merge_tool_path" -d -c "wincmd l" \
+				"$LOCAL" "$MERGED" "$REMOTE"
 			check_unchanged
 		else
-			"$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$REMOTE"
+			"$merge_tool_path" -d -c "wincmd l" \
+				"$LOCAL" "$REMOTE"
 		fi
 		;;
 	gvimdiff)
 		if merge_mode; then
 			touch "$BACKUP"
-			"$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
+			"$merge_tool_path" -d -c "wincmd l" -f \
+				"$LOCAL" "$MERGED" "$REMOTE"
 			check_unchanged
 		else
-			"$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$REMOTE"
+			"$merge_tool_path" -d -c "wincmd l" -f \
+				"$LOCAL" "$REMOTE"
 		fi
 		;;
 	xxdiff)
 		if merge_mode; then
 			touch "$BACKUP"
-		fi
-		if $base_present; then
-			"$merge_tool_path" -X --show-merged-pane \
-			    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
-			    -R 'Accel.Search: "Ctrl+F"' \
-			    -R 'Accel.SearchForward: "Ctrl-G"' \
-			    --merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
-		else
-			if merge_mode; then
-				"$merge_tool_path" -X $extra \
+			if $base_present; then
+				"$merge_tool_path" -X --show-merged-pane \
 					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
 					-R 'Accel.Search: "Ctrl+F"' \
 					-R 'Accel.SearchForward: "Ctrl-G"' \
-					--merged-file "$MERGED" "$LOCAL" "$REMOTE"
+					--merged-file "$MERGED" \
+					"$LOCAL" "$BASE" "$REMOTE"
 			else
-				"$merge_tool_path" \
+				"$merge_tool_path" -X $extra \
+					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
 					-R 'Accel.Search: "Ctrl+F"' \
 					-R 'Accel.SearchForward: "Ctrl-G"' \
+					--merged-file "$MERGED" \
 					"$LOCAL" "$REMOTE"
 			fi
+			check_unchanged
+		else
+			"$merge_tool_path" \
+				-R 'Accel.Search: "Ctrl+F"' \
+				-R 'Accel.SearchForward: "Ctrl-G"' \
+				"$LOCAL" "$REMOTE"
 		fi
-		check_unchanged
 		;;
 	opendiff)
-		merge_mode && touch "$BACKUP"
-		if $base_present; then
-			"$merge_tool_path" "$LOCAL" "$REMOTE" \
-				-ancestor "$BASE" -merge "$MERGED" | cat
-		else
-			if merge_mode; then
+		if merge_mode; then
+			touch "$BACKUP"
+			if $base_present; then
 				"$merge_tool_path" "$LOCAL" "$REMOTE" \
+					-ancestor "$BASE" \
 					-merge "$MERGED" | cat
 			else
-				"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
+				"$merge_tool_path" "$LOCAL" "$REMOTE" \
+					-merge "$MERGED" | cat
 			fi
+			check_unchanged
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
 		fi
-		check_unchanged
 		;;
 	ecmerge)
-		merge_mode && touch "$BACKUP"
-		if $base_present; then
-			"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
-				--default --mode=merge3 --to="$MERGED"
+		if merge_mode; then
+			touch "$BACKUP"
+			if $base_present; then
+				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
+					--default --mode=merge3 --to="$MERGED"
+			else
+				"$merge_tool_path" "$LOCAL" "$REMOTE" \
+					--default --mode=merge2 --to="$MERGED"
+			fi
+			check_unchanged
 		else
 			"$merge_tool_path" "$LOCAL" "$REMOTE" \
 				--default --mode=merge2 --to="$MERGED"
 		fi
-		check_unchanged
 		;;
 	emerge)
-		if $base_present; then
-			"$merge_tool_path" -f emerge-files-with-ancestor-command \
-				"$LOCAL" "$REMOTE" "$BASE" "$(basename "$MERGED")"
+		if merge_mode; then
+			if $base_present; then
+				"$merge_tool_path" \
+					-f emerge-files-with-ancestor-command \
+					"$LOCAL" "$REMOTE" "$BASE" \
+					"$(basename "$MERGED")"
+			else
+				"$merge_tool_path" \
+					-f emerge-files-command \
+					"$LOCAL" "$REMOTE" \
+					"$(basename "$MERGED")"
+			fi
+			status=$?
 		else
 			"$merge_tool_path" -f emerge-files-command \
 				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
 		fi
-		status=$?
 		;;
 	tortoisemerge)
 		if $base_present; then
 			touch "$BACKUP"
-			"$merge_tool_path" -base:"$BASE" -mine:"$LOCAL" -theirs:"$REMOTE" -merged:"$MERGED"
+			"$merge_tool_path" \
+				-base:"$BASE" -mine:"$LOCAL" \
+				-theirs:"$REMOTE" -merged:"$MERGED"
 			check_unchanged
 		else
 			echo "TortoiseMerge cannot be used without a base" 1>&2
@@ -240,9 +262,14 @@ run_merge_tool () {
 		fi
 		;;
 	*)
-		if test -n "$merge_tool_cmd"; then
-			if merge_mode &&
-			test "$merge_tool_trust_exit_code" = "false"; then
+		if test -z "$merge_tool_cmd"; then
+			if merge_mode; then
+				status=1
+			fi
+			break
+		fi
+		if merge_mode; then
+			if test "$merge_tool_trust_exit_code" = "false"; then
 				touch "$BACKUP"
 				( eval $merge_tool_cmd )
 				check_unchanged
@@ -250,6 +277,8 @@ run_merge_tool () {
 				( eval $merge_tool_cmd )
 				status=$?
 			fi
+		else
+			( eval $merge_tool_cmd )
 		fi
 		;;
 	esac
@@ -257,27 +286,31 @@ run_merge_tool () {
 }
 
 guess_merge_tool () {
-	if diff_mode; then
+	tools="ecmerge"
+	if merge_mode; then
+		tools="$tools tortoisemerge"
+	else
 		kompare="kompare"
 	fi
 	if test -n "$DISPLAY"; then
 		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
-			tools="meld kdiff3 $kompare tkdiff"
+			tools="meld opendiff kdiff3 $kompare tkdiff $tools"
 			tools="$tools xxdiff gvimdiff diffuse"
 		else
-			tools="kdiff3 $kompare tkdiff xxdiff"
+			tools="opendiff kdiff3 $kompare tkdiff xxdiff $tools"
 			tools="$tools meld gvimdiff diffuse"
 		fi
 	fi
 	if echo "${VISUAL:-$EDITOR}" | grep emacs > /dev/null 2>&1; then
 		# $EDITOR is emacs so add emerge as a candidate
-		tools="$tools emerge opendiff vimdiff"
+		tools="$tools emerge vimdiff"
 	elif echo "${VISUAL:-$EDITOR}" | grep vim > /dev/null 2>&1; then
 		# $EDITOR is vim so add vimdiff as a candidate
-		tools="$tools vimdiff opendiff emerge"
+		tools="$tools vimdiff emerge"
 	else
-		tools="$tools opendiff emerge vimdiff"
+		tools="$tools emerge vimdiff"
 	fi
+	tools="$(echo "$tools" | sed -e 's/ +/ /g')"
 	echo >&2 "merge tool candidates: $tools"
 
 	# Loop over each candidate and stop when a valid merge tool is found.
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index cbfbe87..2586f86 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -202,10 +202,10 @@ test_expect_success 'difftool + mergetool config variables' '
 
 test_expect_success 'difftool.<tool>.path' '
 	git config difftool.tkdiff.path echo &&
-	diff=$(git difftool -y -t tkdiff branch) &&
+	diff=$(git difftool --tool=tkdiff --no-prompt branch) &&
 	git config --unset difftool.tkdiff.path &&
 	lines=$(echo "$diff" | grep file | wc -l) &&
-	test "$lines" = 1
+	test "$lines" -eq 1
 '
 
 test_done
