From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Sat, 04 Mar 2006 21:44:47 -0800
Message-ID: <7vfylxigxc.fsf@assigned-by-dhcp.cox.net>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603042058250.13139@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 06:45:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFm3L-0003wt-EW
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 06:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbWCEFot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 00:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWCEFot
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 00:44:49 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:26276 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751845AbWCEFos (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 00:44:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305054454.DVUK25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 00:44:54 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603042058250.13139@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 4 Mar 2006 20:58:41 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17205>

Linus Torvalds <torvalds@osdl.org> writes:

> I'm not sure this is worth it, but it looks obvious enough. Somebody with 
> gitweb somewhere should probably check if it still even wants this.

I just pulled and it's still v264 (Jan 17 2006).  It does it in
one sub (git_read_commit) to read a single commit and the sub is
called from almost everywhere, so it would help.

Having said that...

> diff --git a/revision.c b/revision.c
> index a3df810..33a5f20 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -696,6 +696,18 @@ struct commit *get_revision(struct rev_i
>  		break;
>  	case 0:
>  		return NULL;
> +
> +	/* Special case to avoid unnecessary parent checking */
> +	case 1:
> +		if (!revs->limited &&
> +		    !revs->no_merges &&
> +		    !revs->paths &&
> +		    revs->min_age == -1 &&
> +		    revs->max_age == -1) {
> +		    	revs->max_count = 0;
> +			commit->object.flags |= SHOWN;
> +			return commit;
> +		}

At this point commit is revs->commits->item.  It cannot be
UNINTERESTING because you make it sure with !revs->limited and
friends, but I wonder if it can be SHOWN already for some
reason, in which case returning it is wrong.

Unlike the earlier special case in rev-list, this special case
kicks in for the last iteration of repeated calls to
get_revision() (e.g. third iteration of "rev-list -3")...
