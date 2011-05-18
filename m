From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a debug mode for git-clone https traffic?
Date: Wed, 18 May 2011 08:38:47 -0700
Message-ID: <7vmxikc92w.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=-i063MqrboT1MHrQy-vM0yBTUGg@mail.gmail.com>
 <20110518085932.GI27482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 18 17:39:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMipy-0003Bh-Q3
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 17:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802Ab1ERPi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 11:38:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314Ab1ERPi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 11:38:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A4FA46D7;
	Wed, 18 May 2011 11:41:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P8x9hENpVdG/wDSjJQSnc7JN9EM=; b=nOtHjU
	pEBeIOAwzrqL0IMkYUIdtHexXpHsMVE4uPe/POiEo/UC+tJ3DEB01CRL0SPlNCd8
	tzThyORKEZTuvPfR9pwoIXYEo3Aq08Mddigsad5GuDYvmsAeSTYlyspyMz2I50Hu
	VME8Jl+waAa0NaI0xrE7pcx74eziXKTu2JkDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dwpchraUKjs8M86qJN1zFZwKvzm0p377
	V/3EbI6mOQ26VNFVk0I6yST9gnXZCdL2DVJvhw8c40E7Z0abQS5lcJg3J1mDttxb
	cHwGHTcKYI/Z/R9V39oCN8eg8kCxwq3FmLjctySJm6ztxva0MPcjnPYrj3KeLXj7
	znDfkFCzNP8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C21A46D6;
	Wed, 18 May 2011 11:41:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 40B1546D5; Wed, 18 May 2011
 11:40:56 -0400 (EDT)
In-Reply-To: <20110518085932.GI27482@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 18 May 2011 04:59:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B037EE8-8165-11E0-90EE-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173885>

Jeff King <peff@peff.net> writes:

> Others have mentioned ways to dump data from clone. But you can more or
> less see what's going on with "git ls-remote <remote>". The sha1 for
> "HEAD" will try to match with the sha1 for some other ref. If it
> doesn't, then we give up.

One thing noticed by somebody at $work is that we perform poorly when
fetching from or pushing to a remote, which has an alternate, and when
that alternate has a dangling HEAD that does not point at a valid commit.

I don't recall the exact details, but the story goes like...

The remote in the middle would want to mark the objects that are available
from the alternate by internally running ls-remote against its alternate,
which returns with a failure status, and then the entire serving process
is aborted, and the original client does not get what it wanted from the
remote.

... or something like that.

As the internal discovery of what additional objects are available to the
remote from its alternate is primarily for improving network performance
by avoiding to transfer unnecessary objects, it is tempting to argue that
the remote could ignore the failure in ls-remote against the alternate.

The remote however _is_ relying on the alternate for some (and possibly
large part of) objects it _thinks_ it has via its own refs, and an
alternate that fails ls-remote because it has its refs messed up is a bad
sign that does not give us confidence that the remote itself is healthy,
so from that point of view, we might be doing the right thing by refusing
to serve the original requestor to prevent the damage from spreading.
