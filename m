X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 11:50:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612101129190.12500@woody.osdl.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
 <200612101402.51363.jnareb@gmail.com> <457C0F8F.7030504@garzik.org>
 <200612102011.52589.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 19:51:38 +0000 (UTC)
Cc: Jeff Garzik <jeff@garzik.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612102011.52589.jnareb@gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33917>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtUhy-0003Y5-6p for gcvg-git@gmane.org; Sun, 10 Dec
 2006 20:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762443AbWLJTvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 14:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762448AbWLJTvJ
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 14:51:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55542 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762428AbWLJTvH
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 14:51:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBAJoGID017163
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 10
 Dec 2006 11:50:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBAJoFFn001367; Sun, 10 Dec
 2006 11:50:16 -0800
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 10 Dec 2006, Jakub Narebski wrote:
> >> If-Modified-Since:, If-Match:, If-None-Match: do you?
> 
> Adn in CGI standard there is a way to access additional HTTP headers
> info from CGI script: the envirionmental variables are HTTP_HEADER,
> for example if browser sent If-Modified-Since: header it's value
> can be found in HTTP_IF_MODIFIED_SINCE environmental variable.

Guys, you're missing something fairly fundamnetal. 

It helps almost _nothing_ to support client-side caching with all these 
fancy "If-Modified-Since:" etc crap.

That's not the _problem_.

It's usually not one client asking for the gitweb pages: the load comes 
from just lots of people independently asking for it. So client-side 
caching may help a tiny tiny bit, but it's not actually fixing the 
fundamental problem at all.

So forget about "If-Modified-Since:" etc. It may help in benchmarks when 
you try it yourself, and use "refresh" on the client side. But the basic 
problem is all about lots of clients that do NOT have things cached, 
because all teh client caches are all filled up with pr0n, not with gitweb 
data from yesterday.

So the thing to help is server-side caching with good access patterns, so 
that the server won't have to seek all over the disk when clients that 
_don't_ have things in their caches want to see the "git projects" summary 
overview (that currently lists something like 200+ projects).

So to get that list of 200+ projects, right now gitweb will literally walk 
them all, look at their refs, their descriptions, their ages (which 
requires looking up the refs, and the objects behing the refs), and if 
they aren't cached, you're going to have several disk seeks for each 
project.

At 200+ projects, the thing that makes it slow is those disk seeks. Even 
with a fast disk and RAID array, the seeks are all basically going to be 
interdependent, so there's no room for disk arm movement optimization, and 
in the absense of any other load it's still going to be several seconds 
just for the seeks (say 10ms per seek, four or five seeks per project, 
you've got 10 seconds _just_ for the seeks to generate the top-level 
summary page, and quite frankly, five seeks is probably optimistic).

Now, hopefully some of it will be in the disk cache, but when the 
mirroring happens, it will basically blow the disk caches away totally 
(when using the "--checksum" option), and then you literally have tens of 
seconds to generate that one top-level page. 

And when mirroring is blowing out the disk caches, the thing will be doing 
other things _too_ to the disk, of course.

So what you want is server-side caching, and you basically _never_ want to 
re-generate that data synchronously (because even if the server can take 
the load, having the clients wait for half a minute or more for the data 
is just NOT FRIENDLY). This is why I suggested the grace-period where we 
fill the cache on he server side in the background _while_at_the_same_time 
actually feeding the clients the old cached contents.

Because what matters most to _clients_ is not getting the most recent 
up-to-date data within the last few minutes - people who go to the 
overview page want to just get a list of projects, and they want to get 
them in a second or two, not half a minute later.

And btw, all those "If-Modified-Since:" things are irrelevant, since quite 
often, the top-level page really technically _has_ been modified in the 
last few minutes, because with the kernel and git projects, _somebody_ has 
usually pushed out one of the projects within the last hour.

And no, people don't just sit there refreshing their browser page all the 
time. I bet even "active" git users do it at most once or twice a day, 
which means that their client cache will _never_ be up-to-date.

But if you do it with server-side caches and grace-periods, you can 
generally say "we have something that is at most five minutes old", and 
most importantly, you can hopefully do it without a lot of disk seeks 
(because you just cache the _one_ page as _one_ object), so hopefully you 
can do it in a few hundred ms even if the thing is on disk and even if 
there's a lot of other load going on.

I bet the top-level "all projects" summary page and the individual 
project summary pages are the important things to cache. That's what 
probably most people look at, and they are the ones that have lots of 
server-side cache locality. Individual commits and diffs probably don't 
get the same kind of "lots of people looking at them" and thus don't get 
the same kind of benefit from caching.

(Individual commits hopefully also need fewer disk seeks, at least with 
packed repositories. So even if you have to re-generate them from scratch, 
they won't have the seek times themselves taking up tens of seconds, 
unless the project is entirely unpacked and diffing just generates total 
disk seek hell)

