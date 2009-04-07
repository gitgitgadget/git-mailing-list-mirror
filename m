From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v3 14/14] difftool/mergetool: refactor commands to use git-mergetool--lib
Date: Tue, 7 Apr 2009 20:11:14 +0200
Message-ID: <200904072011.15503.markus.heidelberg@web.de>
References: <1239092483-14973-1-git-send-email-davvid@gmail.com> <1239092483-14973-5-git-send-email-davvid@gmail.com> <1239092483-14973-6-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, charles@hashpling.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 20:13:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrFnb-0008QB-6r
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 20:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759725AbZDGSLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 14:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759559AbZDGSLE
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 14:11:04 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:49706 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759328AbZDGSLB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 14:11:01 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 78153FF8A48A;
	Tue,  7 Apr 2009 20:10:59 +0200 (CEST)
Received: from [89.59.110.219] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LrFlD-0003VF-00; Tue, 07 Apr 2009 20:10:59 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1239092483-14973-6-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/8QuhUrrz1LOzFsaKAUs9P0rlGZLZNPpS/1/uu
	gt1L3Jvao3jla4cbfnrygLI8V26I52+qM6RgS5OCGRtleGNK2K
	JojnebPkpuk9qcyFjCbw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115974>

David Aguilar, 07.04.2009:
> This consolidates the common functionality from git-mergetool and
> git-difftool--helper into a single git-mergetool--lib scriptlet.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> 
> Includes suggestions from Markus.
> We also moved opendiff up to the front so that it's
> preferred when on Mac OS.
> 
>  .gitignore                           |    1 +
>  Documentation/git-mergetool--lib.txt |   56 +++++
>  Makefile                             |    1 +
>  git-difftool--helper.sh              |  186 +----------------
>  git-mergetool--lib.sh                |  387 ++++++++++++++++++++++++++++++++++
>  git-mergetool.sh                     |  224 ++------------------
>  6 files changed, 467 insertions(+), 388 deletions(-)
>  create mode 100644 Documentation/git-mergetool--lib.txt
>  create mode 100644 git-mergetool--lib.sh
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh

> +check_unchanged () {
> +	if merge_mode; then
> +		if test "$MERGED" -nt "$BACKUP"; then
> +			status=0
> +		else
> +			while true; do
> +				echo "$MERGED seems unchanged."
> +				printf "Was the merge successful? [y/n] "
> +				read answer < /dev/tty
> +				case "$answer" in
> +				y*|Y*) status=0; break ;;
> +				n*|N*) status=1; break ;;
> +				esac
> +			done
> +		fi
> +	else
> +		status=0
> +	fi
> +}

This function is now only called when $merge_mode is set.

