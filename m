From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* diff: --quiet does not imply --exit-code if --diff-filter is
 present
Date: Tue, 31 May 2011 10:36:12 -0700
Message-ID: <7v8vtmkc1f.fsf@alter.siamese.dyndns.org>
References: <87wrh7jgzk.wl@dns1.atmark-techno.com>
 <20110531153356.GB2594@sigill.intra.peff.net>
 <7vvcwqkh4a.fsf@alter.siamese.dyndns.org>
 <20110531162546.GA11321@sigill.intra.peff.net>
 <7vd3iykdej.fsf_-_@alter.siamese.dyndns.org>
 <20110531171401.GA12466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 31 19:36:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRSrj-0005C1-Oq
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 19:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192Ab1EaRgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 13:36:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133Ab1EaRgV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 13:36:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8861452D1;
	Tue, 31 May 2011 13:38:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ws4shWuywxgHApVX2yT4J3GxecM=; b=CxsUfj
	Fbucmt9uq86+mJr/B1oXSEVHuRcqCKUfXhEO+sqSuwUPk/pJTC97sJwgODcGze6z
	O6eLTTZG8ZARr4/4IAkqL7QgVFxXiZmbauZqmbNTau/qbhZpk4ybM9A12bmgzEYw
	79EFTu16CleE0MduWkEpjxXPoRp7k8kTbxTqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hj20B4OYdLsVC9i1euAJZs3dAEISmgNK
	9g9wHhTWolSgOCOSXrn64yN696712g1VJkAvzd9spWiCzx37sNfqEog4zLKd7QR1
	/MNWtoa44f+935HMOlPVQXkLIDd8QMm5KlA1RCk4OFQgMnJXykfQKGypQcvfAyDr
	GnSf9CnYsx0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5627A52D0;
	Tue, 31 May 2011 13:38:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3F29F52CF; Tue, 31 May 2011
 13:38:22 -0400 (EDT)
In-Reply-To: <20110531171401.GA12466@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 31 May 2011 13:14:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAB6EDE4-8BAC-11E0-94D4-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174816>

Jeff King <peff@peff.net> writes:

> I guess you did it this way to better share the discard-the-result
> codepath.

No, I did it as a hack because many places already do:

	if (... sub helper function that eventually call_callback ... < 0)
        	break; // or
                return; // or
                goto fail_return; // or whatever to exit recursion and loop

and obviously it was too much pain to change everybody to also pay
attention to the new flag.

A possibly cleaner way would be to designate a single negative value that
is not -1 as "early return but not failure" without using an extra bit,
but that also needs full vetting of the existing callchain, which I didn't
want to do just to write a "it would be as little as this" patch.
