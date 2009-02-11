From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-filter-branch: Add more error-handling
Date: Wed, 11 Feb 2009 15:58:37 +0100
Message-ID: <4992E79D.10208@viscovery.net>
References: <1234361365-63711-1-git-send-email-git@randomhacks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Kidd <git@randomhacks.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 16:00:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXGZN-0002OG-7t
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 16:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbZBKO6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 09:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbZBKO6m
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 09:58:42 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50966 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbZBKO6l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 09:58:41 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LXGXs-0002EJ-U9; Wed, 11 Feb 2009 15:58:37 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A6B066EF; Wed, 11 Feb 2009 15:58:36 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1234361365-63711-1-git-send-email-git@randomhacks.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109422>

Eric Kidd schrieb:
> In particular, the following hunk may change the public UI to
> git-filter-branch, although I'm not sure whether the change is for
> better or for worse.  As I understand it, this hunk would allow
> $filter_commit to abort the rewriting process by returning a non-0 exit
> status:
> 
>  	@SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
> -		$(git write-tree) $parentstr < ../message > ../map/$commit
> +		$(git write-tree) $parentstr < ../message > ../map/$commit ||
> +			die "could not write rewritten commit"
>  done <../revs
> 
> I'd be happy to add a test case for what happens when $filter_commit
> returns a non-0 exit status.  Is the old behavior preferable?

I think it's OK to die if the commit filter fails.

But generally, I think it is not necessary to use 'die with error
message', a plain '|| exit' should be enough because an error will have
been reported already by the tool that failed.

> @@ -483,7 +486,7 @@ test -z "$ORIG_GIT_INDEX_FILE" || {
>  }
>  
>  if [ "$(is_bare_repository)" = false ]; then
> -	git read-tree -u -m HEAD
> +	git read-tree -u -m HEAD || die "Unable to checkout rewritten tree"

Here you shouldn't die. But unlike elsewhere, this case warrants an
explanation for the user:

	git read-tree -u -m HEAD ||
		echo >&2 "WARNING: The working directory is not up-to-date!"

>  fi
>  
>  exit $ret

-- Hannes
