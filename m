Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42EAC203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112AbcGYWLw (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:11:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752878AbcGYWLT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 18:11:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2E843032F;
	Mon, 25 Jul 2016 18:11:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Epa0xKcXkr/ZIt+3wKrvyZb/Y0=; b=d5OfGf
	iv/2Z6TXMNfcRUNGi4h6GcKEWxk4PAKtxlqp8+ZdxAfoYDjcO5x9A5foCKHQapsk
	yN/qGo2zPFvbaDSm1bh4SmZr+ah63GhbIGjjLa47Xc6qNIiL1Yp0a34pmcRc9sRJ
	7GJO2kuJ3pvNwqCNgJZb+KTwi4nMC8YYV4UE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o18nlEXKNF28JOS7+NP7UUyj/YNdVU7p
	J2RAQzyyRte8NlrX6WU/tsJ/SkrHOIc8+2egooesDYI0wVkizP+hXcQU/kuQDCJW
	ZtghFiWYWd60IHg264grfLazlZr8syIlEC95H1UkclicowUQkHRXWg87YKbiIoY1
	20Y0iqGDwEk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABC2E3032E;
	Mon, 25 Jul 2016 18:11:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 321523032C;
	Mon, 25 Jul 2016 18:11:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	John Keeping <john@keeping.me.uk>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] push: allow pushing new branches with --force-with-lease
References: <6b401124e734d4f5486003459e586cc05c7843e8.1469287889.git.john@keeping.me.uk>
	<xmqq4m7d7hlq.fsf@gitster.mtv.corp.google.com>
Date:	Mon, 25 Jul 2016 15:11:14 -0700
In-Reply-To: <xmqq4m7d7hlq.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 25 Jul 2016 10:28:01 -0700")
Message-ID: <xmqq37mx4bct.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B563302C-52B4-11E6-9E70-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I suspect that the if/else cascade in the loop in apply_cas() can
> also be taught that ':' followed by an empty string asks to check
> that the target ref does not exist, in order to make it a bit more
> useful for folks who do not rely on the "use the last observed
> status of the tracking branch".
>
> That would make the "explicit" test much less cumbersome to read.

In other words, something like this, perhaps?

 remote.c            |  2 ++
 t/t5533-push-cas.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/remote.c b/remote.c
index b35ffd9..55812d8 100644
--- a/remote.c
+++ b/remote.c
@@ -2303,6 +2303,8 @@ int parse_push_cas_option(struct push_cas_option *cas, const char *arg, int unse
 	entry = add_cas_entry(cas, arg, colon - arg);
 	if (!*colon)
 		entry->use_tracking = 1;
+	else if (!colon[1])
+		hashclr(entry->expect);
 	else if (get_sha1(colon + 1, entry->expect))
 		return error("cannot parse expected object name '%s'", colon + 1);
 	return 0;
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 4276b1b..04f4636 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -215,6 +215,18 @@ test_expect_success 'new branch covered by force-with-lease (explicit)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'new branch covered by force-with-lease (less cumbersome)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		git branch another master &&
+		git push --force-with-lease=another: origin another
+	) &&
+	git ls-remote dst refs/heads/another >expect &&
+	git ls-remote src refs/heads/another >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'new branch already exists' '
 	setup_srcdst_basic &&
 	(
-- 
2.9.2-629-gdd92683

