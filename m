From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-compat-util.h: implement a different ARRAY_SIZE macro for for safely deriving the size of array
Date: Thu, 30 Apr 2015 10:41:30 -0700
Message-ID: <xmqqd22l1pkl.fsf@gitster.dls.corp.google.com>
References: <1430397854-28908-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 19:41:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnsT3-0001A0-BU
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 19:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbbD3Rlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 13:41:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751784AbbD3Rlc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 13:41:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1172E4D051;
	Thu, 30 Apr 2015 13:41:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BaWq6Hakao0Rr84odPyNb8zpOPY=; b=j2v5Sv
	cOMXg9sR3CONwIIB8ix5SuankCBzvpc7/yzjh2MI2MV5PPbnoyI5HZjQ3i87j5oC
	IGfaFT/z2tPoFBas8dsMvuZqR5cKFOUaXhsfO5kMYfZCg2ugoLOpLshMORlOTZwT
	VwxdE2Cuut7x/IKMsVYYj+rvxqM0dJqJuWfa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dYrtqmLagAYxPOm2z4GWeSLoBSvpR5kq
	ifipX5DDwPx4yL8u04xbYlTw8MBuPYyN8jwn3PnrUMr20XLy/MJaLvsZ8uG4hBXl
	xPfzZeVjCo7iNAIbmqXDFVTh9eXWloDuiFKN4Pe32VjoJndiugus+MaHT8cxDRH8
	ZQXNZP5MwhM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09A284D050;
	Thu, 30 Apr 2015 13:41:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83C444D04E;
	Thu, 30 Apr 2015 13:41:31 -0400 (EDT)
In-Reply-To: <1430397854-28908-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Thu, 30 Apr 2015 14:44:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 23445350-EF60-11E4-A248-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268080>

Elia Pinto <gitter.spiros@gmail.com> writes:

> +#if defined(__GNUC__) && (__GNUC__ >= 3)
> +# if GIT_GNUC_PREREQ(3, 1)
> + /* &arr[0] degrades to a pointer: a different type from an array */
> +# define BARF_IF_IS_NOT_AN_ARRAY(arr)						\
> +	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(typeof(arr), \
> +							typeof(&(arr)[0])))
> +# else
> +#  define BARF_IF_IS_NOT_AN_ARRAY(arr) 0 
> +# endif
> +#endif 
> +/*
> + * ARRAY_SIZE - get the number of elements in a visible array
> + *  <at> x: the array whose size you want.
> + *
> + * This does not work on pointers, or arrays declared as [], or
> + * function parameters.  With correct compiler support, such usage
> + * will cause a build error (see the build_assert_or_zero macro).
> + */
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]) + BARF_IF_IS_NOT_AN_ARRAY(x))
> +
>  #define bitsizeof(x)  (CHAR_BIT * sizeof(x))
>  
>  #define maximum_signed_value_of_type(a) \

Hmmmmmmmm.

    CC ws.o
ws.c: In function 'parse_whitespace_rule':
ws.c:46:3: error: unknown type name 'typeof'
   for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++) {
   ^

$ gcc --version
gcc (Ubuntu 4.8.2-19ubuntu1) 4.8.2
Copyright (C) 2013 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There
is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.
