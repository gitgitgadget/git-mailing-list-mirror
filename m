From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH/RFC 01/11] mingw: add network-wrappers for daemon
Date: Thu, 26 Nov 2009 13:03:37 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0911261250180.14228@cone.home.martin.st>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>  <1259196260-3064-2-git-send-email-kusmabite@gmail.com>  <alpine.DEB.2.00.0911261015140.14228@cone.home.martin.st> <40aa078e0911260246j47fa36d5t421de7c1d07d5cca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 26 12:03:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDc8b-0004np-8W
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 12:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbZKZLDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 06:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754060AbZKZLDe
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 06:03:34 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:35110 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbZKZLDd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 06:03:33 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by jenni2.inet.fi (8.5.014)
        id 4A7770910437124D; Thu, 26 Nov 2009 13:03:38 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <40aa078e0911260246j47fa36d5t421de7c1d07d5cca@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133783>

On Thu, 26 Nov 2009, Erik Faye-Lund wrote:

> Yeah, I saw your patches, and realized that I needed to rebase my work
> at some point, but none of the repos I usually pull from seems to
> contain the patches yet. Rebasing will be a requirement before this
> can be applied for sure.

Ok, great! I tried applying it on the latest master, and it wasn't too 
much of work.

> > Also, the getaddrinfo-compatibility wrappers perhaps may need some minor
> > updates to handle the use cases needed for setting up listening sockets.
> 
> I expect you're referring to IPv6 support in the wrappers this patch
> adds? Unfortunately IPv6 isn't something I'm very familiar with, but
> I'll give it a go unless someone else provides some patches...

No, sorry for being unclear.

When IPv6 is enabled, name lookups go through getaddrinfo instead of 
gethostbyname. Since getaddrinfo isn't available on Win2k (and switching 
between getaddrinfo/gethostbyname happens at compile time when IPv6 is 
enabled), we have to provide a small getaddrinfo stub, implemented in 
terms of gethostbyname. This currently implements only parts of the 
getaddrinfo interface - enough for the way getaddrinfo was used this far.

git-daemon uses getaddrinfo in a slightly different way (for setting up 
listening sockets), and thus uses parameters that our current getaddrinfo 
stub doesn't support. The patch I sent to this thread a moment ago adds 
support for the way git-daemon uses getaddrinfo.


I tested this patch series on top of the latest master, with IPv6 support, 
and found a slight problem caused by the IPv6 support. If IPv6 isn't 
enabled, git-daemon always listens on one single socket, otherwise it may 
listen on two separate sockets, one for v4 and one for v6.

This causes problems with the mingw poll() replacement, which has a 
special case for polling one single fd - otherwise it tries to use some 
emulation that currently only works for pipes. I didn't try to make any 
proper fix for this though. I tested git-daemon by hacking it to listen on 
only one of the sockets, and that worked well for both v4 and v6.


So, in addition to the getaddrinfo patch I sent, the mingw poll() 
replacement needs some updates to handle polling multiple sockets. Except 
from that, things seem to work, at a quick glance.

// Martin
