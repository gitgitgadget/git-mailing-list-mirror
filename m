From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] Run garbage collection with loose object pruning
 after svn dcommit
Date: Fri, 05 Oct 2007 10:04:02 +0200
Message-ID: <4705EFF2.9090506@op5.se>
References: <20071005001528.GA13029@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 10:04:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdiAW-00029d-Sb
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 10:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbXJEIEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 04:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbXJEIEK
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 04:04:10 -0400
Received: from mail.op5.se ([193.201.96.20]:55940 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530AbXJEIEG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 04:04:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 01D89194472;
	Fri,  5 Oct 2007 10:04:05 +0200 (CEST)
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4dyed8PQiUpV; Fri,  5 Oct 2007 10:04:04 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 048D6194466;
	Fri,  5 Oct 2007 10:04:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071005001528.GA13029@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60044>

Steven Grimm wrote:
> git-svn dcommit, by virtue of rewriting history to insert svn revision IDs,
> leaves old commits dangling.  Since dcommit is already unsafe to run
> concurrently with other git commands, no additional risk is introduced
> by making it prune those old objects as needed.
> 
> Signed-off-by: Steven Grimm <koreth@midwinter.com>
> ---
> 
> This is in response to a colleague who complained that, after I
> installed the latest git release, he was getting lots of "too many
> unreachable loose objects" errors from the new "git gc --auto" run.
> Those objects turned out to be dangling commits from a year's worth of
> git-svn usage, since every git-svn commit will abandon at least one
> existing commit in order to rewrite it with the svn version data.
> 
>  git-svn.perl |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 777e436..be62ee1 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -441,6 +441,12 @@ sub cmd_dcommit {
>  			}
>  			command_noisy(@finish, $gs->refname);
>  			$last_rev = $cmt_rev;
> +
> +			# rebase will have made the just-committed revisions
> +			# unreachable; over time that can build up lots of
> +			# loose objects in the repo. prune is unsafe to run
> +			# concurrently but so is dcommit.
> +			command_noisy(qw/gc --auto --prune/);
>  		}
>  	}
>  }

I'd be surprised if this would ever prune anything, as git doesn't throw out
objects reachable by reflog (or, I assume, any of the objects reachable from
objects reachable from reflog).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
