From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/2] Decrease the fetch pack client buffer to the
	lower minimum
Date: Sun, 10 May 2009 17:55:26 -0700
Message-ID: <20090511005526.GI30527@spearce.org>
References: <1241995685-13260-1-git-send-email-spearce@spearce.org> <1241995685-13260-2-git-send-email-spearce@spearce.org> <7vfxfctqon.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 02:55:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Jnr-0003pm-II
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 02:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757207AbZEKAz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 20:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756390AbZEKAz0
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 20:55:26 -0400
Received: from george.spearce.org ([209.20.77.23]:33472 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756817AbZEKAzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 20:55:25 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2274A381D5; Mon, 11 May 2009 00:55:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vfxfctqon.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118765>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > This is the lowest buffer size we actually require to keep the
> > client and server sides from deadlocking against each other.
> 
> Is this about the fetch-pack protocol where

Yes.
 
>  (1) upload-pack shows what it has; fetch-pack keeps reading until it sees
>      a flush; then
> 
>  (2) fetch-pack shows what it wants; upload-pack keeps reading; then
> 
>  (3) fetch-pack sends a bunch of have's, followed by a flush; upload-pack
>      keeps reading and then responds with an ACK-continue or NAK, which
>      fetch-pack reads; this step continues zero or more times; and then
>      finally
> 
>  (4) fetch-pack sends a bunch of have's, followed by a flush; upload-pack
>      keeps reading and then responds with an ACK, fetch-pack says done.
> 
> Where do you need "enough buffer"?  The conversation looks very much "it's
> my turn to talk", "now it's your turn to talk and I'll wait until I hear
> from you", to me.  I am puzzled.

In step 3 during the first round the client can send up to 2 blocks
worth of data, with 32 haves per block.  This means the client
writes 2952 bytes of data before it reads.

C Git doesn't run into this sort of problem because a normal pipe
would get 1 page (~4096 bytes) in the kernel for the FIFO buffer.

In SSH transport, we still have 4096 between us and the ssh client
process, plus that has its own buffering.

In TCP transport, we have the kernel TX buffer on this side, and the
kernel RX buffer on the remote side, plus network switch buffers in
the middle.  2952 bytes nicely fits into just over 2 IP packets,
and the TCP window is sufficiently large enough to allow these to
be sent without blocking the writer.

We need to be able to shove 2952 bytes down at the other guy before
we start listening to him.  The upload-pack side of the system can
(at worst) send us 64 "ACK %s continue" lines.  We must be able
to enter into the receive mode before the upload-pack side fills
their outgoing buffer.

In the Sun JVMs a pure in-memory pipe only has room for 1024 bytes
in the FIFO before it blocks.  Though the technique I am using to
boost the FIFO from 1024 to 2952 bytes isn't necessarily going to
be portable to other JVMs.  If both sides only have 1024 bytes of
buffer available and both sides can possibly write more than that,
we deadlock.

> > +	/**
> > +	 * Amount of data the client sends before starting to read.
> > +	 * <p>
> > +	 * Any output stream given to the client must be able to buffer this many
> > +	 * bytes before the client will stop writing and start reading from the
> > +	 * input stream. If the output stream blocks before this many bytes are in
> > +	 * the send queue, the system will deadlock.
> > +	 */
> > +	protected static final int MIN_CLIENT_BUFFER = 2 * 32 * 46 + 4;

And this should be + 8 here.  F@!*!

Robin, can you amend?  It should be + 8 because we send to end()
packets in that initial burst, each packet is 4 bytes in size.

-- 
Shawn.
