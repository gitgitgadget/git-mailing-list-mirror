From: David Kastrup <dak@gnu.org>
Subject: Re: Can I have this, pretty please?
Date: Mon, 13 Aug 2007 07:49:11 +0200
Message-ID: <85wsw03rxk.fsf@lola.goethe.zz>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org>
	<854pj4o8k5.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121246020.30176@woody.linux-foundation.org>
	<18111.42072.605823.932110@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 07:49:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKSnz-0001ZN-5Y
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 07:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbXHMFtP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 01:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461AbXHMFtO
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 01:49:14 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:46021 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750814AbXHMFtO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Aug 2007 01:49:14 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 78AC730340C;
	Mon, 13 Aug 2007 07:49:12 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 6195D28EE24;
	Mon, 13 Aug 2007 07:49:12 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-055-003.pools.arcor-ip.net [84.61.55.3])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 2F2FA36E869;
	Mon, 13 Aug 2007 07:49:12 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id C88A31C3C79D; Mon, 13 Aug 2007 07:49:11 +0200 (CEST)
In-Reply-To: <18111.42072.605823.932110@cargo.ozlabs.ibm.com> (Paul Mackerras's message of "Mon\, 13 Aug 2007 10\:22\:48 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55744>

Paul Mackerras <paulus@samba.org> writes:

> Linus Torvalds writes:
>
>> Well, gitk has certainly had performance problems in the past, they've 
>> been fixable. I think this should just be fixed too. And if the rev-list 
>> is fast enough, then the gitk fix may well be to just not compute the 
>> *whole* history - ie the solution may be as simple as stopping the 
>> background job that does all the graph calculations when it is (pick a 
>> point at random) something like a thousand commits into the graph, and the 
>> user hasn't scrolled down..
>
> I have made a "dev" branch in the gitk.git repository that has some
> tweaks to the graph layout algorithm which change the appearance a
> bit; specifically it doesn't continue the graph lines downwards until
> it has to terminate them with an arrow because the graph is getting
> too wide.  Instead, it always terminates them if they are going to be
> longer than a certain length (about 100 rows).

How about terminating them when they are going off-screen?  If you
worry about reformatting when scrolling, you can terminate them if
there will be no change for at least one screen more.

More importantly: you can do your layout without having to look at
more than two screen's worth of commit data.

> Also I made some changes to reduce the incidence of two lines having
> a corner at the same point, for visual clarity.
>
> The point of terminating the graph lines early is that it means gitk
> won't have to lay out the whole graph, just the visible bits and a
> limited number of rows around that.

Ok, that was what you were already thinking.

> So I'm interested to know if people think it looks OK visually.  (I
> think it's actually better, myself.)

I'd think so, too, but will be able to check only later this days.

> The other thing that takes time is reading in the topology for the
> previous/next tag computations.

If you can move that out of the busy loop and do it in the
background...

> I did a patch that wrote out the topology to a cache file but I ran
> into some problems where the cache includes commits that have gone
> away since the cache was created.

I think it should be possible to come up with a data structure that
swallows less memory than the current one.  All the info you need are
the SHA1s and their relations: the rest can be asked from git while
one is scrolling, with a LRU buffer of a few hundred commits for
speed.

> Would it be possible to make git rev-list ignore commits that don't
> exist if they have a "^" in front of them, i.e. where we're asking
> for them to be excluded anyway?  If we can do that (or something
> equivalent) then I can make the cache work reliably.  It does speed
> up gitk enormously, and the cache file is only about 3MB for the
> kernel tree, so it seems well worth while.

Cough, cough.  If the cache file is only about 3MB, why wouldn't you
be able to keep it in memory?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
