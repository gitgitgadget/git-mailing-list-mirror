From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not send "want" lines for complete objects
Date: Thu, 20 Oct 2005 04:04:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510200351260.26594@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510200004290.7689@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmp5xfwu.fsf@assigned-by-dhcp.cox.net> <7vwtk9vvhg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 04:05:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESPnI-00008G-Ak
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 04:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbVJTCEW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 22:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbVJTCEW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 22:04:22 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:10170 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751697AbVJTCEV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 22:04:21 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6FDD513F002; Thu, 20 Oct 2005 04:04:20 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5602E9EF16; Thu, 20 Oct 2005 04:04:20 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 409719EEC4; Thu, 20 Oct 2005 04:04:20 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1D4AE13F002; Thu, 20 Oct 2005 04:04:20 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtk9vvhg.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10338>

Hi,

On Wed, 19 Oct 2005, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Let's draw a single strand of pearl case to illustrate.  You
> > have a commit chain A->B->C->D, and the other end says she has
> > C.  At this point, telling her that you have C is enough, and by
> > not telling her about A and B, you would save her from depreting
> > MAX_HAVE slots.  Of course, if the other end has D as another
> > head, then the above logic would give "^D^" to rev-list as well,
> > telling it not to tell her about C, but that is what we want --
> > because she already knows you have C too when you tell her that
> > you have D.  I think I like this optimization.
> 
> This was subtly wrong.  ^D^ would barf if D is a tag that points
> at a non commit (refs/tags/v2.6.11-tree).  Also it would do a
> suboptimal thing for a merge commit, since it will not cull the
> second and later parents.

Right, I keep forgetting about tags. And again right, like I said, it is 
suboptimal but helps the common case.

> +		if (has_sha1_file(remote) &&
> +		    ((o = parse_object(remote)) != NULL) &&
> +		    (o->flags & COMPLETE) &&

Why not split it here, and do a separate block here:

> +		    ((commit = (struct commit *) deref_tag(o)) != NULL) &&
> +		    (commit->object.type = commit_type)) {
> +			struct commit_list *p = commit->parents;
> +			while (p && rev_command_len + 44 < sizeof(rev_command)) {
>  				snprintf(rev_command + rev_command_len, 44,
> -					" ^%s^", sha1_to_hex(remote));
> +					 " ^%s",
> +					 sha1_to_hex(p->item->object.sha1));
>  				rev_command_len += 43;
> +				p = p->next;
>  			}

And here I am at a loss: why only continue if p is empty? I mean, remote 
could be a tag, and still be complete, no?

> -
> -			continue;
> +			if (!p)
> +				continue;
>  		}
>  
>  		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
> 

If the git-rev-list call goes, this probably gets prettier. I'll try to 
come up with a patch.

Ciao,
Dscho
