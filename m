From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Speedup bash completion loading
Date: Mon, 5 Oct 2009 08:25:04 -0700
Message-ID: <20091005152504.GE9261@spearce.org>
References: <1254737039-10404-1-git-send-email-kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Mon Oct 05 17:32:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MupXw-0001PG-1n
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 17:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbZJEPZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 11:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbZJEPZl
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 11:25:41 -0400
Received: from george.spearce.org ([209.20.77.23]:54563 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZJEPZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 11:25:41 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 91428381FE; Mon,  5 Oct 2009 15:25:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1254737039-10404-1-git-send-email-kirr@mns.spb.ru>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129567>

Kirill Smelkov <kirr@mns.spb.ru> wrote:
> I've tracked down that the most time is spent warming up merge_strategy,
> all_command & porcelain_command caches.

Nak.

The problem is, during completion when we modify the value the
change doesn't persist beyond the current completion invocation.
Thus there is no value in the cache, so every completion attempt
which needs the list has to rerun the command to compute it.

 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 2c2a0d4..4c09d41 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -340,7 +340,6 @@ __git_merge_strategies ()
>  	}'
>  }
>  __git_merge_strategylist=
> -__git_merge_strategylist=$(__git_merge_strategies 2>/dev/null)
>  
>  __git_complete_file ()
>  {
> @@ -505,7 +504,6 @@ __git_all_commands ()
>  	done
>  }
>  __git_all_commandlist=
> -__git_all_commandlist="$(__git_all_commands 2>/dev/null)"
>  
>  __git_porcelain_commands ()
>  {
> @@ -596,7 +594,6 @@ __git_porcelain_commands ()
>  	done
>  }
>  __git_porcelain_commandlist=
> -__git_porcelain_commandlist="$(__git_porcelain_commands 2>/dev/null)"
>  
>  __git_aliases ()
>  {
> -- 
> 1.6.5.rc2.17.gdbc1b
> 

-- 
Shawn.
