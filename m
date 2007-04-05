From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Thu, 5 Apr 2007 10:01:52 +0200
Message-ID: <200704051001.52592.chriscool@tuxfamily.org>
References: <20070327064957.34dad72a.chriscool@tuxfamily.org> <200703290702.47972.chriscool@tuxfamily.org> <7virck8txp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 09:53:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZMmx-0000pR-FN
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 09:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946056AbXDEHxo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 5 Apr 2007 03:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946057AbXDEHxo
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 03:53:44 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:54449 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946056AbXDEHxn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2007 03:53:43 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 475EDB94A2;
	Thu,  5 Apr 2007 09:53:42 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <7virck8txp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43805>

Le jeudi 29 mars 2007 08:06, Junio C Hamano a =E9crit :

[...]

> The thing is, the more you add policy to a building block, the
> less generally useful the building block becomes.  The reason I
> took "git bisect run" is because for the simplest use case, it
> can be used without writing a specialized "run script" (you can
> give "make test" to it, for example).  And more importantly, in
> the case of "run", there is not much policy involved.  It is a
> good command to have in a building block because what it does is
> purely to automate what the user would perform mechanically by
> hand anyway.  One thing I would want is to keep the bisect
> subcommands to the minimum, so that people can easily use it as
> a building block in their automation, without having to hunt
> through many workflow-specific subcommands that do not suit
> their particular needs.=20

I understand this.

> Catering to their particular needs are=20
> better handled in their scripts, including your "I have one
> known good commit, I do not know if the tip is good, and I want
> to dig down from the tip only when the tip is bad" case.

But I think this is not a specific need. Many people are doing nightly=20
builds and it's a good practice, so we should encourage them by making =
it=20
as easy as possible.

Perhaps a new git subcommand instead of a git bisect subcommand.

=46or a nightly build you want to do something like:

my_build_script || {
	git bisect start &&
	git bisect bad &&
	git bisect good good_rev &&
	git bisect run my_script
}

> If you want to add value to bisect, here are two I can think of,
> one almost trivial, and the other a bit harder.
>
> (1) One bad commit is fundamentally needed for bisect to run,
>     and if we beforehand know more good commits, we can narrow
>     the bisect space down without doing the whole tree checkout
>     every time we give good commits.  I think it may be a good
>     idea to have:
>
> 	git bisect start [$bad [$good1 $good2...]] [-- <paths>...]
>
>     as a short-hand for this command sequence:
>
> 	git bisect start
>         git bisect bad $bad
>         git bisect good $good1 $good2...
>
>     That would be a good script-shorterner, without limiting it to
>     any specific use scenario.
>
> (2) There is no technical reason to have a good commit for
>     bisect to run, other than you _often_ do not want the first
>     mid-point checkout before you give good ones to it.  But
>     sometimes, you may not know even if something _ever_ worked,
>     IOW, even the root commit might not be good.  In such a
>     case, being able to bisect having only one bad commit and no
>     good commit would be handy.  For this, bisect_next_check
>     needs to be tweaked.  Probably a transcript for such a
>     feature would go like this:
>
> 	$ git bisect start
>         $ git bisect bad HEAD
>         $ git bisect next ; echo $?
>         You need to give me at least one good and one bad revisions,
> 	with "git bisect good" and "git bisect bad".
> 	1
> 	$ git bisect next --without-good
> 	Bisecting: 4321 revisions left to test after this
> 	[deadcafedeadcafedeadcafedeadcafedeadcafe] an ancient commit
> 	$ git bisect bad
> 	Bisecting: 2152 revisions left to test after this
> 	[edeadcafedeadcafedeadcafedeadcafedeadcaf] a more ancient commit
