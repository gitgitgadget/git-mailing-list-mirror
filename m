From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: rev-list/tree committer/author information.
Date: Mon, 16 May 2005 18:35:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505161747290.30848-100000@iabervon.org>
References: <7vekc6onzc.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 17 00:42:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXoH7-0007fW-En
	for gcvg-git@gmane.org; Tue, 17 May 2005 00:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVEPWks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 18:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVEPWht
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 18:37:49 -0400
Received: from iabervon.org ([66.92.72.58]:22535 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261965AbVEPWgJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 18:36:09 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DXoBB-0006Mf-00; Mon, 16 May 2005 18:35:17 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vekc6onzc.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 16 May 2005, Junio C Hamano wrote:

> The only reason why I did it that way was because the strategy
> taken by "struct object" derivatives seemed to pick up bare
> absolute minimum to support actual callers that have immediate
> need for information stored in structural fields, as opposed to
> designing for helping yet to be written callers by adding fields
> to hold information of "having this might also help somebody in
> the future" type.  And the author and committer names are in the
> structured fields while signed-off-by and others are not.  Also
> when author / committer name strings are intern'ed like the way
> I did, the memory consumption even for a long sequence of
> commits are kept reasonably low.  However,...

I think if we had a good reason to make author and committer structured,
there must be some reason we'll want them parsed out eventually, although
we may not have reached the point at which it makes sense to do it.

> The above implies to keep the unpacked raw data as a whole to be
> accessible to the callers for at least commit objects and if we
> go that route I think it would make more sense to do that
> uniformly for everything (probably except for pure "blob"
> objects for size concerns but we might as well do them while we
> are at it).  On the other hand, the current lifetime rules being
> what it is, that strategy may introduce memory consumption
> problems when working on a huge project.

Perhaps have a struct object field for the unpacked data, have it filled
by a unpack_object(struct object *) function, have the parse functions use
it if it's filled, and have a function to free it (and NULL the field).

So, if you want the actual contents, you'd call
unpack_object(&commit->obj) before parse_commit(commit), and
close_object(&commit_obj) when you're done, and the parse wouldn't
duplicate the work. The lifetime rules only really care that the return
value from lookup_*() stays the same for the duration of the program, not
that the fields in it don't get cleared (aside from the flags and the
hash).

This could be useful even for blobs; I'm working on a program to do
diff/merge on commits and everything under them (taking advantage of all
available information if the fast path leads to a conflict); it would be
nice not to have to go through the filesystem with the blob data.

	-Daniel
*This .sig left intentionally blank*

