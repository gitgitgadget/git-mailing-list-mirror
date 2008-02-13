From: "J.H." <warthog9@kernel.org>
Subject: Re: Another bench on gitweb (also on gitweb caching)
Date: Wed, 13 Feb 2008 11:12:03 -0800
Message-ID: <1202929923.2687.15.camel@localhost.localdomain>
References: <20080210030919.GA32733@c3sl.ufpr.br>
	 <20080213004528.GB31455@c3sl.ufpr.br>
	 <1202864493.17207.24.camel@localhost.localdomain>
	 <200802131317.48815.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 20:13:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPN2s-0005z9-Q1
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 20:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757743AbYBMTM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 14:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755935AbYBMTM3
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 14:12:29 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:41231 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757842AbYBMTM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 14:12:28 -0500
Received: from [172.19.0.93] ([76.21.83.184])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.13.8) with ESMTP id m1DJC39L024708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Feb 2008 11:12:04 -0800
In-Reply-To: <200802131317.48815.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-1.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/5799/Wed Feb 13 07:15:22 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73812>


> BTW. did you consider using cgit (C/Caching git web interface) instead
> or in addition to gitweb? Freedesktop.org uses it side by side with
> gitweb. I wonder how it would perform on kernel.org...

When I branched and did the initial work for gitweb-caching CGit had
only barely made verion 0.01.  So putting something *that* new into
production on Kernel.org didn't even remotely make sense.  Since than
the caching modifications (along with a few other fixes and such) have
proven to be quite stable and have withstood the onslaught of users
fairly well.  I have toyed with the idea of giving up on gitweb-caching
(since I either need to redo it to bring it closer to mainline gitweb,
and probably give up on breaking it up into multiple files or switch to
something new) but the current question that I, and no one else on the
kernel.org admin staff has had time to investigate is does cgit use the
same url paths.  If so it would be a simple drop-in replacement and that
would appeal to us.  If it doesn't we can't use cgit and will have to
stick with gitweb or a direct derivative there-of.

> 
> (Almost) every optimization should begin with profiling. Could you tell
> us which gitweb pages are most called and perhaps which pages generate
> most load for kernel.org?

That would be correct, though when I did up gitweb-caching the profiling
was blatantly obvious, with every single page request git was being
called, git was hammering the disk and it was becoming increasingly
obvious that going and running git for every page load was completely
impractical.  I know git is fast - but it's not *that* fast, and it is a
bit abusive to the system for certain things requiring a lot of memory,
chewing cpu or chewing disk.  In order of badness for kernel.org:
chewing memory, disk, cpu.  Use up too much memory and you force too
much needed content out of ram, chew up disk and you make queries that
are forced to disk to take longer (and if you've chewed up too much ram
this gets *lots* worse).

So the simplest and obvious thing - take git out of the equation,
directly, for most calls.  If you've ever seen the "Generating..." page
on kernel.org that is a stalling mechanism I'm using to let git run in
the background and generate the page your going to see.  If you notice
it can take several seconds for that to complete, and we are on *very*
fast boxes - now multiply that by hundreds of times a second and you'll
start to understand why the caching layer is saving us right now.

As for the most often hit pages - the front page is by far hit the most,
which should be no surprise to everyone, and it is by far the most
abusive since it has to query *every* project have.  After that things
taper off as people find the project they want and go looking for the
data they are interested in.

>  How new projects are added (old projects
> deleted)?

By and large - left up to the users - if they don't want their tree
anymore they delete it (though I don't know of anyone who has) if they
need another one - they create it.

>  Do you control (can add to or can add multiplexing) to update
> or post-receive hooks?

No.  We do not want to, at all, control in any way the tree's that
people put up on Kernel.org.  We just don't have the bandwidth to deal
with that for every single tree on kernel.org.  Anything that would
require us to go changing or forcing a user to change something in their
git tree means we've already lost.  Taking the caching layer and making
it 100% transparent to the git tree's owners and generally speaking to
the end user makes things very simple for us to deal with.

> 
> Without this data we could concentrate on things which are of no
> importance. BTW. I wonder if slitting projects_list page would help...

That would be bad - I know for a fact there are people who will go to
git.kernel.org and then search on the page for the things they want - so
changing this would probably cause a lot of confusion for minor gain at
this point.

- John 'Warthog9' Hawley
