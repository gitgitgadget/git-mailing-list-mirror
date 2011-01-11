From: Jeff King <peff@peff.net>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 12:39:22 -0500
Message-ID: <20110111173922.GB1833@sigill.intra.peff.net>
References: <4D262D68.2050804@cfl.rr.com>
 <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com>
 <20110107205103.GC4629@burratino>
 <4D278930.7010100@cfl.rr.com>
 <20110107214907.GA9194@burratino>
 <20110107220942.GB10343@sigill.intra.peff.net>
 <4D27B33C.2020907@cfl.rr.com>
 <20110111054735.GC10094@sigill.intra.peff.net>
 <4D2C7611.6060204@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 18:39:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PciBv-0000GY-0z
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 18:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab1AKRj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 12:39:27 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41874 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab1AKRjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 12:39:25 -0500
Received: (qmail 14208 invoked by uid 111); 11 Jan 2011 17:39:24 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 17:39:24 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 12:39:22 -0500
Content-Disposition: inline
In-Reply-To: <4D2C7611.6060204@cfl.rr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164958>

On Tue, Jan 11, 2011 at 10:24:01AM -0500, Phillip Susi wrote:

> Yes, either a new branch or separate historical repository could be
> published to pull the original history from, or git would need to pass
> the --no-replace-objects flag to git-upload-pack on the server, causing
> it to ignore the replace and send the original history.

AFAIK, git can't pass --no-replace-objects to the server over git:// (or
smart http). You would need a protocol extension.

And here's another corner case I thought of:

Suppose you have some server S1 with this history:

  A--B--C--D

and a replace object truncating history to look like:

  B'--C--D

You clone from S1 and have only commits B', C, and D (or maybe even B,
depending on the implementation). But definitely not A, nor its
associated tree and blobs.

Now you want to fetch from another server S2, which built some commits
on the original history:

  A--B--C--D--E--F

You and S2 negotiate that you both have D, which implies that you have
all of the ancestors of D. S2 therefore sends you a thin pack containing
E and F, which may contain deltas against objects found in D or its
ancestors. Some of which may be only in A, which means you do not have
them.

Aside from fetching the entire real history, the only solution is that
you somehow have to communicate to S2 exactly which objects you have,
presumably by telling them which replacements you have used to arrive at
the object set you have. Which in the general case would mean actually
shipping them your replacement refs and objects (simply handling the
special case of commit truncation isn't sufficient; you could have
replaced any object with any other one).

-Peff
