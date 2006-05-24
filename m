From: Junio C Hamano <junkio@cox.net>
Subject: Re: Slow fetches of tags
Date: Wed, 24 May 2006 11:08:26 -0700
Message-ID: <7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
References: <20060524131022.GA11449@linux-mips.org>
	<Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605240947580.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 24 20:08:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fixma-00055r-RC
	for gcvg-git@gmane.org; Wed, 24 May 2006 20:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbWEXSIa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 14:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWEXSI3
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 14:08:29 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:50877 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932757AbWEXSI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 14:08:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524180827.SSBL27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 14:08:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 24 May 2006 10:21:41 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20696>

Linus Torvalds <torvalds@osdl.org> writes:

> So the problem may be that we basically send a totally unnecessary list of 
> all the objects we have, when the other end really only cares about the 
> fact that we have the objects that the tags point to. Which we know we do, 
> but we didn't say so, because "git-fetch" didn't really mark them that 
> way.

I think this speculation is correct.  We should be able to do
better.

> I almost suspect that we need to have a syntax where-by the local 
> fetch-list ends up doing
>
> 	"$tagname:$tagname:$sha1wehave"
>
> as the argument to fetch-pack, and then fetch-pack would be modified to 
> send those "$sha1wehave" objects early as "have" objects.

But this logic has to be a bit more involved.

A "have" object is not just has_sha1_file(), but it needs to be
reachable from one of our tips we have already verified as
complete, so either the caller of fetch-pack does the
verification and give a verified $sha1wehave, or fetch-pack
takes $sha1weseemtohave and does its own verification and then
send it as one of the "have" objects (the issue is the same as
the one in my previous message to Eric W. Biederman -- we trust
only refs not just having a single object).

It might be useful to have a helper script you can give N object
names and M refs (and/or --all flag to mean "all of the refs"),
which returns the ones that are reachable from the given refs.
It would be even more useful if it were a helper function, but
given that the computation would involve walking the ancestry
chain, I suspect it would have a bad interaction with any user
of such a helper function that wants to do its own ancestry
walking, because many of them seem to assume an object that has
already been parsed are the ones they parsed for their own
purpose.
