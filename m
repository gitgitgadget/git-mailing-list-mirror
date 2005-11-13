From: Petr Baudis <pasky@suse.cz>
Subject: Re: Balanced packing strategy
Date: Sun, 13 Nov 2005 12:00:24 +0100
Message-ID: <20051113110024.GM30496@pasky.or.cz>
References: <1131800663.29461.11.camel@blade> <cae2e895f6598781f4f22b76e781684b@codefountain.com> <20051112135947.GC30496@pasky.or.cz> <b6abcb70496730705046934973221b93@codefountain.com> <7vveyxcm3p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Craig Schlenter <craig@codefountain.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 12:01:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbFb4-0002iU-OX
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 12:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVKMLA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 06:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVKMLA1
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 06:00:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:15320 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932448AbVKMLA0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 06:00:26 -0500
Received: (qmail 972 invoked by uid 2001); 13 Nov 2005 12:00:24 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vveyxcm3p.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11733>

Dear diary, on Sun, Nov 13, 2005 at 03:34:02AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Craig Schlenter <craig@codefountain.com> writes:
> 
> > Does the pack index file contain enough information to enable a client
> > to send http byte range requests to grab individual objects from a pack?
> > It does seem to store object offsets...
> 
> Yes, it is certainly doable; there is enough information.  I am
> not sure if it is worth the complexity, though.

I think we need either the balanced packing or this.

> Many objects are stored delitified, so your byte range requests
> would return delta and base object name.  After you read what
> was returned and find out the base object name, you would need
> to get it, which can be another delta against its base object.
> This would make tangling a delta chain would become a serialized
> sequence of requests.

Sort the objects topologically, then get everything from the old heads
on. Obviously, this will not work so well when we get multiple heads in
single pack, but either don't do that (would it be actually so bad if we
would create one pack per head?), or:

  (i) objects are topologically sorted
  (ii) objects introduced by a commit/tree are right after the commit or
       tree in the pack file
  (iii) index file contains parents list for each commit

This way, you can possibly run through the gaps, or if the gap is big
enough, restart the request. You still will miss objects introduced by
commits in different branches, but in case of trees you can slurp the
trees at once again, and pick the individual objects otherwise; while
doing this second pass, you can apply the gaps strategy again.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
