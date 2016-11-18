Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156DE1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 23:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbcKRXcB (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 18:32:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55158 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752774AbcKRXcA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 18:32:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5472B4F7D4;
        Fri, 18 Nov 2016 18:31:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fS9wDuK8gBm2rII5xTjbu0UGIbM=; b=lp1VTL
        Hg3g+lSU2YmePNwu85mNN2ZKAAlhagwF+abbP/Dx0KEgGNIHaM2oGveSPrnZa+i1
        jmh+37HVecXZ/Rtt5k4rgKXHaph16LRrAMiJpDPCWOgzRhT01rDDBStQD7UmUspn
        jjaD6m/7RGYFbL6N6IFK3ebg8NPXRnIKkJXZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aExM+miN0bVvpyMULeclWhFEJeSBCxaC
        gJotYA1YzRYgIaLOWvlguSEaAUnztWA1upG6hpj//6uEKe9XBG/MutltTLURdC3I
        rAzH+umE8NP7rCKXxYSJASgFrMBa2f2Zk24h86lxaL8CH0LJByUP3cOrt9zmMqzK
        R0TaKR2g5J0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46A444F7D3;
        Fri, 18 Nov 2016 18:31:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B9B84F7D2;
        Fri, 18 Nov 2016 18:31:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v7 00/17] port branch.c to use ref-filter's printing options
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <xmqqbmxgtqxv.fsf@gitster.mtv.corp.google.com>
        <CAOLa=ZQtmQWpFMPa-SD29N7hASHAPp8SGGJsLu+AW_Kv-1LqwA@mail.gmail.com>
Date:   Fri, 18 Nov 2016 15:31:57 -0800
In-Reply-To: <CAOLa=ZQtmQWpFMPa-SD29N7hASHAPp8SGGJsLu+AW_Kv-1LqwA@mail.gmail.com>
        (Karthik Nayak's message of "Wed, 16 Nov 2016 21:01:35 +0530")
Message-ID: <xmqqd1hsl5zm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33072DA2-ADE7-11E6-B697-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> Thanks, will add it in.

OK, here is a reroll of what I sent earlier in

    http://public-inbox.org/git/<xmqq7f84tqa7.fsf_-_@gitster.mtv.corp.google.com>

but rebased so that it can happen as a preparatory bugfix before
your series.  

The bug dates back to the very original implementation of %(HEAD) in
7a48b83219 ("for-each-ref: introduce %(HEAD) asterisk marker",
2013-11-18) and was moved to the current location in the v2.6 days
at c95b758587 ("ref-filter: move code from 'for-each-ref'",
2015-06-14).

-- >8 --
Subject: [PATCH] for-each-ref: do not segv with %(HEAD) on an unborn branch

The code to flip between "*" and " " prefixes depending on what
branch is checked out used in --format='%(HEAD)' did not consider
that HEAD may resolve to an unborn branch and dereferenced a NULL.

This will become a lot easier to trigger as the codepath will be
used to reimplement "git branch [--list]" in the future.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ref-filter.c            |  2 +-
 t/t6300-for-each-ref.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index bc551a752c..d7e91a78da 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1017,7 +1017,7 @@ static void populate_value(struct ref_array_item *ref)
 
 			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 						  sha1, NULL);
-			if (!strcmp(ref->refname, head))
+			if (head && !strcmp(ref->refname, head))
 				v->s = "*";
 			else
 				v->s = " ";
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 19a2823025..039509a9cb 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -553,4 +553,14 @@ test_expect_success 'Verify sort with multiple keys' '
 		refs/tags/bogo refs/tags/master > actual &&
 	test_cmp expected actual
 '
+
+test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
+	test_when_finished "git checkout master" &&
+	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
+	sed -e "s/^\* /  /" actual >expect &&
+	git checkout --orphan HEAD &&
+	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0-rc2-152-gc9ad1dc38a

