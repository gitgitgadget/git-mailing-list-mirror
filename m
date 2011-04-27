From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Wed, 27 Apr 2011 16:32:12 -0700
Message-ID: <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
References: <20110427225114.GA16765@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 28 01:32:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFEDp-0001i9-5r
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 01:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760222Ab1D0Xcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 19:32:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab1D0Xce (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 19:32:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A0F75539;
	Wed, 27 Apr 2011 19:34:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+rX++UbzgJvq7VqMVr6FV/Lu3jw=; b=CRQvGP
	kR35wgV8b2RjC3SSVtnnF1kgX8APehokBUHhTH2cSB4SQRXBWQ6iXxqQoledQRLl
	gEQkwF1aPNiUrj2lMgoeHSuU75ghX53yGZPOnoNlgCXcWmJXIpm2VgZed19TstRA
	XwCypMCF+rWgef2sonUchqBfIFbK8NCpm9EK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uqVX8SUsawdDIEAaXt26Nopm/tEazNSP
	kA4z9C0koj0RbDfyfPiJtRWfzr3AMMuCd2HfdgKF6qVmqSDp7L22nX2YWY+p6tBK
	EUXV6I6vDU4nH3XtN81BteD0O8lmQiN2yMr0BKnWXsbFyZZwDXyqM7M9EFY9jEqV
	HKoqvB+wQJM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D5F05532;
	Wed, 27 Apr 2011 19:34:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4BF7A552D; Wed, 27 Apr 2011
 19:34:17 -0400 (EDT)
In-Reply-To: <20110427225114.GA16765@elte.hu> (Ingo Molnar's message of "Thu,
 28 Apr 2011 00:51:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4514916-7126-11E0-8B63-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172291>

Ingo Molnar <mingo@elte.hu> writes:

> +static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>  {
> -	return !memcmp(sha1, null_sha1, 20);
> +	int i;
> +
> +	for (i = 0; i < 20; i++, sha1++, sha2++) {
> +		if (*sha1 != *sha2) {
> +			if (*sha1 < *sha2)
> +				return -1;
> +			return +1;
> +		}
> +	}
> +
> +	return 0;

This is very unfortunate, as it is so trivially correct and we shouldn't
have to do it.  If the compiler does not use a good inlined memcmp(), this
patch may fly, but I fear it may hurt other compilers, no?

> +static inline int is_null_sha1(const unsigned char *sha1)
>  {
> -	return memcmp(sha1, sha2, 20);
> +	const unsigned long long *sha1_64 = (void *)sha1;
> +	const unsigned int *sha1_32 = (void *)sha1;

Can everybody do unaligned accesses just fine?
