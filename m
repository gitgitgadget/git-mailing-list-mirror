From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] revert: add --ff option to allow fast forward when
 cherry-picking
Date: Fri, 05 Feb 2010 15:57:18 -0800
Message-ID: <7vpr4jnsm9.fsf@alter.siamese.dyndns.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org>
 <20100205231112.3689.67634.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:58:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdY3k-0001hN-Tm
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934102Ab0BEX5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:57:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933483Ab0BEX5l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:57:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84ECE97D0A;
	Fri,  5 Feb 2010 18:57:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SE2naoc6E4TeJrd/56e/4IipnB8=; b=fdEsrp
	tY2EPNRxFq8bEmq5hWRzjMQnjSy+KuSIO8U6IyqS7PesgrYTDlq3cPY0FnUL6MV4
	5W0PLTFcC5WA0mzB7bBqyRXSl6LRglA7syPvijHEjQAXcPkHXiXmp0bSBQWdlwP+
	BJUdwntu6J54qzcWQxGGt2TvMnIWflZhRyoFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m2hbNu59FGu8iAjs2ctXte+sWV0RQGyz
	7EilrVQhVOeRpyre8tv0pCkOuJT/9girxylTBkOtKYr8fPZUwP7ePAMvd7vRrwvY
	+AgkXznlzVlDP6PREod2aL6P7cA38v/HqpTn/Q2MP7VCGSAD7PVnw+rtrVumE/dD
	hxrQpM+OFMM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F175E97D09;
	Fri,  5 Feb 2010 18:57:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F95B97D08; Fri,  5 Feb
 2010 18:57:19 -0500 (EST)
In-Reply-To: <20100205231112.3689.67634.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat\, 06 Feb 2010 00\:11\:07 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3820E742-12B2-11DF-B125-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139127>

Christian Couder <chriscool@tuxfamily.org> writes:

> As "git merge" fast forwards if possible, it seems sensible to
> have such a feature for "git cherry-pick" too, especially as it
> could be used in git-rebase--interactive.sh.


> +	if (!(flags & PICK_REVERSE) && ff_ok && commit->parents) {
> +		unsigned char head_sha1[20];
> +		if (get_sha1("HEAD", head_sha1))
> +			die("You do not have a valid HEAD.");
> +		if (!hashcmp(commit->parents->item->object.sha1, head_sha1)) {
> +			char *hex = sha1_to_hex(commit->object.sha1);

With this check, you are saying:

	If we are cherry-picking commit $C, and if the current HEAD is
        the first parent of $C, then just reset to $C instead of running a
        cherry-pick.

I didn't check if you have access to commit->parents->item->object.sha1 at
this point in the codepath, though (e.g. have you parsed "commit" yet?).

If the goal is to make untouched 'pick' in rebase-i to fast forward
without actually running cherry-picking, perhaps it is much cleaner to do
this kind of comparison in the caller of cherry-pick (i.e. rebase-i and
anything that runs cherry-pick)?

The whole series is titled as if "cherry-pick --ff" is the primary goal,
but I am puzzled why earlier patches in the series were necessary for this
change.
