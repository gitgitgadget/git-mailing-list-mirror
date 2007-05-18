From: Junio C Hamano <junkio@cox.net>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 10:00:21 -0700
Message-ID: <7vejle6p96.fsf@assigned-by-dhcp.cox.net>
References: <200705170539.11402.andyparkins@gmail.com>
	<200705180141.06862.Josef.Weidendorfer@gmx.de>
	<200705180857.18182.andyparkins@gmail.com>
	<200705181043.09203.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Nicolas Pitre <nico@cam.org>,
	Steven Grimm <koreth@midwinter.com>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 18 19:00:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp5ow-0004kv-Ee
	for gcvg-git@gmane.org; Fri, 18 May 2007 19:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894AbXERRA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 13:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756990AbXERRA0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 13:00:26 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42844 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894AbXERRAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 13:00:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070518170023.WJK6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 18 May 2007 13:00:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0h0M1X00H1kojtg0000000; Fri, 18 May 2007 13:00:22 -0400
In-Reply-To: <200705181043.09203.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Fri, 18 May 2007 10:43:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47621>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Friday 18 May 2007, Andy Parkins wrote:
>> Bear in mind that what you're suggesting is no different in implementation 
>> >from what Junio is suggesting but with one difference: in Junio's option 
>> the "identifier" will act as a default URL if no override is found.
>
> Yes; actually, its exactly the same aside from the name used in .gitmodules
> for it, as I proposed a default URL which is derived from the suproject identifier
> if no config entry is found.
>
>> > Again, we could have a default URL in the absence of this config entry
>> > which is relative to the URL of the superproject, and which allows for the
>> > superproject repository to act as proxy.
>> 
>> This is why Junio's option of URL=Key is better.

There is one thing that three-level thing Steven Grimm suggested
solves cleaner that my strawman would not.

If the superproject is about building a live-cd that hosts two
different systems, one BSD and the other Linux, you would have:

	kernel-bsd/ subproject pointing at http://some.bsd.org/
        kernel-linux/ pointing at http://www.kernel.org/kernel/

Now suppose kernel.org people forgot to renew the domain
registration and BSD people are quick to react, takes over the
nice "kernel.org" domain, and now the latter URL becomes a site
about the BSD kernel---what happens? ;-) URL=Key scheme uses the
URL as the key so newer kernel-bsd/ subproject may be pointed at
by http://www.kernel.org/kernel/ in the superproject after such
a transition.  Linux kernel wouldn't cease to be served, so
in your .git/config you will a map to tell git to fetch from the
new location http://www.linux-kernel.org/kernel, but what key
would you use?  Using http://www.kernel.org/kernel/ would not be
correct as it would work only for older parts of the history.
Newer part of the history would want to map the same URL (=Key)
to http://www.kernel.org/kernel which is now hosting the BSD
kernel.

In short, you would need to be able to express the "intent" in
the .gitmodules and say "I am talking about the Linux kernel
with this entry", and if the same URL used for that purpose is
ever retargetted to house something different that is also used
in your superproject, URL=Key scheme is screwed.

