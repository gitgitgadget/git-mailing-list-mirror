From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] multi_ack protocol v2
Date: Thu, 27 Oct 2005 00:13:17 -0700
Message-ID: <7vzmov4elu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510270149590.12163@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 09:13:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV1wx-0004vh-3k
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 09:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVJ0HNT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 03:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVJ0HNT
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 03:13:19 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:32494 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964975AbVJ0HNS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 03:13:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051027071303.SLIL16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Oct 2005 03:13:03 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510270149590.12163@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 27 Oct 2005 02:16:45 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10699>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> after thinking about my earlier approach, I think there's a better, less 
> intrusive, and all in all just simpler approach:
>
> - client asks for multi_ack protocol by sending " multi_ack" at the end
>   of at least one "want" line
> - server appends " continue" to the ACK message, but continues sending
>   ACK (but not NAK) messages
> - after receiving "done", server repeats last ACK message without 
>   " continue" appended
>
> After much fun with non-working, fragile code which had to be retracted 
> from master, I hope that this approach is less prone to errors.

Sorry for a late reply -- real life interrupts ;-).

I do not necessarily think the last round (still found in the
proposed updates branch) was a failure.  One valuable thing you
found out was that there is a way to extend the protocol with
the appended "multi-ack" trick.

Sending "have you found a common yet" every 32 "have" like the
original protocol does has a nice batching property (I think we
could even tweak pkt-line.c::packet_write() to actually buffer
these "have"s and write them out in one-go, to put them in a
single network packet) and I do not want to lose it, but other
than that, since you have found a good way to extend the initial
handshake to find out if both ends can do a v2 protocol without
breaking older server nor clients, I have no objection against
doing things drastically differently in the v2 protocol.

I noticed the sketch in Documentation/pack-protocol.txt is
somewhat buggy.  Here is my attempt to correct it:

upload-pack (S) | fetch/clone-pack (C) protocol (v1):

	# Tell the puller what commits we have and what their names are
	S: SHA1 name
	S: ...
	S: SHA1 name
	S: # flush -- it's your turn
	# Tell the pusher what commits we want, and what we have
	C: want SHA1
	C: ..
	C: want SHA1
	C: # flush -- done with "want" lines.
	C: have SHA1
	C: have SHA1
	C: ...
	C: # flush -- this occasionally asks "had enough?"
	S: NAK
        # and the server answers "notyet"
	C: have SHA1
	C: ...
	C: have SHA1
	S: ACK SHA1
	C: done
	S: XXXXXXX -- packfile contents.

I wrote as if "want" sends names, but it actually sends SHA1s.
Also I missed a place where "flush" was needed.

So let's illustrate the v2 the same way as I understand it.

upload-pack (S) | fetch/clone-pack (C) protocol (v2):

	# Tell the puller what commits we have and what their names are
	S: SHA1 name
	S: ...
	S: SHA1 name
	S: # flush -- it's your turn
	# Tell the pusher what commits we want, and what we have.
        # In addition, we tell the other end that we support protocol
	# extensions, without breaking the old servers.
	C: want SHA1 extended
	C: ..
	C: want SHA1
	C: # flush -- done with "want" lines.

Notice that until we hear from the server, we cannot tell if our
"extended" protocol wish will be granted, and in the original
protocol, "NAK" will come in fixed length, and the only thing we
could tack arbitrary garbage to was "ACK SHA1".  That's why your
"ACK SHA1 continue" works nicely, but at the time you could not
find out if you are talking with updated server until you get at
least one ACK.

However, at this point, we *could* force the server to reveal
what it supports, by doing an extra flush here, before sending
*ANY* "have" lines yet:

	C: # flush -- this is another one after "I'm done with wants".

Upon receiving this, if we were talking with an old upload-pack,
we would certanly get an NAK.  Note that the server already
knows that we support extended protocol at this point, so our
updated server can send anything here to say it knows what
protocol extensions it supports.  Let's say it says something
like this:

	S: proto v2 v3 v5

to tell the puller it understands protocol v2, v3, and v5, to
which the puller responds:

	C: proto v2

After this exchange, both ends know they understand and would
want to talk at protocol level v2.  This leaves door open for
future protocol extension, but more importantly, I think this
arrangement would make things safer.

Both the server side and the client side code can be modified
from the current one by splitting the above handshake part and
the current trusty "only one ACK is supported" code, and the
exchange after this protocol negotiation part can be implemented
in totally separate functions.  We could also give command line
option and/or .git/config item to limit the protocol level each
end supports when we find the v2 protocol implementation of the
day was buggy, in order to work problems around without
recompilation, reducing the risk of breaking things too much.
