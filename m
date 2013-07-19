From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add the GIT_SENTINEL macro
Date: Fri, 19 Jul 2013 00:18:29 -0700
Message-ID: <7vmwpjyq4a.fsf@alter.siamese.dyndns.org>
References: <51E849C4.7020305@ramsay1.demon.co.uk>
	<7vr4evz0oc.fsf@alter.siamese.dyndns.org>
	<20130719033634.GB27853@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 09:18:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V04xZ-0007ns-H1
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 09:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933931Ab3GSHSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 03:18:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49097 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759663Ab3GSHSc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 03:18:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10BF62DB85;
	Fri, 19 Jul 2013 07:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=InkcK3h7jlwV08TFBkDvampf4nM=; b=iHgB41
	iLL7t0Fej3BkPkl8TzXJHgqqm+2C9DbeHa86YCZWFztaSUv9G09VyYseFkX3917H
	U0BHEaYiHnZ3ZbJjnr8a+w+N9LoYWcHNWiJLKGrY1hE6WEpbSJBnR8OKV/x9SA2d
	jETpOnbsAzPx5loL1whdTdpOGkBUbPyeSMjf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X1JHGA5EpgiCSigaQm68WCvkpinfY476
	eR7N8GcUzG3ZjwS3lnFAWN1zbEM0UDov6MSI2Oa917mdWXaqfzKDoDJhjeuq3gg+
	+CnsONRc4E3fFpFQ/CUQD6h90vf6HWU44ZvxMB/hL1Dd0cb/KK3u4CK4k8AHNSYh
	+voeDZ3XqZE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 040562DB84;
	Fri, 19 Jul 2013 07:18:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5696A2DB81;
	Fri, 19 Jul 2013 07:18:31 +0000 (UTC)
In-Reply-To: <20130719033634.GB27853@google.com> (Jonathan Nieder's message of
	"Thu, 18 Jul 2013 20:36:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A6E8E76-F043-11E2-A760-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230782>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> It seems to apply well on the tip of jk/gcc-function-attributes.
>>
>>  - This macro is not about "git" at all, so I'll edit the patch to
>>    call it GCC_ATTR_SENTINEL before applying.
>
> Would naming it something like LAST_ARG_MUST_BE_NULL instead make
> sense?  That way, if some other compiler gains a different syntax for
> the same annotation, it would be possible to do
>
> 	#if defined(__GNUC__) && __GNUC__ >= 4
> 	# define LAST_ARG_MUST_BE_NULL __attribute__((sentinel))
> 	#elif defined(_MSC_VER) && _MSC_VER > 27
> 	# define LAST_ARG_MUST_BE_NULL __declspec(lastargnull)
> 	#else
> 	# define LAST_ARG_MUST_BE_NULL
> 	#endif

I do like last-arg-must-be-null name for its descriptiveness; with
the example of NORETURN vs NORETURN_PTR, however, I am not quite
convinced that it would help reusing the same macro to different
compilers.

I would say it is already sheer luck that GCC's __attribute__(())
and MSC's __declspec() both come at the same place in the function
declaration syntax, i.e. before the usual declaration.  Your next
compiler may want the magic immediately before the closing semicolon
of the declaration, for example.
