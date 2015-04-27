From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-compat-util.h: implement a different ARRAY_SIZE macro for for safely deriving the size of array
Date: Mon, 27 Apr 2015 10:56:30 -0700
Message-ID: <xmqq1tj5xxo1.fsf@gitster.dls.corp.google.com>
References: <1430140269-11784-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 19:56:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmnGr-0005EY-9T
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 19:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852AbbD0R4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 13:56:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932828AbbD0R4f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 13:56:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA3114C17F;
	Mon, 27 Apr 2015 13:56:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=twx6O6wLdTNS22PeRuvT+ZdNHRo=; b=NR0kQT
	RNgZz1N+KF2O1OUqScqve+AmGZsdEsxB5All3PKysTROg1SBqv3wWt5QIsgtH1gx
	2j0V3BD4WZfeCSdCgmIcSqBWi3ee+PYMOObLyE7dcVNqY8J9xLQ0il3HmukRuuQE
	26R7KKRBuFj9ZW//+BbdI3lKnNHqt0LCVEJz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RarnBPLzL6Lcju9qzsKIQ5A3iE/mk6Nz
	V2aA6HvLNIGDdKkWVAi9OP8K7yZXAIYfQ6LV8WCxeRcfIPUIGvz38Q6fiITfio2o
	0mrhmEkEV7IKfiuFBP9UvxZQkyTRNjc3D1EpzO3TFZ8r0Ol7BP6bAeebc06MRl8z
	o/EJiQtDD8c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E23C04C17E;
	Mon, 27 Apr 2015 13:56:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E3C24C17D;
	Mon, 27 Apr 2015 13:56:32 -0400 (EDT)
In-Reply-To: <1430140269-11784-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Mon, 27 Apr 2015 15:11:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD171B2C-ED06-11E4-84E0-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267861>

Elia Pinto <gitter.spiros@gmail.com> writes:

> This is the second version of this patch.  It had not been
> discussed before. In the second version, I just tried to clarify
> the comment in the commit. I resend it just in case you missed

I do not recall seeing it before.  No discussion usually means no
interest, so I'll see what happens this time on the list for a few
days before picking it up.

> +#if SUPPORT__BUILTIN_TYPES_COMPATIBLE_P
> +/* &arr[0] degrades to a pointer: a different type from an array */
> +#define _array_size_chk(arr)						\
> +	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(typeof(arr), \
> +							typeof(&(arr)[0])))
> +#else
> +#define _array_size_chk(arr) 0
> +#endif

Wouldn't there be a more sensible name?  _chk does not tell us
anything about what is being checked, and the only thing this name
gives us is "what uses it" (i.e. it is some magic used by array-size
and does not say what it checks and what for).

I think you are checking arr is an array and not a pointer.  Perhaps
"#define is_an_array(arr)" or something along that line may be a
more descriptive name for it.

I doubt the leading underscore is particularly a good idea, though.

> +/*
> + * ARRAY_SIZE - get the number of elements in a visible array
> + *  <at> x: the array whose size you want.
> + *
> + * This does not work on pointers, or arrays declared as [], or
> + * function parameters.  With correct compiler support, such usage
> + * will cause a build error (see build_assert).
> + */
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]) + _array_size_chk(x))
>  #define bitsizeof(x)  (CHAR_BIT * sizeof(x))
>  
>  #define maximum_signed_value_of_type(a) \
