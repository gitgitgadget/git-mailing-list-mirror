Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0DF21F461
	for <e@80x24.org>; Wed, 17 Jul 2019 20:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfGQUin (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 16:38:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61199 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfGQUin (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 16:38:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 799006BB11;
        Wed, 17 Jul 2019 16:38:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Ru7k+JEqtwen75RmRyWbRQBISU=; b=BoFtwQ
        FGabPiX9f6tM6SLGCbLh8R39MmpAwoTFc1LKgbVifPWwIm1llZ8rI3kqYlAEcnxm
        S80l1acWMRBb151pkzWcV0zE7hZon//QVrdOP4c0XrHhOHvPlxRiRUcRCd332nfR
        mxuabUlv/iAQPKClkCwK44wbma4HTWl/OEdJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pGYAteRUJbSonCRBJWu0Ce4750zbryFV
        Ur3gAEiWBSnAUppgJVRtKlJ10xJccqlj4+t/0Za/jXYCUvmR6oYsoA1GFejYpGek
        FcKqzikSBvtWE8VZ3HPJWEsil75NboRGVGrM6pEXCO8nVVq2DGLbgI6Gl4IqIEr4
        WFb6bOdiaA0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 713B26BB10;
        Wed, 17 Jul 2019 16:38:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5432F6BB0B;
        Wed, 17 Jul 2019 16:38:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <git@vger.kernel.org>
Cc:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: [PATCH] rm: resolving by removal is not a warning-worthy event
References: <5D2ED50D020000A100032435@gwsmtp.uni-regensburg.de>
        <xmqqd0i81ui4.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 17 Jul 2019 13:38:35 -0700
In-Reply-To: <xmqqd0i81ui4.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 17 Jul 2019 09:44:03 -0700")
Message-ID: <xmqqims0z99w.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA7ACEF2-A8D2-11E9-846F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When resolving a conflict on a path in favor of removing it, using
"git rm" on it is the standard way to do so.  The user however is
greeted with a "needs merge" message during that operation:

	$ git merge side-branch
	$ edit conflicted-path-1
	$ git add conflicted-path-1
	$ git rm conflicted-path-2
	conflicted-path-2: needs merge
	rm 'conflicted-path-2'

The removal by "git rm" does get performed, but an uninitiated user
may find it confusing, "needs merge? so I need to resolve conflict
before being able to remove it???"

The message is coming from "update-index --refresh" that is called
internally to make sure "git rm" knows which paths are clean and
which paths are dirty, in order to prevent removal of paths modified
relative to the index without the "-f" option.  We somehow ended up
not squelching this message which seeped through to the UI surface.

Use the same mechanism used by "git commit", "git describe", etc. to
squelch the message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rm.c  |  2 +-
 t/t3600-rm.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 65b448ef8e..b63c86ae92 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -272,7 +272,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv);
-	refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
+	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &pathspec, NULL, NULL);
 
 	seen = xcalloc(pathspec.nr, 1);
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b8fbdefcdc..5aae78ccc4 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -251,6 +251,19 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 	test_path_is_missing .git/index.lock
 '
 
+test_expect_success 'Resolving by removal is not a warning-worthy event' '
+	git reset -q --hard &&
+	test_when_finished "rm -f .git/index.lock msg && git reset -q --hard" &&
+	qfwfq=$(echo qfwfq | git hash-object -w --stdin) &&
+	for stage in 1 2 3
+	do
+		echo "100644 $qfwfq $stage	qfwfq"
+	done | git update-index --index-info &&
+	git rm qfwfq >msg &&
+	test_i18ngrep ! "needs merge" msg &&
+	test_must_fail git ls-files -s --error-unmatch qfwfq
+'
+
 test_expect_success 'rm removes subdirectories recursively' '
 	mkdir -p dir/subdir/subsubdir &&
 	echo content >dir/subdir/subsubdir/file &&
-- 
2.22.0-653-g37fc7794bc

