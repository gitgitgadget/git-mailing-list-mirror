From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Mon, 21 Apr 2014 21:59:52 -0700
Message-ID: <20140422045951.GA60610@gmail.com>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
 <1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 07:00:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcSoS-0004wp-Hf
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 07:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbaDVFAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 01:00:03 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:40816 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbaDVFAB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 01:00:01 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so4469698pdb.28
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 22:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=t2oq9iZpcZYvjPzgQz0orcLnzumzhruZlaF5+iPj0uo=;
        b=kgretRzCjQnSsAFEY8N4pq+AZkCDf4pXRVr6iiALjkFKSrx4CfL/8TbHD26CYZkIw9
         o4LmTC3bBkQBulXxdXgpvol/hVzDNAH8YcF5Gx1l2cy73iBQWwNRVz7VA03ndcIxcdV8
         d3X0YigR3Sb/fQNC/b9aHAcMljSpKUcmpOCL8KOQEtYROwWA26UGq5hiQ0pI9xCJbg4b
         BkeiBemsoug0uYFP+A3fowW1an+VV/B0c+EqVJtgc5yRvpTBpcHZb9XCLIzFqxGQfe/L
         Bqz3dDRxxKrZUW3V0xOvXmC2fCt6FHxKMf0OLQ62THJ9iUOl4+HMNcfS1OY8osVJZE3a
         4Zrw==
X-Received: by 10.68.110.226 with SMTP id id2mr42523447pbb.40.1398142800699;
        Mon, 21 Apr 2014 22:00:00 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id xx4sm12344937pbb.51.2014.04.21.21.59.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 21:59:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246691>

[Cc:ing Charles in case he has an opinion, this behavior dates back to the original MT]

On Sun, Apr 20, 2014 at 07:17:34PM -0500, Felipe Contreras wrote:
> It's annoying to see the prompt:
> 
>   Hit return to start merge resolution tool (foo):
> 
> Every time the user does 'git mergetool' even if the user already
> configured 'foo' as the wanted tool.
> 
> Display this prompt only when the user hasn't explicitly configured a
> tool.

I agree this is probably helpful.
Most users I've met end up configuring mergetool.prompt=false.

Thanks

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-mergetool.sh | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 332528f..d08dc92 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -277,7 +277,7 @@ merge_file () {
>  	echo "Normal merge conflict for '$MERGED':"
>  	describe_file "$local_mode" "local" "$LOCAL"
>  	describe_file "$remote_mode" "remote" "$REMOTE"
> -	if "$prompt" = true
> +	if test "$guessed_merge_tool" = true || test "$prompt" = true
>  	then
>  		printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
>  		read ans || return 1
> @@ -315,7 +315,8 @@ merge_file () {
>  	return 0
>  }
>  
> -prompt=$(git config --bool mergetool.prompt || echo true)
> +prompt=$(git config --bool mergetool.prompt)
> +guessed_merge_tool=false
>  
>  while test $# != 0
>  do
> @@ -373,7 +374,14 @@ prompt_after_failed_merge () {
>  
>  if test -z "$merge_tool"
>  then
> -	merge_tool=$(get_merge_tool "$merge_tool") || exit
> +	# Check if a merge tool has been configured
> +	merge_tool=$(get_configured_merge_tool)
> +	# Try to guess an appropriate merge tool if no tool has been set.
> +	if test -z "$merge_tool"
> +	then
> +		merge_tool=$(guess_merge_tool) || exit
> +		guessed_merge_tool=true
> +	fi
>  fi
>  merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
>  merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
> -- 
> 1.9.2+fc1.1.g5c924db
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
David
