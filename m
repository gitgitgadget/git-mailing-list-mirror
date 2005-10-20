From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not send "want" lines for complete objects
Date: Thu, 20 Oct 2005 03:51:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510200348410.26594@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510200004290.7689@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmp5xfwu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 03:52:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESPam-0003az-Ao
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 03:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbVJTBvU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 21:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbVJTBvU
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 21:51:20 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:41145 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751694AbVJTBvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 21:51:19 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7649A13EFFE; Thu, 20 Oct 2005 03:51:18 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5C4549EF0E; Thu, 20 Oct 2005 03:51:18 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4B28F9EEC4; Thu, 20 Oct 2005 03:51:18 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 26FE313EFFE; Thu, 20 Oct 2005 03:51:18 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmp5xfwu.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10337>

Hi,

On Wed, 19 Oct 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Also, git-fetch-pack does not have to ask for descendants of remote refs 
> > which are complete (for now, git-rev-list is told to ignore only the first 
> > parent).
> 
> I should interpret what you said with s/descendant/ancestor/
> applied, I think.  I would like to make sure I understand what
> you are doing here.

Sure. You are thinking along chronological lines. Okay.

> > +		if (has_sha1_file(remote)
> > +				&& parse_object(remote)->flags & COMPLETE) {
> > +			if (rev_command_len + 44 < sizeof(rev_command)) {
> > +				snprintf(rev_command + rev_command_len, 44,
> > +					" ^%s^", sha1_to_hex(remote));
> > +				rev_command_len += 43;
> > +			}
> 
> This rev-list command is to generate the list of "have", and we
> learned that the other side says she has remote -- we choose not
> to tell her that we have ancestors of it, but we do tell her
> about the remote head itself.
> 
> Let's draw a single strand of pearl case to illustrate.  You
> have a commit chain A->B->C->D, and the other end says she has
> C.  At this point, telling her that you have C is enough, and by
> not telling her about A and B, you would save her from depreting
> MAX_HAVE slots.  Of course, if the other end has D as another
> head, then the above logic would give "^D^" to rev-list as well,
> telling it not to tell her about C, but that is what we want --
> because she already knows you have C too when you tell her that
> you have D.  I think I like this optimization.
> 
> One thing that might help, when we are telling the other end
> about what we have, is an output ordering option to get-rev-list
> that shows not in chronological order, but in the order of
> distance from the tip.  That may give the other end a better
> chance to find the latest (in commit order) common commit in
> each branch without running out is MAX_HAS buffer.

That was my idea.

Ciao,
Dscho
