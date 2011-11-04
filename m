From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: New Feature wanted: Is it possible to let git clone continue
 last break point?
Date: Fri, 4 Nov 2011 09:56:33 +0100
Message-ID: <20111104085633.GA13924@ecki>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
 <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
 <20111031090717.GA24978@elie.hsd1.il.comcast.net>
 <20111102220614.GB14108@sigill.intra.peff.net>
 <7vwrbigna7.fsf@alter.siamese.dyndns.org>
 <20111102232735.GA17466@sigill.intra.peff.net>
 <CAJo=hJtt8vjB5oU+tEabN2AS7c-24bMHNwQSoWtZYtjjrR3d7Q@mail.gmail.com>
 <20111103024248.GA9492@sigill.intra.peff.net>
 <CAJo=hJt2kU10r5rq23qgimtW8dmzu-N92vjO_hNBbVVsKSpDmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	netroby <hufeng1987@gmail.com>,
	Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 04 09:56:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMFZy-0007dP-Us
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 09:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846Ab1KDI4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 04:56:46 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:43331 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753829Ab1KDI4p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 04:56:45 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.105])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 6FE5BCE057
	for <git@vger.kernel.org>; Fri,  4 Nov 2011 09:56:39 +0100 (CET)
Received: from localhost (p5B22DEAB.dip.t-dialin.net [91.34.222.171])
	by bsmtp.bon.at (Postfix) with ESMTP id 8D12A2C4022;
	Fri,  4 Nov 2011 09:56:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAJo=hJt2kU10r5rq23qgimtW8dmzu-N92vjO_hNBbVVsKSpDmg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184763>

On Wed, Nov 02, 2011 at 09:19:03PM -0700, Shawn Pearce wrote:
> 
> [...] But they can use sendfile() on the server they have and get
> a lot of improvement in clone speed due to lower system load,
> plus resumable clone for the relatively stable history part.

Setting aside the system load issue for now, couldn't we simply do
the following?

1. Figure out HAVE's and WANT's [1], based on which an ad-hoc pack
   will be made and sent to the client.
2. Cache the information on disk (not the pack but the information
   to re-create it), and give the client a 'ticket number' which
   corresponds to that ad-hoc pack.
3. Start downloading the packfile

When the connection drops, we can resume like this:

1. Send the previously received 'ticket number', and the amount of
   previously received data.
2. Re-generate the pack from the HAVE's and WANT's cached under
   'ticket number'. (This may fail if the repo state has changed
   such that previously accessible refs are now inaccessible.)
3. Resume download of that pack.

The upside of this approach is that it would work automatically,
without any manual setup by the server admin. All the previously
discussed ideas skip the step where we figure out the HAVE's and
WANT's. And to me that implies that we manually prepare a packfile
somewhere on disk, which contains what the user usually WANT's and
is allowed to have (think per-branch access control). Even if we
disregard access control, wouldn't that at least require the server
to create a "clean" pack which does not contain any objects from
the reflog?

The whole mirror thing could be pursued independently of the resume
capability, and if each git repo is capable of resuming the mirrors
can be plain git clones as well.

Just my 2 cents,
Clemens
