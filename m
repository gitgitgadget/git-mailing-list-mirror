From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: New Feature wanted: Is it possible to let git clone continue
 last break point?
Date: Sat, 5 Nov 2011 11:00:15 +0100
Message-ID: <20111105100015.GB17752@ecki>
References: <20111031090717.GA24978@elie.hsd1.il.comcast.net>
 <20111102220614.GB14108@sigill.intra.peff.net>
 <7vwrbigna7.fsf@alter.siamese.dyndns.org>
 <20111102232735.GA17466@sigill.intra.peff.net>
 <CAJo=hJtt8vjB5oU+tEabN2AS7c-24bMHNwQSoWtZYtjjrR3d7Q@mail.gmail.com>
 <20111103024248.GA9492@sigill.intra.peff.net>
 <CAJo=hJt2kU10r5rq23qgimtW8dmzu-N92vjO_hNBbVVsKSpDmg@mail.gmail.com>
 <20111104085633.GA13924@ecki>
 <4EB3B1E7.7080507@viscovery.net>
 <CAJo=hJtsiEEHA33CQn1MCvb7vFv7uEF+U292YgBa7EWv7P8Jng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	netroby <hufeng1987@gmail.com>,
	Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 05 11:12:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMdEL-00056p-Kr
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 11:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab1KEJ7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 05:59:54 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:46369 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752457Ab1KEJ7y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 05:59:54 -0400
X-Greylist: delayed 90222 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Nov 2011 05:59:53 EDT
Received: from localhost (p5B22CB46.dip.t-dialin.net [91.34.203.70])
	by bsmtp.bon.at (Postfix) with ESMTP id 58B46CDF8C;
	Sat,  5 Nov 2011 11:00:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAJo=hJtsiEEHA33CQn1MCvb7vFv7uEF+U292YgBa7EWv7P8Jng@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184843>

On Fri, Nov 04, 2011 at 07:22:20AM -0700, Shawn Pearce wrote:
> On Fri, Nov 4, 2011 at 02:35, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> > Am 11/4/2011 9:56, schrieb Clemens Buchacher:
> >> Cache ... not the pack but the information
> >> =A0 =A0to re-create it...
> >
> > It has been discussed. It doesn't work. Because with threaded pack
> > generation, the resulting pack is not deterministic.

So let the client disable it, if they'd rather have a resumeable
fetch than a fast one.

Sorry if I'm being obstinate here. But I don't understand the
problem and I can't find an explanation in related discussions.

> The information to create a pack for a repository with 2M objects
> (e.g. Linux kernel tree) is *at least* 152M of data. This is just a
> first order approximation of what it takes to write out the 2M SHA-1s=
,
> along with say a 4 byte length so you can find given an offset
> provided by the client roughly where to resumse in the object stream.
> This is like 25% of the pack size itself. Ouch.

Sorry, I should not have said HAVEs. All we need is the common
commits, and the sha1s of the WANTed branch heads at the time of
the initial fetch. That shouldn't be more than 10 or so in typical
cases.

> This data is still insufficient to resume from. A correct solution
> would allow you to resume in the middle of an object, which means we
> also need to store some sort of indicator of which representation was
> chosen from an existing pack file for object reuse. Which adds more
> data to the stream. And then there is the not so simple problem of ho=
w
> to resume in the middle of an object that was being recompressed on
> the fly, such as a large loose object.

How often does the "representation chosen from an existing pack
file for object reuse" change? Long term determinism is a problem,
yes. But I see no reason why it should not work for this short-term
case. So long as the pack is created by one particular git and libz
version, and for this particular consecutive run of fetches, we do
not need to store anything about the pack. The client downloads n
MB of data until the drop. To resume, the client says it already
has n MB of data.

No?

Clemens
