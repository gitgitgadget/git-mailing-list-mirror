From: Jeff King <peff@peff.net>
Subject: Re: testing vger handling of charsets (part 2)
Date: Wed, 16 May 2007 06:55:24 -0400
Message-ID: <20070516105522.GA30256@coredump.intra.peff.net>
References: <20070515test.2@coredump.intra.peff.net> <7vmz05ffad.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kha@treskal.com, bfields@fieldses.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 12:55:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoHAN-0006Qq-IW
	for gcvg-git@gmane.org; Wed, 16 May 2007 12:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbXEPKz3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 06:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756477AbXEPKz3
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 06:55:29 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3803 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755169AbXEPKz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 06:55:28 -0400
Received: (qmail 13812 invoked from network); 16 May 2007 10:55:27 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 May 2007 10:55:27 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 16 May 2007 06:55:24 -0400
Content-Disposition: inline
In-Reply-To: <7vmz05ffad.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47431>

On Tue, May 15, 2007 at 11:34:02PM -0700, Junio C Hamano wrote:

> I think you are trying to figure out how vger adds/munges the
> headers, and the above is not very useful for people but
> yourself unless you explicitly say what headers you gave on your
> end in the body of the message, is it?

Yes, I'm sorry that the message itself looked a bit vague. It was
actually about the 4th or 5th such message I sent, as the list filter
kept blocking the previous ones, so with each iteration I made the
message shorter and shorter to try to remove any offending text.

So Karl and Bruce actually received several explanatory messages that
everyone else didn't, and I really only expected them to be replying.

> Judging from the list responses, I am guessing the situation is
> like this.  Does that match your understanding?

Yes, this is close.

> 	outgoing:
>         	body in utf-8
>         	Content-type: text/plain; charset=utf-8
>                 no MIME-Version: header
> 
> 	vger relayed to recipients:
>         	body untouched
>                 Content-type: text/plain; charset=iso-8859-1
>                 MIME-Version: 1.0

There is also a "Content-Transfer-Encoding: 8bit" that gets switched to
quoted-printable (and the body is actually encoded as QP). However, the
change of charset is the problem.

> I am not sure what exactly you meant by with/without "the right
> mime header", but the above is based on my guess that you meant
> only MIME-VERSION header.

Yes, the two messages differed _only_ in the presence of a MIME-Version
header.

So now that I have the data, let me explain the sequence of events in
the bug, which should hopefully explain what everyone has seen.

1. Bruce generates a message containing utf8 characters in the body and
the following headers:
  Content-Type: text/plain; charset=utf-8
  Content-Transfer-Encoding: 8bit
and _no_ MIME-Version header. This is produced by git-format-patch on a
commit with non-ascii in the body. The message is sent to vger, and cc'd
to some recipients, and we move to step 2.

2a. The cc'd recipients receive one copy of the message intact; none of
the mailservers along the route do any munging. This message is done.

2b. vger sends the message to each list member in turn. What the user
sees depends on the mail route. We move to step 3.

3a. If the next hop from vger advertises 8BITMIME in the SMTP session,
then vger submits the message intact. This is the case for me, so I see
all messages intact (and is why I needed responses from others --
specifically, I knew Karl and Bruce were seeing the problem). This
message is done.

3b. If the next hop does not advertise 8BITMIME, vger must convert the
message to a 7bit encoding (it chooses quoted-printable). Continue to
step 4.

4a. If the message has valid MIME headers, then vger can simply encode,
re-writing the content-transfer-encoding to quoted-printable and
encoding the body. vger considers valid mime headers to be a
MIME-version header and a content-type header. This is the case for the
second message I set, which appears correctly to all recipients.

4b. If the message doesn't have valid MIME headers, then vger adds the
headers. Without a MIME-Version header, it ignores the content-type and
guesses at a suitable one, using text/plain with some totally arbitrary
local charset (in this case "iso-8859-1"). This message has now been
incorrectly munged (claims latin1 charset, but has utf8 characters).
vger puts an explanation into the X-Warning headers of the munged
message (the only unexplained thing that I had to test is that
MIME-Version is critical to vger believing the current content-type).

So recipients see the bug IFF
   the original has utf8 characters
   AND the original lacks a MIME-Version header
   AND their mailserver doesn't claim 8BITMIME

Interestingly, rfc1428 claims that in this case vger should actually set
the charset to "unknown-8bit":

  If no information about the character set in use is available, the
  gateway should upgrade the content by using the character set
  "unknown-8bit". The unknown-8bit value of the charset parameter
  indicates only that no reliable information about the character set(s)
  used in the message was available.

Though that really just pushes the problem to the recipients MUA, and I
have no idea what the handling of "unknown-8bit" is like there.

-Peff
