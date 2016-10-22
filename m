Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB1E20229
	for <e@80x24.org>; Sat, 22 Oct 2016 04:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbcJVEju (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 00:39:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62582 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750842AbcJVEjt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 00:39:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F40B8493DB;
        Sat, 22 Oct 2016 00:39:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+410PHEIIkiCvkvYCtEhfZDBkQM=; b=f+NlM5
        8fyhFolFzuDKr43zksfFzhM3IzhsMVE62nc8/sjbw9sQHj8RvKUsWZxKyvqS39od
        b9gK3jV9Sd2V4gVG7UcyG21RFR/k2GHf8xINZKLSvmxdo+7tNGhCBUGqHpfxunh3
        jSH8sLkaIbmGE/qXjKfwffEejl5u0g1JneXWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MdC7+bWq0swsEDVVDfd+kMS8TCIyyCtG
        kRF4mSFd5cgZQsXDV011RS3BftRByZwb1ZhfN7mSMrpO1sl6E0WCQDd2EUXrDBDY
        yTszws5ApUft5JoSuoiPCcvG3cYEfgkHB3LeDFl/ZH3JDXA85N27DRwdpcGY/6EH
        dREa48DA408=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC37B493DA;
        Sat, 22 Oct 2016 00:39:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6166D493D9;
        Sat, 22 Oct 2016 00:39:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] transport: allow summary-width to be computed dynamically
References: <xmqqa8dxbb9r.fsf@gitster.mtv.corp.google.com>
        <20161021223927.26364-1-gitster@pobox.com>
        <20161021223927.26364-4-gitster@pobox.com>
Date:   Fri, 21 Oct 2016 21:39:45 -0700
In-Reply-To: <20161021223927.26364-4-gitster@pobox.com> (Junio C. Hamano's
        message of "Fri, 21 Oct 2016 15:39:27 -0700")
Message-ID: <xmqqoa2d9eum.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FB375BA-9811-11E6-8E14-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Now we have identified three callchains that have a set of refs that
> they want to show their <old, new> object names in an aligned output,
> we can replace their reference to the constant TRANSPORT_SUMMARY_WIDTH
> with a helper function call to transport_summary_width() that takes
> the set of ref as a parameter.  This step does not yet iterate over
> the refs and compute, which is left as an exercise to the readers.

And this is the final one.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 21 Oct 2016 21:33:06 -0700
Subject: [PATCH] transport: compute summary-width dynamically

Now all that is left to do is to actually iterate over the refs
and measure the display width needed to show their abbreviation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index d4b8bf5f25..f1f95cf7c7 100644
--- a/transport.c
+++ b/transport.c
@@ -429,9 +429,25 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 	return 1;
 }
 
+static int measure_abbrev(const struct object_id *oid, int sofar)
+{
+	char hex[GIT_SHA1_HEXSZ + 1];
+	int w = find_unique_abbrev_r(hex, oid->hash, DEFAULT_ABBREV);
+
+	return (w < sofar) ? sofar : w;
+}
+
 int transport_summary_width(const struct ref *refs)
 {
-	return (2 * FALLBACK_DEFAULT_ABBREV + 3);
+	int maxw;
+
+	for (maxw = -1; refs; refs = refs->next) {
+		maxw = measure_abbrev(&refs->old_oid, maxw);
+		maxw = measure_abbrev(&refs->new_oid, maxw);
+	}
+	if (maxw < 0)
+		maxw = FALLBACK_DEFAULT_ABBREV;
+	return (2 * maxw + 3);
 }
 
 void transport_print_push_status(const char *dest, struct ref *refs,
-- 
2.10.1-723-g2384e83bc3

