From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Slightly prettier reflog message from checkout
Date: Sat, 15 Jun 2013 18:24:44 -0700
Message-ID: <7vmwqqkftv.fsf@alter.siamese.dyndns.org>
References: <1371317906-3991-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 03:24:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo1i7-0002U1-4i
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 03:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab3FPBYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 21:24:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754809Ab3FPBYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 21:24:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BD5B28C0F;
	Sun, 16 Jun 2013 01:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=PsB9FFJUAXQeU3CSjyiaRQ6diXc=; b=T9Q/AyQhwsOU+w+dn6/2
	IIT+XGvHydM/mq1ZacdvHgTnSDbH8Vh5JbTrepBwce6P2oFc8E6jtIDq7t9sWNWE
	iRb2tjz1TUNASucj5HvIcJDx4vgS4IeyrTdiPCLayRwxAsJpBzFMKeVSQcYas8N9
	EWayIWZ3jirN8AfUyTxMLsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jyY/lA00ejV4Kgcbf5Pne9+3gZp66rJvToCVhtrludEtu4
	1ujcaOM1kNV+8oIq74q1B7n2a3mr04HU3ZvzY25Ml4pd8Irn0bwlUF7uRARnUJDt
	3nErMyikhO27uUoC7opC6exgNFKtsbi2FzEoeDQZmIba8mJ3/pfFIRyMYz9P4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50BA928C0D;
	Sun, 16 Jun 2013 01:24:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5F7B28C0C;
	Sun, 16 Jun 2013 01:24:45 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8759AE9C-D623-11E2-A913-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227981>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> [1/2] is important.  [2/2] is a minor prettification, that wouldn't
> have been possible without [1/2].
>
> Thanks.
>
> Ramkumar Ramachandra (2):
>   sha1_name: stop hard-coding 40-character hex checks
>   checkout: do not write full sha1 to reflog
>
>  builtin/checkout.c | 2 +-
>  sha1_name.c        | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

I view the two codepaths touched by these patches the other way
around.

An abbreviated unique SHA-1 you have today may not be unique
tomorrow.  There is no reason to deliberately lose information
(e.g. by using "Then, instead of the absolute minimum, let's record
a bit more bytes" heuristics) when we record. The reflog recording
code in checkout writes full 40-characters on purpose and there is
no reason not to do so (i.e. the codepath that is the topic of 2/2).

That is a more important design decision between the two codepaths.

Once we accept that design principle of not losing information when
we do not have to, it naturally follows that the writing side should
write full 40-hex, and also the reading side (i.e. the codepath that
is the topic of 1/2) should make sure that it reads 40-hex and
nothing else.  This also reduces the risk of a funny branch name
that consists only of [0-9a-f] getting mistaken as an object name,
but that is not the primary point.

So I am fairly strongly negative on both changes.
