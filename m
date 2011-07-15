From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a 'generation' number to commits
Date: Fri, 15 Jul 2011 12:49:17 -0700
Message-ID: <7v8vrz1g02.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.02.1107141126300.4159@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 21:49:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhoOE-0004Kb-BY
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 21:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879Ab1GOTtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 15:49:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59375 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157Ab1GOTtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 15:49:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E4DA49CC;
	Fri, 15 Jul 2011 15:49:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EJqs8Qqbcv4cKGjH419cBKT+PEg=; b=xru07K
	kzVfIjhTNXRpz3IP8KPUWHqw4k25kkQSgmFz5jUO0ZV4dU4M0iT64Fab4F0aIqfl
	yZIKvP/uJFKNKrxaxBYKNkyBpTw4O2KR64Y3Qg4so277gEaIFpBxgEFsTxBxHMya
	rhaDaqowrYDV+GsnB/szL2Qipt+8IUyf155Io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZmQoHn0CI0tv2E6MwctzMFPx2GSJDgLx
	NNAhLKQ1sKWeuJZkTYb26vIyRlvGprMmeRjRhbakSTJMS8wxJ9WFuM4Da+J6stws
	Ob4DfI7Y+hJGFABMHuHuxvvdU5nY8BxO7Kbd14Mir2wmvMcny0jUHRnzZ8j6MzZ1
	EaLqSf0pyXw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 027BD49CB;
	Fri, 15 Jul 2011 15:49:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7341849CA; Fri, 15 Jul 2011
 15:49:18 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.02.1107141126300.4159@i5.linux-foundation.org>
 (Linus Torvalds's message of "Thu, 14 Jul 2011 11:34:09 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86FD21E4-AF1B-11E0-9274-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177220>

> Comments? This is pretty simplistic, and yes, it's slow. On the kernel, it 
> now takes a few seconds to generate a new commit when there are no 
> generation numbers - and that's on a fast machine.

I agree this is the way to go if we _were_ to use generation number
associated with commit objects in the longer term, and if the SLOP
logic in still_interesting() in revision.c:

 (1) can gracefully fall back to the date based heuristics for older
     commits without the header; and

 (2) can take advantage of the generation numbers in more recent commit.

If we cannot do (1), we could augment this with Peff's generation number
cache. I suspect (1) is doable and in that case we do not have to have
(and we may be better off without) the on-disk cache that could go stale,
but nobody so far has shown that yet, so...

As I mentioned in a review comment of the actual patch, I however am not
convinced that generation number is a better substitute for the timestamp
in the context of "tag --contains" optimization.
