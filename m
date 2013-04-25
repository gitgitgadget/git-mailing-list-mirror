From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Make --full-history consider more merges
Date: Thu, 25 Apr 2013 11:19:21 -0700
Message-ID: <7v1u9y4gnq.fsf@alter.siamese.dyndns.org>
References: <7v4nfcj2kq.fsf@alter.siamese.dyndns.org>
	<1366658602-12254-1-git-send-email-kevin@bracey.fi>
	<7vzjwqny64.fsf@alter.siamese.dyndns.org> <5176B854.2000707@bracey.fi>
	<7va9ona77d.fsf@alter.siamese.dyndns.org>
	<7v61zb8j5d.fsf@alter.siamese.dyndns.org> <5179505F.2000108@bracey.fi>
	<7vtxmu4kq2.fsf@alter.siamese.dyndns.org> <517963B4.30801@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Apr 25 20:20:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVQm4-0007zk-Gi
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759209Ab3DYSTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 14:19:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759113Ab3DYSTY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 14:19:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F4FB1796A;
	Thu, 25 Apr 2013 18:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rMxRC7u6Y7Jhme2ZhBGr2Q6veO0=; b=rAOrtR
	0ODPx4qRAGvvyQkUVNAwFS29DQ7UtZU46SKyjVY08J4Do1f8ZpFNPnvoOHTJFyNL
	6bm3arhGCrfhKoug4/iqxz6Zu1K1GS5Rj7u5b9TDXTnfk33EIWCdBbc0ZuP16lx2
	bl+a3rKz8qTwTC1zk3S0FC34N0vSkCm1vJDt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hyhoKjWZJLDfRsvLJ08EkLkr82DFXt08
	YzL0SxqHI0fWZGTTkr0YfcATxCFBVd1K63pEdEDqXJSGbDBV/YXDMHu0iQ9aTi3C
	ePtqVfkIUz5TGrlUSWYaeqNba7eIMYvXn2pQ3wluLkEMi1K/K4BndHZHwSre07k+
	Cvwgq8iSBH8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20CD917969;
	Thu, 25 Apr 2013 18:19:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AD1C17963;
	Thu, 25 Apr 2013 18:19:23 +0000 (UTC)
In-Reply-To: <517963B4.30801@bracey.fi> (Kevin Bracey's message of "Thu, 25
	Apr 2013 20:11:16 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7D74282-ADD4-11E2-B3EE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222404>

Kevin Bracey <kevin@bracey.fi> writes:

> On 25/04/2013 19:51, Junio C Hamano wrote:
>> Kevin Bracey <kevin@bracey.fi> writes:
>>
>>> Thanks for the test addition. Maybe we will be able to satisfy your
>>> greed in this series. There could be more worth doing here, and I
>>> think getting TREESAME precise is key.
>> It is perfectly fine to do things one step at a time.  Let's get
>> the --full-history change into a good shape first and worry about
>> the more complex case after we are done.
>
> So do you see the rerun of try_to_simplify_commit() as acceptable? I'm
> really not happy with it - it was fine for an initial
> proof-of-concept, but it's an obvious waste of CPU cycles to recompute
> something we already figured out, and I'm uncomfortable with the fact
> that the function potentially does more than just compute TREESAME; by
> inspection it seems safe given the known context inside
> simplify_merges(), but it feels like something waiting to trip us
> up.

True.

> The latter could be dealt with by breaking
> try_to_simplify_commit() up, but that feels like a diversion. I'd
> rather just get on and make this first patch store and use the
> per-parent-treesame flags if feasible.

OK.  We have survived with this corner case glitch for more than 6
years, so a fix is not ultra-urgent.  Let's try to see if we can get
it right.

How many decorations are we talking about here?  One for each merge
commit in the entire history?  Do we have a cue that can tell us
when we are really done with a commit that lets us discard the
associated data as we go on digging, keeping the size of our working
set somewhat bounded, perhaps proportional to the number of commits
in our rev_info->commits queue?