> +run_merge_tool () {
> +	base_present="$2"
> +	if diff_mode; then
> +		status=0
> +		base_present="false"
> +	fi

$base_present also is only used when $merge_mode is set. And I think we
don't need to set status=0 conditionally then.

> +	case "$1" in
> +	kdiff3)
> +		if merge_mode; then
> +			if $base_present; then
> +				("$merge_tool_path" --auto \
> +					--L1 "$MERGED (Base)" \
> +					--L2 "$MERGED (Local)" \
> +					--L3 "$MERGED (Remote)" \
> +					-o "$MERGED" \
> +					"$BASE" "$LOCAL" "$REMOTE" \
> +				> /dev/null 2>&1)
> +			else
> +				("$merge_tool_path" --auto \
> +					--L1 "$MERGED (Local)" \
> +					--L2 "$MERGED (Remote)" \
> +					-o "$MERGED" \
> +					"$LOCAL" "$REMOTE" \
> +				> /dev/null 2>&1)
> +			fi
> +			status=$?
> +		else
> +			("$merge_tool_path" --auto \
> +			 --L1 "$MERGED (A)" \
> +			 --L2 "$MERGED (B)" "$LOCAL" "$REMOTE" \
> +			 > /dev/null 2>&1)
> +		fi
> +		;;
> +	kompare)
> +		"$merge_tool_path" "$LOCAL" "$REMOTE"
> +		;;
> +	tkdiff)
> +		if merge_mode; then
> +			if $base_present; then
> +				"$merge_tool_path" -a "$BASE" \
> +					-o "$MERGED" "$LOCAL" "$REMOTE"
> +			else
> +				"$merge_tool_path" \
> +					-o "$MERGED" "$LOCAL" "$REMOTE"
> +			fi
> +			status=$?
> +		else
> +			"$merge_tool_path" "$LOCAL" "$REMOTE"
> +		fi
> +		;;
> +	meld)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> +			check_unchanged
> +		else
> +			"$merge_tool_path" "$LOCAL" "$REMOTE"
> +		fi
> +		;;
> +	diffuse)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +			if $base_present; then
> +				"$merge_tool_path" \
> +					"$LOCAL" "$MERGED" "$REMOTE" \
> +					"$BASE" | cat
> +			else
> +				"$merge_tool_path" \
> +					"$LOCAL" "$MERGED" "$REMOTE" | cat
> +			fi
> +			check_unchanged
> +		else
> +			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
> +		fi
> +		;;
> +	vimdiff)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +			"$merge_tool_path" -d -c "wincmd l" \
> +				"$LOCAL" "$MERGED" "$REMOTE"
> +			check_unchanged
> +		else
> +			"$merge_tool_path" -d -c "wincmd l" \
> +				"$LOCAL" "$REMOTE"
> +		fi
> +		;;
> +	gvimdiff)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +			"$merge_tool_path" -d -c "wincmd l" -f \
> +				"$LOCAL" "$MERGED" "$REMOTE"
> +			check_unchanged
> +		else
> +			"$merge_tool_path" -d -c "wincmd l" -f \
> +				"$LOCAL" "$REMOTE"
> +		fi
> +		;;
> +	xxdiff)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +			if $base_present; then
> +				"$merge_tool_path" -X --show-merged-pane \
> +					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
> +					-R 'Accel.Search: "Ctrl+F"' \
> +					-R 'Accel.SearchForward: "Ctrl-G"' \
> +					--merged-file "$MERGED" \
> +					"$LOCAL" "$BASE" "$REMOTE"
> +			else
> +				"$merge_tool_path" -X $extra \
> +					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
> +					-R 'Accel.Search: "Ctrl+F"' \
> +					-R 'Accel.SearchForward: "Ctrl-G"' \
> +					--merged-file "$MERGED" \
> +					"$LOCAL" "$REMOTE"
> +			fi
> +			check_unchanged
> +		else
> +			"$merge_tool_path" \
> +				-R 'Accel.Search: "Ctrl+F"' \
> +				-R 'Accel.SearchForward: "Ctrl-G"' \
> +				"$LOCAL" "$REMOTE"
> +		fi
> +		;;
> +	opendiff)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +			if $base_present; then
> +				"$merge_tool_path" "$LOCAL" "$REMOTE" \
> +					-ancestor "$BASE" \
> +					-merge "$MERGED" | cat
> +			else
> +				"$merge_tool_path" "$LOCAL" "$REMOTE" \
> +					-merge "$MERGED" | cat
> +			fi
> +			check_unchanged
> +		else
> +			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
> +		fi
> +		;;
> +	ecmerge)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +			if $base_present; then
> +				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
> +					--default --mode=merge3 --to="$MERGED"
> +			else
> +				"$merge_tool_path" "$LOCAL" "$REMOTE" \
> +					--default --mode=merge2 --to="$MERGED"
> +			fi
> +			check_unchanged
> +		else
> +			"$merge_tool_path" "$LOCAL" "$REMOTE" \
> +				--default --mode=merge2 --to="$MERGED"
> +		fi
> +		;;
> +	emerge)
> +		if merge_mode; then
> +			if $base_present; then
> +				"$merge_tool_path" \
> +					-f emerge-files-with-ancestor-command \
> +					"$LOCAL" "$REMOTE" "$BASE" \
> +					"$(basename "$MERGED")"
> +			else
> +				"$merge_tool_path" \
> +					-f emerge-files-command \
> +					"$LOCAL" "$REMOTE" \
> +					"$(basename "$MERGED")"
> +			fi
> +			status=$?
> +		else
> +			"$merge_tool_path" -f emerge-files-command \
> +				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
> +		fi
> +		;;
> +	tortoisemerge)
> +		if $base_present; then
> +			touch "$BACKUP"
> +			"$merge_tool_path" \
> +				-base:"$BASE" -mine:"$LOCAL" \
> +				-theirs:"$REMOTE" -merged:"$MERGED"
> +			check_unchanged
> +		else
> +			echo "TortoiseMerge cannot be used without a base" 1>&2
> +			status=1
> +		fi
> +		;;

Looks nice.

> +	*)
> +		if test -z "$merge_tool_cmd"; then
> +			if merge_mode; then
> +				status=1
> +			fi
> +			break
> +		fi
> +		if merge_mode; then
> +			if test "$merge_tool_trust_exit_code" = "false"; then
> +				touch "$BACKUP"
> +				( eval $merge_tool_cmd )
> +				check_unchanged
> +			else
> +				( eval $merge_tool_cmd )
> +			fi
> +			status=$?

"fi" and "status=$?" have to be swapped, else it overwrites the value
set by check_unchanged():
+				status=$?
+			fi

> +		else
> +			( eval $merge_tool_cmd )
> +		fi
> +		;;
> +	esac
> +	return $status
> +}
> +
> +guess_merge_tool () {
> +	tools="ecmerge"
> +	if merge_mode; then
> +		tools="$tools tortoisemerge"
> +	else
> +		kompare=" kompare "
> +	fi
> +	if test -n "$DISPLAY"; then
> +		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
> +			tools="meld opendiff kdiff3""$kompare""tkdiff $tools"
> +			tools="$tools xxdiff gvimdiff diffuse"
> +		else
> +			tools="opendiff kdiff3""$kompare""tkdiff xxdiff $tools"
> +			tools="$tools meld gvimdiff diffuse"
> +		fi
> +	fi

The setting of $tools looks a bit weird. Maybe we can just ignore the
additional spaces here...

> +	if echo "${VISUAL:-$EDITOR}" | grep emacs > /dev/null 2>&1; then
> +		# $EDITOR is emacs so add emerge as a candidate
> +		tools="$tools emerge vimdiff"
> +	elif echo "${VISUAL:-$EDITOR}" | grep vim > /dev/null 2>&1; then
> +		# $EDITOR is vim so add vimdiff as a candidate
> +		tools="$tools vimdiff emerge"
> +	else
> +		tools="$tools emerge vimdiff"
> +	fi

...and delete them here with something like
    sed -e 's/ \+/ /g'
to have it look nice here?:

> +	echo >&2 "merge tool candidates: $tools"
> +
> +	# Loop over each candidate and stop when a valid merge tool is found.
> +	for i in $tools
> +	do
> +		merge_tool_path="$(translate_merge_tool_path "$i")"
> +		if type "$merge_tool_path" > /dev/null 2>&1; then
> +			merge_tool="$i"
> +			break
> +		fi
> +	done
> +
> +	if test -z "$merge_tool" ; then
> +		echo >&2 "No known merge resolution program available."
> +		return 1
> +	fi
> +	echo "$merge_tool"
> +}
