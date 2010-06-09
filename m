From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/ PATCH 1/5] tree-walk: do not stop when an error is
 detected
Date: Wed, 09 Jun 2010 09:49:47 -0700
Message-ID: <7vaar4p2vo.fsf@alter.siamese.dyndns.org>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 09 18:50:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMOTi-0000Yd-6m
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 18:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757994Ab0FIQuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 12:50:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757932Ab0FIQuA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 12:50:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AAF8BA760;
	Wed,  9 Jun 2010 12:49:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=t9S/IeJD/06kz84xgDLugof1kEU=; b=GpnbQMAfXRLHZAnwQI00ODU
	GFwNHEgU1HrRLrXSUz0RdGIljE70TgkgR6ZM8wEcQkNacgPQMzefNvYeOH9lhVPB
	iSSPhmbZIFQIHFx0O+rlLgAbhO9KoL06wzbZFwy2ux5WMzT9ofge/CBhOqT+TkZa
	A87huZS6IXRUhmhc53/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RJejXhTzSqpmHZXP8ImlslkiKDxZ9P4d6kV7fVy6NkU08pIRb
	1wyRXRwHrGixm4LJD9bmi4NJyagU82A662E7kYQ38UyYkzmWoX9wANmlpKDuEINQ
	z2rn0j0KREvViA/2aAo7GAkdxSmWVcPrfN+kwEMnukyiLq/WfhWei1PuZU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE063BA75F;
	Wed,  9 Jun 2010 12:49:54 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFD2CBA75D; Wed,  9 Jun
 2010 12:49:49 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 07A70682-73E7-11DF-9E06-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148791>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> When an error is detected, traverse_trees() is not stopped anymore.
> The whole tree is traversed so that all the merging errors can be detected.

A small worry is if we have some codepath that uses this function like
this:

    if (traverse trees finishes successfully) {
    	be happy, all is well;
    } else {
	attempt a different strategy to achieve
        what we wanted to with traverse trees, if
        it worked fine.
    }

In such a case, spending extra cycles in traverse-trees only to collect
more errors would actively degrade performance in the "alternative
implementation" codepath.  For "try 'quick but limited' version first, and
if it doesn't work, try more elaborate version spending extra cycles"
pattern to work well, the 'quick but limited' version needs to fail
quickly without wasting extra cycles when it hits its limitation.  In the
original code, we deliberately returned early upon seeing the first error
exactly for this reason.

I don't think of concrete examples offhand (fallbacks "merge -s resolve -s
recursive" or "am -3" use come close, perhaps), though, so I may be
worried needlessly in this case.  I honestly don't know offhand.

With our attention focused only on UI issues, I however would agree that
it makes a lot of sense to collect all errors and give them all to the
user, especially because the extra cycles (compared to the current code)
spent to do so is only in the error codepath.
