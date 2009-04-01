From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 08/10] mergetool-lib: introduce run_mergetool
Date: Thu, 2 Apr 2009 00:47:40 +0200
Message-ID: <200904020047.41561.markus.heidelberg@web.de>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com> <1238590514-41893-8-git-send-email-davvid@gmail.com> <1238590514-41893-9-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, charles@hashpling.org, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 00:49:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp9F8-000681-2g
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 00:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbZDAWrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 18:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755540AbZDAWrf
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 18:47:35 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:42985 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbZDAWre (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 18:47:34 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id B314AFF4B5C0;
	Thu,  2 Apr 2009 00:47:31 +0200 (CEST)
Received: from [89.59.70.14] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lp9DX-0004yU-00; Thu, 02 Apr 2009 00:47:31 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1238590514-41893-9-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+Rshlnz6FiI/cvM9mLTnEP6ucZ/naAPPQRcC+O
	RWbCXvqK6w9jwsR1UQVpaSMXIZqvmwMQsFtZtGZh5A82acc2/B
	U8kiLD7TJeLBSBzxL2wA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115422>

David Aguilar, 01.04.2009:
> diff --git a/git-mergetool-lib.sh b/git-mergetool-lib.sh
> +run_mergetool () {
> +	base_present="$2"
> +	if diff_mode; then
> +		base_present="false"
> +	fi
> +	if test -z "$base_present"; then
> +		base_present="true"
> +	fi
> +
> +	case "$1" in
> +	kdiff3)
> +		if $base_present; then
> +			("$merge_tool_path" --auto \
> +			 --L1 "$MERGED (Base)" --L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" \
> +			 -o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
> +		else
> +			("$merge_tool_path" --auto \
> +			 --L1 "$MERGED (Local)" --L2 "$MERGED (Remote)" \
> +			 -o "$MERGED" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
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
> +			if diff_mode; then

Query merge_mode instead of diff_mode as in all the other places.

> +				"$merge_tool_path" "$LOCAL" "$REMOTE"
> +			else
> +				"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
> +			fi
> +		fi
> +		status=$?
> +		;;
> +	meld)
> +		merge_mode && touch "$BACKUP"
> +		if merge_mode; then
> +			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"

Put the touch command into the if then block as in the other places.

> +		else
> +			"$merge_tool_path" "$LOCAL" "$REMOTE"
> +		fi
> +		check_unchanged
> +		;;
> +	vimdiff)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +			"$merge_tool_path" -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
> +			check_unchanged
> +		else
> +			"$merge_tool_path" -c "wincmd l" "$LOCAL" "$REMOTE"
> +		fi
> +		;;
> +	gvimdiff)
> +		if merge_mode; then
> +			touch "$BACKUP"
> +			"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
> +			check_unchanged
> +		else
> +			"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$REMOTE"
> +		fi
> +		;;
> +	xxdiff)
> +		merge_mode && touch "$BACKUP"
> +		if $base_present; then
> +			"$merge_tool_path" -X --show-merged-pane \
> +			    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
> +			    -R 'Accel.Search: "Ctrl+F"' \
> +			    -R 'Accel.SearchForward: "Ctrl-G"' \
> +			    --merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
> +		else
> +			merge_mode && extra=--show-merged-pane
> +			"$merge_tool_path" -X $extra \
> +				-R 'Accel.SaveAsMerged: "Ctrl-S"' \
> +				-R 'Accel.Search: "Ctrl+F"' \
> +				-R 'Accel.SearchForward: "Ctrl-G"' \
> +				--merged-file "$MERGED" "$LOCAL" "$REMOTE"
> +		fi
> +		check_unchanged
> +		;;
> +	opendiff)
> +		merge_mode && touch "$BACKUP"
> +		if $base_present; then
> +			"$merge_tool_path" "$LOCAL" "$REMOTE" \
> +				-ancestor "$BASE" -merge "$MERGED" | cat
> +		else
> +			"$merge_tool_path" "$LOCAL" "$REMOTE" \
> +				-merge "$MERGED" | cat
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
> +}