Also I would be lying if I said I do not like the three-level
thing --- that was one of the options I considered before the
URL=Key thing.  Steven's three-level thing does not have the
above problem (but there is one thing you need to be careful
about, which I'll mention at the end of this discussion).

> It all depends on how we construct the default URL out of the subproject
> identifier. Options:
> (1) do not try to construct a default URL at all. Error out without a config
> (2) use a configurable rewriting scheme like s/(.*)/git://host/\1/
> (3) automatically detect a senseful rewriting scheme
>
> Let's start with (1). We can invent convenient default schemes later on.

My preference is to stay at (1), and even if we are to do the
later steps, do it _always_ with confirmation from the user.

Fetching from a new URL (not just "different from what is
defined in .gitmodules") is a major deal from security point of
view (you should not fetch from stranger you do not trust).

There is one thing that I sense was misunderstood by some people
about my original strawman.  Entries in .git/config are _not_
used as an override.  They _are_ the only thing that are used.

Let's forget the above "BSD takes over kernel.org" example,
which was a tongue-in-cheek, and go back to the original
appliance release #1 and #2 uses kernel 2.4 and 2.6 example.

When you see this in .gitmodule:

 	[subproject "kernel/"]
         	URL = git://git.kernel.org/pub/linux-2.4.git
 
you can be in three states:

 (1) You haven't known about this subproject's URL.

 (2) You have already known about this subproject, and you
     earlier decided not to clone it nor check it out (i.e. in
     your working tree, kernel/ subdirectory is left empty).
     By default, you do not want to be bothered by this
     subproject.

 (3) You have known about this subproject, and you earlier
     decided that you are interested in it.  You have a
     repository and working tree that represents the subproject
     checked out in your kernel/ subdirectory.  By default, you
     want to keep track of this subproject.

Obviously in the initial-clone case you can only be in state
(1).  After the initial clone, if the upstream changed the
kernel/ binding to point at 2.6 kernel tree, you are also in the
same state (1).

In these cases, since the upstream clearly states that they are
now talking about a project unknown to you so far, or talking
about a different project (it could be just a new location for
the same thing, the case Steven's three-level thing can help you
to differenciate with this), I DO NOT want git to automatically
say "Ok, that's the new location" and blindly start following.

An unattended pull (actually, the checkout step after a pull)
SHOULD error out.

An interactive case should give an easy way for the user to
express his preference: (a) I do not care about this subproject,
(b) I do want to have this cloned and checked out, and the
suggested URL in .gitmodules would work fine for me, or (c) I do
want to have this, but I want to use this other URL because I
have a local mirror already.

I wrote in my original strawman to have these two entries in the
.git/config file:

 	[subproject "git://git.kernel.org/pub/linux-2.4.git"]
         	URL = http://www.kernel.org/pub/linux-2.4.git
 
The example mapped the URL=Key to a different URL, which gave a
false impression that I was only talking about override, but
that was my fault.  My intention was to use the _presense_ of
subproject.$URL section in .git/config as a way to detect state
(1), so when the user says "I do want to follow this subproject
and the .gitmodules URL is Ok" (iow, choice (b) above), you
would have an identical "mapping" there:

 	[subproject "git://git.kernel.org/pub/linux-2.4.git"]
         	URL = git://git.kernel.org/pub/linux-2.4.git

That's not an "override".  Lack of these two lines does not mean
you will blindly follow kernel/ subproject using the URL
recorded in .gitmodules file; it means you haven't decided what
to do about the kernel/ subproject yet.

If the user wants to say "I am not interested" (iow, choice (a)
above), we would not have URL section, but explicit variable to
say "I am not interested" there, like this:

 	[subproject "git://git.kernel.org/pub/linux-2.4.git"]
         	ignored

Then the presense of this section tells us that we are not in
state (1) about this subproject.

The above can easily be rewritten to use Steven's three-level
scheme, which I tend to think would work better.  But if we were
to do that, I think the .git/config section should give you a
way to differentiate not just known/unknown subprojects but also
a way to differentiate known/unknown URLs.

IOW, .gitmodules in three-level scheme might say:

	[subproject "kernel/"]
        	name = linux-2.6
                URL = git://git.kernel.org/pub/linux-2.6.git

and your .git/config would say:

	[subproject "linux-2.6"]
                URL = http://www.kernel.org/pub/linux-2.6.git
                seen = git://git.kernel.org/pub/linux-2.6.git

so that when the upstream .gitmodules changed the suggested URL
to "git://git.or.cz/pub/linux-2.6.git", the UI can say:

	The project uses "linux-2.6" project at kernel/
	subdirectory as subproject, we already know that you are
	interested in tracking it, that you have been tracking
	it with http://www.kernel.org/pub/linux-2.6.git URL.
	The upstream suggests a new URL you haven't seen, which is
	"git://git.or.cz/pub/linux-2.6.git".  Do you want to
	adjust the URL to follow this subproject?

The user may say yes and tell git to use http:// instead, in
which case the section in .git/config would become:

	[subproject "linux-2.6"]
                URL = http://git.or.cz/pub/linux-2.6.git
                seen = git://git.kernel.org/pub/linux-2.6.git
		seen = git://git.or.cz/pub/linux-2.6.git

After that, if the upstream wags the entry .gitmodules back to
point at git.kernel.org/, you already know about that repository
and the UI does not have to ask you what to do about it.  That's
made possible by using URL=Key in my strawman, but needs to be
done by this extra 'seen' multi-value variables in the three-level
scheme.
