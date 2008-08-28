From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 07:57:06 -0700
Message-ID: <20080828145706.GB21072@spearce.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 16:58:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYiwz-0001hn-1t
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 16:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbYH1O5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 10:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbYH1O5J
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 10:57:09 -0400
Received: from george.spearce.org ([209.20.77.23]:39626 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbYH1O5I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 10:57:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6C1BF38375; Thu, 28 Aug 2008 14:57:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vhc95iwcs.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94065>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > HTTP Redirects
> > --------------
> >
> > If a POST request results in an HTTP 302 or 303 redirect response
> > clients should retry the request by updating the URL and POSTing
> > the same request to the new location.  Subsequent requests should
> > still be sent to the original URL.
> 
> At the first reading I was confused because this seemed to contradict with
> the server pinning that is done by the payload level redirect.

This is meant to help load balancing initially target to a server.
I think its also reasonable to honor a transport level redirect,
much as we honor whatever route IP gives us (not that we have a
lot of choice - or even want one at that level).
 
> > Service upload-pack
> > -------------------
> >  one compute step:
> >  (c) Send an upload-pack request:
> >
> > 	C: 0011capabilities
> > 	C: 0024thin-pack include-tag ofs-delta
> > 	C: 0009want
> > 	C: 0xxx<WANT list>
> > 	C: 000bcommon
> > 	C: 0xxx<COMMON list>
> > 	C: 0009have
> > 	C: 0xxx<HAVE list>
> > 	C: 0000
> >
> >      The stream is organized into "sections", where each section is
> >      composed of two git pkt-lines.  The first pkt-line provides the
> >      name of the section ("capabilities", "want", "have", "common").
> >      The second pkt-line has the binary SHA-1 ids which compose that
> >      section.
> 
> It appears that you really meant "Binary", as opposed to "Hexadecimal"
> that show-ref example illustrate, judging from the later 3,276 number.
> I'd prefer hexadecimal here.

Yes, I really did mean for this part of the protocol to be in binary.
We have to exchange a bunch of commits to figure out what is common.
The binary form is 1/2 the size of the hexadecimal form, resulting
in fewer TCP packets for the same request.

Reading/writing the SHA-1s in binary is usually faster than doing
it in hex; you don't have to go through the formatting routines.
So there's a few less CPU cycles on the server end.

But the rest of the protocol is in hex and ASCII, so I guess it
does make sense to make this part be in hex too. I can change it
in the next draft.
 
> As a protocol specification, you'd eventually need to describe the
> pkt-line format, namely, (1) four hexadecimal digits that represents the
> length of the line (including that four bytes), followed by that many
> number of bytes as the line's payload, or (2) "0000" which is "flush".
> Also typically the text based line payload is LF terminated (hence the
> four-hexdigit length counts the terminating LF).

Yes.  I'll add that into the next draft.

> Also "capabilities" need
> to be defined.

Well, currently its just room for expansion.  But I'll try to define
it out better.  My initial thought is to do something like we have
in the native protocol where there are capability names "hidden"
on the end of the first pkt-line.  Only I'm making it explicit.
 
> >   (s) Parse the upload-pack request:
> >
> >       Verify all objects in WANT are reachable from refs.  As
> >       this may require walking backwards through history to
> >       the very beginning on invalid requests the server may
> >       use a reasonable limit of commits (e.g. 1000) walked
> >       beyond any ref tip before giving up.
> 
> I suspect moving as much work to the client side by erroring out and
> having the client restart from show-ref might be a better tradeoff (also
> this has been advertised as a security feature on the native protocol
> side).

I'm concerned about livelock.  If the client sees something in
show-ref, starts upload-pack and gets 2 round-trips into the common
exchange and then someone updates a ref the client wants, the client
has to go back to the beginning and start all over.

But if the object they want is still reachable (within a reasonable
distance) from the current refs, what is the harm in letting the
client see the stale view?  Especially since grabbing the most
current refs would still make that object available to the client?

Remember that is how the native protocol behaves.  You get a single
upload-pack process which has grabbed a snapshot of the refs.
If they change during the want-have-ack-nack exchange the client
doesn't get kicked out and asked to start all over again.  Same idea.
 
> >       If any WANT object is not reachable, send an error:
> >
> > 	S: 001estatus error invalid want
> >
> >      Create an empty list, S_COMMON.
> >
> >      If 'common' was sent:
> >
> >      Load all objects into S_COMMON.
> 
> Security?  Error out if some of them do not exist on the server end, at
> least.

I think I can add something saying its a protocol error if that
happens.  Its not a security risk, remember the S_COMMON set
eventually turns into the

  git rev-list --objects-edge $WANT --not $S_COMMON \
  | git pack-objects --stdout

Sending an S_COMMON the server doesn't have just causes it to fail.

If the server silently prunes out ones it doesn't know its not a
concern.  If the server has it, but it isn't advertised in a ref,
its also not a security risk.  No data from those objects is sent
back to the client.
 
> >   (s) Send the upload-pack response:
> >
> >      If the server has found a closed set of objects to pack, it
> >      replies with the pack and the enabled capabilities.  The set
> >      of enabled capabilities is limited to the intersection of
> >      what the client requested and what the server supports.
> 
> Define "closed set".

Yea, not only that I don't describe how the client can give up and
just ask for everything that is left.  Like say on an initial clone.
 
> >      The stream formatting rules are the same as the request.
> >
> >      The section "common" details the contents of S_COMMON,
> >      that is all objects from HAVE that the server also has.
> 
> An object in HAVE that exists on the server end can be a descendant of
> many other HAVEs. Answering with that youngest one alone is enough,
> without the other HAVEs the server end also has as its ancestors, as they
> are redundant information.

Yes, obviously.  I must not have made that clear here.  I'll try
to improve the language.
 
> >   (c) Parse the upload-pack response:
> >
> >       If the status pkt-line is "status pack:"
> >
> >       Process the pack stream and update the local refs.
> >
> >       If the status pkt-line is "status continue":
> >
> >       Reset COMMON to the items in S_COMMON.  The new S_COMMON
> >       should be a superset of the existing COMMON set.
> 
> Is there a way to detect bad clients that does not obey this rule without
> server side states?

No.  Is that really a concern though?

The worst a bad client can do here is cause itself to receive
more data than it wants by refusing to put things into COMMON.
Eventually it gives up and just clones the entire repository.  How is
that any different from a well behaved client doing an initial clone?

A bad client could also stick random things into COMMON.  If the
server doesn't have the object we error out (as you suggest above)
during the next call.  So the client has only DOS'd the server.
It can DOS the server easier other ways.

A bad client could stick only part of what S_COMMON into COMMON.
That may cause it to get a bigger pack file than it asked for as the
rev-list call won't be as limited.  How is that any different from
a well behaved client that is really behind and has a lot to fetch?

-- 
Shawn.
