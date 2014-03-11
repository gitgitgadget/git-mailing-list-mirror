From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Mon, 10 Mar 2014 21:49:45 -0400
Message-ID: <20140311014945.GB12033@sigill.intra.peff.net>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu>
 <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu>
 <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
 <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org>
 <CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 02:49:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNBpJ-0001BA-9g
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 02:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbaCKBts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 21:49:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:36984 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753951AbaCKBtr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 21:49:47 -0400
Received: (qmail 3950 invoked by uid 102); 11 Mar 2014 01:49:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Mar 2014 20:49:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Mar 2014 21:49:45 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243832>

On Sun, Feb 23, 2014 at 09:44:14AM +0700, Duy Nguyen wrote:

> (Digging up an old thread about initial refs listing in git protocol)

And now I am responding to it slowly. :)

> > For that to work, the new server needs to wait for the client to
> > speak first.  How would that server handle old clients who expect to
> > be spoken first?  Wait with a read timeout (no timeout is the right
> > timeout for everybody)?
> 
> I think the client always speaks first when it asks for a remote
> service. Earlier in this thread you described the new protocol
> upload-pack-2. Why can't it be a new service "upload-pack-2" in
> git-daemon?
> 
> So new client will try requesting "upload-pack-2" service with client
> capability advertisement before ref listing. Old servers do not
> recognize this service and disconnect so the new client falls back to
> the good old "upload-pack" (one more round trip though, but you could
> configure new client to use old protocol for certain "old" hosts).
> Similar thing happens for ssh transport. "upload-pack" service is
> always there for old clients.

Right, I recall the general feeling being that such a system would work,
and the transition would be managed by a config variable like
"remote.*.useUploadPack2". Probably with settings like:

  true:
    always try, but allow fall back to upload-pack

  false:
    never try, always use upload-pack

  auto:
    try, but if we fail, set remote.*.uploadPackTimestamp, and do not
    try again for N days

The default would start at false, and people who know their server is
very up-to-date can turn it on. And then when many server
implementations support it, flip the default to auto. And either leave
it there forever, or eventually just set it to "true" and drop "auto"
entirely as a code cleanup.

In theory we could do more radical protocol changes here, but I think
most people are just interested in adding an opportunity for the client
to speak before the ref advertisement in order to set a few
flags/variables.  That should be relatively simple, and for http we can
probably pass those flags via url parameters without any extra
compatibility/round-trip at all.

I think the main flag of interest is giving an fnmatch pattern to limit
the advertised refs. There could potentially be others, but I do not
know of any offhand.

-Peff
