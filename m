From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool: Teach about submodules
Date: Sat, 9 Apr 2011 05:03:03 -0700
Message-ID: <20110409120301.GA1369@gmail.com>
References: <1302321570-85987-1-git-send-email-me@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 14:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Wsq-0000O9-PX
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 14:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343Ab1DIMDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 08:03:15 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60223 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab1DIMDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 08:03:14 -0400
Received: by iyb14 with SMTP id 14so4188361iyb.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JpTNm6s6hsHvcuV7Ys04LcdFghz4bX8IcazelTXm0Uc=;
        b=PY8jGKnIWhQ38S9IbiDvNCAp7T1Uu0T8WFx7mHb/lwKFX/JpVxSsS6c2LDOHVXo8eI
         4cqRzSdbuZ6MWt0YkQNdLzXI3hlzU5JB36Clqh3VjmejZoRd9PJ5xk8o37ZRfJG+pUc+
         jUgWRw2Bp8k3KeLgZ1dv+8m1PBc8B9AeoHG2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LRZi2rdxYPedcMpnrLegm8zRma4lq3Akd7StLvQi3a5DhXVFHU/gMRLi7kfJLhNKFE
         IWG7u8jr+1CyA2wlTIFGUIGIoOI5+TlfjMD7tYFmgfNoTPiCCwkclWOlEILa2QKPeuWQ
         Uc9JQGwNOpQ1Ebbf9JmniUuHG0mrdj6hynw+I=
Received: by 10.42.35.198 with SMTP id r6mr459241icd.240.1302350593183;
        Sat, 09 Apr 2011 05:03:13 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id hc41sm2597207ibb.13.2011.04.09.05.03.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 05:03:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302321570-85987-1-git-send-email-me@JonathonMah.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171191>

I added Charles Bailey to the cc list.

On Fri, Apr 08, 2011 at 08:59:30PM -0700, Jonathon Mah wrote:
> Mergetool mildly clobbered submodules, attempting to move and copy their
> directories. It now recognizes submodules and offers a resolution:
> 
> Submodule merge conflict for 'Shared':
>   {local}: commit ad9f12e3e6205381bf2163a793d1e596a9e211d0
>   {remote}: commit f5893fb70ec5646efcd9aa643c5136753ac89253
> Use (l)ocal or (r)emote, or (a)bort?
> 
> Selecting a commit will stage it, but not update the submodule (as it
> would had there been no conflict). Type changes are also supported,
> should the path be a submodule on one side, and a file on the other.
> 
> Signed-off-by: Jonathon Mah <me@JonathonMah.com>
> ---

This is a nice patch.  It fixes a bug by introducing a great
new feature.  Thank you.

One thing that could make it better, though, would be if it
also added tests for the feature to t/t7610-mergetool.sh.
That will help prevent someone (like me) from accidentally
breaking it in the future.

Cheers,
-- 
					David

>  git-mergetool.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index bacbda2..83351d6 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -21,6 +21,10 @@ is_symlink () {
>      test "$1" = 120000
>  }
>  
> +is_submodule () {
> +    test "$1" = 160000
> +}
> +
>  local_present () {
>      test -n "$local_mode"
>  }
> @@ -52,6 +56,8 @@ describe_file () {
>  	echo "deleted"
>      elif is_symlink "$mode" ; then
>  	echo "a symbolic link -> '$(cat "$file")'"
> +    elif is_submodule "$mode" ; then
> +	echo "commit $file"
>      else
>  	if base_present; then
>  	    echo "modified"
> @@ -112,6 +118,51 @@ resolve_deleted_merge () {
>  	done
>  }
>  
> +resolve_submodule_merge () {
> +    while true; do
> +	printf "Use (l)ocal or (r)emote, or (a)bort? "
> +	read ans
> +	case "$ans" in
> +	    [lL]*)
> +		local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
> +		if is_submodule "$local_mode"; then
> +		    stage_submodule "$MERGED" $(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')
> +		else
> +		    git checkout-index -f --stage=2 -- "$MERGED"
> +		    git add -- "$MERGED"
> +		fi
> +		return 0
> +		;;
> +	    [rR]*)
> +		remote_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}')
> +		if is_submodule "$remote_mode"; then
> +		    stage_submodule "$MERGED" $(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $2;}')
> +		else
> +		    git checkout-index -f --stage=2 -- "$MERGED"
> +		    git add -- "$MERGED"
> +		fi
> +		return 0
> +		;;
> +	    [aA]*)
> +		return 1
> +		;;
> +	    esac
> +	done
> +}
> +
> +stage_submodule () {
> +    path="$1"
> +    submodule_sha1="$2"
> +
> +    submodule_basename=$(basename "$path")
> +    tree_with_module=$(echo "160000 commit $submodule_sha1	\"$submodule_basename\"" | git mktree --missing 2>/dev/null)
> +    if test -z "$tree_with_module" ; then
> +	echo "$path: unable to stage commit $sha1"
> +	return 1
> +    fi
> +    git checkout $tree_with_module -- "$path"
> +}
> +
>  checkout_staged_file () {
>      tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
>  
> @@ -139,13 +190,23 @@ merge_file () {
>      REMOTE="./$MERGED.REMOTE.$ext"
>      BASE="./$MERGED.BASE.$ext"
>  
> -    mv -- "$MERGED" "$BACKUP"
> -    cp -- "$BACKUP" "$MERGED"
> -
>      base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
>      local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
>      remote_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}')
>  
> +    if is_submodule "$local_mode" || is_submodule "$remote_mode"; then
> +	echo "Submodule merge conflict for '$MERGED':"
> +	local_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')
> +	remote_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $2;}')
> +	describe_file "$local_mode" "local" "$local_sha1"
> +	describe_file "$remote_mode" "remote" "$remote_sha1"
> +	resolve_submodule_merge
> +	return
> +    fi
> +
> +    mv -- "$MERGED" "$BACKUP"
> +    cp -- "$BACKUP" "$MERGED"
> +
>      base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
>      local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
>      remote_present && checkout_staged_file 3 "$MERGED" "$REMOTE"
> -- 
> 1.7.5.rc1.1.g64431
