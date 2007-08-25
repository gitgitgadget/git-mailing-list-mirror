From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Sat, 25 Aug 2007 11:44:07 -0400
Message-ID: <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	 <20070824062106.GV27913@spearce.org>
	 <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
	 <alpine.LFD.0.999.0708241618070.16727@xanadu.home>
	 <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
	 <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Sat Aug 25 17:44:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOxo6-0002VQ-CF
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 17:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbXHYPoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 11:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbXHYPoJ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 11:44:09 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:20789 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbXHYPoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 11:44:08 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1400250wah
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 08:44:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AbDyBLeUUD90O4SG136+wk6qe+m665Uk9znVqo663J4QcaZ9iicgKGfqlGWtlu23omBFTVIdeen2EmcFZtbXtYNRPPEHbcVY3XWzyEWKn11KBmNBMDbMAjF84npyVtcZqmHrSbM8Det7w3fjhGaoGgkeTxrLs0mh3VuKA1d0Zqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tcQ0vX6kGU2TWKxF4Cbw/gzAcsQIQpA3RvPJi5pJ0qD8v0OyrceryGJUZL6ckb8T6qQigSmQjRIDqUtiPDTICat5v/SAYHb8hnLXWLYtXuPfPlVavfKJScpSjRCfjYis9+d3K3BpIwZcVdVB+Uctm9HO60JP2gkcylYQQazTIwQ=
Received: by 10.114.60.19 with SMTP id i19mr2358193waa.1188056647446;
        Sat, 25 Aug 2007 08:44:07 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sat, 25 Aug 2007 08:44:07 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56643>

On 8/24/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > I can clone the tree in five minutes using the http protocol. Using the
> > git protocol would take 24hrs if I let it finish.
>
> The http side doesn't actually do any global verification, the way
> git-daemon does. So to it, everything is just temporary buffers, and you
> don't need any memory at all, really.
>
> git-daemon will create a packfile. That means that it has to generate the
> *global* object reachability, and will then optimize the object packing
> etc etc. That's a minimum of something like 48 bytes per object for just
> the object chains, and the kernel has a *lot* of objects (over half a
> million).

A large, repeating work load is created in this process when you take
a 200MB pack, repack it to add a few loose objects and then don't save
the results. This model makes the NSLU2 unusable, but I also see it at
my shared hosting provider. Initial clones of a repo that take 3min
from kernel.org take 25min on a shared host since the RAM is not
dedicated.

There are three categories of fetches:
1) initial clone, fetch all
2) fetch recent
3) I haven't fetched in three months

99% of fetches fall in the first two categories.

A very simple solution is to sendfile() existing packs if they contain
any objects that the client wants and let the client deal with the
unwanted objects. Yes this does send extra traffic over the net, but
the only group significantly impacted is #2 which is the most
infrequent group.

Loose objects are handled as they are currently. To optimize this
scheme you need to let the loose objects build up at the server and
then periodically sweep only the older ones into a pack. Packing the
entire repo into a single pack would cause recent fetches to retrieve
the entire pack.

Initial clone can be optimized further by recognizing that the
receiving repository is empty and sending them everything; no need to
compute which objects are missing at the server. This method will
speed up initial clone since the existing pack can be immediately sent
instead of waiting on a pack file to be built. Build the loose object
pack in parallel with sending the existing packs.

I recognize that in the case of cloning a single branch or --reference
too many objects will also be transmitted but I believe the benefits
of reducing the server load outweigh the overhead of transmitting
extra objects in this case. You can always remove the extra objects on
the client side.

On 8/24/07, Jakub Narebski <jnareb@gmail.com> wrote:
> There was idea to special case clone (just concatenate the packs, the
> receiving side as someone told there can detect pack boundaries; do not
> forget to pack loose objects, first), instead of using generic fetch --all
> for clone, bnut no code. Code speaks louder than words (although if someone
> would provide details of pack boundary detection...)

Write the file name and length into the socket before sending the
pack. Use sendfile() or it's current incarnation to actually send the
pack. Insert these header lines between packs.

> In addition to the object chains yourself, the native protocol will also
> obviously have to actually *look* at and parse all the tree and commit
> objects while it does all this, so while it doesn't necessarily keep all
> of those in memory all the time, it will need to access them, and if you
> don't have enough memory to cache them, that will add its own set of IO.
>
> So I haven't checked exactly how much memory you really want to have to
> serve big projects, but with some handwavy guesstimate, if you actually
> want to do a good job I'd guess that you really want to have at least as
> much memory as the size of largest project you are serving, and probably
> add at least 10-20% on top of that.
>
> So for the kernel, at a guess, you'd probably want to have at least 256MB
> of RAM to do a half-way good job. 512MB is likely nicer and allows you to
> actually cache the stuff over multiple accesses.
>
> But I haven't actually tested. Maybe it might be bearable at 128M.
>
>                         Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
