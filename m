Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52A41F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 02:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436939AbfJXC3k (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 22:29:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50230 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406400AbfJXC3k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 22:29:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E59861CDC6;
        Wed, 23 Oct 2019 22:29:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ERkDbm39ZY62a/FR/AIxi2i4dtM=; b=Z7rQnC
        hlnxZ080AKsaPL8S/Gynfb0LT827IkpGKZAiuYfX4y5p1YvCX3CThRxo7HqRBCv6
        XC+m+lbcu4nawLz/9eQVTm0HYnb8sUDtqRfLanQRpA9Oi71pmrckpere4ZLUk1Yr
        YyAjZ9YZz0JeBLUI5x1Iyts/LJtw05SQtQsrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=voq9zEpXxFrWoVjxGMzfykPCWoLj8nW4
        AtsQSNvhjSnPXz/eZTRaMRocsAedT/DzSNfZsJR6oUInQ+O6pGvS1HVvnE6HRKGs
        cfQuD6dh7iV7Hw0DfdsBdrLXLnNVOTDdUOUGvC7NJVU4uIxNj3ahduHm+HLjnSyR
        /8YFY6k7LTM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC5DF1CDC4;
        Wed, 23 Oct 2019 22:29:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BFDA1CDC3;
        Wed, 23 Oct 2019 22:29:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Prarit Bhargava <prarit@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH] pretty: Add "%aU"|"%au" option to output author's username
References: <20191022232847.5212-1-prarit@redhat.com>
        <20191022234822.f4ixqcpfytimiscn@camp.crustytoothpaste.net>
Date:   Thu, 24 Oct 2019 11:29:36 +0900
In-Reply-To: <20191022234822.f4ixqcpfytimiscn@camp.crustytoothpaste.net>
        (brian m. carlson's message of "Tue, 22 Oct 2019 23:48:44 +0000")
Message-ID: <xmqqa79qho4v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FAEE0DC-F606-11E9-B881-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> +	if (part == 'u' || part == 'U') {	/* username */
>> +		maillen = strstr(s.mail_begin, "@") - s.mail_begin;
>> +		strbuf_add(sb, mail, maillen);
>> +		return placeholder_len;
>> +	}
>
> This branch doesn't appear to do anything different for the mailmap and
> non-mailmap cases.  Perhaps adding an additional test that demonstrates
> the difference would be a good idea.

Yes, and the bug that would be exposed is the lack of call to
mailmap.

Perhaps along this line (I may have off-by-one or two tho)?

 pretty.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index e4ed14effe..4b76d022c6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -696,15 +696,27 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	mail = s.mail_begin;
 	maillen = s.mail_end - s.mail_begin;
 
-	if (part == 'N' || part == 'E') /* mailmap lookup */
+	if (part == 'N' || part == 'E' || part == 'L') /* mailmap lookup */
 		mailmap_name(&mail, &maillen, &name, &namelen);
-	if (part == 'n' || part == 'N') {	/* name */
+
+	switch (part) {
+	case 'n': case 'N':
 		strbuf_add(sb, name, namelen);
 		return placeholder_len;
-	}
-	if (part == 'e' || part == 'E') {	/* email */
+	case 'l': case 'L':
+		{
+			const char *at = memchr(mail, '@', maillen);
+			if (at) {
+				maillen -= at - mail + 1;
+				mail = at + 1;
+			}
+		}
+		/* fall through */
+	case 'e': case 'E': 
 		strbuf_add(sb, mail, maillen);
 		return placeholder_len;
+	default:
+		break;
 	}
 
 	if (!s.date_begin)
