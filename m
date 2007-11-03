From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 0/2] History replay support
Date: Sat, 3 Nov 2007 08:56:35 +0100
Message-ID: <e5bfff550711030056m5f62eb21k4972e1340f7d6e6c@mail.gmail.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
	 <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
	 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
	 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 08:56:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoDsG-0000yH-Fh
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 08:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745AbXKCH4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 03:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755900AbXKCH4h
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 03:56:37 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:16296 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804AbXKCH4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 03:56:36 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1000690rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 00:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uk8ZgYsKRj7XqSrlMuY1C1LhVtG7I8ppcVhoWmtsI5s=;
        b=M+I1yPuHDjNU2nT9W+YmvM5BXbu0z8MjqyIyMboDfHaunSF5ncwRbN7ZQsDI0Ed1eUvRuaL5lD3lxgIp1sOkzq6kEZrLry+i0F0Yi0PxMhbjLAaSSDlRhxgiMvp7doRlkRfD5gheMFolyQmv7zrwtquG8QJKhjoSWL2JZHBmnuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gQNyFT3vDvPJFPXTHHlUu6CXuUhH6da5rO6RWe6p4dPuOOBMaE94r0rCvqlZg6MPaS2K8b124l3Db/75dXgS61uHFLZSy/nYbxiW7ipdQJlqduS5Oo+WVHoE37tiAKy3i90x+6t93C9DWY7ImSBBjom2OlRj5eV3ociJ4r7k8R8=
Received: by 10.141.159.13 with SMTP id l13mr1330542rvo.1194076595829;
        Sat, 03 Nov 2007 00:56:35 -0700 (PDT)
Received: by 10.141.203.3 with HTTP; Sat, 3 Nov 2007 00:56:35 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63215>

On 11/3/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Fri, 2 Nov 2007, Linus Torvalds wrote:
> >
> > The bad news is that it doesn't work well in this simplistic form, because
> > there is a O(n**2) behaviour when replays *do* happen, ie we end up having
> > replays within replays [..]
>
> Gaah. the more I look at this, the more I think the topo sort should be
> done at the visualization side.
>
> It's really quite cheap to do the topo sort, *and* it's really quite cheap
> to do the tests that trigger the topo sort, but what's expensive is to
> re-output all the data again!
>
> The silly thing is, I think I've come up with an "almost optimal"
> solution, but it's so ugly that I'm a bit ashamed of it.
>
> That almost optimal solution is simply:
>  - get the first <n> (say: 100) commits, and topo-sort just them. Feed it
>    to the visualizer.
>  - the visualizer will now have enough to work with in order to show the
>    starting screen and set the cursor to the hourglass or whatever the
>    "wait for it" thing is.
>  - get the rest of the commits at our normal leisurely pace (whether it
>    is one second of 17).
>  - output the total number of commits (so that the visualizer can re-size
>    the slider and/or allocate some big array just once), topo-sort it all,
>    and output the full thing.
>
> It's disgusting. But it avoids the unnecessary data transfer - except for
> just the first 100 commits that get sent twice. And it gets what *I* look
> for, namely that "immediate" feel to the initial pop-up of the history.
>

It's not disgusting is human perception oriented !

All this stuff is not needed to get the sha faster, but to let think
the user that are faster. It's for strictly human consumption, so I
would say your "ugly" solution is the best for me.

A bunch of revisions, just to let user eyes to re-focus on new stuff
(and some hundredths of milliseconds are already elapsed after this)
while in the background the real, shadowed, work goes on.

It's also easy on the client GUI side, simply discard all and reload
as soon _correct_ data arrives.

So the new option could became:

git log --fast-output 100 500 --topo-order <...whatever...>

where git log outputs as soon as it can 100 commits and feeds it to
the visualizer. If the _normal_ commits are still not ready after 500
ms are elapsed then git log spits out another 100 commits chunk and so
on at 500ms intervals until good commits are ready. Then outputs the
full thing.

It is very user perception oriented, but hey, so is a GUI!

Marco

P.S: A little optimization for small repositories would be that git
log *waits* at maximum 500ms before to output the first 100 commits
chunk, so that in case of small repos (thousands of revisions) or in
case of warmed up cache the commits in output are already the good
ones, no need for fakes!
