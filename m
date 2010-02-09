From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: t5401-update-hooks test failure
Date: Tue, 9 Feb 2010 09:51:39 -0800
Message-ID: <20100209175139.GA28936@spearce.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org> <7vtytrih7b.fsf@alter.siamese.dyndns.org> <7vvde7h1mn.fsf@alter.siamese.dyndns.org> <20100208213256.GA470@coredump.intra.peff.net> <7viqa7cqs9.fsf@alter.siamese.dyndns.org> <20100208223107.GB21718@cthulhu> <7vpr4f9wey.fsf@alter.siamese.dyndns.org> <20100209045417.GA15210@cthulhu> <7v4olqlva7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Larry D'Anna <larry@elder-gods.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:51:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeuFZ-0000Ee-4U
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 18:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374Ab0BIRvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 12:51:44 -0500
Received: from mail-qy0-f190.google.com ([209.85.221.190]:51922 "EHLO
	mail-qy0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab0BIRvn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 12:51:43 -0500
Received: by qyk28 with SMTP id 28so739495qyk.25
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 09:51:42 -0800 (PST)
Received: by 10.229.214.69 with SMTP id gz5mr1299192qcb.106.1265737902112;
        Tue, 09 Feb 2010 09:51:42 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm210336iwn.3.2010.02.09.09.51.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 09:51:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v4olqlva7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139423>

Junio C Hamano <gitster@pobox.com> wrote:
> $ while sh t5401-*.sh -i; do :; done
> ... wait for a while ...
> * FAIL 12: send-pack stderr contains hook messages
> 
>                 grep ^remote: send.err | sed "s/ *\$//" >actual &&
>                 test_cmp - actual <expect
> 
> $ t/(364643e...); cat trash\ directory.t5401-update-hooks/actual 
> remote: STDOUT pre-receive
> remote: STDERR pre-receive
> remote: STDOUT update refs/heads/master
> remote: STDERR update refs/heads/master
> remote: STDOUT update refs/heads/tofail
> remote: STDOUT post-receive
> remote: STDERR post-receive
> remote: STDOUT post-update
> remote: STDERR post-update
> $ t/(364643e...); cat trash\ directory.t5401-update-hooks/expect 
> remote: STDOUT pre-receive
> remote: STDERR pre-receive
> remote: STDOUT update refs/heads/master
> remote: STDERR update refs/heads/master
> remote: STDOUT update refs/heads/tofail
> remote: STDERR update refs/heads/tofail
> remote: STDOUT post-receive
> remote: STDERR post-receive
> remote: STDOUT post-update
> remote: STDERR post-update

A quick visual inspection shows that only the STDERR tofail message
is missing here.  That sounds to me like a race condition in the
recv_sideband decoder.  Or, a race condition in the hook code in
builtin-receive-pack.c.

I doubt its in receive-pack. run_update_hook() directly calls the
copy_to_sideband() function, and that reads until EOF on the hook's
stderr stream before it returns and waits for the hook's exit status.
So we should be pulling everything and dumping it into the sideband.

builtin-send-pack.c clearly isn't stopping early while processing
the stream, since we see later messages from the post-receive and
post-update hooks just fine.

So I think the only code that is in question is the case 2 arm of
recv_sideband().  But to be honest, I can't find any fault with it.


I've been running this test in a while loop for a while now, and
I can't make it trigger this failure.  Maybe its possible that
its the update hook itself, not flushing its stderr buffer before
it terminates?

-- 
Shawn.
