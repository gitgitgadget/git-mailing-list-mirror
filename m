From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to still kill git fetch with too many refs
Date: Mon, 01 Jul 2013 22:19:51 -0700
Message-ID: <7vtxkd8rns.fsf@alter.siamese.dyndns.org>
References: <201307012102.31384.mfick@codeaurora.org>
	<20130702040758.GA7068@sigill.intra.peff.net>
	<20130702044151.GB7068@sigill.intra.peff.net>
	<20130702050142.GA1206@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 02 07:19:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utt0Q-0000yq-L3
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 07:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab3GBFTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 01:19:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59018 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379Ab3GBFTy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 01:19:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 888CD28163;
	Tue,  2 Jul 2013 05:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6AwJF/uSQxXEwyHx7ELrMOAPcqQ=; b=hIdZ5T
	IoP1h/OHDnf8vHPt+Jn2G6iZ24uj1pJkGxevBICaBZ3Mts0j3GDAOCrFDLHwNhOz
	HrmvryTgBQwdizO7CgbPoOyqik8V1TQNciYvndo/wJU5PKwn9TQdyq4zXdqvaj9/
	/NTf8soTwwq5OVY1Rm34mCk8C23MvOBE2d138=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CMDqvFPP6eNfql1YMIfzhRq9P0tJ70E/
	kskQed9g81UkaB8igAbmE6K7ilth3K9LGpgKWUGfWj9Va4wV6Ly43zV0cP8z27Qw
	vSb47i2d1YySnhXPnoKunSjhti9n8QBwZcFDjWWqdjBvGtI98LBbn48sGtRa/8iN
	j0hq/Prm7eI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F97A28161;
	Tue,  2 Jul 2013 05:19:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F253C28160;
	Tue,  2 Jul 2013 05:19:52 +0000 (UTC)
In-Reply-To: <20130702050142.GA1206@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 2 Jul 2013 01:01:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0688FDC0-E2D7-11E2-BF89-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229362>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 02, 2013 at 12:41:51AM -0400, Jeff King wrote:
>
>> I replicated your test setup, and the problem is that we have many
>> common objects on both sides during the ref negotiation. So we end up in
>> rev_list_push for each one, which has the same O(n^2) behavior.
>> Switching it to just sort at the end is not trivial; we first insert all
>> of the objects, but then we actually walk the parents, pushing onto the
>> list as we go. So I think we'd want a better data structure (like a
>> priority queue).
>
> Like the patch below, which is built on top of next (which has Junio's
> prio_queue implementation), and has both the priority queue fix for
> rev_list_push and the mark_complete sort-at-the-end fix.

Wow, I saw "160 lines" in my MUA which scared me a bit until I
opened it to realize 40% is discussion and most of the remaining
lines are context around single liners.

It just looks too easy/simple, but the result looks correct, at
least from a cursory read.

Good job ;-)
