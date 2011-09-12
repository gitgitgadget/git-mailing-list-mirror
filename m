From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated
 submodules
Date: Mon, 12 Sep 2011 16:33:22 -0700
Message-ID: <7vsjo11gl9.fsf@alter.siamese.dyndns.org>
References: <20110912195652.GA27850@sigill.intra.peff.net>
 <7vr53l5u7h.fsf@alter.siamese.dyndns.org>
 <20110912224934.GA28994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:33:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3G0L-0005ix-9P
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020Ab1ILXd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:33:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755559Ab1ILXd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:33:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E065E4EF7;
	Mon, 12 Sep 2011 19:33:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RIZ0oTrrTa3nYW5yNJe7ZQx4znw=; b=bunsBp
	GJbcTExvfmIswtT2NoHdWb2E0suhpE6FWi39cxXx1dlfdkHSwa1QB72EJFLtalwI
	SmTgD8TlAJOhcqygc+AaSaM1xY9mEP0C5FDHwBDsUQ4aGKIWyFs7M1mhFdheDAV4
	2rAhr0rN79hA5yPMIoy96xwP4iTXXhYKHnPe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kNaqYTZs4rqp4/rln5krQnBHqotwO+RQ
	EzLv4f+Sf4I2dc3yTpTyUxhOnq2ktm1g936E1Rf/lIwuQMiWYQJVACo4SIw9/Ghf
	Tcc2ryDmC6MCyWtdaKgAWBjUlN8KRAIVN/DGOjJKHlTXeWxFs1daQFS2bFEyh/ST
	TSjVPyG5RkM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6CCC4EF4;
	Mon, 12 Sep 2011 19:33:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AF304EF3; Mon, 12 Sep 2011
 19:33:24 -0400 (EDT)
In-Reply-To: <20110912224934.GA28994@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Sep 2011 18:49:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BC82740-DD97-11E0-8B3B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181258>

Jeff King <peff@peff.net> writes:

> To be honest, the whole submodule recursion thing seems a bit confusing
> to me....
> So since we must accept that we can't necessarily get every intermediate
> step, I wonder if we are simply better off diffing the "before" and
> "after" state of a particular ref, rather than traversing.

Yes, exactly my thought.

It would be far cheaper to look at a single final tree and enumerate all
the submodules, which would give you pessimistically the maximum set that
could possibly be relevant, than running millions of pairwise diff trees.

By the way, I think the submodule traversal won't hurt the correctness of
the primary traversal because that happens _after_ we fetch the object
stream.

The submodule traversal _may_ be getting an incorrect result, though, for
the same reason.
