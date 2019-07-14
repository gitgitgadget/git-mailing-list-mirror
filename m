Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1171F461
	for <e@80x24.org>; Sun, 14 Jul 2019 21:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfGNV4t (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 17:56:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52160 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfGNV4t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jul 2019 17:56:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 995231617D5;
        Sun, 14 Jul 2019 17:56:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/WYr7DGkyy6HPLgQrg1Gbq58ow4=; b=lC8Pn9
        Xt2jRg1Bbc+02YhUCVIGsN7m871xiOf2pZ2ncMttfIN6jYi28IyXGPbOeeBp/Vq3
        47Fhzg/Tx3cVJbio97k5ShRb7h4xCOOhpElj1L51/VQGPji93HOJDNIIOsplyC/+
        +uZmXGqYVgOdSNWuVCXmdW4+Pp67HfHmTTtpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LpGny5klQDZfFT8CNX6Zs2Cc6+BToZ/F
        4PcSTy2SzyedT3cAqzFMFLinfMWWc6opdK2x1Q/wgP0qRIiCxIUgMZ0OYYD9uLu/
        VFNzPjJnxXL3OwKJWuoK6xkpbjD3EKm1YKMCft44tOd+jFyxn7hRQfvojyDgKa1p
        PAzF/gMZhJc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9246F1617D4;
        Sun, 14 Jul 2019 17:56:48 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD6D81617D3;
        Sun, 14 Jul 2019 17:56:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tests: defang pager tests by explicitly disabling the log.mailmap warning
References: <20190712230204.16749-1-ariadne@dereferenced.org>
        <20190712230204.16749-4-ariadne@dereferenced.org>
Date:   Sun, 14 Jul 2019 14:56:46 -0700
In-Reply-To: <20190712230204.16749-4-ariadne@dereferenced.org> (Ariadne
        Conill's message of "Fri, 12 Jul 2019 18:02:04 -0500")
Message-ID: <xmqqy31046w1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46FE6CE4-A682-11E9-938D-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ariadne Conill <ariadne@dereferenced.org> writes:

> In the previous patch, we added a deprecation warning for the current
> log.mailmap setting. This warning only appears when git is attached to
> a controlling terminal. Some tests however run under an emulated
> terminal, so we need to disable the warning for those tests.
>
> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
> ---
>  t/t7006-pager.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Hmm, this is horrible.  

These tests are primarily to see how use of color gets affected by
various configuration and the use of the pager, and having to
sprinkle log.mailmap configuration to just randomly selected 10
tests among 50+ tests in the script makes readers wonder if the
configuration has anything to do with the coloring (answer: no).

The primary reason why other 40+ tests do not need log.mailmap
tweaked is not because log.mailmap does not affect the coloring.
But for a new developer who will be adding a new test to this file,
how would s/he decide if the new test needs log.mailmap=false like
these 10, or it is like the other 40+?

It almost makes me feel that it would be much better to just disable
the warning inside the setup part, perhaps like

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 00e09a375c..283de499fc 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -7,6 +7,8 @@ test_description='Test automatic use of a pager.'
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success 'setup' '
+	: squelch advise messages during the transition &&
+	git config --global log.mailmap false &&
 	sane_unset GIT_PAGER GIT_PAGER_IN_USE &&
 	test_unconfig core.pager &&
 
