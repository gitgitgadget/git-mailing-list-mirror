From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v2 14/14] difftool/mergetool: refactor commands to use git-mergetool--lib
Date: Tue, 7 Apr 2009 01:37:17 +0200
Message-ID: <200904070137.17716.markus.heidelberg@web.de>
References: <1239010228-21315-1-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, benji@silverinsanity.com,
	charles@hashpling.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 01:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqyP7-0005tj-N4
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 01:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbZDFXhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 19:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbZDFXhK
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 19:37:10 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:57371 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbZDFXhI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 19:37:08 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 3F175FF7E8D9;
	Tue,  7 Apr 2009 01:37:05 +0200 (CEST)
Received: from [89.59.82.208] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LqyNF-0000I7-00; Tue, 07 Apr 2009 01:37:05 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1239010228-21315-1-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1//Y/Qpq3r3VCLX4CvXSq2biTHg2EZUjb+LQLt0
	7Ok+RhnbAjO7YluMRz/iRGJskLUSXgaX0LsgAs7aMr5L+54xhm
	c+rAjj0Ux1nMJ13fXm7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115892>

David Aguilar, 06.04.2009:
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
> +	return $status
> +}

The return value is currently never used.

> +run_merge_tool () {
> +	base_present="$2"
> +	if diff_mode; then
> +		base_present="false"
> +	fi
> +	if test -z "$base_present"; then
> +		base_present="true"
> +	fi

The second if is never true, so isn't necessary. run_merge_tool() is
called with $2 = true or false in mergetool and $2 = "" in difftool.

But I wonder, if it would be better to change the proceeding in the
case-esac in the next hunk below:

Currently it is:
    if $base_present
        mergetool with base
    else
        if $merge_mode
            mergetool without base
        else
            difftool
        fi
    fi

Maybe better:
    if $merge_mode
        if $base_present
            mergetool with base
        else
            mergetool without base
        fi
    else
        difftool
    fi

Then the first if can vanish as well and $base_present doesn't have to
be set to false in diff_mode.

And check_unchanged() doesn't have to be called in diff_mode any more,
$status could be set to 0 by default and doesn't have to be touched when
in diff_mode. Only in merge_mode git-mergetool has to know, whether the
merge went fine.

Then it will be:
    if $merge_mode
        touch $BACKUP
        if $base_present
            mergetool with base
        else
            mergetool without base
        fi
	check_unchanged
    else
        difftool
    fi

or:
    if $merge_mode
        if $base_present
            mergetool with base
        else
            mergetool without base
        fi
	status=$?
    else
        difftool
    fi

Sorry for coming so late with this.

> +	case "$1" in
> +	kdiff3)
> +		if $base_present; then
> +			("$merge_tool_path" --auto \
> +			 --L1 "$MERGED (Base)" --L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" \
> +			 -o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
> +		else
> +			if merge_mode; then
> +				("$merge_tool_path" --auto \
> +				 --L1 "$MERGED (Local)" \
> +				 --L2 "$MERGED (Remote)" \
> +				 -o "$MERGED" "$LOCAL" "$REMOTE" \
> +				> /dev/null 2>&1)
> +			else
> +				("$merge_tool_path" --auto \
> +				 --L1 "$MERGED (A)" \
> +				 --L2 "$MERGED (B)" \
> +				 "$LOCAL" "$REMOTE" \
> +				> /dev/null 2>&1)
> +			fi
> +		fi
> +		status=$?
> +		;;
> +	kompare)
> +		"$merge_tool_path" "$LOCAL" "$REMOTE"
> +		status=$?
> +		;;
> +	tkdiff)
> +		if $base_present; then
> +			"$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"
> +		else
> +			if merge_mode; then
> +				"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
> +			else
> +				"$merge_tool_path" "$LOCAL" "$REMOTE"
> +			fi
> +		fi
> +		status=$?
> +		;;
> +	meld)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> +		else
> +			"$merge_tool_path" "$LOCAL" "$REMOTE"
> +		fi
> +		check_unchanged
> +		;;
> +	diffuse)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +		fi
> +		if $base_present; then
> +			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE" "$BASE" | cat
> +		else
> +			if merge_mode; then
> +				"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE" | cat
> +			else
> +				"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
> +			fi
> +		fi
> +		check_unchanged
> +		;;
> +	vimdiff)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +			"$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
> +			check_unchanged
> +		else
> +			"$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$REMOTE"
> +		fi
> +		;;
> +	gvimdiff)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +			"$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
> +			check_unchanged
> +		else
> +			"$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$REMOTE"
> +		fi
> +		;;
> +	xxdiff)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +		fi
> +		if $base_present; then
> +			"$merge_tool_path" -X --show-merged-pane \
> +			    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
> +			    -R 'Accel.Search: "Ctrl+F"' \
> +			    -R 'Accel.SearchForward: "Ctrl-G"' \
> +			    --merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
> +		else
> +			if merge_mode; then
> +				"$merge_tool_path" -X $extra \
> +					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
> +					-R 'Accel.Search: "Ctrl+F"' \
> +					-R 'Accel.SearchForward: "Ctrl-G"' \
> +					--merged-file "$MERGED" "$LOCAL" "$REMOTE"
> +			else
> +				"$merge_tool_path" \
> +					-R 'Accel.Search: "Ctrl+F"' \
> +					-R 'Accel.SearchForward: "Ctrl-G"' \
> +					"$LOCAL" "$REMOTE"
> +			fi
> +		fi
> +		check_unchanged
> +		;;
> +	opendiff)
> +		merge_mode && touch "$BACKUP"
> +		if $base_present; then
> +			"$merge_tool_path" "$LOCAL" "$REMOTE" \
> +				-ancestor "$BASE" -merge "$MERGED" | cat
> +		else
> +			if merge_mode; then
> +				"$merge_tool_path" "$LOCAL" "$REMOTE" \
> +					-merge "$MERGED" | cat
> +			else
> +				"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
> +			fi
> +		fi
> +		check_unchanged
> +		;;
> +	ecmerge)
> +		merge_mode && touch "$BACKUP"
> +		if $base_present; then
> +			"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
> +				--default --mode=merge3 --to="$MERGED"
> +		else
> +			"$merge_tool_path" "$LOCAL" "$REMOTE" \
> +				--default --mode=merge2 --to="$MERGED"
> +		fi
> +		check_unchanged
> +		;;
> +	emerge)
> +		if $base_present; then
> +			"$merge_tool_path" -f emerge-files-with-ancestor-command \
> +				"$LOCAL" "$REMOTE" "$BASE" "$(basename "$MERGED")"
> +		else
> +			"$merge_tool_path" -f emerge-files-command \
> +				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
> +		fi
> +		status=$?
> +		;;
> +	tortoisemerge)
> +		if $base_present; then
> +			touch "$BACKUP"
> +			"$merge_tool_path" -base:"$BASE" -mine:"$LOCAL" -theirs:"$REMOTE" -merged:"$MERGED"
> +			check_unchanged
> +		else
> +			echo "TortoiseMerge cannot be used without a base" 1>&2
> +			status=1
> +		fi
> +		;;
> +	*)
> +		if test -n "$merge_tool_cmd"; then
> +			if merge_mode &&
> +			test "$merge_tool_trust_exit_code" = "false"; then
> +				touch "$BACKUP"
> +				( eval $merge_tool_cmd )
> +				check_unchanged
> +			else
> +				( eval $merge_tool_cmd )
> +				status=$?
> +			fi
> +		fi
> +		;;
> +	esac
> +	return $status
> +}
> +
> +guess_merge_tool () {
> +	if diff_mode; then
> +		kompare="kompare"
> +	fi
> +	if test -n "$DISPLAY"; then
> +		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
> +			tools="meld kdiff3 $kompare tkdiff"
> +			tools="$tools xxdiff gvimdiff diffuse"
> +		else
> +			tools="kdiff3 $kompare tkdiff xxdiff"
> +			tools="$tools meld gvimdiff diffuse"
> +		fi
> +	fi

We lost tortoisemerge. And we could add ecmerge. Then every possible
built-in can be detected if installed.

> +	if echo "${VISUAL:-$EDITOR}" | grep emacs > /dev/null 2>&1; then
> +		# $EDITOR is emacs so add emerge as a candidate
> +		tools="$tools emerge opendiff vimdiff"
> +	elif echo "${VISUAL:-$EDITOR}" | grep vim > /dev/null 2>&1; then
> +		# $EDITOR is vim so add vimdiff as a candidate
> +		tools="$tools vimdiff opendiff emerge"
> +	else
> +		tools="$tools opendiff emerge vimdiff"
> +	fi

Why is opendiff here? I thought the graphical tools should go above.
Doesn't have Mac OS $DISPLAY set?
