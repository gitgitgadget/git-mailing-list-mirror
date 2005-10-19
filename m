From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not send "want" lines for complete objects
Date: Wed, 19 Oct 2005 16:09:37 -0700
Message-ID: <7vzmp5xfwu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510200004290.7689@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 01:11:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESN4B-0000Wr-3E
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 01:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVJSXJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 19:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbVJSXJj
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 19:09:39 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:7657 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750968AbVJSXJi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 19:09:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019230913.IMGE29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 19:09:13 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10323>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Also, git-fetch-pack does not have to ask for descendants of remote refs 
> which are complete (for now, git-rev-list is told to ignore only the first 
> parent).

I should interpret what you said with s/descendant/ancestor/
applied, I think.  I would like to make sure I understand what
you are doing here.

> +		if (has_sha1_file(remote)
> +				&& parse_object(remote)->flags & COMPLETE) {
> +			if (rev_command_len + 44 < sizeof(rev_command)) {
> +				snprintf(rev_command + rev_command_len, 44,
> +					" ^%s^", sha1_to_hex(remote));
> +				rev_command_len += 43;
> +			}

This rev-list command is to generate the list of "have", and we
learned that the other side says she has remote -- we choose not
to tell her that we have ancestors of it, but we do tell her
about the remote head itself.

Let's draw a single strand of pearl case to illustrate.  You
have a commit chain A->B->C->D, and the other end says she has
C.  At this point, telling her that you have C is enough, and by
not telling her about A and B, you would save her from depreting
MAX_HAVE slots.  Of course, if the other end has D as another
head, then the above logic would give "^D^" to rev-list as well,
telling it not to tell her about C, but that is what we want --
because she already knows you have C too when you tell her that
you have D.  I think I like this optimization.

One thing that might help, when we are telling the other end
about what we have, is an output ordering option to get-rev-list
that shows not in chronological order, but in the order of
distance from the tip.  That may give the other end a better
chance to find the latest (in commit order) common commit in
each branch without running out is MAX_HAS buffer.

> 	NOTE: I'd rather have git-rev-list circumvented, so that 
> 	descendants of ack'ed objects are not sent via "have" lines.

I think since we do the traversal ourselves this may start to
make more sense.
