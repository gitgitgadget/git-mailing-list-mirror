From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t2017: redo physical reflog existance check
Date: Thu, 22 Jul 2010 19:23:41 -0700
Message-ID: <7vsk3bey1e.fsf@alter.siamese.dyndns.org>
References: <1279763190-32757-1-git-send-email-erick.mattos@gmail.com>
 <7vlj93h120.fsf@alter.siamese.dyndns.org>
 <AANLkTilt5gx3Wj4eANfkIFm869Olns1rsMpCS81hS2BV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 04:23:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc7vY-00044j-VZ
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 04:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758268Ab0GWCXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 22:23:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398Ab0GWCXu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 22:23:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ACA9BC6EA3;
	Thu, 22 Jul 2010 22:23:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RFFlIDMxcyOf29TzQsf8VTH4A7s=; b=RUQ5NZ
	HGZtKJyfcksnqmSurQrJRQ1KXa731EOGO1aTDKhSXAwniQwXNtsbnth5uJyj+tHI
	o3XNXdG6mhWPy6CMAUezjaosAq20Dfn3Dge76+3gEkUwrZsKdU+lmHFt0DZvCCCO
	krxo6Pno/bbCe3mVgCv0Huscw/EfofvMkZQAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F6uL2opZUj5vB04/9QSPF3sJehIT7xLz
	6HXfQvgCYttY4XPi/EKj5XFGQPrKtMQJvbcd/pqLHgseL0h9HQfJZrWZti/lpRql
	8gAZwVZ0eeZ0wJrATm8c7CS1YBQ9I5ZV/fBoW6z8bChDsrRfWDYictzy1jK51nna
	x1UV4O7bTzg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87324C6EA0;
	Thu, 22 Jul 2010 22:23:45 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C191BC6E9E; Thu, 22 Jul
 2010 22:23:42 -0400 (EDT)
In-Reply-To: <AANLkTilt5gx3Wj4eANfkIFm869Olns1rsMpCS81hS2BV@mail.gmail.com>
 (Erick Mattos's message of "Thu\, 22 Jul 2010 15\:58\:42 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 51C2B996-9601-11DF-BEBD-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151500>

Erick Mattos <erick.mattos@gmail.com> writes:

> To make the new orphan branch ready to have a reflog on that config
> was as simple as creating a "touch file" for reflog.  This is the goal
> achieved by code.

I have to say that you are somewhat confused about the _goal_ then.  touch
is not a goal, it is means to a goal.

It does not matter how you implement the user visible effect, be it a
creation of an empty file, or some other means [*1*].  What matters is
that the user won't get a reflog for a branch that really didn't get
created and must-fail "rev-parse --verify" test checks that.

Another thing that could matter would be that future actions that want to
create a reflog for the same branch (perhaps after the user switches to
'master', another attempt is made to create eta with "checkout -b eta") or
another branch with a similar or related name (say "eta/real") are not get
broken by whatever you do to implement the "we want to create a reflog
when a ref is actually made but not right now" feature.  Perhaps the right
way to test that would be to actually try to run such operations and make
sure they do not fail.


[Footnote]

*1* For example, you could have implemented the feature by adding a config
item in ".git/config: [branch "eta"] need-to-create-reflog", and taught
refs.c::update_ref() to pay attention to it (I am not saying that it would
be a better implementation).
