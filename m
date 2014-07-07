From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/4] hashmap: factor out getting an int hash code from a, SHA1
Date: Mon, 07 Jul 2014 10:22:56 -0700
Message-ID: <xmqqoax1dqxb.fsf@gitster.dls.corp.google.com>
References: <53B48540.5070600@gmail.com> <53B485A4.20609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:23:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4CdC-00075w-DP
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 19:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbaGGRXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 13:23:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63792 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbaGGRXD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 13:23:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6151A266FB;
	Mon,  7 Jul 2014 13:22:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yNsZPoPHnuCxuj31LwSyYIzswxg=; b=R9x5JJ
	a9TYO1NsYLTkqAWey2aMa91D9MIPwK0cdXlcxiZ6E4GTJQnTs+dQ4aU3KXxxVofS
	BbjWgtwr30M5BLNUMVJhvyv/1y8yFypLHwyX3BecQ9TZHn7yVNteTITCH4GIRdmo
	XBwtd+rc2NhiPzbd6NXFrEbkQrGdcReZAx/b8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ygus5VNPmzw0DEToSTRlWC2Mv7STkdNB
	kPLACdrtpJpfZ8FWnZtNVdhuexhC53YXK/ikT4M9oOdfIfr76/+XCh0YYNm8V77z
	QNF27RB9H0tZL/KAwO5elxLLDbgrEXi7KMzQW4lFFQ26h/MnBDm8e9VMYI+s81dQ
	3P0emnEO0TQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 561D9266FA;
	Mon,  7 Jul 2014 13:22:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B8444266E4;
	Mon,  7 Jul 2014 13:22:44 -0400 (EDT)
In-Reply-To: <53B485A4.20609@gmail.com> (Karsten Blees's message of "Thu, 03
	Jul 2014 00:20:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4EF64106-05FB-11E4-9F35-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252973>

Karsten Blees <karsten.blees@gmail.com> writes:

> Copying the first bytes of a SHA1 is duplicated in six places, however,
> the implications (wrong byte order on little-endian systems) is documented
> only once.

s/wrong /different /; but other than that I think this is a good
change.

> +`unsigned int sha1hash(const unsigned char *sha1)`::
> +
> +	Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
> +	for use in hash tables. Cryptographic hashes are supposed to have
> +	uniform distribution, so in contrast to `memhash()`, this just copies
> +	the first `sizeof(int)` bytes without shuffling any bits. Note that
> +	the results will be different on big-endian and little-endian
> +	platforms, so they should not be stored or transferred over the net!

Tone down with s/!/./, perhaps?

Another thing we may want to caution against is to use it as a
tie-breaker that affects the final outcome the user can observe, but
that may be something that goes without saying.  I dunno..

> diff --git a/hashmap.h b/hashmap.h
> index a816ad4..ed5425a 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -13,6 +13,17 @@ extern unsigned int strihash(const char *buf);
>  extern unsigned int memhash(const void *buf, size_t len);
>  extern unsigned int memihash(const void *buf, size_t len);
>  
> +static inline unsigned int sha1hash(const unsigned char *sha1)
> +{
> +	/*
> +	 * Equivalent to 'return *(int *)sha1;', but safe on platforms that
> +	 * don't support unaligned reads.
> +	 */

s/int/unsigned &/; other than that, the explanation is good.

> +	unsigned int hash;
> +	memcpy(&hash, sha1, sizeof(hash));
> +	return hash;
> +}
> +
