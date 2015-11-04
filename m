From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Wed, 04 Nov 2015 09:09:03 -0800
Message-ID: <xmqqsi4lbsk0.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cRRjCDhdT-DvGtZqns1mMxygnxi=ZnRKzg+H_do7oRpqQ@mail.gmail.com>
	<1446359536-25829-1-git-send-email-apahlevan@ieee.org>
	<xmqqh9l5h8g3.fsf@gitster.mtv.corp.google.com>
	<CA+izobvbDYLvShT8TdDhe9UiYHVWw+Le+Yy4yOnvCYOWE0bhQQ@mail.gmail.com>
	<xmqqpozsdrnl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Randall Becker <rsbecker@nexbridge.com>,
	Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: Atousa Duprat <atousa.p@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 18:09:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu1Yj-0000M3-Uc
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 18:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079AbbKDRJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 12:09:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756074AbbKDRJM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 12:09:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 51D0E2764F;
	Wed,  4 Nov 2015 12:09:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OBM9c2s2aN/WhDjNLCX1ZIIXjXo=; b=xXqs0N
	vsewB9ncOWHKB16oVihrucd+/ddjMrh8cfRxXip/K1mLwtSiSVYwkQYjCyAYd5kS
	SXLWOifNBw3EcBrMi9ez0YwzeyLEfcwUXtNr7SPAdSmWSPH7XdMWQilS3JrsY95t
	nQJKcLqzVeCHRIpum4pOvRc3hxNS1BjV4mlZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qjwXBg4OnlSJHwTAIs59cw89rGA5PKCb
	7PMRQ6fZwosG1HpluBvwpdTAlkilVdJDkO9LtrHx4RiUSyIilg8Bf7+dSP50zcJb
	j4AqNfY34QJjVpChIxoVROYCc0NX9xQZGAv6KHK2/rCQUvFJ09xHA03bJ2tikhLl
	yWcQfuiQQAw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 489302764C;
	Wed,  4 Nov 2015 12:09:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BEAE127649;
	Wed,  4 Nov 2015 12:09:04 -0500 (EST)
In-Reply-To: <xmqqpozsdrnl.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 02 Nov 2015 13:21:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C09BA3C0-8316-11E5-962A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280859>

Junio C Hamano <gitster@pobox.com> writes:

>> ifdef BLK_SHA1
>>         SHA1_HEADER = "block-sha1/sha1.h"
>>         LIB_OBJS += block-sha1/sha1.o
>> else
>> ifdef PPC_SHA1
>>         SHA1_HEADER = "ppc/sha1.h"
>>         LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
>> else
>> ifdef APPLE_COMMON_CRYPTO
>>         COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
>>         SHA1_HEADER = <CommonCrypto/CommonDigest.h>
>>         SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
>> else
>>         SHA1_HEADER = <openssl/sha.h>
>>         EXTLIBS += $(LIB_4_CRYPTO)
>> endif
>>
>> which seems to imply that BLK_SHA1 and APPLE_COMMON_CRYPTO are
>> mutually exclusive?
>
> Yes, you are correct that these two cannot be used at the same time.
> In general (not limited to BLK_SHA1 and APPLE_COMMON_CRYPTO) you can
> pick only _one_ underlying SHA-1 implementation to use with the
> system.

Our "seems to imply" above is a faulty reading.  The four lines I
wrote are not incorrect per-se, but this exchange was misleading.

When BLK_SHA1 is defined, the above fragment from the Makefile is
only saying "CommonCrypto may or may not be used for any other
purposes, but for SHA-1 hashing, I'll use our own block-sha1/
implementation."  It does not say anything about how the system
favours CommonCrypto over OpenSSL with APPLE_COMMON_CRYPTO.

And it is legit to define both APPLE_COMMON_CRYPTO and BLK_SHA1; the
resulting build would still use SSL-related functions what other
people may use from OpenSSL from CommonCrypto.  Filipe Cabecinhas
pointed out that such a configuration works (and solves the issue
that triggered this thread) very early in the thread.

I haven't looked carefully at the latest version of your patch, but
I just wanted to make sure that I didn't mislead you to add an
unnecessary "we check if both APPLE_COMMON_CRYPTO and BLK_SHA1 are
defined and error out because they are incompatible" check.  Sorry
for an earlier message that may have been confusing.

Thanks.
