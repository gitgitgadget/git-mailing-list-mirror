From: Jeff King <peff@peff.net>
Subject: Re: Should branches be objects?
Date: Thu, 19 Jun 2014 22:27:06 -0400
Message-ID: <20140620022706.GB31908@sigill.intra.peff.net>
References: <CAK3OfOiB0YWf25Hvvvqi+YBwu2V-gE-sjm7XrfE0p2zds4CE2Q@mail.gmail.com>
 <20140619234614.GY8557@google.com>
 <CAK3OfOjnYXxhWT7Vp-0Pcb=F8ze6wJnqSm1_LW0Zp1FmYZfUEg@mail.gmail.com>
 <20140620010147.GZ8557@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nico Williams <nico@cryptonector.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 04:27:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxoXq-0007Vd-4v
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 04:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbaFTC1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 22:27:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:47931 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754537AbaFTC1I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 22:27:08 -0400
Received: (qmail 30821 invoked by uid 102); 20 Jun 2014 02:27:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 21:27:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 22:27:06 -0400
Content-Disposition: inline
In-Reply-To: <20140620010147.GZ8557@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252209>

On Thu, Jun 19, 2014 at 06:01:47PM -0700, Jonathan Nieder wrote:

> > Speaking of which: are there any power failure corruption cases left
> > in git?  How is this tested?
> 
> What kind of power failure corruption are you talking about?  Git
> usually updates files by writing a completely new file and then
> renaming it into place, so depending on your filesystem this means it
> is very hard or very easy to lose data with a power failure. :)

We use git-core on ext4 at GitHub, and we certainly have seen our share
of machines failing unexpectedly. We haven't seen any problems of this
nature[1] (but note that we journal data writes; you should also be fine
with ordered data writes, but data=writeback is likely disastrous).

> If you're on one of those filesystems where it is very easy and you
> lose power a lot, you'll probably want to enable the
> core.fsyncobjectfiles configuration option.  It might be worth adding
> another knob like that for the other files git writes if someone is
> interested.

You probably know this already Jonathan, but to be clear:

Git always fsyncs pack writes. That knob controls fsyncing of loose
object files, but nothing else. So ref writes (and writing packed-refs)
could be corrupted on a filesystem that doesn't order data and metadata
writes (and there is currently no way to tell git to do otherwise).

My recommendation would be to steer clear or reconfigure such systems,
but it also would not be very hard to add an optional fsync in those
cases.

-Peff

[1] We did have one case where after a crash packfiles would end up
    corrupted, but it turned out to be bad RAM in a battery-backed RAID
    card that was transparently caching (and losing) the writes.
    There's not much git can do when fsync lies to it, nor much the
    kernel can do when the hardware lies to it. :)
