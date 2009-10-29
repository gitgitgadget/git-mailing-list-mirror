From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 06/26] Add multi_ack_detailed capability to
	fetch-pack/upload-pack
Date: Thu, 29 Oct 2009 09:17:48 -0700
Message-ID: <20091029161748.GB10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-7-git-send-email-spearce@spearce.org> <7v4opibv4i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 17:18:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3XhJ-0001Wv-03
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 17:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbZJ2QRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 12:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753076AbZJ2QRo
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 12:17:44 -0400
Received: from george.spearce.org ([209.20.77.23]:37962 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbZJ2QRn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 12:17:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 48099381D3; Thu, 29 Oct 2009 16:17:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v4opibv4i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131608>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > ACK %s
> > -----------------------------------
> >   * no multi_ack or multi_ack_detailed:
> >
> >     Sent in response to "have" when the object exists on the remote
> >     side and is therefore an object in common between the peers.
> >     The argument is the SHA-1 of the common object.
> 
> Do you mean by "exists" something a bit stronger than that, namely, it
> exists and everything reachable from it also exists, right?

No, I mean "object exists".  The upload-pack code makes no check that
the object is in fact complete, just that it has the object in the
object database.  The object could be a dangling commit whose parents
aren't present, and we'd still (currently) return an "ACK %s" for it.

I specifically didn't get into completeness here because we don't
actually check for it.
 
> > ACK %s common
> > -----------------------------------
> >   * multi_ack_detailed only:
> >
> >     Sent in response to "have".  Both sides have this object.
> >     Like with "ACK %s continue" above the client should stop
> >     sending have lines reachable for objects from the argument.
> >
> > ACK %s ready
> > -----------------------------------
> >   * multi_ack_detailed only:
> >
> >     Sent in response to "have".
> >
> >     The client should stop transmitting objects which are reachable
> >     from the argument, and send "done" soon to get the objects.
> >
> >     If the remote side has the specified object, it should
> >     first send an "ACK %s common" message prior to sending
> >     "ACK %s ready".
> >
> >     Clients may still submit additional "have" lines if there are
> >     more side branches for the client to explore that might be added
> >     to the common set and reduce the number of objects to transfer.
> 
> I do not understand this after reading it three times.  The remote side
> says "ACK $it common", allow the requestor to feed more "have", then
> eventually send an "ACK $it ready" for the same object it earlier sent
> "common" for?  The first one tells the requestor not to go down the path
> from $it further, so presumably all the "have"s that come after it will be
> about different ancestry paths.
> 
> What is the advantage of using this?  In other words, how, in what
> situation and why would the remote side choose to use "ready" --- it looks
> to me that it could always say "common" whenever it hits a "have" that it
> can determine to be common.

"ACK $it ready" should be used when ok_to_give_up() returns true.

The "ACK $it ready" message is trying to say "don't talk any more
about things reachable from $it, and by the way, if you say 'done'
now I will give you a pack".

The "ACK $it common" message is trying to say "$it is a common base,
don't talk any more about things reachable from $it, but there
may be other branches you should explore before I send you a pack,
so talk about those if you can".


A client only wants to store $it into its request state vector for
replay on the next RPC if $it is truely common.

The "ACK $it common" before "ACK $it ready" is because clients can't
assume that "ACK $it ready" means $it is really common.  Servers send
"ACK $it ready" if they don't have $it but are ok_to_give_up().
But if it is common, *and* ok_to_give_up() is true, a server can
send both messages, but it must send "ACK $it common" first.

-- 
Shawn.
