From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: fix off-by-one in append_option
Date: Wed, 18 Apr 2012 12:34:14 -0700
Message-ID: <7vd374ltqh.fsf@alter.siamese.dyndns.org>
References: <20120417233255.GA24626@sigill.intra.peff.net>
 <20120418191849.GA12619@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 21:34:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKae3-0002md-BZ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 21:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab2DRTeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 15:34:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156Ab2DRTeS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 15:34:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1710678D9;
	Wed, 18 Apr 2012 15:34:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X5Ix3+RgmdLMfOwFvBXmIdVQvxI=; b=rAoI4g
	iTqchpJcEnPpqGn1sM7GzxP7l3X2gTXcPalqpcgT4BZMQgxETH9LckIgaCPv3ruf
	ymJDV3e18ybEwAR+8YwtOeGaEHjjYCrGUH+dAGNYm9ovU8Rsi1JhINMHLWtDbEL+
	Td24QeGlVRHuXDCMNN75lnHz9+sD6xyDsnt8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yGNKMlnGwA5hNB5kMiJNvcC55c+0RwoM
	vywqL68kEnIT0Au30Ya4fGbmQczxBM6O5d8P9UxTE/xVlgWP0PpFr5GL9K+Df3V+
	aYGNZBQCYG7FQUyqxDzw55vcMf9/Jr7IXavwpDyb+YYTlhRhnDXyIv2O7C1MXKr5
	Jt2pF7P7jws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E46078D8;
	Wed, 18 Apr 2012 15:34:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5351878D6; Wed, 18 Apr 2012
 15:34:16 -0400 (EDT)
In-Reply-To: <20120418191849.GA12619@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 18 Apr 2012 12:18:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C1D7ECA-898D-11E1-8E9B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195888>

Jeff King <peff@peff.net> writes:

> I've included a patch below that makes this look like:
>
>   static const char repack_cmd[] = {"repack", "-d", "-l", NULL };
>   static struct argv_array repack = ARGV_ARRAY_INIT_DEFAULT(repack_cmd);
>
> which is way less nice than I would prefer, but I think may be the best
> we can do with static initialization.
>
>> What do you think of just:
>> 
>>   static struct argv_array argv_repack;
>>   [...]
>>   argv_init_from_string(&argv_repack, "repack -d -l");
>
> I looked into this, but it seems our sq_dequote_* functions insist that
> it be spelled "'repack' '-d' '-l'", so I would have to teach them to be
> more liberal first.
>
> Thoughts?

I do not know it is worth it to try to be too fancy.

I was about to suggest, immediately after seeing the first one I quoted
above, to omit NULL and instead use ARRAY_SIZE(), but I do not think that
is even worth it, as some (possibly future) caller may have only "char **"
as a usual NULL terminated array at hand.

I am perfectly OK with even without initializers, like this:

	struct argv_array repack = ARGV_ARRAY_INIT;
	argv_array_push_strings(&repack, "repack", "-d", "-l", NULL);
