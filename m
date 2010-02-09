From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: t5401-update-hooks test failure
Date: Tue, 09 Feb 2010 14:20:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002091337421.1681@xanadu.home>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
 <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
 <7vtytrih7b.fsf@alter.siamese.dyndns.org>
 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
 <20100208213256.GA470@coredump.intra.peff.net>
 <7viqa7cqs9.fsf@alter.siamese.dyndns.org> <20100208223107.GB21718@cthulhu>
 <7vpr4f9wey.fsf@alter.siamese.dyndns.org> <20100209045417.GA15210@cthulhu>
 <7v4olqlva7.fsf@alter.siamese.dyndns.org> <20100209175139.GA28936@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Larry D'Anna <larry@elder-gods.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 20:20:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nevdp-0001D9-6b
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 20:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab0BITUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 14:20:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21441 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab0BITUv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 14:20:51 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXL0032F9QPYFB0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 Feb 2010 14:20:50 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100209175139.GA28936@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139435>

On Tue, 9 Feb 2010, Shawn O. Pearce wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > $ while sh t5401-*.sh -i; do :; done
> > ... wait for a while ...
> > * FAIL 12: send-pack stderr contains hook messages
> > 
> >                 grep ^remote: send.err | sed "s/ *\$//" >actual &&
> >                 test_cmp - actual <expect
> > 
> > $ t/(364643e...); cat trash\ directory.t5401-update-hooks/actual 
> > remote: STDOUT pre-receive
> > remote: STDERR pre-receive
> > remote: STDOUT update refs/heads/master
> > remote: STDERR update refs/heads/master
> > remote: STDOUT update refs/heads/tofail
> > remote: STDOUT post-receive
> > remote: STDERR post-receive
> > remote: STDOUT post-update
> > remote: STDERR post-update
> > $ t/(364643e...); cat trash\ directory.t5401-update-hooks/expect 
> > remote: STDOUT pre-receive
> > remote: STDERR pre-receive
> > remote: STDOUT update refs/heads/master
> > remote: STDERR update refs/heads/master
> > remote: STDOUT update refs/heads/tofail
> > remote: STDERR update refs/heads/tofail
> > remote: STDOUT post-receive
> > remote: STDERR post-receive
> > remote: STDOUT post-update
> > remote: STDERR post-update
> 
> A quick visual inspection shows that only the STDERR tofail message
> is missing here.  That sounds to me like a race condition in the
> recv_sideband decoder.  Or, a race condition in the hook code in
> builtin-receive-pack.c.
> 
> I doubt its in receive-pack. run_update_hook() directly calls the
> copy_to_sideband() function, and that reads until EOF on the hook's
> stderr stream before it returns and waits for the hook's exit status.
> So we should be pulling everything and dumping it into the sideband.
> 
> builtin-send-pack.c clearly isn't stopping early while processing
> the stream, since we see later messages from the post-receive and
> post-update hooks just fine.
> 
> So I think the only code that is in question is the case 2 arm of
> recv_sideband().  But to be honest, I can't find any fault with it.

Note that strict order of messages passed through the sideband can't be 
relied upon.  Often you have sideband 1 connected to stdin and sideband 
2 connected to stderr, and they are linked with pipes, and various 
factors such as stdio buffering or even printf implementation in the C 
lib, pipe buffers in the OS, random scheduling between the processes 
involved, and other factors such as disk or network speed vs CPU speed, 
are all adding to a certain degree of randomness affecting how the data 
end up in various channels wrt each other.

See my efforts to reduce that issue so far with those commits:

6b59f51b312f06d9420d34c09fa408c658aac6d2

6b9c42b4daabe3d0471d9f90d2ae472c9d994e1c

d048a96ee9bec968be0bdc9c43ffce61169545be

ebe8fa738dcf6911fe520adce0cfa0cb26dee5e2


Nicolas
