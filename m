From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] revision traversal: retire BOUNDARY_SHOW
Date: Tue, 6 Mar 2007 03:05:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703060253140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
 <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703060016020.13683@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk5xvw6mg.fsf@assigned-by-dhcp.cox.net> <7vzm6rurst.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 03:05:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOP3c-0007QU-3j
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 03:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965710AbXCFCFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 21:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965709AbXCFCFh
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 21:05:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:45732 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965702AbXCFCFg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 21:05:36 -0500
Received: (qmail invoked by alias); 06 Mar 2007 02:05:34 -0000
X-Provags-ID: V01U2FsdGVkX19HSwpzpXlHz78CLOCee+PacJ9mREbvbvdhJs81Zb
	Cqm2WgUeAZ9yfv
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vzm6rurst.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41527>

Hi,

On Mon, 5 Mar 2007, Junio C Hamano wrote:

> This removes the flag internally used by revision traversal to
> decide which commits are indeed boundaries and renames it to
> CHILD_SHOWN.  builtin-bundle uses the symbol for its
> verification, but I think the logic it uses it is wrong.  The
> flag is still useful but it is local to the git-bundle, so it is
> renamed to PREREQ_MARK.

The idea was to bail out of revision walking when that prerequisite was 
found, _even_ if it happened to be uninteresting.

Just marking the parents uninteresting unless they are prerequisites would 
be better, probably.

>  
>  	i = req_nr;
>  	while (i && (commit = get_revision(&revs)))
> -		if (commit->object.flags & BOUNDARY_SHOW)
> +		if (commit->object.flags & PREREQ_MARK)
>  			i--;

The above-mentioned idea, then would be: instead of just i--; do

		{
			struct commit_list *parent = commit->parents;
			i--;
			for (; parent; parent = parent->next)
				if (!(parent->item->object.flag & 
						PREREQ_MARK))
					parent->item->object.flag |=
						UNINTERESTING;
		}

This should help performance, as not all reachable commits are traversed 
any more.

>  
>  	for (i = 0; i < req_nr; i++)
> diff --git a/revision.c b/revision.c
> index 5d137ea..2d27ccf 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1285,17 +1285,21 @@ struct commit *get_revision(struct rev_info *revs)
>  			commit_list_insert(c, &l);
>  		revs->commits = l;
>  		revs->reverse = 0;
> +		c = NULL;

Why? It gets assigned here anyway:

>  	}
>  
>  	/*
>  	 * Now pick up what they want to give us
>  	 */
> -	c = get_revision_1(revs);
> +	if (!(c = get_revision_1(revs)))
> +		return NULL;


>  	while (0 < revs->skip_count) {
>  		revs->skip_count--;
>  		c = get_revision_1(revs);
>  		if (!c)
>  			break;
> +		/* Although we grabbed it, it is not shown. */
> +		c->object.flags &= ~SHOWN;

Wasn't --skip meant for something like gitweb, where you just want to skip 
the first <n> commits from the list, but do not want to change the list 
otherwise?

> @@ -1305,6 +1309,9 @@ struct commit *get_revision(struct rev_info *revs)
>  	case -1:
>  		break;
>  	case 0:
> +		/* Although we grabbed it, it is not shown. */
> +		if (c)
> +			c->object.flags &= ~SHOWN;
>  		c = NULL;

Is this really relevant in practice?

Ciao,
Dscho
