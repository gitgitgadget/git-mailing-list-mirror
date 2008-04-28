From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Hmm.. Try harder to find the common commits in git protocol?
Date: Mon, 28 Apr 2008 17:27:22 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804281716310.19665@iabervon.org>
References: <alpine.LFD.1.10.0804280936080.3119@woody.linux-foundation.org> <alpine.LFD.1.10.0804281310320.3119@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:28:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqatT-0001FZ-OK
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763222AbYD1V11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934594AbYD1V11
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:27:27 -0400
Received: from iabervon.org ([66.92.72.58]:49385 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756454AbYD1V1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 17:27:25 -0400
Received: (qmail 15068 invoked by uid 1000); 28 Apr 2008 21:27:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Apr 2008 21:27:22 -0000
In-Reply-To: <alpine.LFD.1.10.0804281310320.3119@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80620>

On Mon, 28 Apr 2008, Linus Torvalds wrote:

> Hmm. Trying to debug this, I find the behavior hard to reproduce. But I 
> *also* find that there seems to be something wrong in builtin-fetch-pack.
> 
> Look at commit f3ec549481827b10609a43bf504517a0e8063a12 ("fetch-pack: 
> check parse_commit/object results"), and tell me that the "parents" 
> handling isn't totally broken. In particular, get_rev() does:
> 
> 	struct commit_list *parents = NULL;
> 	..
> 	commit = rev_list->item;
> 	if (!(commit->object.parsed))
> 		if (!parse_commit(commit))
> 			parents = commit->parents;
> 	..
> 
> which means that "parents" will never even get set if the commit was 
> already parsed!
> 
> And whether it got parsed or not depends on how we got there etc, so this 
> may explain the occasionally odd behaviour I saw.
> 
> Basically, I don't think that code can be right, and with a cut-down repo, 
> I get "no commits in common" due to this, because the whole "get_rev()" 
> thing doesn't work.
> 
> This patch should fix that problem, but I wonder why it got rewritten that 
> way in the first place?

Looks like f3ec549481827b10609a43bf504517a0e8063a12 was trying to do 
something clever when parse_commit returns non-zero, and accidentally did 
the same thing with the case where it isn't needed.

> 
> 			Linus
> 
> ---
>  builtin-fetch-pack.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
> index 65350ca..c97a427 100644
> --- a/builtin-fetch-pack.c
> +++ b/builtin-fetch-pack.c
> @@ -117,15 +117,15 @@ static const unsigned char* get_rev(void)
>  
>  	while (commit == NULL) {
>  		unsigned int mark;
> -		struct commit_list *parents = NULL;
> +		struct commit_list *parents;
>  
>  		if (rev_list == NULL || non_common_revs == 0)
>  			return NULL;
>  
>  		commit = rev_list->item;
> -		if (!(commit->object.parsed))
> -			if (!parse_commit(commit))
> -				parents = commit->parents;
> +		if (!commit->object.parsed)
> +			parse_commit(commit);
> +		parents = commit->parents;

I think it's supposed to be:

		if (commit->object.parsed ||
		    !parse_commit(commit)))
			parents = commit->parents;

Just looking at what the other changes in the same commit do.

	-Daniel
*This .sig left intentionally blank*
