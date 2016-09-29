Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB869207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934312AbcI2VAn (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:00:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50119 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934302AbcI2VAl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:00:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCD48429F7;
        Thu, 29 Sep 2016 17:00:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=d8ZI
        GNnF23TO/nBNS7yhT4CZEZI=; b=OGb2fB4XooTRv0KxqWW5qrJZb1cwDMACksia
        VjADPpNzeGBGMVMVMgiuB3A84FT+ft9MmBS+YXfjerResiJRVDkTd78HXitpeyJ3
        dYZc5rVhJzuMVgIFJWBeHp+cK0AYO5k+pphLoKHF22Sy8sgtjQoew6wUmltMlzAU
        LoaS8mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=w04/Ei
        MQKvAH5sKoondN2q0+MZPdA+7Ilk4pKv3m2wVxDiJJM51zisPwT68Tvy4WqqNOh4
        w+hmk/2n9bThjTLCGXfXK+OjXwRTiC9OqAljihgGfg30I4JgxDlTrCqDobGhU694
        FZyzL+xYu6gTrIRbCD42F1NH7ZYjfHV6NmvbU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF10D429F6;
        Thu, 29 Sep 2016 17:00:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30C1D429F5;
        Thu, 29 Sep 2016 17:00:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 9/9] core.abbrev: raise the default abbreviation to 12 hexdigits
Date:   Thu, 29 Sep 2016 14:00:14 -0700
Message-Id: <20160929210014.3874-10-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-589-g5adf4e1
In-Reply-To: <20160929210014.3874-1-gitster@pobox.com>
References: <20160929210014.3874-1-gitster@pobox.com>
X-Pobox-Relay-ID: C69B019C-8687-11E6-8C11-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Peff said, responding in a thread started by Linus's suggestion
to raise the default abbreviation to 12 hexdigits:

    I actually think "12" might be sane for a long time. That's 48
    bits of sha1, so we'd expect a 50% chance of a single collision
    at 2^24, or 16 million.  The biggest repository I know about (in
    number of objects) is the one holding all of the objects for all
    of the forks of torvalds/linux on GitHub. It's at about 15
    million objects.

    Which seems close, but remember that's the size where we expect
    to see a single collision. They don't become common until much
    later (I didn't compute an exact number, but Linus's 16x sounds
    about right). I know that the growth of the kernel isn't really
    linear, but I think the need to bump to "13" might not just be
    decades, but possibly a century or more.

    So 12 seems reasonable, and the only downside for it (or for "13", for
    that matter) is a few extra bytes. I dunno, maybe people will really
    hate that, but I have a feeling these are mostly cut-and-pasted anyway.

And this does exactly that.

Keep the tests working by explicitly asking for the old 7 hexdigits
setting in the fake system-wide configuration file used for tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 environment.c        | 2 +-
 t/gitconfig-for-test | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index ca72464a9850..25daddbc13d6 100644
--- a/environment.c
+++ b/environment.c
@@ -16,7 +16,7 @@ int trust_executable_bit = 1;
 int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
-int minimum_abbrev = 4, default_abbrev = 7;
+int minimum_abbrev = 4, default_abbrev = 12;
 int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
diff --git a/t/gitconfig-for-test b/t/gitconfig-for-test
index 4598885ed5c3..8c284425d725 100644
--- a/t/gitconfig-for-test
+++ b/t/gitconfig-for-test
@@ -4,3 +4,6 @@
 ;; [user]
 ;;	name = A U Thor
 ;;	email = author@example.com
+
+[core]
+	abbrev = 7
-- 
2.10.0-589-g5adf4e1

