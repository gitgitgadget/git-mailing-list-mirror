From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/index-pack.c: Fix some pthread_t misuse
Date: Wed, 07 Mar 2012 11:15:00 -0800
Message-ID: <7vvcmgmde3.fsf@alter.siamese.dyndns.org>
References: <4F57B04F.6050307@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Mar 07 20:15:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5MKN-0007IP-Cc
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 20:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759740Ab2CGTPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 14:15:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758731Ab2CGTPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 14:15:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3496F67C7;
	Wed,  7 Mar 2012 14:15:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m3C6CZrhGX5G+Age7MxUuYOBtvI=; b=qhonUw
	SZtq1zcjZYKL64eCXpZhAnuJzRrgDitIlzKlUB+5EQXK13zBTdyAUl4ZS+Zd9fZL
	qwqBM8AfZjggjuuZb9RCqOkfAqB+vwdtReI4CjggBooubVuC3mXpAIulP69KTRMX
	fTvjbjlBZKTTKuBGsieXA0IW9w3Z00VPr/KNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lHOzumP+jofB4HDv9GNhKJP/GoxNdTHz
	nsZ89QZY1kwCQgIoinNsOk+LOygkXJvIvG6uft/Zr1dSLVd/qbbNhAY2isHrM7DF
	7JJaFP8NLEYxd4FGZKOdVmlXvR+h2kscTbf8U9ZAFDawhq3MSiMelAzuC1y7pICJ
	+FDI8dIrALo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26BAD67C6;
	Wed,  7 Mar 2012 14:15:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF01467C2; Wed,  7 Mar 2012
 14:15:01 -0500 (EST)
In-Reply-To: <4F57B04F.6050307@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Wed, 07 Mar 2012 19:00:31 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D68E3B6C-6889-11E1-AF21-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192473>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> However, pthread_t is intended to be an opaque (implementation defined)
> type. For example, an implementation may choose to use a structure to
> implement the type.  Therefore, assigning zero (or any other constant)
> to a pthread_t is not supported in general.
> ...
> Note that, for the same reason given above, you can not, in general,
> directly compare pthread_t handles with the built-in equality operator.
> In order to compare pthread_t's for equality, the POSIX standard requires
> the use of pthread_equal().

Thanks, the above analysis all sound sensible.

I do not think it matters in *this* case, but if a loop iterates
over an array of things with a field of type pthread_t in it, whose
element may or may not be valid, and wants to mark the validity of
an element with the value of its pthread_t field, what is the proper
way to do so?  I.e.

	for (i = 0; i < ARRAY_SIZE(thread_data); i++) {
		if (pthread_invalid(thread_data[i].thread)
			continue; /* not used */
        	if (!pthread_equal(self, thread_data[i].thread))
                	continue; /* not me */
		/* ah, this is mine! */
                ...
	}

Perhaps the answer is "Don't do it" and that is perfectly fine, but
does Nguyen's code rely on the final clean-up (assignment with 0 you
are removing with this patch) to mark that these elements are no
longer relevant?
