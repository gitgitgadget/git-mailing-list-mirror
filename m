From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 10/10] mergetool: use run_mergetool from git-mergetool-lib
Date: Thu, 2 Apr 2009 00:54:22 +0200
Message-ID: <200904020054.23147.markus.heidelberg@web.de>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com> <1238590514-41893-10-git-send-email-davvid@gmail.com> <1238590514-41893-11-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, charles@hashpling.org, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 00:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp9La-0007UG-00
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 00:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760107AbZDAWyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 18:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757469AbZDAWyR
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 18:54:17 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:38069 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758031AbZDAWyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 18:54:16 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 54989FC54A77;
	Thu,  2 Apr 2009 00:54:13 +0200 (CEST)
Received: from [89.59.70.14] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lp9K1-0004ta-00; Thu, 02 Apr 2009 00:54:13 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1238590514-41893-11-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+ULa9o78WvZ+MaBHA7gW/Q2AOamgNre78aF0ZL
	vI2hnAMjp3qdFVTUoJP2x4YX5PZrsWvspBenLcg7Vy3J7Cm/pG
	WS3c6ofxiMi7xjRDVo6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115424>

David Aguilar, 01.04.2009:
> This refactors git-mergetool to use run_mergetool.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-mergetool.sh |   96 +++--------------------------------------------------
>  1 files changed, 6 insertions(+), 90 deletions(-)
> 
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 957993c..2c6b325 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -190,96 +190,12 @@ merge_file () {
>  	read ans
>      fi
>  
> -    case "$merge_tool" in
> -	kdiff3)
> -	    if base_present ; then
> -		("$merge_tool_path" --auto --L1 "$MERGED (Base)" --L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" \
> -		    -o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
> -	    else
> -		("$merge_tool_path" --auto --L1 "$MERGED (Local)" --L2 "$MERGED (Remote)" \
> -		    -o "$MERGED" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
> -	    fi
> -	    status=$?
> -	    ;;
> -	tkdiff)
> -	    if base_present ; then
> -		"$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"
> -	    else
> -		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
> -	    fi
> -	    status=$?
> -	    ;;
> -	meld)
> -	    touch "$BACKUP"
> -	    "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> -	    check_unchanged
> -	    ;;
> -	vimdiff)
> -	    touch "$BACKUP"
> -	    "$merge_tool_path" -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
> -	    check_unchanged
> -	    ;;
> -	gvimdiff)
> -	    touch "$BACKUP"
> -	    "$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
> -	    check_unchanged
> -	    ;;
> -	xxdiff)
> -	    touch "$BACKUP"
> -	    if base_present ; then
> -		"$merge_tool_path" -X --show-merged-pane \
> -		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
> -		    -R 'Accel.Search: "Ctrl+F"' \
> -		    -R 'Accel.SearchForward: "Ctrl-G"' \
> -		    --merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
> -	    else
> -		"$merge_tool_path" -X --show-merged-pane \
> -		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
> -		    -R 'Accel.Search: "Ctrl+F"' \
> -		    -R 'Accel.SearchForward: "Ctrl-G"' \
> -		    --merged-file "$MERGED" "$LOCAL" "$REMOTE"
> -	    fi
> -	    check_unchanged
> -	    ;;
> -	opendiff)
> -	    touch "$BACKUP"
> -	    if base_present; then
> -		"$merge_tool_path" "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$MERGED" | cat
> -	    else
> -		"$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$MERGED" | cat
> -	    fi
> -	    check_unchanged
> -	    ;;
> -	ecmerge)
> -	    touch "$BACKUP"
> -	    if base_present; then
> -		"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --default --mode=merge3 --to="$MERGED"
> -	    else
> -		"$merge_tool_path" "$LOCAL" "$REMOTE" --default --mode=merge2 --to="$MERGED"
> -	    fi
> -	    check_unchanged
> -	    ;;
> -	emerge)
> -	    if base_present ; then
> -		"$merge_tool_path" -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$(basename "$MERGED")"
> -	    else
> -		"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE" "$(basename "$MERGED")"
> -	    fi
> -	    status=$?
> -	    ;;
> -	*)
> -	    if test -n "$merge_tool_cmd"; then
> -		if test "$merge_tool_trust_exit_code" = "false"; then
> -		    touch "$BACKUP"
> -		    ( eval $merge_tool_cmd )
> -		    check_unchanged
> -		else
> -		    ( eval $merge_tool_cmd )
> -		    status=$?
> -		fi
> -	    fi
> -	    ;;
> -    esac
> +    present=false
> +    base_present &&
> +    present=true
> +
> +    run_mergetool "$merge_tool" "$present"
> +    status=$?

This last line has to be deleted, because the variable 'status' set in
run_mergetool would be overwritten then. In this case the merge will
succeed even if it didn't and the file will be staged.

>      if test "$status" -ne 0; then
>  	echo "merge of $MERGED failed" 1>&2
>  	mv -- "$BACKUP" "$MERGED"
