From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Mon, 02 Nov 2015 13:21:02 -0800
Message-ID: <xmqqpozsdrnl.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cRRjCDhdT-DvGtZqns1mMxygnxi=ZnRKzg+H_do7oRpqQ@mail.gmail.com>
	<1446359536-25829-1-git-send-email-apahlevan@ieee.org>
	<xmqqh9l5h8g3.fsf@gitster.mtv.corp.google.com>
	<CA+izobvbDYLvShT8TdDhe9UiYHVWw+Le+Yy4yOnvCYOWE0bhQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Randall Becker <rsbecker@nexbridge.com>,
	Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: Atousa Duprat <atousa.p@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 22:21:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtMXP-00068O-UI
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 22:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbbKBVVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 16:21:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753874AbbKBVVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 16:21:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B64827340;
	Mon,  2 Nov 2015 16:21:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o5fIzJ5VRrjU24MP7tON0/+yUy4=; b=W6tsC2
	OVT1ucWhWGoue3jIlIR3taLK+B2MS2ccvprDwEzkTB8+EDfQU6SBEIIdgI/H1CRg
	LopSOxE2vwmGv23mm7PLYPvLPGIiWdeJhK4SOC68tsq6hqavGYqRCZHq5uvCjiI2
	JAxy2coK1x8nJxgE5u63XlVLbn9aJ5JqGlwyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RmaPzWbgcnOtfLaAnRD8YNgn5gLOU5cb
	uUd5BH+JRxokfMUzyJWSvlX2skBVfSXFYcqV0//0WyaW0xSfYz4mizgTR2SqZ9K2
	a6CPHYp+B5ZUl7gXardP3QOkDNX3IXPiDh2YzYco1UkbdpGs6fOImFc+cNlbQ2iT
	0WgfTscujj8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 50D552733E;
	Mon,  2 Nov 2015 16:21:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CACD32733D;
	Mon,  2 Nov 2015 16:21:03 -0500 (EST)
In-Reply-To: <CA+izobvbDYLvShT8TdDhe9UiYHVWw+Le+Yy4yOnvCYOWE0bhQQ@mail.gmail.com>
	(Atousa Duprat's message of "Mon, 2 Nov 2015 12:52:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F65D0F6-81A7-11E5-8DDD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280723>

Atousa Duprat <atousa.p@gmail.com> writes:

> On Sun, Nov 1, 2015 at 10:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Hmm, I admit that this mess is my creation, but unfortunately it
>> does not allow us to say:
>>
>>         make SHA1_MAX_BLOCK_SIZE='1024L*1024L*1024L'
>>
>> when using other SHA-1 implementations (e.g. blk_SHA1_Update()).
>>
>> Ideas for cleaning it up, anybody?
>>
> In the Makefile there is the following:
>
> ifdef BLK_SHA1
>         SHA1_HEADER = "block-sha1/sha1.h"
>         LIB_OBJS += block-sha1/sha1.o
> else
> ifdef PPC_SHA1
>         SHA1_HEADER = "ppc/sha1.h"
>         LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
> else
> ifdef APPLE_COMMON_CRYPTO
>         COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
>         SHA1_HEADER = <CommonCrypto/CommonDigest.h>
>         SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
> else
>         SHA1_HEADER = <openssl/sha.h>
>         EXTLIBS += $(LIB_4_CRYPTO)
> endif
>
> which seems to imply that BLK_SHA1 and APPLE_COMMON_CRYPTO are
> mutually exclusive?

Yes, you are correct that these two cannot be used at the same time.
In general (not limited to BLK_SHA1 and APPLE_COMMON_CRYPTO) you can
pick only _one_ underlying SHA-1 implementation to use with the
system.

If you use APPLE_COMMON_CRYPTO, you may have to use the Chunked
thing, because of APPLE_COMMON_CRYPTO implementation's limitation.

But the above two facts taken together does not have to imply that
you are forbidden from choosing to use Chunked thing if you are
using BLK_SHA1 or OpenSSL's SHA-1 implementation.  If only for
making sure that the Chunked wrapper passes compilation test, for
trying it out to see how well it works, or just for satisfying
curiosity, it would be nice if we allowed such a combination.

The original arrangement of macro was:

 * The user code uses git_SHA1_Update()

 * cache.h renames git_SHA1_Update() to refer to the underlying
   SHA1_Update() function, either from OpenSSL or AppleCommonCrypto,
   or block-sha1/sha1.h renames git_SHA1_Update() to refer to our
   implementation blk_SHA1_Update().

What we want with Chunked is:

 * The user code uses git_SHA1_Update(); we must not change this, as
   there are many existing calls.

 * We want git_SHA1_Update() to call the Chunked thing when
   SHA1_MAX_BLOCK_SIZE is set.

 * The Chunked thing must delegate the actual hashing to underlying
   SHA1_Update(), either from OpenSSL or AppleCommonCrypto.  If we
   are using BLK_SHA1, we want the Chunked thing to instead call
   blk_SHA1_Update().

I do not seem to be able to find a way to do this with the current
two-level indirection.  If we added another level, we can.

* In cache.h, define platform_SHA1_Update() to refer to
  SHA1_Update() from the platform (unless block-sha1/ is used).
  git_SHA1_Update() in the user code may directly call it, or it may
  go to the Chunked thing.

  #ifndef git_SHA1_CTX
  #define platform_SHA1_Update  SHA1_Update
  #endif

  #ifdef SHA1_MAX_BLOCK_SIZE
  #define git_SHA1_Update       git_SHA1_Update_Chunked
  #else
  #define git_SHA1_Update       platform_SHA1_Update
  #endif

* In block-sha1/sha1.h, redirect platform_SHA1_Update() to
  blk_SHA1_Update().

  #define platform_SHA1_Update  blk_SHA1_Update

* In compat/sha1_chunked.c, implement the Chunked thing in terms of
  the platform_SHA1_Update():

  git_SHA1_Update_Chunked(...)
  {
        ...
        while (...) {
                platform_SHA1_Update(...);
        }
  }


I am not sure if the above is worth it, but I suspect the damage is
localized enough that this may be OK.
