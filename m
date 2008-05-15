From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH] Make git add -u honor --dry-run
Date: Thu, 15 May 2008 20:46:45 +0200
Message-ID: <482C8515.6020303@isy.liu.se>
References: <1210868459-9511-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu May 15 20:47:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwiUT-0000wo-Hq
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 20:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbYEOSqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 14:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbYEOSqu
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 14:46:50 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:63392 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbYEOSqt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 14:46:49 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 4C7EC25A41;
	Thu, 15 May 2008 20:46:48 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 16558-05; Thu,  8 May 2008 07:37:09 +0200 (MEST)
Received: from [192.168.13.13] (85.8.6.119.static.se.wasadata.net [85.8.6.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 5332025A3B;
	Thu, 15 May 2008 20:46:47 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <1210868459-9511-1-git-send-email-vmiklos@frugalware.org>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82219>

On 2008-05-15 18:20, Miklos Vajna wrote:
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
> 
> On Thu, May 15, 2008 at 06:08:24PM +0200, Gustaf Hendeby <hendeby@isy.liu.se> wrote:
>> I'm not familiar enough with the code to see how to best fix it.
> 
> Something like this?

This fixes part of the problem.  Nothing gets written to the index now, 
however, I get no list of what files would have been added.  That is 
what I would have suspected.  Am I reading the docs incorrectly?

> 
>  builtin-add.c         |    3 ++-
>  t/t2200-add-update.sh |    7 +++++++
>  2 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-add.c b/builtin-add.c
> index 4a91e3e..222497d 100644
> --- a/builtin-add.c
> +++ b/builtin-add.c
> @@ -212,7 +212,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		if (read_cache() < 0)
>  			die("index file corrupt");
>  		pathspec = get_pathspec(prefix, argv);
> -		add_files_to_cache(verbose, prefix, pathspec);
> +		if(!show_only)
> +			add_files_to_cache(verbose, prefix, pathspec);
>  		goto finish;
>  	}
Since the other code path for show_only, does not end up in finish but 
returns 0 directly, I'm assuming the same could be done here (after 
printing the changed files) to save some cycles.

>  
> diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
> index b664341..13ad975 100755
> --- a/t/t2200-add-update.sh
> +++ b/t/t2200-add-update.sh
> @@ -88,6 +88,13 @@ test_expect_success 'replace a file with a symlink' '
>  
>  '
>  
> +test_expect_success 'add everything changed with --dry-run' '
> +
> +	git add -u --dry-run &&
> +	test -n "$(git diff-files)"
Don't you need to validate the output from git add -u --dry-run too?

/Gustaf

> +
> +'
> +
>  test_expect_success 'add everything changed' '
>  
>  	git add -u &&
