From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diffcore-break: save cnt_data for other phases
Date: Thu, 19 Nov 2009 23:32:20 -0800
Message-ID: <7vtywp7it7.fsf@alter.siamese.dyndns.org>
References: <20091116155331.GA30719@coredump.intra.peff.net>
 <20091116160202.GB30777@coredump.intra.peff.net>
 <7vvdhanp4v.fsf@alter.siamese.dyndns.org>
 <20091119152234.GA6877@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 08:32:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBNys-0003Ti-Gy
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 08:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbZKTHcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 02:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755264AbZKTHcW
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 02:32:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbZKTHcV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 02:32:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FD63814C6;
	Fri, 20 Nov 2009 02:32:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PIla+tPgRf5Ol5R8k9emqz/INr8=; b=hg8SB1
	pJ7GgSa8z3sQavJuoc/EUyRZGMjcTcLIDShm3+Pepg7TAzPrdJk7is4TzYlfJ81S
	XZYKC6Cr2tsunUUN7Sbf7dUjOwafmBJcT2E8d1a2gJIHPiQ6bOWgvBX5hF0sQbyp
	YuoaCfNLOD63Ij5gLGJAab6GZyFOCMnzkwVgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jmrmezhOOuMZQ6/9mmPxed+ucWePf6cJ
	s1hfWZT84plfDOHNVNsvfHBHzlR1DJc0WX3h7h+bxa2vRO/KaSBSGombCTaxGuF0
	HIS7SxyiULS7fW1LwmICAZACN3xhxb3Mn7DNKRZr6H49T5Ks8Mrc80SPqUhBBQMR
	UKJtF4ZBry0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1146E814C4;
	Fri, 20 Nov 2009 02:32:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0DEC814C3; Fri, 20 Nov
 2009 02:32:21 -0500 (EST)
In-Reply-To: <20091119152234.GA6877@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 19 Nov 2009 10\:22\:34 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D90C17B0-D5A6-11DE-AAEA-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133309>

Jeff King <peff@peff.net> writes:

> I don't know if it is worth refactoring though.

I would rather not touch it.

> Also, I don't see where we ever actually free the cnt_data. After we run
> the whole O(n^2) loop, we should be able to drop cnt_data entirely. I
> think in practice it doesn't matter all that much, since it isn't that
> big, and afterwards we just generate the patch and exit (unless we are
> doing diffcore-break, too, which will actually free all of the data).

Originally, each phase of the diffcore pipeline was designed to be
independent from other phases, and keeping things in core was done as an
optimization for smallish trees so that later phases in the diffcore
pipeline can reuse prepopulated data.  If this were year 2006, I would
have said that keeping it in core would be better because we could add new
phases after it later, even though there is nobody who uses cnt_data after
diffcore-rename in the diffcore pipeline right now,

But it seems that our performance is more than adequate without such
keeping-things-around for smallish trees anyway, and it is wiser to
optimize for heavier workload.  More importantly, nobody seems to be
planning new phases in the pipeline, so I agree it is a good idea to drop
cnt_data once the rename detection phase is done with it.
