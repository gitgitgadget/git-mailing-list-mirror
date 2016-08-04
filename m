Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C635A1F855
	for <e@80x24.org>; Thu,  4 Aug 2016 22:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbcHDWkH (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 18:40:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752947AbcHDWkG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2016 18:40:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D190E32B5E;
	Thu,  4 Aug 2016 18:40:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mH1yTcls9zx+
	nDdEAEVsCPtl9C0=; b=fDNlPnbqI7rna1avQ6zfexgIIfeRpLAttYE8eLUxATKC
	N878e4FN3wcQMBSAxmj6Ymfhr7ipg5gsy+qVOpFyCnpKB2Ieoo4GFlaHTBRMhgHD
	4ZWBsl7pm9yjjvaDZm7xFsBQeMpv24PGVXktA5breH9QBq/S5iRrOuJoo2i1w0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VUpVUU
	C3sDmRxXUTGxvrd12nD00d5Wcgx1hPkimEJbeI0b9BwdVqJfj+IdALSyf4b7h+yh
	bF7u9jYUv5S6AoI8UAPNynD9JuZp0EZld/x0B0YuGWXx3rrNjydTHoQwu+a4jHxE
	gdAh+aWORFw+NPboxbPh3i8NHbMM1Vv/CFyeo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C953232B5D;
	Thu,  4 Aug 2016 18:40:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E13032B58;
	Thu,  4 Aug 2016 18:40:01 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
References: <cover.1470326812.git.johannes.schindelin@gmx.de>
	<57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de>
	<57A3BA26.5080601@web.de>
Date:	Thu, 04 Aug 2016 15:39:58 -0700
In-Reply-To: <57A3BA26.5080601@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Thu, 4
	Aug 2016 23:56:54 +0200")
Message-ID: <xmqqk2fwyx8h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 61EC3424-5A94-11E6-BAE6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Let's try it this way.  How about this as a replacement?

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 4 Aug 2016 18:07:08 +0200
Subject: [PATCH] nedmalloc: work around overzealous GCC 6 warning

With GCC 6, the strdup() function is declared with the "nonnull"
attribute, stating that it is not allowed to pass a NULL value as
parameter.

In nedmalloc()'s reimplementation of strdup(), Postel's Law is heeded
and NULL parameters are handled gracefully. GCC 6 complains about that
now because it thinks that NULL cannot be passed to strdup() anyway.

Because the callers in this project of strdup() must be prepared to
call any implementation of strdup() supplied by the platform, so it
is pointless to pretend that it is OK to call it with NULL.

Remove the conditional based on NULL-ness of the input; this
squelches the warning.

See https://gcc.gnu.org/gcc-6/porting_to.html for details.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/nedmalloc/nedmalloc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index 677d1b2..88cd78c 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -955,12 +955,10 @@ void **nedpindependent_comalloc(nedpool *p, size_t elems, size_t *sizes, void **
  */
 char *strdup(const char *s1)
 {
-	char *s2 = 0;
-	if (s1) {
-		size_t len = strlen(s1) + 1;
-		s2 = malloc(len);
+	size_t len = strlen(s1) + 1;
+	s2 = malloc(len);
+	if (s1)
 		memcpy(s2, s1, len);
-	}
 	return s2;
 }
 #endif
-- 
2.9.2-766-gd7972a8

