From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] multi_ack protocol v2
Date: Thu, 27 Oct 2005 11:37:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510271107570.5970@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510270149590.12163@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmov4elu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 11:38:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV4Ce-0000pm-Uu
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 11:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbVJ0Jhf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 05:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVJ0Jhf
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 05:37:35 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27351 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932621AbVJ0Jhe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 05:37:34 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7C69913F3C0; Thu, 27 Oct 2005 11:37:31 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5DE89B4EB4; Thu, 27 Oct 2005 11:37:31 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 33EE8B4EA6; Thu, 27 Oct 2005 11:37:31 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ACD6A13F4DD; Thu, 27 Oct 2005 11:37:29 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmov4elu.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10706>

Hi,

On Thu, 27 Oct 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > after thinking about my earlier approach, I think there's a better, less 
> > intrusive, and all in all just simpler approach:
> >
> > - client asks for multi_ack protocol by sending " multi_ack" at the end
> >   of at least one "want" line
> > - server appends " continue" to the ACK message, but continues sending
> >   ACK (but not NAK) messages

Here must be a correction: server continues to send NAK messages. Else we 
must introduce some select() or poll() crud, or the client hangs forever.

> > - after receiving "done", server repeats last ACK message without 
> >   " continue" appended

In effect, an ACK message with "continue" switches into v2, which 
just means: "I'll keep sendin'", and an ACK *without* "continue" switches 
back to v1.

This way the patch looks almost trivial. (Will send soon).

> > After much fun with non-working, fragile code which had to be retracted 
> > from master, I hope that this approach is less prone to errors.
> 
> Sorry for a late reply -- real life interrupts ;-).

No problem (hope you enjoyed it ;-). I tried to get some Zs anyway.

> Sending "have you found a common yet" every 32 "have" like the
> original protocol does has a nice batching property (I think we
> could even tweak pkt-line.c::packet_write() to actually buffer
> these "have"s and write them out in one-go, to put them in a
> single network packet) and I do not want to lose it, but other
> than that, since you have found a good way to extend the initial
> handshake to find out if both ends can do a v2 protocol without
> breaking older server nor clients, I have no objection against
> doing things drastically differently in the v2 protocol.

I think that we don't need to extend packet_write(). Let's leave it like 
that.

> upload-pack (S) | fetch/clone-pack (C) protocol (v1):
> 
> 	# Tell the puller what commits we have and what their names are
> 	S: SHA1 name
> 	S: ...
> 	S: SHA1 name
> 	S: # flush -- it's your turn
> 	# Tell the pusher what commits we want, and what we have
> 	C: want SHA1
> 	C: ..
> 	C: want SHA1
> 	C: # flush -- done with "want" lines.
> 	C: have SHA1
> 	C: have SHA1
> 	C: ...
> 	C: # flush -- this occasionally asks "had enough?"
> 	S: NAK
>         # and the server answers "notyet"
> 	C: have SHA1
> 	C: ...
> 	C: have SHA1
> 	S: ACK SHA1
> 	C: done
> 	S: XXXXXXX -- packfile contents.

alternatively, when no "ACK" was sent, the response to "done" is "NAK".

> I wrote as if "want" sends names, but it actually sends SHA1s.

You also ask if it is sensible in upload-pack.c to accept names. I think 
not. SHA1s are supposed to be unique, names not (master~10 is likely to 
denote different commits on server and client).

> Also I missed a place where "flush" was needed.

Between "want" and "have". It is sent so that the server can handle them 
in separate functions.

> upload-pack (S) | fetch/clone-pack (C) protocol (v2):
> 
> 	# Tell the puller what commits we have and what their names are
> 	S: SHA1 name
> 	S: ...
> 	S: SHA1 name
> 	S: # flush -- it's your turn
> 	# Tell the pusher what commits we want, and what we have.
>         # In addition, we tell the other end that we support protocol
> 	# extensions, without breaking the old servers.
> 	C: want SHA1 extended
> 	C: ..
> 	C: want SHA1
> 	C: # flush -- done with "want" lines.
> 
> Notice that until we hear from the server, we cannot tell if our
> "extended" protocol wish will be granted, and in the original
> protocol, "NAK" will come in fixed length, and the only thing we
> could tack arbitrary garbage to was "ACK SHA1".  That's why your
> "ACK SHA1 continue" works nicely, but at the time you could not
> find out if you are talking with updated server until you get at
> least one ACK.
> 
> However, at this point, we *could* force the server to reveal
> what it supports, by doing an extra flush here, before sending
> *ANY* "have" lines yet:
> 
> 	C: # flush -- this is another one after "I'm done with wants".

We don't need a second flush. The first can do. The client just has to 
expect either "NAK" or "VER blabla blibli multi_ack". "VER" must be sent 
by the server only when the client requested an extension the server has,
though.

> 	S: proto v2 v3 v5

As written above, I'd prefer something like "VER" in order to stay with 
the 3 capital letters convention. Also, I like to read what it is about, 
i.e. "VER multi_ack" instead of "VER v2".

> 	C: proto v2

I'd say that this is not necessary. Client can send that in the "want" 
lines.

> After this exchange, both ends know they understand and would
> want to talk at protocol level v2.  This leaves door open for
> future protocol extension, but more importantly, I think this
> arrangement would make things safer.

Yes. Nice.

I especially like that the client learns early that multi_ack protocol it 
is. In my tests, non-multi_ack would only be happy when fed with commits 
sorted by date, while multi_ack is much more efficient when fed commits 
sorted by distance-to-tip (I cannot yet explain why this is so).

Ciao,
Dscho
