From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] optimizing pack access on "read only" fetch repos
Date: Tue, 29 Jan 2013 07:58:01 -0800
Message-ID: <7vwquwrng6.fsf@alter.siamese.dyndns.org>
References: <20130126224011.GA20675@sigill.intra.peff.net>
 <7vlibfxhit.fsf@alter.siamese.dyndns.org>
 <20130129082939.GB6396@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 16:58:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0DZs-0000vY-T9
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 16:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab3A2P6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 10:58:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522Ab3A2P6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 10:58:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AE72C1FE;
	Tue, 29 Jan 2013 10:58:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TAntR84HjBoATKK48mnCc9iehPU=; b=DvkNms
	1G7zefG2NcoMWgbLSWaYW9oCaipBrpddvyZAxUmGpkOLXPvjnqjbZ8ANaj3LrjvM
	/7ga9fLfl2GIqkQVC25KGbi8Wu7HcoN55o5oSCOwDgq/NT0Ra3zZyfBiIo6rtC6P
	vq9uAzmWTvAY2QjszCM4SZiH1MmiIbQkX6kjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LTTLDjymBLS/4LPP8mSTvXe3YVH7X6Co
	dDuvKQ+08y5ULYeQueI9/34ORKy9h/RQuKXytHM3LHV6fBLPSCTOSFSVEQRLp5QT
	NklHPUWm/A++IR5u96D/CO+3Lemb/W1nM+bl3vHYOBt8l4i0xsHgQAZKWw5XP+zH
	ZLDpdtJGvpI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F4013C1FD;
	Tue, 29 Jan 2013 10:58:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B772C1FA; Tue, 29 Jan 2013
 10:58:03 -0500 (EST)
In-Reply-To: <20130129082939.GB6396@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 29 Jan 2013 03:29:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9CDE6CC-6A2C-11E2-A518-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214942>

Jeff King <peff@peff.net> writes:

>> I also wonder if we would be helped by another "repack" mode that
>> coalesces small packs into a single one with minimum overhead, and
>> run that often from "gc --auto", so that we do not end up having to
>> have 50 packfiles.
>> ...
>
> I'm not sure. If I understand you correctly, it would basically just be
> concatenating packs without trying to do delta compression between the
> objects which are ending up in the same pack. So it would save us from
> having to do (up to) 50 binary searches to find an object in a pack, but
> would not actually save us much space.

The point is not about space.  Disk is cheap, and it is not making
it any worse than what happens to your target audience, that is a
fetch-only repository with only "gc --auto" in it, where nobody
passes "-f" to "repack" to cause recomputation of delta.

What I was trying to seek was a way to reduce the runtime penalty we
pay every time we run git in such a repository.

 - Object look-up cost will become log2(50*n) from 50*log2(n), which
   is about 50/log2(50) improvement;

 - System resource cost we incur by having to keep 50 file
   descriptors open and maintaining 50 mmap windows will reduce by
   50 fold.

 - Anything else I missed?

> I would be interested to see the timing on how quick it is compared to a
> real repack,...

Yes, that is what I meant by "wonder if we would be helped by" ;-)

> But how do these somewhat mediocre concatenated packs get turned into
> real packs?

How do they get processed in a fetch-only repositories that
sometimes run "gc --auto" today?  By runninng "repack -a -d -f"
occasionally, perhaps?

At some point, you would need to run a repack that involves a real
object-graph traversal that feeds you the paths for objects to
obtain a reasonably compressed pack.  We can inspect existing packs
and guess a rough traversal order for commits, but for trees and
blobs, you cannot unify existing delta chains from multiple packs
effectively with data in the pack alone.
