From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -p: seed first commit in case it's before the
 merge bases.
Date: Sun, 18 Jan 2009 00:51:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901180041540.3586@pacific.mpi-cbg.de>
References: <496F6AC3.7050704@drmicha.warpmail.net> <cover.1232233454.git.stephen@exigencecorp.com> <ac1a4533de095f916dd68029793c8ee6eb02d200.1232233454.git.stephen@exigencecorp.com>
 <a524993b13ee586cf0e8fbd3b6459ccd6767c6d8.1232233454.git.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 00:52:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOKxv-0008HT-Jr
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 00:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbZAQXvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 18:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbZAQXvL
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 18:51:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:52869 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751428AbZAQXvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 18:51:09 -0500
Received: (qmail invoked by alias); 17 Jan 2009 23:51:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 18 Jan 2009 00:51:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18g63QEBiggR0FBEBqPIMv+z3ZL5zMIhIqcOBlfoM
	VY8LO9wdID7yzj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <a524993b13ee586cf0e8fbd3b6459ccd6767c6d8.1232233454.git.stephen@exigencecorp.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106114>

Hi,

On Sat, 17 Jan 2009, Stephen Haberman wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index c8b0861..e800e07 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -604,11 +604,18 @@ first and then run 'git rebase --continue' again."
>  				echo $ONTO > "$REWRITTEN"/$c ||
>  					die "Could not init rewritten commits"
>  			done
> +			# Along with the merge bases, look at the first commit's
> +			# parent (which may be before the merge base) and mark it
> +			# as rewritten to ONTO
> +			FIRST="$(git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1)"
> +			for p in $(git rev-list --parents -1 $FIRST | cut -d' ' -f2)
> +			do
> +				echo $ONTO > "$REWRITTEN/$p"
> +			done

AFAICT this is wrong.  You have no guarantee whatsoever that the output of

	$ git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1

has any parents at all.  Take for example a coolest-merge-ever, i.e. a 
merge of an independent project.

Instead, what you _actually_ are looking for are the boundary objects of 
$UPSTREAM..$HEAD, which would be easy to get at.

However, I have a strong feeling that just piling onto the current code 
will not fix the underlying issues.

Ciao,
Dscho
