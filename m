From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Make object contents optionally available
Date: Tue, 17 May 2005 13:55:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505171325150.30848-100000@iabervon.org>
References: <7vfywlhj3h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue May 17 19:58:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY6It-0003J3-A8
	for gcvg-git@gmane.org; Tue, 17 May 2005 19:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVEQR4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 13:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEQR4p
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 13:56:45 -0400
Received: from iabervon.org ([66.92.72.58]:44551 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261815AbVEQR4a (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 13:56:30 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DY6IK-0000ac-00; Tue, 17 May 2005 13:55:52 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfywlhj3h.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 May 2005, Junio C Hamano wrote:

> >>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> DB> I'm already going to add a per-type global to have the parse functions
> DB> also unpack the object contents user-visibly, for the case that Junio
> DB> pointed out. (Making it: parse_* doesn't change whether the contents are
> DB> unpacked, unless you tell it to unpack objects.)
> 
> That sounds better than the patch you sent last night, but are
> we sure that callers would be satisfied if you just make some
> _types_ more special than others?

It wouldn't make any types special; the caller can just control each type
individually, so that code that only cares about commits could get commits
unpacked, but not get trees unpacked even if it has them parsed.

> Parse functions need to unpack anyway, so it might make more
> sense to add an optional callback just after where unpacking
> happens to ask the main program if it wants the unpacked raw
> data to be kept.

I think that a callback is a bit excessive, and it wouldn't get the useful
information anyway, which is really: "what is supposed to happen to this
object, which you haven't seen before, after it's parsed?" 

> So you would do something like:
>     struct object *parse_object(unsigned char *sha1)
>     {

That reminds me that I should also fix the parse_object path, which can
now be simplified substantially.

Note that parse_object calls parse_<type>, rather than the reverse,
because parse_<type> can skip the step of figuring out what routine to
use. The parse_<type> version also has lookup_<type>, which can return the
struct which will be filled out later; this isn't possible for an object
of unknown type, since it can't tell what struct type to allocate.

> Another possibility is not to make double unpacking too costly
> by having an LRU of unpack_sha1_file(), but I am not sure how
> effective that would be.

It would work for pop_most_recent_commit, which parses the thing it's
about to return, but I don't think it's a particularly good solution in
general.

	-Daniel
*This .sig left intentionally blank*

