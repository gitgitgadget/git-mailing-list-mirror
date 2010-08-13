From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/9] stash: extract stash-like check into its own
 function
Date: Thu, 12 Aug 2010 17:49:28 -0700
Message-ID: <7v8w4bnxpj.fsf@alter.siamese.dyndns.org>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
 <1281398688-21008-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j6t@kdbg.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 02:49:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjiSy-0004zr-W9
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 02:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821Ab0HMAtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 20:49:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab0HMAtm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 20:49:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 736C3CD609;
	Thu, 12 Aug 2010 20:49:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=zBEMPGMxLqG0OWDI0nXu0gPCLYc=; b=SIrvOViV3XzatUgXqRVuTqo
	OfUWQUFizcmqUV054RTC+1P5CrJfGV415zinpOGtaLnze2/ePRfmVxzLYPPjLm1u
	o3a24SbiL9Z9glfjyQSCFufKizzdDlAm+fdCojt0dbFrGBu9EpQsMwF3YVJ/II4C
	KFxZQOJinii70ngQSGek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=L2ksr2kP+w436D2OuwZHUPArXGlpBh/w+VnGd6bpUDQFXWFsa
	l6h4//6h3jItuUSjt6++p+ugm59BgHAU5LiIijw3skPttTwjUpOlKB4qxweny9TR
	rul2wsKs1AIiaPM6YKiXstdw5OOtzyulWxNvD0y6p7YFdgaFTIEtSx20pQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CEA8CD603;
	Thu, 12 Aug 2010 20:49:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7B07CD5FA; Thu, 12 Aug
 2010 20:49:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5615BC4-A674-11DF-AF95-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153444>

Jon Seymour <jon.seymour@gmail.com> writes:

> A similar code block is used in three places; this change
> factors the stash-like check into a separate function so that
> it can be used in these and other places.

"git stash show" used to be able to show a single-parent commit, and we
are forbidding that "feature".  I'd actually call that a bugfix though ;-)

> +# if this function returns, then:
> +#   s is set to the stash commit
> +#   w_commit is set to the commit containing the working tree
> +#   b_commit is set to the base commit
> +#   i_commit is set to the commit containing the index tree
> +# otherwise:
> +#   the function exits via die
> +#
> +assert_stash_like() {
> +	# stash records the work tree, and is a merge between the
> +	# base commit (first parent) and the index tree (second parent).
> +	s=$(git rev-parse --revs-only --quiet --verify --default $ref_stash "$@") &&
> +	w_commit=$(git rev-parse --quiet --verify "$s:") &&
> +	b_commit=$(git rev-parse --quiet --verify "$s^1:") &&
> +	i_commit=$(git rev-parse --quiet --verify "$s^2:") ||
> +		die "$*: no valid stashed state found"

Don't these "rev-parse" calls return tree objects?  It is too confusing to
call them x_commit if that is the case.
