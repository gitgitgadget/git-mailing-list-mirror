From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Tolerate zlib deflation with window size < 32Kb
Date: Wed, 03 Aug 2011 16:56:36 -0700
Message-ID: <7vsjpi82x7.fsf@alter.siamese.dyndns.org>
References: <1312410730-12261-1-git-send-email-roberto.tyley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Roberto Tyley <roberto.tyley@guardian.co.uk>
To: roberto.tyley@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 04 01:56:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QolIs-0007eI-HC
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 01:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab1HCX4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 19:56:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48493 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755872Ab1HCX4j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 19:56:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC4DA593C;
	Wed,  3 Aug 2011 19:56:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yeffCLjc/Qy/Nv/NLEZTbCrPpjs=; b=iayNuA
	BfIECYH0nP//+75VaoTkiXyHJNjAyFVeR3evZaRV2N+LQLY//cti7m0EzG3f5hzZ
	wdHszrkWWoN5hRhMceiky1WbsTGG+fQlRIgA8LSoaF+02BwQ0rehHbfaCLIykA8H
	Ua4jzK7wxecENIPlK3W/meE78cvKTpUyOdtjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vK0p6Hub5AQKnb7u+Ig1vBk4YHqbkrdO
	8fsQV0EFpQN55B029PsyQCL6cCTFg0WcFwqapNk+oPIswUQrWwSdnEwDc1HhZwHw
	xYOMn2JOptdl2vGfw5tvKGSqf7Z6W1Mml0UIDmxSanySsWvsR1NT6QYkegbgNq1h
	tWRbycugLQI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B39E3593B;
	Wed,  3 Aug 2011 19:56:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B7BC593A; Wed,  3 Aug 2011
 19:56:38 -0400 (EDT)
In-Reply-To: <1312410730-12261-1-git-send-email-roberto.tyley@gmail.com>
 (roberto tyley's message of "Wed, 3 Aug 2011 23:32:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A07DA4E-BE2C-11E0-9C56-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178644>

roberto.tyley@gmail.com writes:

> +	 * We must determine if the buffer contains the standard
> +	 * zlib-deflated stream or the experimental format based
> +	 * on the in-pack object format. Compare the header byte
> +	 * for each format:
> +	 *
> +	 * RFC1950 zlib w/ deflate : 0www1000 : 0 <= www <= 7
> +	 * Experimental pack-based : Stttssss : ttt = 1,2,3,4
> +	 *
> +	 * If bit 7 is clear and bits 0-3 equal 8, the buffer MUST be
> +	 * in standard loose-object format, UNLESS it is a Git-pack
> +	 * format object *exactly* 8 bytes in size when inflated.
> +	 *
> +	 * However, RFC1950 also specifies that the 1st 16-bit word
> +	 * must be divisible by 31 - this checksum tells us our buffer
> +	 * is in the standard format, giving a false positive only if
> +	 * the 1st word of the Git-pack format object happens to be
> +	 * divisible by 31, ie:
> +	 *      ((byte0 * 256) + byte1) % 31 = 0
> +	 *   =>        0ttt10000www1000 % 31 = 0
> +	 *
> +	 * As it happens, this case can only arise for www=3 & ttt=1
> +	 * - ie, a Commit object, which would have to be 8 bytes in
> +	 * size. As no Commit can be that small, we find that the
> +	 * combination of these two criteria (bitmask & checksum)
> +	 * can always correctly determine the buffer format.
>  	 */
>  	word = (map[0] << 8) + map[1];
> -	if (map[0] == 0x78 && !(word % 31))
> +	if ((map[0] & 0x88) == 0x08 && !(word % 31))

Are you sure about this 0x88? Isn't it 0x8F or something?

>  		return 0;
>  	else
>  		return 1;
