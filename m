From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/29] ref_transaction_create(): disallow recursive pruning
Date: Fri, 29 Apr 2016 01:41:20 -0700
Message-ID: <xmqqzisc24en.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<615204c877610855b02b21ce14efa5b7342182bc.1461768689.git.mhagger@alum.mit.edu>
	<xmqq60v2anyo.fsf@gitster.mtv.corp.google.com>
	<1461788637.11504.3.camel@twopensource.com>
	<xmqqh9em93xo.fsf@gitster.mtv.corp.google.com>
	<xmqqvb327nyz.fsf@gitster.mtv.corp.google.com>
	<5723059C.5080406@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 29 10:41:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw3zW-0000mK-Lk
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 10:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbcD2Il1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 04:41:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751339AbcD2IlY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 04:41:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6341134F2;
	Fri, 29 Apr 2016 04:41:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NdrDR+XCdMwt+2uZensTuxdwG+c=; b=tn8knS
	xE3ssEFR5ivVPSApRFYnOXUSAMvHEHmUWsvNDBMh76adxMDYZsrs9VWzR2u+EZOv
	qKquYumITCnh5mNECn2WVaYubEV2Su8r1QI+ilqMW4eUM9VpB+7fWw0DhTfF76nY
	JGrdNrYPrRmNQJPzBgaSu2WPUcG6meqrsAiEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q7pMaBcyAagN0q26dRRs4q9XQnkmVesC
	KUKhfZNTV9pXEmUCF2dRPtCwVXePWdeFVIUXiZRuOWuiqH+SwKU5LTtqzdZjovtP
	0jBtmwJEW/W+JBkvbdCyuPe7eQ/C4kJ/NPV4+ASjPly1m43JYrA69TnaGpKteihd
	oaQLFS90Zn0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD0C5134F1;
	Fri, 29 Apr 2016 04:41:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29DF8134F0;
	Fri, 29 Apr 2016 04:41:22 -0400 (EDT)
In-Reply-To: <5723059C.5080406@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 29 Apr 2016 08:56:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26979A62-0DE6-11E6-9BF7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292980>

Two things I forgot to say.

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I was thinking of this patch as documenting and enforcing a limitation
> in the current implementation of pruning.

This actually is an excellent point, and is the reason why I
repeatedly made my suggestion conditional on "If my understanding of
the purpose of this patch correctly" ;-) And I personally am not
convinced that this limitation is fundamental and will not be
lifted.  It may be better to treat this as a limitation of the
current implementation of pruning, and in that case I do agree that
the original patch that started this thread is the best way to
express it.

I said that it makes harder to write incorrect client code of this
API to make REF_ISPRUNING contain both 0x04 and REF_NODEREF, and I
still think that is true, but at the same time, it makes it easier
to write incorrect code in the API implementation.  We no longer can
check if we are in the pruning codepath with

    if (flag & REF_ISPRUNING)

but have to write

    if ((flag & REF_ISPRUNING) == REF_ISPRUNING)

instead.  This "& with the constant and compare the result with that
same constant" pattern could also be used for a single-bit constant,
so if there were short-and-sweet syntax to express that pattern in
the language, consistently using that for all bit checks would make
it less likely for us to write incorrect code, but but there is no
short-and-sweet syntax to do so in C, and spelling it out like the
above is too cumbersome to be practical.  The suggested squash did

    if (flag & REF_ISPRUNING_)

to check only for 0x04 bit, but that is also error prone; it is too
easy to forget the difference between the two and drop the trailing
underscore by mistake.

Even though it is generally a good trade-off to make it harder to
make mistakes in the "user of the API" code even if it makes it
easier to make mistakes in the "implementation of the API" code,
because the "user of the API" in this case is actually still inside
the ref API implementation, I do not think either way makes too much
of a difference.  So perhaps your original might be the best version
among those that have been discussed in this thread.
