From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/6] commit: provide a function to find a header in a
 buffer
Date: Wed, 27 Aug 2014 14:16:06 -0400
Message-ID: <20140827181606.GA6590@peff.net>
References: <20140827075503.GA19521@peff.net>
 <20140827075600.GA26384@peff.net>
 <xmqqioldet75.fsf@gitster.dls.corp.google.com>
 <20140827180016.GA6269@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 20:16:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMhlW-0008Uf-UQ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 20:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935512AbaH0SQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 14:16:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:60228 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932413AbaH0SQI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 14:16:08 -0400
Received: (qmail 14842 invoked by uid 102); 27 Aug 2014 18:16:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 13:16:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 14:16:06 -0400
Content-Disposition: inline
In-Reply-To: <20140827180016.GA6269@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256018>

On Wed, Aug 27, 2014 at 02:00:16PM -0400, Jeff King wrote:

> That may be something some callers want, but they should build it
> separately around this find_commit_header, so that callers that want a
> single line (like "encoding" or "author") do not have to pay the price.
> I didn't bother building it out here since there are no callers which
> want it yet (though I did not look at the mergetag code, which could
> possibly be converted).

I just peeked at the mergetag code. It is all built around
read_commit_extra_headers, which is a different approach (it is "copy
out non-standard things", not "find this one thing I am looking for").

The former is more efficient if we are looking for lots of things, since
we'd only have to parse once. But we don't use it that way (we parse the
whole thing and then see if we have any "mergetag" headers).

The most efficient and convenient thing IMHO would be a progressive
parser that keeps a partially-parsed state and advances the parser
on-demand. So if I ask it for header "foo", it would start at the
beginning and parse until it finds "foo", marking the location of
anything along the way. If I then ask for "bar", it would keep going
from the end of "bar", and so forth.

I do not know if that is even worth the effort, though. I do not think
commit-parsing is a major hotspot for most operations (it might be for a
traversal, but we already use a minimalistic parser there that only
grabs the items that "struct commit" cares about). And we already
zlib-inflate the whole commit object in the first place, so it's not
like we haven't touched all these bytes anyway[1].

-Peff

[1] A long time ago I experimented with having parse_commit do a partial
    inflate, just up to the empty-line delimiter. I don't have the
    numbers handy, but I recall that it did not make a measurable
    improvement in rev-list speeds.
