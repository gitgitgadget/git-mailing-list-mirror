From: David Aguilar <davvid@gmail.com>
Subject: Re: git: regression with mergetool and answering "n" (backport fix
 / add tests)
Date: Thu, 25 Dec 2014 17:00:25 -0800
Message-ID: <20141226010023.GC14150@gmail.com>
References: <5499BDB2.4070301@thequod.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Hahler <genml+git-2014@thequod.de>
X-From: git-owner@vger.kernel.org Fri Dec 26 02:00:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4JG6-0002Yk-0J
	for gcvg-git-2@plane.gmane.org; Fri, 26 Dec 2014 02:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbaLZA75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2014 19:59:57 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:55497 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbaLZA74 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2014 19:59:56 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so12035335pdb.8
        for <git@vger.kernel.org>; Thu, 25 Dec 2014 16:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MyC3wolOQfoezxK+TbCdGur0M3sH64mDkXrLNZwa8OI=;
        b=qGulYziiCxSAOssC+yx0I7gjnOnWDPWzFdZ9mnB30s41RvJKrmFnWdO707wJsnTKzu
         9aq/t5fEcNWDl1VFWa1BdC/GO8OuZcZmuTpg8GsI6MD5ylktaxWei72czwnYuxgDv0dC
         WkBM2Uu0/fX4CxxhAstpF3XVaFipeExF9EHwwH30fO2KY3bdvh8u0+fyBqfi5CETss5p
         OgTn3CNfiOgYjj9RqeHjAM+hWIWEk6ZLvDs7zmuxqgtBRodIC0kcyvsnYG5rEhlnEnI1
         YyMEp7aZjZvgDswQJ6tdy+OR8kzUXtZHOCzKCKjJ93zKD8R7F7UPjKhwfpHRF/bpvXvn
         2vnw==
X-Received: by 10.70.119.106 with SMTP id kt10mr16301197pdb.89.1419555596186;
        Thu, 25 Dec 2014 16:59:56 -0800 (PST)
Received: from gmail.com (pool-108-47-101-254.lsanca.fios.verizon.net. [108.47.101.254])
        by mx.google.com with ESMTPSA id i7sm13490701pdp.3.2014.12.25.16.59.55
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 16:59:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5499BDB2.4070301@thequod.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261824>

On Tue, Dec 23, 2014 at 08:08:34PM +0100, Daniel Hahler wrote:
> Hi,
> 
> this is in reply to the commits from David:
> 
>     commit 0ddedd4d6b9b3e8eb3557d8ed28e1a0b354a25f8
>     Refs: v2.2.0-60-g0ddedd4
>     Merge: e886efd 1e86d5b
>     Author:     Junio C Hamano <gitster@pobox.com>
>     AuthorDate: Fri Dec 12 14:31:39 2014 -0800
>     Commit:     Junio C Hamano <gitster@pobox.com>
>     CommitDate: Fri Dec 12 14:31:39 2014 -0800
> 
>         Merge branch 'da/difftool-mergetool-simplify-reporting-status'
> 
>         Code simplification.
> 
>         * da/difftool-mergetool-simplify-reporting-status:
>           mergetools: stop setting $status in merge_cmd()
>           mergetool: simplify conditionals
>           difftool--helper: add explicit exit statement
>           mergetool--lib: remove use of $status global
>           mergetool--lib: remove no-op assignment to $status from setup_user_tool
> 
> I've ran into a problem, where "git mergetool" (using vimdiff) would add
> the changes to the index, although you'd answered "n" after not changing/saving
> the merged file.

Thanks for the heads-up.

Do you perhaps have mergetool.vimdiff.trustExitCode defined, or
a similar setting?

If you saw the prompt then it should have aborted right after
you answered "n".

The very last thing merge_cmd() for vimdiff does is call
check_unchanged().  We'll come back to check_unchanged() later.

I tried to reproduce this issue.  Here's a transcript:

....
$ git status -s
UU file.txt

$ git mergetool -t vimdiff file.txt
Merging:
file.txt

Normal merge conflict for 'file.txt':
  {local}: modified file
  {remote}: modified file
4 files to edit
#### Enter :qall inside vim
file.txt seems unchanged.
Was the merge successful? [y/n] n
merge of file.txt failed
Continue merging other unresolved paths (y/n) ? n

$ git status -s
UU file.txt
....

That seemed to work fine.  Any clues?
More notes below...

> This regression has been introduced in:
> 
>     commit 99474b6340dbcbe58f6c256fdee231cbadb060f4
>     Author: David Aguilar <davvid@gmail.com>
>     Date:   Fri Nov 14 13:33:55 2014 -0800
> 
>         difftool: honor --trust-exit-code for builtin tools
>         
>         run_merge_tool() was not setting $status, which prevented the
>         exit code for builtin tools from being forwarded to the caller.
>         
>         Capture the exit status and add a test to guarantee the behavior.
>         
>         Reported-by: Adria Farres <14farresa@gmail.com>
>         Signed-off-by: David Aguilar <davvid@gmail.com>
>         Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
>     diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>     index c45a020..cce4f8c 100644
>     --- a/git-mergetool--lib.sh
>     +++ b/git-mergetool--lib.sh
>     @@ -221,6 +221,7 @@ run_merge_tool () {
>             else
>                     run_diff_cmd "$1"
>             fi
>     +       status=$?
>             return $status
>      }
> 
> 
> My fix has been the following, but I agree that the changes from David
> are much better in general.
> 
>     diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>     index cce4f8c..fa9acb1 100644
>     --- a/git-mergetool--lib.sh
>     +++ b/git-mergetool--lib.sh
>     @@ -105,6 +105,7 @@ check_unchanged () {
>                             esac
>                     done
>             fi
>     +       return $status
>      }

I don't think this fix does anything.
Here is all of check_unchanged() for context:

check_unchanged () {
	if test "$MERGED" -nt "$BACKUP"
	then
		return 0
	else
		while true
		do
			echo "$MERGED seems unchanged."
			printf "Was the merge successful? [y/n] "
			read answer || return 1
			case "$answer" in
			y*|Y*) return 0 ;;
			n*|N*) return 1 ;;
			esac
		done
	fi
}

The addition of "return $status" after the "fi" in the above fix
won't do anything because that code is unreachable.
We either return 0 or 1.

> I haven't verified if it really fixes the regression, but if it does it
> should get backported into the branches where the regression is present.

Also, the $status variable doesn't even exist anymore, so the
fix is suspect.

What platform are you on?

> Also, there should be some tests for this.

I don't disagree with that ;-)

Let me know if you have any clues.  I don't see anything obvious.

cheers,
-- 
David
