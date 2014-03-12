From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] general style: replaces memcmp() with proper
 starts_with()
Date: Wed, 12 Mar 2014 17:39:44 -0400
Message-ID: <20140312213944.GA12818@sigill.intra.peff.net>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
 <20140312175624.GA7982@sigill.intra.peff.net>
 <xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
 <20140312194943.GA2912@sigill.intra.peff.net>
 <xmqq61njkwnw.fsf@gitster.dls.corp.google.com>
 <20140312211415.GA10305@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:39:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNqsR-0003r5-RC
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 22:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbaCLVjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 17:39:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:38386 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750981AbaCLVjq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 17:39:46 -0400
Received: (qmail 6458 invoked by uid 102); 12 Mar 2014 21:39:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 16:39:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 17:39:44 -0400
Content-Disposition: inline
In-Reply-To: <20140312211415.GA10305@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244001>

On Wed, Mar 12, 2014 at 05:14:15PM -0400, Jeff King wrote:

> I also think that "eof = next" (which I retained here) is off-by-one.
> "next" here is not the newline, but the start of the next line. And I'm
> guessing the code actually wanted the newline (otherwise "it->key" ends
> up with the newline in it). But we cannot just subtract one, because if
> we hit "eob", it really is in the right spot.

I started on a patch for this, but found another interesting corner
case. If we do not find a newline and hit end-of-buffer (which
_shouldn't_ happen, as that is a malformed commit object), we set "next"
to "eob". But then we copy the whole string, including *next into the
"value" of the header.

So we intend to capture the trailing newline in the value, and do in the
normal case. But in the end-of-buffer case, we capture an extra NUL. I
think that's OK, because the eventual fate of the buffer is to become a
C-string. But it does mean that the result sometimes has a
newline-terminator and sometimes doesn't, and the calling code needs to
handle this when printing, or risk lines running together.

Should this function append a newline if there is not already one? If
it's a mergetag header, we feed the result to gpg, etc, and expect to
get the data out verbatim. We would not want to mess that up. OTOH, the
commit object is bogus (and possibly truncated) in the first place, so
it probably doesn't really matter. And the GPG signature on tag objects
has its own delimiters, so a stray newline present or not at the end
should not matter.

-Peff
