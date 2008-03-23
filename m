From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] git-rebase -i: New option to support rebase with
 merges
Date: Sun, 23 Mar 2008 23:41:11 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803232334130.4353@racer.site>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-4-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-698933871-1206312074=:4353"
Cc: git@vger.kernel.org, gitster@pobox.com, B.Steinbrink@gmx.de
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 23:42:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdYt8-0005Gq-GR
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 23:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbYCWWlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 18:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755929AbYCWWlM
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 18:41:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:34658 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754195AbYCWWlL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 18:41:11 -0400
Received: (qmail invoked by alias); 23 Mar 2008 22:41:09 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp051) with SMTP; 23 Mar 2008 23:41:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18geKEF6L0gNEorkbPjazPkIh6pGy43w8ofWexoQn
	a4qkWAmhKHx0U7
X-X-Sender: gene099@racer.site
In-Reply-To: <1206308562-31489-4-git-send-email-joerg@alea.gnuu.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77972>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-698933871-1206312074=:4353
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 23 Mar 2008, Jörg Sommer wrote:

> The option --preserve-merges does not allow to change the order of 
> commits or squash them. The new option --linear-history does support 
> this, but doing so it can only look at the commits reachable with 
> through the first parent of each merge.

Why do you call it "linear-history"?  That name is pretty ambiguous.  Why 
not calling it "--first-parents"?

> Joining merge commits with other commits leads to problems, because git
> merge fails with a dirty index (the case “COMMIT squash MERGE”) and
> squashing a merge leads to the lost of the parents (case “MERGE squash
> COMMIT”).

Please use the term "to squash" not "to join".  And say "to the loss" 
instead of "to the lost".

And I still think that it would be better to fix the bug that squashing 
merges fails.

> @@ -247,6 +248,13 @@ OPTIONS
>  	Instead of ignoring merges, try to recreate them.  This option
>  	only works in interactive mode.
>  
> +-l, \--linear-history::
> +	Use only commits of the branch they are not merged in, i.e.

s/they are/that are/

> +	follow only the first parent of a merge. Merges are part of this

s/first parent of a merge/first parents of the encountered merge commits/

> @@ -150,7 +152,18 @@ pick_one () {
>  		sha1=$(git rev-parse --short $sha1)
>  		output warn Fast forward to $sha1
>  	else
> -		output git cherry-pick "$@"
> +		if test t = "$LINEAR_HISTORY" &&
> +			other_parents="$(parents_of_commit $sha1 | cut -s -d' ' -f2-)" &&
> +			test -n "$other_parents"
> +		then
> +			if test a"$1" = a-n
> +			then
> +				merge_opt=--no-commit
> +			fi
> +			redo_merge $sha1 $no_commit $other_parents
> +		else
> +			output git cherry-pick "$@"
> +		fi

Now, that is funny.  In case of --preserve-merges, I would have expected 
you to touch pick_one_preserving_merges(), not pick_one().

I would find it highly illogical to try to redo merges _without_ -p.

And again, I have to stress that fixing -p for the cases you mentioned 
should be a higher priority than to introduce new options to work around 
the bugs.  Seems like I am repeating myself, but hopefully I don't have to 
do that many more times.

Ciao,
Dscho

--8323584-698933871-1206312074=:4353--
