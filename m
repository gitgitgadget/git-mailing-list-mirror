X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 13:01:06 -0800
Message-ID: <7vbqn38831.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
	<7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>
	<20061118184345.GO7201@pasky.or.cz>
	<e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
	<7vac2oefuz.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
	<Pine.LNX.4.64.0611181706250.3692@woody.osdl.org>
	<e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com>
	<Pine.LNX.4.64.0611190945500.3692@woody.osdl.org>
	<e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
	<e5bfff550611191209s63982818vd3999b543e68e8df@mail.gmail.com>
	<Pine.LNX.4.64.0611191219350.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 21:01:17 +0000 (UTC)
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611191219350.3692@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 19 Nov 2006 12:36:46 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31863>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gltmr-0005pQ-Il for gcvg-git@gmane.org; Sun, 19 Nov
 2006 22:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933282AbWKSVBJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 16:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933283AbWKSVBJ
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 16:01:09 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37019 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S933282AbWKSVBI
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 16:01:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061119210107.TSNP7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Sun, 19
 Nov 2006 16:01:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ol0e1V00S1kojtg0000000; Sun, 19 Nov 2006
 16:00:39 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> So the optimizations that _can_ be done are:
>
>  - add dereference info to .git/packed-refs
>
>    This would allow us to simply not do the expensive object lookup for 
>    every single tag. We'd still have to do it for non-packed objects, of 
>    course, but the cost here tends to be that over time you might have 
>    hundreds of tags, and even if each tag only takes 0.02s to look up, 
>    you're going to be slow.
>
>  - avoid the references for "heads/" (which we know are supposed to be 
>    commits, and cannot be tags) and when not specifying "-d". This won't 
>    help your case very much, though. If you want "-d", you want it, and 
>    the _big_ number of refs tends to be in tags, not branches, anyway.
>
>  - using a filesystem wih nicer locality behaviour for directory entries 
>    and inodes. This can cut down costs of cold-cache case by a factor of 
>    two, but right now there are no good filesystems that do this (but see 
>    for example "spadfs" that Mikulas Patocka announced a few weeks ago on 
>    linux-kernel - it would seem to have the possibility of being better in 
>    this area. I looked at the code and it looked like it could become 
>    very reasonable, but I've not actually _tested_ it, soo...)
>
> Anyway, I think that if we really want to make "git show-refs" go fast 
> when things are cold in the cache, and with lots ot tags and "-d" (which 
> is a reasonable case to optimize for: it's probably exactly what we end up 
> doing both for gitweb _and_ for "git-send-pack"), we'd need to expand the 
> packed-refs file with the deref cache.
>
> Junio?

Yes; the "for discussion only" WIP patch from yesterday was
about the first point and half of the second point.

One downside about storing the peeled refs in .git/packed-refs
is that the code in the wild does not have safety guard against
them, so the version of show-ref from v1.4.4 recently released
will list tags/v2.6.19^{} as if it is a true tag and worse yet
it might even show tags/v2.6.19^{}^{} under -d option after the
repository's refs are packed in the new format.

But I think we can avoid that problem by using a format slightly
different from the WIP patch.  We can for example use two spaces
between SHA-1 and the name for them.  refs.c::parse_ref_line()
in existing code will say "oh, this line is nonsense" and skip
them, while the updated code can say "ok, this is a peeled ref",
since it has a seemingly incomplete "check for valid refname"
there that only checks "isspace(*line)".

Did you do this "if (isspace(*line)) return NULL" to have
extensibility later, I wonder...



