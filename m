From: Jeff King <peff@peff.net>
Subject: Re: [PATCH, resent] fix openssl headers conflicting with custom
	SHA1 implementations
Date: Tue, 30 Sep 2008 23:47:12 -0400
Message-ID: <20081001034712.GE24513@coredump.intra.peff.net>
References: <alpine.LFD.2.00.0809301621091.3635@xanadu.home> <20080930203928.GN21310@spearce.org> <alpine.LFD.2.00.0809301645340.3635@xanadu.home> <20080930205122.GO21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 05:48:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkshh-0006BR-Vo
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 05:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbYJADrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 23:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbYJADrQ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 23:47:16 -0400
Received: from peff.net ([208.65.91.99]:1224 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbYJADrP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 23:47:15 -0400
Received: (qmail 14187 invoked by uid 111); 1 Oct 2008 03:47:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Sep 2008 23:47:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Sep 2008 23:47:12 -0400
Content-Disposition: inline
In-Reply-To: <20080930205122.GO21310@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97190>

On Tue, Sep 30, 2008 at 01:51:22PM -0700, Shawn O. Pearce wrote:

> Yea, its a bit ugly due to the rats nest of system includes.
> Right now I don't see how we can include your patch, it breaks a
> major platform for us.  But obviously my "fix" is also bogus and
> won't get ARM working again.
> 
> Any other ideas we can try?  'cause I don't have any right now.  :-|

I think you have an inherent conflict. Using openssl is going to end up
including their SHA definition, and we clearly can't include both..
Right now, you are trying to find a way to squeak by because imap-send
is the only thing that uses openssl, and it doesn't actually need our
SHA definition. But any solution that exploits that characteristic is
prone to failing later, when something _does_ need both of them.

You _could_ do something hack-ish like defining HEADER_SHA_H to avoid
theirs being loaded, but:

  1. You are relying on their header guard never changing.

  2. This actually leaves room for subtle problems, since some code
     thinks a SHA_CTX is defined one way, and other code thinks it is
     defined another way. If one piece of code passes a SHA_CTX to the
     other (say another part of openssl), you risk invoking nasal
     demons.

So I think the right way is probably to use a level of indirection. Turn
the ARM implementation into

  void ARM_SHA1_Init()

and

  #define SHA1_Init ARM_SHA1_Init

making sure not to allow such a macro to be in effect when including
openssl. This is similar to the way we override compat functions.

You can make it even simpler by just having all code call git_SHA1_Init,
and that will expand to whichever implementation has been chosen.

-Peff
