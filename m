From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Sun, 26 Aug 2007 12:34:29 -0400
Message-ID: <9e4733910708260934i1381e73ftb31c7de0d23f6cae@mail.gmail.com>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	 <20070824062106.GV27913@spearce.org>
	 <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
	 <alpine.LFD.0.999.0708241618070.16727@xanadu.home>
	 <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
	 <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org>
	 <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com>
	 <20070826093331.GC30474@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, jnareb@gmail.com,
	"Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 18:34:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPL4M-000829-NR
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 18:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbXHZQeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 12:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753665AbXHZQeb
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 12:34:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:42730 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbXHZQea (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 12:34:30 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1747613wah
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 09:34:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FBgtQqOxX6YTfaVkbahzTozTYAq9WwZycQrb6ZjSYrcGddMR0N6U4uO6Ab8MpUfatyeaCjqBVjfnY6Ocjure6tesR9XCO2WV+2A1bKXMCiEGHlG+aMAIdsDK3V1k5QhRMQ35NXRW8wdxeHGRk5zgWXPIyD2gmPhtqbQLbjQoOq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GSGvsr0aMZexuLED2UMb1kDYqVvlP363bilsiLRF8+tGHtZAH+Gx0nmIA2wnY4D4prAjpDECMJpixo+wGoZ1KKDMFIP/78TGAYmZYUg44VujVy4iFTAPrZpiJlhyeEa4tUanPn1YFdq/OiH8wwFu2Lt4K/AGF7uRvIfL/H2NuR4=
Received: by 10.114.53.1 with SMTP id b1mr1729646waa.1188146069054;
        Sun, 26 Aug 2007 09:34:29 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sun, 26 Aug 2007 09:34:29 -0700 (PDT)
In-Reply-To: <20070826093331.GC30474@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56703>

On 8/26/07, Jeff King <peff@peff.net> wrote:
> On Sat, Aug 25, 2007 at 11:44:07AM -0400, Jon Smirl wrote:
>
> > A very simple solution is to sendfile() existing packs if they contain
> > any objects that the client wants and let the client deal with the
> > unwanted objects. Yes this does send extra traffic over the net, but
> > the only group significantly impacted is #2 which is the most
> > infrequent group.
> >
> > Loose objects are handled as they are currently. To optimize this
> > scheme you need to let the loose objects build up at the server and
> > then periodically sweep only the older ones into a pack. Packing the
> > entire repo into a single pack would cause recent fetches to retrieve
> > the entire pack.
>
> I was about to write "but then 'fetch recent' clients will have to get
> the entire repo after the upstream does a 'git-repack -a -d'" but you
> seem to have figured that out already.
>
> I'm unclear: are you proposing new behavior for git-daemon in general,
> or a special mode for resource-constrained servers? If general behavior,
> are you suggesting that we never use 'git-repack -a' on repos which
> might be cloned?

This would be a new general behavior. There are cases where git-daemon
is very resource hungry, rearranging things a little can remove this
need for everyone.

There are several ways to address the repack -a problem. But the
simplest solution may be the best, send existing packs only on an
initial clone. In all other cases continue with the current algorithm.
We could work on methods for making the middle case better but it is
so infrequent it is probably not worth bothering with.

Changing git-daemon only for the initial clone case also means that
people don't need to change the way they manage packs.

Posters have been saying, why worry about initial clone since it isn't
done that often. I agree that it isn't done that often, but if it is
done all on my NSLU2 it will take about 40hrs to complete. We can
easily see the impact of changing the the initial clone algorithm, the
http clone takes 3min.

BTW, if the NSLU2 needs a repack -a I can do it on another machine and
copy it over. Or maybe someone will write a repack that is happy in
20MB. The NSLU2 is a great home server, it is usually fast enough.
Power consumption is a tiny 8W, fine to leave on 24/7, My NSLU2 is as
powerful as the average desktop machine in the early 90's, how quickly
we forget.


>
> -Peff
>


-- 
Jon Smirl
jonsmirl@gmail.com
