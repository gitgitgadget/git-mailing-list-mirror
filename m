From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [feature request] git: tags instead of commit IDs in blame
 output
Date: Wed, 25 Aug 2010 09:32:37 +0200
Message-ID: <20100825093237.6fec9c5d@hyperion.delvare>
References: <20100821095352.604a2b85@hyperion.delvare>
	<201008211210.23280.johan@herland.net>
	<20100824145426.38b1fb15@hyperion.delvare>
	<201008241653.50225.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Aug 25 09:32:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoATd-0002zJ-RK
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 09:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab0HYHct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 03:32:49 -0400
Received: from zone0.gcu-squad.org ([212.85.147.21]:6196 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab0HYHcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 03:32:47 -0400
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1OoASZ-0003ki-Vq
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Wed, 25 Aug 2010 09:31:48 +0200
In-Reply-To: <201008241653.50225.johan@herland.net>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154431>

Hi Johan,

On Tue, 24 Aug 2010 16:53:49 +0200, Johan Herland wrote:
> On Tuesday 24 August 2010, Jean Delvare wrote:
> > On Sat, 21 Aug 2010 12:10:22 +0200, Johan Herland wrote:
> > > To me, it seems what you want to do is convert the commit ID in
> > > front of every blame-line into the result of running 'git name-rev'
> > > (or 'git describe') on that line.
> > >
> > > To that effect something like this should work:
> > >
> > >   git blame <file> |
> > >   while read sha1 rest
> > >   do
> > >       tag=$(git name-rev --tags --name-only $sha1) &&
> > >       echo "$tag $rest"
> > >   done
> > >
> > > Of course, if you're doing this at a bigger scale, you want to wrap
> > > this in a script that (1) caches commitID -> tag mappings, and that
> > > (2) runs 'git name-rev in its --stdin mode'.
> >
> > Thanks for the very valuable suggestion. Obviously, the fact that the
> > above command took over an hour to complete on a 1000-line file as
> > kind of an issue ;) I did suspect this performance issue originally,
> > which is why I thought it would be better if git itself would
> > implement the feature.
> 
> Yes, everything would be easier and faster if git itself implemented it. 
> Aka. infinite feature creep... This obviously does not scale.
> 
> Instead, Git tries to provide the building blocks that you can string 
> together to produce the exact result you're looking for.

Yes, I get the idea now, it makes a lot of sense.

> > That being said... git name-rev's --stdin 
> > option seems to be doing all the hard caching work already:
> >
> > git blame -l <file> | git name-rev --tags --name-only --stdin
> >
> > does almost what I want, and is reasonably fast (13 seconds for the
> > same file.)
> 
> I did the same experiment on a much larger file (~19000 lines), and got:
> 
>   27.94s git blame -l <file>
> 
>   28.31s git blame -l <file> | git name-rev --tags --name-only --stdin
> 
> which suggests that the git name-rev process only adds ~1% to the total 
> runtime.
> 
> > I'll need to do some reformatting work to extract the tag 
> > from the symbolic names (which in turn should almost fix the
> > alignment),
> 
> ...only if all the tag names happen to have the same length.

Exactly. Which is the case for me at the moment, and if it ever
changes, I'll deal with it. I guess a simple printf will do.

> > but this is nothing a few lines of shell scripting can't do.
> 
> I don't see why you need to remove the suffix from the tag name. You're 
> simply removing information that could be used to look up the exact 
> commit resposible for each line. And it's not like the tag name is 
> completely unreadable unless you remove the suffix...

I'm not claiming that my approach is the universal solution to
anything. It's just what I need in specific cases, and what my old tool
was doing. If my needs evolve in the future, maybe I'll stop stripping
the extra information. But for the time being, I value conciseness over
completeness.

And for the interested, if any, here's the small script I came up with:

#!/bin/sh

if [ -z "$1" ]
then
	echo "File?"
	exit 1
fi

# Replace commit IDs with symbolic names, then strip symbolic names
# to tags, and finally strip the -rc part of tags.
git blame -l "$1" | \
	git name-rev --tags --name-only --stdin | \
	sed -e 's/^\([^~ ]*\)~[^ ]*/\1/' -e 's/^\([^ ]*\)-rc[0-9][0-9]*/\1/'


-- 
Jean Delvare
