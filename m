From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Mon, 25 Jun 2007 23:52:14 +0200
Message-ID: <878xa7u2gh.fsf@rho.meyering.net>
References: <87r6nzu666.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 23:52:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2wTr-0001sh-NG
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 23:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850AbXFYVwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 17:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755673AbXFYVwQ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 17:52:16 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:50100 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754894AbXFYVwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 17:52:16 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id EC2D6817B
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 23:52:14 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id D47463495B; Mon, 25 Jun 2007 23:52:14 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org> (Linus Torvalds's message of "Mon\, 25 Jun 2007 13\:59\:21 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50929>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 25 Jun 2007, Jim Meyering wrote:
>>
>> [this patch depends on the one I posted here:
>>  http://marc.info/?l=git&m=118280134031923&w=2 ]
>>
>> Without this patch, git-rev-list unnecessarily omits strerror(errno)
>> from its diagnostic, upon write failure:
>
> And this is a perfect example of what's wrong with the whole thing.
>
> Dammit, how many times do I need to say this:
>
>  - If you want reliable errors, don't use stdio!
>
> That fflush is there FOR A REASON. You removed it FOR A MUCH LESS
> IMPORTANT REASON!

Wow.  No need to curse and get into ALL_CAPS_MODE every time you
reply to me.  It does not advance your cause.

Remember: I'm trying to improve existing code here.
You should save some of your ire for the person who wrote that code.

> That fflush is there exactly because WE DO NOT WANT TO BUFFER the list of
> commits, because that thing is meant very much to be used for pipelines,
> and it's quite common that the receiving end is going to do something
> asynchronous with the result, and can - and does - want the results as
> soon as possible.

That's good to know.  I'm glad you pointed it out.  It would have been
nice to have a comment.  However, wouldn't it be better at least to check
for and report fflush failure?  fflush usually does a write, after all.
Most of the rest of the code is careful to diagnose write errors at
the source.  Why not here?

I've posted a revised patch.

> IOW, things like "gitk" use git-rev-list exactly to get the list of
> commits, and they want that list *incrementally*. They don't want to wait
> for git-rev-list to have filled up some 8kB buffer of commits. Especially
> since generating those commits can be slow if we're talking about a big
> tree and some path-limited stuff.
>
> So for example, do something like
>
> 	git rev-list HEAD -- drivers/char/drm/Makefile
>
> and if you don't see the result scroll a line at a time on a slower
> machine, there's something *wrong*.
>
> Junio, I'm NAK'ing this very forcefully!
>
> Jim: I don't know what I'm doing wrong, but I'm apparently not reaching
> you. So let me try one more time:
>
>  - stdio really isn't very good with error handling
>
>  - if you use stdio, YOU HAD BETTER ACCEPT THAT

Using stdio is fine, as long as you know and respect its limitations.

It's a real shame that you have to intersperse your often-valuable
feedback with such vitriol.
