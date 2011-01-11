From: Jeff King <peff@peff.net>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 12:50:31 -0500
Message-ID: <20110111175031.GA2085@sigill.intra.peff.net>
References: <4D262D68.2050804@cfl.rr.com>
 <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com>
 <20110107205103.GC4629@burratino>
 <4D278930.7010100@cfl.rr.com>
 <20110107214907.GA9194@burratino>
 <20110107220942.GB10343@sigill.intra.peff.net>
 <7vmxnc48yt.fsf@alter.siamese.dyndns.org>
 <20110111053653.GB10094@sigill.intra.peff.net>
 <7vr5cj49vi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 18:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PciMk-0007Iu-OT
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 18:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516Ab1AKRui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 12:50:38 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33526 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932442Ab1AKRug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 12:50:36 -0500
Received: (qmail 14376 invoked by uid 111); 11 Jan 2011 17:50:33 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 17:50:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 12:50:31 -0500
Content-Disposition: inline
In-Reply-To: <7vr5cj49vi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164961>

On Tue, Jan 11, 2011 at 09:40:17AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Sure, I think that is a sane way for the user to think about it, but do
> > we actually support multiple views? I thought replacement objects were
> > all or nothing.
> 
> It is not implausible for a long running large project to restart their
> history from a physical root commit every year, stiching the year-long
> segments together at their ends with replacements, to make a default clone
> to get a year's worth of the most recent history while allowing people to
> get more by asking, no?

Oh, absolutely I think it is reasonable. I just meant that we do not
have a convenient way of saying "fetch these replace objects, but only
use this particular subset". I think you are stuck with something manual
like:

  # grab "view" from upstream and name it; let's imagine it links 2010
  # history into 2009
  git fetch origin refs/replace/$sha1 refs/views/2009/$sha1

  # now we feel like using them
  git for-each-ref --shell --format='%(refname)' refs/views/2009 |
    while read ref; do
      git update-ref "refs/replace/${ref#refs/views/2009}" "$ref"
    done

Which is a little overkill for the simple example you gave, but would
also handle something as complex as a view like "pretend the foo/
subtree never existed" or even "pretend the foo/ subtree existed all
along".

Not that I'm sure such things are actually sane to do, performance-wise.
The replace system is fast, but it was designed for a handful of
objects, not hundreds or thousands.

Anyway. My point is that we don't have the porcelain to do something
like managing views or enabling/disabling them in a sane manner.

-Peff
