From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git cannot push to repository with too many tags/heads
Date: Tue, 21 Feb 2006 17:59:16 -0800
Message-ID: <7vwtfotaq3.fsf@assigned-by-dhcp.cox.net>
References: <1140547568.5509.21.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:59:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBjHq-0003WC-Gi
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 02:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWBVB7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 20:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161306AbWBVB7U
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 20:59:20 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:17571 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932532AbWBVB7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 20:59:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222015752.ZXHQ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Feb 2006 20:57:52 -0500
To: "Stephen C. Tweedie" <sct@redhat.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16584>

"Stephen C. Tweedie" <sct@redhat.com> writes:

> send_pack()
> then skips all other refs by doing a
>
> 		if (!ref->peer_ref)
> 			continue;
>
> Unfortunately, exec_rev_list() is missing this, and it tries to ask
> git-rev-list for the commit objects of *every* ref on the remote_refs
> list, even if they have been explicitly excluded by match_refs() and
> have no peer_ref.  So with this huge repository, I can't even push a
> single refspec without bumping into the limit of 900 refs.

IIRC, the distinction was deliberate.  send_pack() excludes
what did not match because it does not want to send them.
rev_list() adds what we know they have to "do not bother to
send" list to make the resulting pack smaller.  The time where
it matters most is when you are pushing a new branch head (or a
tag).

I think the exec_rev_list logic should be taught to first
include all the positive refs (i.e. the ones we are going to
send), and then as many the negative refs (i.e. the ones we know
they have), from newer to older, as they fit without triggering
"argument list too long".

Another, probably conceptually cleaner alternative might be to
allow rev-list to read from its stdin so that we do not have to
worry about the argument list issues.
