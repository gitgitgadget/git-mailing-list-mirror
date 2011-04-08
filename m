From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "prune" prone to clock skew (Re: t3306 failure with v1.7.5-rc1)
Date: Fri, 08 Apr 2011 11:51:10 -0700
Message-ID: <7vei5c4lwh.fsf@alter.siamese.dyndns.org>
References: <4D9ECF7C.6010709@drmicha.warpmail.net>
 <4D9EB406.5080302@viscovery.net> <4D9EB57D.1060402@drmicha.warpmail.net>
 <4D9EBC41.4080501@drmicha.warpmail.net>
 <20110408163021.GB32709@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 20:51:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8GmK-0007zZ-EK
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 20:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377Ab1DHSv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 14:51:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab1DHSvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 14:51:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 06161461B;
	Fri,  8 Apr 2011 14:53:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=whg2+ewRr4BWBC3E/ecKVCnUhRU=; b=WUkQec
	XH4g0+Wkc3r+kiPLUiyTrxgi+hy/xdtt6tcQRoXTeMrB5xHYp8CNep0tND2t+KRW
	UXioPuoMhmzAt7BKF3abA9xKln0dc1bTDyJirfVMD6IZr3Y0c2NFtDrYN+F9Yshg
	N2dxGWjioHVImzM4Vaaw962hwUahgAjpqEXPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R+Q3YO4/d46YXOkd4Kv4G7HDNPpGs5oy
	rsxp8WHHdn442S4IJ5+Pu3hzKALSconOjqaZw48+ePGGp3KFPg7o72SIYYCUQKdw
	X51HE9RcDFd/BW7NUMxbB+JANElsv8R46OsYpLMPe8rOyFPo0p8fvc3OaVgU9jTp
	YbAs7DZPQ0k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6BDB461A;
	Fri,  8 Apr 2011 14:53:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5E39E4615; Fri,  8 Apr 2011
 14:53:08 -0400 (EDT)
In-Reply-To: <20110408163021.GB32709@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 8 Apr 2011 12:30:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74EBDE5C-6211-11E0-BB11-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171142>

Jeff King <peff@peff.net> writes:

> So I don't know that it's worth fixing, nor do I know what your "proper
> checks" would be. We could open up commits we're about to prune and
> check their timestamps for age. That wouldn't help blobs and trees. For
> them, we could make a guess as to their age by seeing if they're
> connected to any dangling commits, and using the commit timestamp. But
> that will only cover some objects, and it is also still vulnerable to
> certain types of clock skew (though it is more robust, since you would
> need a client and server with one type writing the objects, and then
> another skewed client doing the prune, which is even less likely).

I don't personally think this is worth addressing, but as I was Cc'ed,
I'll try.

If we at least know that the object store is contained within a single
filesystem whose clock is at least guaranteed to monotonically increase,
one possible workaround would be to touch a garbage file and read its
timestamp, instead of grabbing the current time from the local clock, no?
