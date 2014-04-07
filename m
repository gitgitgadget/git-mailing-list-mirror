From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 19/27] refs: add a concept of a reference transaction
Date: Mon, 07 Apr 2014 12:13:06 -0700
Message-ID: <xmqq8urhlzr1.fsf@gitster.dls.corp.google.com>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
	<1396878498-19887-20-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 07 21:13:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEyq-0008Q6-R5
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 21:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbaDGTNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 15:13:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbaDGTNK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 15:13:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97A717AC33;
	Mon,  7 Apr 2014 15:13:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S//S0IRzvbercYjg0kA1Y93DurY=; b=mql/JC
	Qwy5UtU7es9AqaqMOIXdMhdrfZwwBBCkRml4nYezIx7R0izTscaZkk/F8g6dvWoI
	ZQya0muP4RteeFNiQ8dwLKHZA2U7zHBrgsTOSJLhwOnPKpcVzsMWec4opue48H7W
	x5/V0DQu7kJGxUXKVLRESDAC2eupVLMJlZkow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JmPkVxJffSplJo/xoByYZeND7gqYbv5R
	BxQNGZ8SkYwSnqOXi4sScaiHimnAtkch88KZGIPpwQxgd2XoB9Q4C8CmW3pyJQPy
	aSEpMHEfH8MOLSmvSjhCe+9xXmFX8s6JSo7NrWmWQIRzrDu1kAPZivOp9uggwHya
	GU6A3BFuLtc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 807427AC32;
	Mon,  7 Apr 2014 15:13:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C0357AC2E;
	Mon,  7 Apr 2014 15:13:08 -0400 (EDT)
In-Reply-To: <1396878498-19887-20-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 7 Apr 2014 15:48:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A779BA84-BE88-11E3-853D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245892>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +void ref_transaction_create(struct ref_transaction *transaction,
> +			    const char *refname,
> +			    unsigned char *new_sha1,
> +			    int flags)
> +{
> +	struct ref_update *update = add_update(transaction, refname);
> +
> +	assert(!is_null_sha1(new_sha1));
> +	hashcpy(update->new_sha1, new_sha1);
> +	hashclr(update->old_sha1);
> +	update->flags = flags;
> +	update->have_old = 1;
> +}
> +
> +void ref_transaction_delete(struct ref_transaction *transaction,
> +			    const char *refname,
> +			    unsigned char *old_sha1,
> +			    int flags, int have_old)
> +{
> +	struct ref_update *update = add_update(transaction, refname);
> +
> +	update->flags = flags;
> +	update->have_old = have_old;
> +	if (have_old) {
> +		assert(!is_null_sha1(old_sha1));
> +		hashcpy(update->old_sha1, old_sha1);
> +	}
> +}

These assert()s will often turn into no-op in production builds.  If
it is a bug in the code (i.e. the callers are responsible for
catching these conditions and issuing errors, and there are actually
such checks implemented in the callers), it is fine to have these as
assert()s, but otherwise these should be 'if (...) die("BUG:")', I
think.

Other than that, I did not spot anything questionable in this round.

Thanks; will replace the series (but on the same base as I needed to
apply the series there to compare what got changed with the old
version of corresponding change for each patches).
