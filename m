From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix race and deadlock when sending pack
Date: Mon, 19 Dec 2005 01:02:53 -0800
Message-ID: <7vvexlihmq.fsf@assigned-by-dhcp.cox.net>
References: <43A628F6.1060807@serice.net>
	<Pine.LNX.4.64.0512190130450.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Serice <paul@serice.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 10:05:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoGv6-0000GK-3f
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 10:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVLSJC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 04:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVLSJC4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 04:02:56 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:32719 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932206AbVLSJCz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 04:02:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051219090126.DVBX17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Dec 2005 04:01:26 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0512190130450.25300@iabervon.org> (Daniel
	Barkalow's message of "Mon, 19 Dec 2005 01:49:44 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13818>

Daniel Barkalow <barkalow@iabervon.org> writes:

> ... I don't think that it's actually a 
> good idea to have output to stdout from hooks go to git-send-pack's 
> stdout, since we may want to have git-send-pack report some sort of 
> information of its own to stdout,...

I admit that I haven't thought things through yet, but I do not
offhand think of an argument against Paul's patch (a scenario
that may be broken by the patch, that is), so I am inclined to
take it, perhaps after hearing about the cpfd() thing I
mentioned in the previous response to Paul.

It is conceivable that we may want to later extend the protocol
so that the receiver can tell the sender the result of what
happened to each of the ref-update request.  Right now, the
sender refuses to listen to what receiver says after it learns
the current object names, but after pack transfer finishes and
receiver decides what to do with each ref update request, we
might want to add status, like this:

	# Tell the pusher what commits we have and what their names are
	R: SHA1 name
	R: ...
	R: SHA1 name
	R: # flush -- it's your turn
	# Tell the puller what the pusher wants to happen
	S: old-SHA1 new-SHA1 name
	S: old-SHA1 new-SHA1 name
	S: ...
	S: # flush -- done with the list
	S: XXXXXXX --- packfile contents.
	# current protocol exchange ends here, but we could add...

        # ... what happened to each ref-update request.
	R: name OK
        R: name FAIL
        R: ...

If we do something like this, we might want to say why things
failed on "FAIL" line, and the output from hooks/update that
prevented the ref-update would probably belong there.
