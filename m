From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: never skip files included in index
Date: Sun, 11 Oct 2009 19:46:06 -0700
Message-ID: <7v63alpbwx.fsf@alter.siamese.dyndns.org>
References: <1255189906-16049-1-git-send-email-pav@iki.fi>
 <7viqelwyp1.fsf@alter.siamese.dyndns.org>
 <20091011191440.GA2532@coredump.intra.peff.net>
 <7vpr8tr2pe.fsf@alter.siamese.dyndns.org>
 <20091012014007.GA7674@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pauli Virtanen <pav@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 12 04:48:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxAxo-0000qo-Pc
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 04:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbZJLCrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 22:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbZJLCrY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 22:47:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbZJLCrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 22:47:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B83E674F2E;
	Sun, 11 Oct 2009 22:46:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D8nWDxcpbvEp95bEpJNY7BFumjo=; b=wZp3ms
	njwTn/ntVv4vprWFZT3OjsGsw9xw3ozS1z8kSHOMNF1HBerKvmbO2qNfNbgnyMiy
	AvYHY12GjYEqrisx2wPsqot23AHSmFM2UAY+YUcUM/pchal4U6Upa8f4hGJoZ6lc
	9YXG2ltdo4cbWqKOP6eRKCHYMr8Cd5K7fvlss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NmWtEr/Rgi/wxYYKZlxH+xhpiQcRn/lc
	nFDQC3eRSFfkrCnPfvfwDB51b6X0zhweR5IKjTckxGlUrpz/v8J3lYCwaV/AUf/q
	fsc5ZoSTefX4xZgrHDQLfhDtK+Tvr7slVjNUa1RcCT0YwN1kZ8KqMukHb1R8BAaE
	YUNIEkZJMbg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B4A874F2D;
	Sun, 11 Oct 2009 22:46:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 686B774F2C; Sun, 11 Oct 2009
 22:46:08 -0400 (EDT)
In-Reply-To: <20091012014007.GA7674@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 11 Oct 2009 21\:40\:07 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6750D912-B6D9-11DE-90EE-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129969>

Jeff King <peff@peff.net> writes:

> So now I am doubly confused. Did this feature exist, and was broken, and
> you actually fixed it in 63d285c, creating what looked like a regression
> but was actually intentional?

I do not think it was an intentional change.  I _think_ the comment at the
beginning of show_files() tells us quite a bit---we don't do read-dir when
showing the indexed files, and I suspect that we used to rely on the fact
that not doing the read-dir made exclusion mechanism a no-op.  After the
lazy .gitignore reading, I suspect that excluded() call started to
initialize the exclude mechanism lazily, and that is how the bug was
introduced, isn't it?

Regarding your patch, the loops deal with paths that are already in the
index, so removing the conditional skip looks like a sane thing to do.
