From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 13:52:53 -0700
Message-ID: <7v4pm0r5ga.fsf@assigned-by-dhcp.cox.net>
References: <8c5c35580705250752k2021f02dv804d87da5c0d5da7@mail.gmail.com>
	<11801165433267-git-send-email-hjemli@gmail.com>
	<Pine.LNX.4.64.0705251924280.4648@racer.site>
	<7vodk8r97s.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580705251329u33ac1462m9db35cac0c37e3a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 22:53:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrgmT-0005Go-Va
	for gcvg-git@gmane.org; Fri, 25 May 2007 22:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbXEYUwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 16:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbXEYUwz
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 16:52:55 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:41043 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbXEYUwy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 16:52:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525205254.URSS19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 25 May 2007 16:52:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3Yst1X00T1kojtg0000000; Fri, 25 May 2007 16:52:54 -0400
In-Reply-To: <8c5c35580705251329u33ac1462m9db35cac0c37e3a9@mail.gmail.com>
	(Lars Hjemli's message of "Fri, 25 May 2007 22:29:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48413>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 5/25/07, Junio C Hamano <junkio@cox.net> wrote:
> ...
>> I really do not want that (mis)conception that .gitmodules
>> specify the default and .git/config the override.  I really
>> think we should use the .git/config as _the_ only authority to
>> get URL, but keyed with the three-level scheme, with URL in
>> .gitmodules used _solely_ as a hint when setting up the URL in
>> the .git/config file.
>>
>>         cf. $gmane/47502, 47548, 47621
>>
>
> I've read these articles, but I think much of the concerns about
> trusting the url supplied by upstream goes away when the submodule
> clone/checkout isn't an integrated part of the superproject
> clone/checkout. Besides, if you trust your upstream enough to clone
> their repository (the superproject), why wouldn't you trust the data
> (.gitmodules) in that very repository?

It's not about trusting.  You would need to support the mapping
for network connectivity reasons, and you would also need to
notice and reconfirm when the suggested URL in .gitmodules
changes (perhaps because the upstream relocated from sf.net to
repo.or.cz ;-), you would need something like what I described
in order to keep track of user preference for each submodule in
.git/config anyway.  If that "mapping" ends up to be ident
mapping for most people, that is fine.  At least by always doing
the three-level mapping we would not have any special case in
the code, and this is not the performance critical part of the
system.

I think the response to the case when upstream repository
relocates from the ".gitmodule for default, .git/config for
override" camp would be "you asked to override in .git/config,
so it is your job to notice the change in .gitmodules and adjust
your override URL".  That is a serious mistake in usability
point of view.  Repository relocation would (hopefully) seldom
happen, but when it does happen, things either would break
(which is easier to diagnose and manually fix up), or things
clone fine but we reach a wrong repository (which is harder to
notice, as "fetch" may succeed -- it just would not fetch the
right commit).  Being able to notice when upstream repository
relocates and to ask for confirmation when that happens would
eliminate a lot of confusion from that.

> Another possibility is simply doing the submodule clone/checkout by
> hand (i.e. do 'git clone preferred-url path', don't do 'git submodule
> init path').

But that is what this patch is trying to help the users, isn't
it?  It reduces the attractiveness of this new tool greatly if
you give up there.

>>When the name of the commit object in the
>> superproject tree and/or index is 0{40}, it would be a good
>> extension to use "whatever commit that happens to be at the tip
>> of this branch" taken from the .gitmodules file.
>
> I really can't imagine what kind of superproject would have such a
> setup. Why would this be needed?

"We would work with any working version of Linux 2.6 kernel"
would be a sensible thing to say, I would think.

It's purely optional, and as you seem to agree always detaching
HEAD is easier to explain, you do not need "module.$path.branch"
at all.  I just mentioned 0{40} as a possible use case for that
configuration variable.
