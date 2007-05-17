From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 01:41:06 +0200
Message-ID: <200705180141.06862.Josef.Weidendorfer@gmx.de>
References: <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net> <20070517215841.GB29259@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri May 18 01:42:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HopbW-0005DM-A6
	for gcvg-git@gmane.org; Fri, 18 May 2007 01:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756587AbXEQXlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 19:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757986AbXEQXlq
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 19:41:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:49518 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757776AbXEQXlo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 19:41:44 -0400
Received: (qmail invoked by alias); 17 May 2007 23:41:43 -0000
Received: from p5496a7d5.dip0.t-ipconnect.de (EHLO noname) [84.150.167.213]
  by mail.gmx.net (mp030) with SMTP; 18 May 2007 01:41:43 +0200
X-Authenticated: #352111
X-Provags-ID: V01U2FsdGVkX1/HmJdwwrrHuHtS7BEdYyE6S5/EgZkvbDntQGaD+i
	OE8KBuc49bcTWA
User-Agent: KMail/1.9.6
In-Reply-To: <20070517215841.GB29259@mellanox.co.il>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47565>

On Thursday 17 May 2007, Michael S. Tsirkin wrote:
> > What I was "handwaving" (or "envisioning") was to have something
> > like this in .gitmodules:
> > 
> > 	[subproject "kernel/"]
> >         	URL = git://git.kernel.org/pub/linux-2.4.git
> > 
> > (or 2.6, depending on the revision of the superproject) and per
> > repository configuration would maps this with these two entries:
> > 
> > 	[subproject "git://git.kernel.org/pub/linux-2.4.git"]
> >         	URL = http://www.kernel.org/pub/linux-2.4.git
> > 
> > 	[subproject "git://git.kernel.org/pub/linux-2.6.git"]
> >         	URL = http://www.kernel.org/pub/linux-2.6.git
> > 
> > The intent is 
> > 
> > 	(1) "kernel/" directory is found to be a gitlink in the
> >             tree/index; .gitmodules is consulted to find the
> >             "URL", which is just a handle and the initial hint
> > 
> > 	(2) That "initial hint" is used to look up the
> >             subproject entry from the configuration, to find the
> >             "real" URL that is used by this repository
> 
> I'm reading up on submodules, two questions on this:
> 
> 1. I understand the usefulness of the hint for public repositories, (the user might
> need help discovering where to get submodules) but for private ones would this
> create a hassle: I start with a subproject in ~/subprojecttest and if that gets
> put in the URL hint, I have to maintain a map for ~/subprojecttest in my
> .git/config forever even after I move it to ~/subprojectproduction, just to make
> old releases build?

Yes, AFAICS that was the original idea; but that is no problem as we will need an
override scheme.

However, I think the usage of "url"/"url hint" as the 1st level subproject identifier
really is badly misleading and confusing for users; it would be better for this
identifier to not look like a URL at all. But by naming it "url" in .gitmodules, the
user is tempted to put an URL at this place.

IMHO it is by far better to simply talk about the "subproject name/identifier" which is
valid in the subproject namespace of the superproject.

And why not use the .gitattributes for the ".gitmodules" needs? 
With linux 2.4 as subproject in "top/kernel/", there could be a "top/.gitattributes"
with 

 kernel subproject=linux24

We could have a default rule that in the absense of the attribute, we default to the
path of the submodule, ie. to

 kernel subproject=top/kernel

In .git/config, there needs to be a config entry like

	[subproject "linux24"]
		URL = http://www.kernel.org/pub/linux-2.4.git

Again, we could have a default URL in the absence of this config entry which is
relative to the URL of the superproject, and which allows for the superproject
repository to act as proxy.

As relative path I would propose $SUPERURL/subproject/$SUBPROJECTNAME, ie. if
the superproject is at git://git.kernel.org/pub/super.git, the above subproject
would default to the URL git://git.kernel.org/pub/super.git/subproject/linux24
which could be a symlink on the server.

To support different subproject repositories linked in at the
same path of a superproject, Nicolas noted that we would have to replace
the subproject repository at top/kernel/.git (taking my example above)
whenever we cross the subproject change boundary in a checkout (e.g. from
linux24 to linux26). The natural thing here would be to have
subproject repositories at a seperate place, like inside of the superproject
repository such as at ".git/subproject/linux24", which works well with my
default interpretation of relative subproject paths above. At checkout,
the correct repository would be bound by a symlink:

 top/kernel/.git -> .git/subproject/linux24

Instead of a symlink, a magically working linkage mechanisms would be better
(the .git/gitlink proposal).

> 2. Suppose .gitmodules in upstream tree points at subproject repo at kernel.org,
> and I clone from there - my repo will point at kernel.org by default?
> But now, I'd like everyone who clones from *my* repo to get
> pointed at *my* server by default (e.g. for mirroring),
> but would not changing .gitmodules create a commit so my
> head will now differ from upstream  - so it won't be signed properly etc...
> Did I misunderstand something?

No, that is correct. Supporting a relative URL specification as proposed above
should solve this issue.

Josef

> 
