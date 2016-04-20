From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 0/3] Implements the GIT_TRACE_CURL environment variable
Date: Wed, 20 Apr 2016 16:45:00 -0400
Message-ID: <20160420204500.GB14904@sigill.intra.peff.net>
References: <20160420162825.62380-1-gitter.spiros@gmail.com>
 <xmqq4maww2bk.fsf@gitster.mtv.corp.google.com>
 <5717DD63.6050002@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	tboegi@web.de, sunshine@sunshineco.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 22:45:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asyzn-0002b0-T1
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 22:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbcDTUpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 16:45:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:53197 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750998AbcDTUpE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 16:45:04 -0400
Received: (qmail 13238 invoked by uid 102); 20 Apr 2016 20:45:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 16:45:02 -0400
Received: (qmail 2648 invoked by uid 107); 20 Apr 2016 20:45:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 16:45:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2016 16:45:00 -0400
Content-Disposition: inline
In-Reply-To: <5717DD63.6050002@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292074>

On Wed, Apr 20, 2016 at 08:49:55PM +0100, Ramsay Jones wrote:

> > Strictly speaking 1 should come at the end for the same reason, as
> > setting GIT_TRACE_CURL after seeing that commit would not give users
> > anything new.
> 
> Yep, I was just about to send an email saying that the patches should
> be in the exact opposite order! (ie. 1->3 and 3->1) That is *if* you
> want to keep them as a series. I would squash them into one patch ...

I also wondered about simply squashing them. IMHO it does not help to
split documentation from the addition of a feature. It is not as if we
will take one over the other, and by putting them in the same patch you
do not have to justify one without the other.

> > Other than that, I didn't find anything blatantly wrong ;-).  Will
> > nitpick individual patches later but I expect that it would be
> > sufficient to locally tweak while queuing without rerolling.
> 
> I have one small issue ... 

Overall I'm pleased at the concept, though I find the output a little
funny in places.

Most of the "Send/Recv SSL data" chunks are just line noise. Do people
actually care about seeing them? I can conceive of a case where you are
debugging SSL-level stuff, but I feel like you might do better using
openssl s_client to do so, and not git. Should we stick to more
HTTP-level debugging?

For the actual data packets, the first line gets treated differently
than the rest, and you get:

16:33:38.164068 http.c:515              => Send header, 0000000167 bytes (0x000000a7)
0000: GET /git/git/info/refs?service=git-upload-pack HTTP/1.1
16:33:38.164070 http.c:515              0039: Host: github.com
16:33:38.164072 http.c:515              004b: User-Agent: git/2.8.1.220.g9816fc6
...

for instance. Would it be saner to break the "Send header..." bit and
the first data line into separate trace outputs, and end up with
something more like:

16:33:38.164068 http.c:515              => Send header, 0000000167 bytes (0x000000a7)
16:33:38.164069 http.c:515              0000: GET /git/git/info/refs?service=git-upload-pack HTTP/1.1
16:33:38.164070 http.c:515              0039: Host: github.com
16:33:38.164072 http.c:515              004b: User-Agent: git/2.8.1.220.g9816fc6

Or it might even be nice to prefix each line to indicate it is about
sending a header. That would make it much easier to grep for just
particular 

It might even be nice to prefix _all_ of the lines with some state
information, like "send header". That's more verbose, but makes it much
easier to pick out snippets with line-oriented tools like grep. I often
find myself doing that kind of thing, either to inspect a subset of the
output, or because I want to be able to pull out things like request
content verbatim so I can replay it.

One of my complaints with GIT_CURL_VERBOSE is that it puts your
credentials into the debugging output. Since it looks like we're
parsing through the data anyway, I wonder if we could auto-censor
Authorization headers by default (and then possibly output them if an
extra variable is given). That would make it safe to ask people to show
the output of GIT_CURL_TRACE on the list without having to explain
further.

-Peff
