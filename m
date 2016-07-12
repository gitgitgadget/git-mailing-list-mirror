Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06EBD1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 19:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbcGLT10 (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 15:27:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750885AbcGLT1Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 15:27:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 177882B1AD;
	Tue, 12 Jul 2016 15:27:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZQl5XJP/TZsC
	6KJJOfsW8uYdfLg=; b=kXtxQasNJp6VrHdSeu7ZKRX11AI4fpF4TM3RwHBPAhJa
	EYJpL3zuC+45maGMPpMARu0762/eVsqEiPKUhU76IU/Sq5/2ZffCAuD2FGBrkuzH
	of9icWEVBx5eLI2PoBzSqGTzJZETYew4I9RUwFEvGT0aROanzophsT/JikcQ9gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=H7kTeC
	X6Cvygop08Mei1xddOwLbqtN+cH7i8ffY6zKr9ljmt23tV6RhDxf5CcEZeaCNfLG
	P9OLNsfvt27DXPfBWDTeAYtSkKv8/QPz4W0SuqYa0RK7YqtcxJgNBHUuP41Stswy
	e5SnA9nbJYwDxGInJc4nY+5EcHa3s0iGEy3ak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F4AF2B1AC;
	Tue, 12 Jul 2016 15:27:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85DB12B1AB;
	Tue, 12 Jul 2016 15:27:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, michelbach94@gmail.com
Subject: Re: [PATCH 4/5] index-pack: report correct bad object offsets even if they are large
References: <1466807902.28869.8.camel@gmail.com>
	<20160705170558.10906-1-pclouds@gmail.com>
	<20160705170558.10906-5-pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 12:27:15 -0700
In-Reply-To: <20160705170558.10906-5-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Tue, 5 Jul 2016 19:05:57 +0200")
Message-ID: <xmqqmvlm4pyk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A520423E-4866-11E6-86AB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>  	va_end(params);
> -	die(_("pack has bad object at offset %lu: %s"), offset, buf);
> +	die(_("pack has bad object at offset %"PRIiMAX": %s"),
> +	    (intmax_t)offset, buf);

Subject: [PATCH] SQUASH???

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 73f7cd2..e2d8ae4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -349,8 +349,8 @@ static NORETURN void bad_object(off_t offset, const char *format, ...)
 	va_start(params, format);
 	vsnprintf(buf, sizeof(buf), format, params);
 	va_end(params);
-	die(_("pack has bad object at offset %"PRIiMAX": %s"),
-	    (intmax_t)offset, buf);
+	die(_("pack has bad object at offset %"PRIuMAX": %s"),
+	    (uintmax_t)offset, buf);
 }
 
 static inline struct thread_local *get_thread_data(void)
-- 
2.9.1-500-g4c1e1e0

