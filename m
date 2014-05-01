From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add extra logic required to detect endianness on Solaris
Date: Thu, 01 May 2014 12:18:22 -0700
Message-ID: <xmqq61lpcnpd.fsf@gitster.dls.corp.google.com>
References: <1398930197-12851-1-git-send-email-cbailey32@bloomberg.net>
	<xmqqa9b1coml.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <cbailey32@bloomberg.net>
X-From: git-owner@vger.kernel.org Thu May 01 21:18:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfwV5-00061Q-1Y
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 21:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbaEATS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 15:18:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54909 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbaEATS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 15:18:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA54210476;
	Thu,  1 May 2014 15:18:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OIKTYQ1xXqeS0uWuDBD4TT4y5cg=; b=aC8j8U
	2flOrx5iq7+eFuEyQ5TgNUw9+KZrLjBtdpEV6X45FSAGjtHbY1NvepSESMUbm6oE
	OVY0aLb2aE7xUfzVTtIeMQhYy+O0wTju77ag+uCT1ifXq5fYq39x2MCDBPesiEO8
	Z3uxtioShIVy1eBiiGjNdpRsV5kZSnQHQRRc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HACiTnD7NaLr5VquBoGV6BNbH2TC6VHs
	R4vr2minT5ueYibUIuoteaje9mZKp0h0lLlroz8F10Ui9p7NAhVxZEL+flnAE7JX
	YCKnFssrjCnfigndrOC1IzEVkVq3+cAECdNjMSEDQdy4PV6XWGMStyj21Zb1z5os
	eQDXD2Vs12M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E09AC10473;
	Thu,  1 May 2014 15:18:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DCCFE1046A;
	Thu,  1 May 2014 15:18:23 -0400 (EDT)
In-Reply-To: <xmqqa9b1coml.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 01 May 2014 11:58:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5D5724EC-D165-11E3-9415-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247827>

Junio C Hamano <gitster@pobox.com> writes:

> Charles Bailey <cbailey32@bloomberg.net> writes:
>
>>  #if !defined(__BYTE_ORDER)
>> +/* Known to be needed on Solaris but designed to potentially more portable */
>> +
>> +#if !defined(__BIG_ENDIAN)
>> +#define __BIG_ENDIAN 4321
>> +#endif
>> +
>> +#if !defined(__LITTLE_ENDIAN)
>> +#define __LITTLE_ENDIAN 1234
>> +#endif
>> +
>> +#if defined(_BIG_ENDIAN)
>> +#define __BYTE_ORDER __BIG_ENDIAN
>> +#endif
>> +#if defined(_LITTLE_ENDIAN)
>> +#define __BYTE_ORDER __LITTLE_ENDIAN
>> +#endif
>
> The existing support is only for platforms where all three macros
> (BYTE_ORDER, LITTLE_ENDIAN and BIG_ENDIAN) are defined, and the
> convention used on such platforms where BYTE_ORDER is set to either
> one of the *_ENDIAN macros to tell the code which byte order we
> have.  This mimics the convention where __BYTE_ORDER and other two
> macros are already defined with two leading underscores, and in such
> a case we do not have to do anything.  We make the final decision to
> use or bypass bswap64() in our ntohll() implementation based on the
> variables with double leading underscores.
>
> This patch seems to address two unrelated issues in that.
>
>  (1) The existing support does not help a platform where the
>      convention is to define either _BIG_ENDIAN (with one leading
>      underscore) or _LITTLE_ENDIAN and not both, which is Solaris
>      but there may be others.
>
>  (2) There may be __LITTLE_ENDIAN and __BIG_ENDIAN macros already
>      defined on the platform.  Or these may not have been defined at
>      all.  You avoid unconditionally redefing these.
>
> I find the latter iffy.
>
> What is the reason for avoiding redefinition?  Is it because you
> know the original values they have are precious?  And if so in what
> way they are precious?  If the reason of avoiding redefinition is
> because you do not even know what their values are (so that you are
> trying to be safe by preserving), what other things can you say
> about their values you are preserving?
>
> Specifically, do you know that these two are defined differently, so
> that defining __BYTE_ORDER to one of them and comparing it to
> __BIG_ENDIAN is a good way to tell if the platform is big endian?
>
> I would understand it if (2) were "we undefine if these are defined
> and then define them as 4321 and 1234 respectively, in order to
> avoid a compiler warning against redefinition of a macro", but that
> is not what I am seeing, so I am not sure what you meant to achieve
> by that "if !defined()" constructs.
>
> Thanks.

Just a thought.

I am wondering if you may want to go the other way around.  That is,
instead of using "we have byte-order, big and little and the way to
determine endianness is to see byte-order matches which of the
latter two", use "there may be either big or little but not both
defined, and that is how you learn the byte-order".

And make these two macros match what Solaris happens to use.

I am not sure which variant I like better myself, though.

 compat/bswap.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 120c6c1..e87998e 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -101,19 +101,24 @@ static inline uint64_t git_bswap64(uint64_t x)
 #undef ntohll
 #undef htonll
 
-#if !defined(__BYTE_ORDER)
-# if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
-#  define __BYTE_ORDER BYTE_ORDER
-#  define __LITTLE_ENDIAN LITTLE_ENDIAN
-#  define __BIG_ENDIAN BIG_ENDIAN
-# endif
+#if !defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
+
+#if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
+# if BYTE_ORDER == BIG_ENDIAN
+#  define _BIG_ENDIAN
+# else
+#  define _LITTLE_ENDIAN
+#endif
+
 #endif
 
-#if !defined(__BYTE_ORDER)
+#if !defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
 # error "Cannot determine endianness"
+#elif defined(_BIG_ENDIAN) && defined(_LITTLE_ENDIAN)
+# error "Your endianness is screwed up"
 #endif
 
-#if __BYTE_ORDER == __BIG_ENDIAN
+#if defined (_BIG_ENDIAN)
 # define ntohll(n) (n)
 # define htonll(n) (n)
 #else
