From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v4 14/26] Add stateless RPC options to upload-pack,
 receive-pack
Date: Thu, 29 Oct 2009 13:43:58 -0700
Message-ID: <7vtyxi53sh.fsf@alter.siamese.dyndns.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
 <1256774448-7625-15-git-send-email-spearce@spearce.org>
 <7vd446dfx4.fsf@alter.siamese.dyndns.org>
 <20091029152629.GY10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 21:44:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3bqt-0002Ww-W9
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 21:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675AbZJ2UoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 16:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756673AbZJ2UoB
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 16:44:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655AbZJ2UoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 16:44:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6944E6C5F7;
	Thu, 29 Oct 2009 16:44:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=t4lEarNP1KsEpPmvqEK0RRf2oiY=; b=hVKSpWfvpCTla63qeGnmVsm
	bQCfMWvDIXwkhyPI897U3X0VplzvjA/LZxM2xJORh2bZIoP2EuqVB3bE7V8dJMBG
	hPm7izuzzVEsqPxh1rR2Ivi4p0p+YaBwvR5xzsSuUTsR+Mjs5z9n3K27DuglSWxy
	mFWl1mSJG9AykMVBSsK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kTCoElW4qHb4Ui3p6GLnVGRDz1NSt//K3GP3up+uT8NEQ+BMS
	pKIfmHjl8/VOnjz9N4XDmjdNMC9N5jqNUyjzpt+VasdQ0CQazHOdV1nEJu5L05wT
	IyNZU9dKuQrFrR2mRMEHKXibX10mJ3q6XS4WV6FyouMJ33HR5Gf413U8ao=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 477B06C5F6;
	Thu, 29 Oct 2009 16:44:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 747A56C5F5; Thu, 29 Oct
 2009 16:43:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB1ACC6E-C4CB-11DE-967D-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131652>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> One approach is to use an HMAC and sign each advertised SHA-1
> during the initial --advertise-refs phase.  Requesters then present
> the SHA-1 and the HAMC signature in each "want" line, and the
> --stateless-rpc phase validates the signatures to ensure they came
> from a trusted party.
>
> The major problem with this approach is the private key management.
> All mirrors of that repository need to have a common private key
> so they can generate and later verify that HMAC signature.  This is
> additional complexity, for perhaps not much gain.

I am not worried so much about malicious clients getting themselves
confused.  One simple alternative would be to internally recreate the
response the requestee would send if it were the first phase request upon
receiving the request for the second phase---then you take an SHA-1 hash
of it.  In the second phase request have the requestor include the SHA-1
hash of what it received in the response to its first phase request, and
the requestee can make sure they match.  No per-ref signing nor secret key
management is necessary, and it would let the requestor retry if you allow
the response to the second phase request to be "your request is stale, try
again".

> A different approach is to have the --stateless-rpc phase validate
> the want lines against its refs (like we do now), but if the validate
> fails (no ref exactly matches) support walking backwards through the
> last few records in the reflog, or through that ref's own history
> for a few hundred commits, to see if the want SHA-1 appears in the
> recent prior past.
>
> Obviously when walking the reflog we would need to use a time bound,
> e.g. "only examine last record if more recent than 5 minutes ago".

I think that is probably too much complexity for too little gain.  I think
detecting stale request and having requestor retry would be sufficient,
and validating the want lines as we already do would give the same level
of assurance as "check against the hash of first phase response" I
outlined above, and would be much simpler thus more robust.
