From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: respect "core.ignorecase"
Date: Mon, 10 Sep 2012 16:07:05 -0700
Message-ID: <7v4nn5lbom.fsf@alter.siamese.dyndns.org>
References: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
 <7v7gs3q9rp.fsf@alter.siamese.dyndns.org>
 <20120910161325.GB9435@sigill.intra.peff.net>
 <7vvcflmxis.fsf@alter.siamese.dyndns.org>
 <20120910203442.GA968@sigill.intra.peff.net>
 <7vtxv5lfsv.fsf@alter.siamese.dyndns.org>
 <20120910214152.GA2139@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 11 01:07:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBD5B-0002VQ-BH
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 01:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758105Ab2IJXHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 19:07:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45585 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758074Ab2IJXHI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 19:07:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2406978E;
	Mon, 10 Sep 2012 19:07:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hHeys7pExKA6UANoZHtSOXendTg=; b=Z1vZA9
	bOQXAnoL3yniQFMyAZibB7KiJn6adyscFylnI2Z6SB+TjIndX0CsfQtprGhRJs3o
	KtA/vpfquTDc5mDy3Nxz96In/r0dgAAXy7q6VdwvCRZmoonMDTpV3CVDn+xjv2Sz
	xwdmZZBaMelukHaqhZ2qEIlBnCxLjSLsV6Eps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hiy4ZGxsJMsHOy/WbG5Kuj6sWQwXA4hO
	RTWA7iaXEyy3tZ78qho7LEF18024gHOfioRx6AtyExHpPtQMJHltmCaFad7GAdjZ
	VicN4x7979A7b8Tb/zv4im2eA9zzgVD2nEorjp6+BUEgmRrFJ1MVVY+KBoPIn1Nl
	qZAEK7DukOk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90309978D;
	Mon, 10 Sep 2012 19:07:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0B6D978B; Mon, 10 Sep 2012
 19:07:06 -0400 (EDT)
In-Reply-To: <20120910214152.GA2139@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 10 Sep 2012 17:41:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DDE776E-FB9C-11E1-A4D3-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205205>

Jeff King <peff@peff.net> writes:

> But I would think for that particular use case, you would not want to do
> a per-glob prefix for that, but would rather use a command-line switch.

Yes.

Even though it is not listed as possible future semantics, one thing
that we may want to have before all others is ":(negate)", so that
we can say something like:

    git log -- '*.c' ':(negate)compat/"

I do not offhand recall what we decided during the last discussion
on the topic, but IIRC, the concensus was that it will make the code
too complex and general case unusably slow to support 'or', 'and',
and 'not' operators between pathspec elements (e.g. "*.c" or "*.h"
files but not in "compat/" directory, unless ...) in a general way,
and it would be sufficient to support negation by:

 - first grouping pathspec elements into two bins (i.e. normal
   patterns and negative patterns);

 - doing the usual path limiting using only the normal patterns;

 - among the paths that match one of the normal patterns, rejecting
   the ones that match one of the negative patterns.

or something like that.
