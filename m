From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command: prettify -D_FORTIFY_SOURCE workaround
Date: Tue, 15 Mar 2011 22:37:30 -0700
Message-ID: <7v7hbzaan9.fsf@alter.siamese.dyndns.org>
References: <d2e97e801001291438k21a652cakb05ec34fc8bee227@mail.gmail.com>
 <20110316035135.GA30348@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Wookey <michaelwookey@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 06:37:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzjQd-0001vf-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 06:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349Ab1CPFhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 01:37:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab1CPFhp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 01:37:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B37F123D6;
	Wed, 16 Mar 2011 01:39:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Whj+KjzFJlGnCAgdhehe8fl60OQ=; b=CvD8u+
	nfNCleZP86nJGD4X2Vcm+IOjNoEKKfLWjbI4fETo23BNR3zrFUwRxxxPr2OmxQlE
	J5kVg/mKpyV6i6GvmXlCZKqn+jafTfijicnCKyKBllYfhQc4jhirCrPrvrH2j+MB
	69WJlyWPdlF8DxTpUCNjvtiyZDVZafMKujlm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YwHAs1elYnARWaDswfJG7OC6H0qZOgQM
	o6VTBVZIRmxpaMqpGIAmkSFplmvQwhfNUzpTWUZpHUvoNXoEu24Ks67kfCrdm3L1
	5Wk6HQL4wcdcshI/Xzg2rZtfNNRlwWObGEfL3VAQsxUusZQZc6UxkJm8XiJchOaA
	0C8wah7/NhM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 731F223C9;
	Wed, 16 Mar 2011 01:39:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EAE7723C6; Wed, 16 Mar 2011
 01:39:04 -0400 (EDT)
In-Reply-To: <20110316035135.GA30348@elie> (Jonathan Nieder's message of
 "Tue, 15 Mar 2011 22:51:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B868475E-4F8F-11E0-89AE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169105>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Instead, use an "if" statement with an empty body to make the intent
> clear.
>
> 	if (write(...))
> 		; /* yes, yes, there was an error. */

Yuck --- and that is not meant against your workaround, but against the
compiler bogosity.  The above is reasonable (for some definition of the
word) and the comment makes the yuckiness tolerable by being somewhat
amusing.

But your comment in the actual patch is not amusing at all.

It certainly is _not_ "ok" to see errors from write(2); we are _ignoring_
the error because at that point in the codepath there isn't any better
alternative.  The unusual "if ()" whose condition is solely for its side
effect, with an empty body, is a strong enough sign to any reader that
there is something fishy going on, and it would be helpful to the reader
to hint _why_ such an unusual construct is there.  It would be much better
for the longer term maintainability to say at least "gcc" in the comment,
i.e.

	if (write(...))
        	; /* we know we are ignoring the error, mr gcc! */

or something.

Thanks for another amusing patch.
