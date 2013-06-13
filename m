From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset: trivial refactoring
Date: Thu, 13 Jun 2013 14:34:13 -0700
Message-ID: <7v38slu23u.fsf@alter.siamese.dyndns.org>
References: <1371147305-20771-1-git-send-email-felipe.contreras@gmail.com>
	<CANiSa6i5xL-V+W46zWXGzLc+dSO6a+V0BLPt7hFgGZGXpp03BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 23:34:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnF9x-0004Oh-TI
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 23:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758909Ab3FMVeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 17:34:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59402 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757807Ab3FMVeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 17:34:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B572927C32;
	Thu, 13 Jun 2013 21:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xqUeXXGTL+z/25VIlsWmab/uWHQ=; b=lH70R7
	EGgmE/FK9kVdh36az47leg4UKEPO6+ewaFJzsET1PgOwa4yWZXgQZbDQDJtGSfAW
	mLsgnogMs9Z3ADVO6xoI54SaL9Dn5JmC+Ncraer4PlVcB4p+6a+II6Ilw3YNBGEQ
	ENQ2M7mmKmLhJx6KmjnSLtjoa0JLcWUAri5fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wlfZzXSGGps3J1c+zayvUuoZVPK3OYM9
	g/jwj+FycAyd9L+swyEALRWw/4T9+ORfozpsw9SPfjnlbYnUVjCKWKBS6PvnsFhD
	kc0NT8C/ABdXQpKYkimLvFgcFL9G2eaLJN1uCX5qSqrX3lJQ9CGyk46fHW/5WyV8
	5pnsoK8FBnQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA27727C31;
	Thu, 13 Jun 2013 21:34:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1655627C2D;
	Thu, 13 Jun 2013 21:34:15 +0000 (UTC)
In-Reply-To: <CANiSa6i5xL-V+W46zWXGzLc+dSO6a+V0BLPt7hFgGZGXpp03BQ@mail.gmail.com>
	(Martin von Zweigbergk's message of "Thu, 13 Jun 2013 14:13:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FED04BA2-D470-11E2-A5E8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227780>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> ...the line after this one reads
>
>    err = reset_index(sha1, MIXED, quiet);
>
> ? I don't know what the consequence of not calling prime_cache_tree()
> would be, though.

It does not affect correctness, but makes the subsequent "git
status", the part that internally computes "diff-cache --index" to
see what changes have been added to the index, more costly.

After doing "reset --hard $commit" or just "reset $commit", we know
that the contents of the index must match $commit^{tree}, and
writing out any subpart of the index that corresponds to a directory
(including the top-level one, i.e. the whole index) must match the
corresponding subtree of $commit^{tree}.  And that is why we prime
the cache-tree that was discarded by unpack_trees() at the very end.
Then incremental "git add" to the resulting index after that can
invalidate only the parts of the index and cache-tree while
relieving the next "write-tree" (most often done by the next "git
commit") from having to compute the tree objects for parts of the
index that have not been touched since the "reset" operation.

I do not use "reset --keep $commit" very often myself, but IIRC, it
is like "checkout $commit" (and not "checkout -m $commit") in that
the resulting index matches $commit^{tree}, so I think priming the
cache-tree just like --hard/--mixed is the right thing to do.
