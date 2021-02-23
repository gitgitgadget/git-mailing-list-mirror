Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91661C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 472B564E5C
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhBWXWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 18:22:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54881 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhBWXOU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 18:14:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60F0B109BEE;
        Tue, 23 Feb 2021 18:13:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=EC0u57mYQv5BASjPzVg6G1t0QWQ=; b=VfxjECwRddneGirGpBzDn9fIH9C2
        V82CjHdTHCvbSDfdAifTrXVa7+kzveuBrxSzLNiIQ0OPm6Y+oEfNgLqG8MOSF7I8
        p/M+ItBaD49+pwBjeg7o2gKWmOsL4K1YUmfssRpWLHPi1QYfrguYNQ+5T1lDyLDQ
        xb22DZhZGWjJgSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
        btQol40vdf1EOScBrX1fOaeXNYlGqqdVkcHAYBulmZaGRHiihtOboF53ojXBoSvm
        maGFaeD5blN496LYU6j/eBnqfDIHCUWMBWr+hcuLNBGr2ezd8/PGWXblIWd46wre
        9ywArqAFI/aofsFmQIke8KIEkRS/gEDx2tYYKG/gqrM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 593DF109BED;
        Tue, 23 Feb 2021 18:13:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A2088109BEC;
        Tue, 23 Feb 2021 18:13:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] push: do not turn --delete '' into a matching push
cc:     Tilman Vogel <tilman.vogel@web.de>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Date:   Tue, 23 Feb 2021 15:13:32 -0800
Message-ID: <xmqq4ki21ioz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C097D2CC-762C-11EB-834D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we added a syntax sugar "git push remote --delete <ref>" to
"git push" as a synonym to the canonical "git push remote :<ref>"
syntax at f517f1f2 (builtin-push: add --delete as syntactic sugar
for :foo, 2009-12-30), we weren't careful enough to make sure that
<ref> is not empty.

Blindly rewriting "--delete <ref>" to ":<ref>" means that an empty
string <ref> results in refspec ":", which is the syntax to ask for
"matching" push that does not delete anything.

Worse yet, if there were matching refs that can be fast-forwarded,
they would have been published prematurely, even if the user feels
that they are not ready yet to be pushed out, which would be a real
disaster.

Noticed-by: Tilman Vogel <tilman.vogel@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So this time with an obvious test.  It is somewhat surprising
   that this has been left unnoticed for the past 10 years.

 builtin/push.c        | 2 +-
 t/t5516-fetch-push.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 03adb58602..194967ed79 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -115,7 +115,7 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
 			else
 				refspec_appendf(&rs, "refs/tags/%s", ref);
 		} else if (deleterefs) {
-			if (strchr(ref, ':'))
+			if (strchr(ref, ':') || !*ref)
 				die(_("--delete only accepts plain target ref names"));
 			refspec_appendf(&rs, ":%s", ref);
 		} else if (!strchr(ref, ':')) {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 3ed121d0ce..7eee4e782f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -824,6 +824,11 @@ test_expect_success 'push --delete refuses src:dest refspecs' '
 	test_must_fail git push testrepo --delete master:foo
 '
 
+test_expect_success 'push --delete refuses empty string' '
+	mk_test testrepo heads/master &&
+	test_must_fail git push testrepo --delete ""
+'
+
 test_expect_success 'warn on push to HEAD of non-bare repository' '
 	mk_test testrepo heads/master &&
 	(
-- 
2.30.1-824-gddfeb442a8


