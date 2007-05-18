From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 17:32:53 -0700
Message-ID: <464CF435.1010405@midwinter.com>
References: <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net> <20070517215841.GB29259@mellanox.co.il> <200705180141.06862.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 18 02:33:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoqP2-00049n-S4
	for gcvg-git@gmane.org; Fri, 18 May 2007 02:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbXERAc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 20:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754917AbXERAc4
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 20:32:56 -0400
Received: from tater.midwinter.com ([216.32.86.90]:50762 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754646AbXERAcz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 20:32:55 -0400
Received: (qmail 16242 invoked from network); 18 May 2007 00:32:54 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Q3uxrG/WGlViF/iOSxJlBCeasMaur0rhbFezy+J36OajMeJFeKiZ+9SzY86EPNiy  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 18 May 2007 00:32:54 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <200705180141.06862.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47567>

It seems like a lot of the friction here is because people are trying to 
devise a single mechanism that will handle two distinct cases:

1. The location of a subproject's changed (the "public repository 
relocated to a different host" problem). This is not temporally 
sensitive -- if you check out an old version of the superproject, you 
need to look in the new location for the subproject. A local override 
for the subproject's location will likely still be perfectly valid.

2. The superproject no longer wants to use the same subproject; it wants 
to replace it with something else at the same point in the tree (the 
"version 2 of superproject uses the 2.6 kernel as opposed to the 2.4 
kernel"). This is temporally sensitive -- if you check out an old 
version of the superproject, you want to use the old location for the 
subproject too. A single local override will most likely not be valid 
for both versions.

I think these are fundamentally different operations and it's the desire 
to fold them into one mechanism that's leading to a lot of the 
discussion here. Would we simplify things by not conflating them?

For example -- and yes, this is partially a rehash of other people's 
ideas -- instead of mapping a subproject path directly to revision@URL, 
instead map it to revision@symbolic name. The symbolic name is then 
separately mapped to a URL, and it's that symbolic name that can be 
locally overridden. The mappings of symbolic names to URLs is 
unversioned; the mapping of subprojects to revision@symbolic is 
versioned. Local overrides happen at the symbolic->URL mapping.

So you'd have something like

version 1: kernel-src/ -> kernel24
version 2: kernel-src/ -> kernel26
unversioned:
    kernel24 -> git://whatever/2.4
    kernel26 -> git://whatever/2.6

And then locally, the override is:

    kernel24 -> git://myhost/2.4

When version 2 gets pulled down, you start off using the upstream's URL, 
which you know because you pulled down the new copy of the unversioned 
symbolic->URL map. Maybe git-pull gives you a warning like, "I see you 
have some overrides, so you might want to know about this new symbolic 
name too." With an appropriate option it might even stop before doing 
anything with the new symbolic name to give you a chance to override.

Maybe that has some problems I'm not seeing, but it seems like adding 
one more layer of indirection which has different versioning semantics 
would make this a more tractable problem.

-Steve
