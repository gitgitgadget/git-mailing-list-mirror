Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DA591F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 23:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755021AbcI1XeK (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 19:34:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60101 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754354AbcI1XbA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 19:31:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA90F41C02;
        Wed, 28 Sep 2016 19:30:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=+qg2
        ew79uvALiwWpOcawT1Sy+YQ=; b=XOawy2VQrrY1J0ojzWax23CcE+j45DdRvC/e
        gGeBZ6PrZFubSKXW7CJtTNLI8nZ8hhjeLltC6+39deBA+aXfmbVfbmU/ZeI8lWJu
        +zcEFhIpc+CaR5hyLPZ4lxPhz/qStG3qqN4I16Mg+pM4fRJZ9Qqah7UK+cnh2L8a
        VNWAt0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        vtHAqkFqqKRfftPCM4lQvxiIsfXYjG0USC6Wtp9wjp11/g/P+uVLZShSPTphqbX5
        UgGkD45XJOh2GcLNBNuVT/jyWdmg9XA9/K9MiDqazwyK7C8dkIkh2MSErLL7d1M4
        d/TQUwJGSYx0CtsOgvlGlifajTFBNo37MOCEPbCGFEw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B21B541C01;
        Wed, 28 Sep 2016 19:30:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E5CE41BFF;
        Wed, 28 Sep 2016 19:30:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, torvalds@linux-foundation.org
Subject: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
Date:   Wed, 28 Sep 2016 16:30:47 -0700
Message-Id: <20160928233047.14313-5-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-584-gc9e068c
In-Reply-To: <20160928233047.14313-1-gitster@pobox.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
X-Pobox-Relay-ID: 9C86C102-85D3-11E6-B17B-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Peff said, responding in a thread started by Linus's suggestion
to raise the default abbreviation to 12 hexdigits:

    I actually think "12" might be sane for a long time. That's 48 bits of
    sha1, so we'd expect a 50% change of a _single_ collision at 2^24, or 16
    million.  The biggest repository I know about (in number of objects) is
    the one holding all of the objects for all of the forks of
    torvalds/linux on GitHub. It's at about 15 million objects.

    Which _seems_ close, but remember that's the size where we expect to see
    a single collision. They don't become common until much later (I didn't
    compute an exact number, but Linus's 16x sounds about right). I know
    that the growth of the kernel isn't really linear, but I think the need
    to bump to "13" might not just be decades, but possibly a century or
    more.

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
index ca72464..25daddb 100644
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
index 4598885..8c28442 100644
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
2.10.0-584-gc9e068c

