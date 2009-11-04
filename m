From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Tue, 3 Nov 2009 16:56:14 -0800
Message-ID: <20091104005614.GD10505@spearce.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com> <7v4opbp1fa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 01:56:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5UAs-0000aZ-0N
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 01:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbZKDA4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 19:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbZKDA4K
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 19:56:10 -0500
Received: from george.spearce.org ([209.20.77.23]:50220 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbZKDA4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 19:56:09 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id ED4E5381FE; Wed,  4 Nov 2009 00:56:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v4opbp1fa.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132015>

Junio C Hamano <gitster@pobox.com> wrote:
> Scott Chacon <schacon@gmail.com> writes:
> 
> > diff --git a/Documentation/technical/protocol-capabilities.txt
> > +
> > +The client MUST send only maximum of one of "side-band" and "side-
> > +band-64k".  Server MUST favor side-band-64k if client requests both.
> 
> Again I think sending both is an error and should be diagnosed as such.
> This is not a three-way handshake where I say "I can handle both", you say
> "I can too", and then I finally pick "then we'll use this one".  There is
> no way for the requesting side to tell which one was chosen, and the
> requester who sent both assumed that the other end chose "side-band" and
> allocated only a 1000-byte buffer like older implementation did, the limit
> of buffer will be busted.

I think Scott borrowed the above from me.  The last sentance with that
server MUST is my error.
 
> Fix the last line "Server MUST favor" to "Server MUST diagnose it as an
> error".  Also drop "A client should ask for only one of them," near the
> beginning of this section, as it is redundant.  I think it is fine to keep
> "A modern client always favors".

Ack, I agree.

> > +include-tag
> > +-----------
> > +
> > +The 'include-tag' capability is about sending tags if we are sending
> > +objects they point to.  If we pack an object to the client, and a tag
> > +points exactly at that object, we pack the tag too.  In general this
> > +allows a client to get all new tags when it fetches a branch, in a
> > +single network connection.
> > +
> > +Clients MAY always send include-tag, hardcoding it into a request.
> 
> "... when the server advertises this capability", no?

This is also my fault.  Its rooted in the way the C implementation
of upload-pack parses the want line, it doesn't care if there are
unrecognized capabilities requested by the client.  This is a bug
in the C implementation.

I agree with you, and disagree with the original text I wrote.
 
> > +Clients SHOULD NOT send include-tag if remote.name.tagopt was set to
> > +--no-tags, as the client doesn't want tag data.
> > +
> > +Servers MUST accept include-tag without error or warning, even if the
> > +server does not understand or support the option.
> 
> Why is this special case here?

Ack, I agree with you, this should be removd.

> > +Servers SHOULD pack the tags if their referrant is packed and the
> > +client has requested include-tag.
> 
> Sorry, I do not understand the motivation to make make this so weak?  If
> the server claims to support this capability, and when a referrant is
> going to the client, the server MUST do so---if it cannot guarantee, why
> claim to support that capability?
> 
> Or am I missing something?

IIRC at one time the C implementation didn't fully ensure the tag is
packed when the referrant is packed.  This SHOULD exists because it
may have been possible for a tag to be omitted.  But I don't think
I've seen this happen under any condition, and it probably is now
a bug if it occurs, which means we likely can convert this to a MUST.
 
> > diff --git a/Documentation/technical/protocol-common.txt
> > +...
> > +pkt-line Format
> > +---------------
> > +
> > +Implementations SHOULD NOT send an empty pkt-line ("0004").
> 
> Not an objection, but where is this coming from?

Me.  I think sending "0004" is stupid.

"0004" must immediately be followed by another pkt-len because there
is no data payload behind it.  "0004" is the same as having called
write(fd, buf, 0), which is equally pointless.  Such a kernel call
will be a no-op, my point here is that "0004" as a packet is also
stupid and shouldn't be sent.
 
> > +A pkt-line with a length field of 0 ("0000"), called a flush-pkt,
> > +is a special case and MUST be handled differently than an empty
> > +pkt-line ("0004").
> 
> ...especially that this sentence makes it sound as if it is perfectly
> normal to send "0004" for "an empty line" (and I've always thought that is
> Ok), I am quite puzzled by that "SHOULD NOT".

I don't think we ever send an empty packet.  If we have no data to
send, why the hell did we create the packet header?

-- 
Shawn.
