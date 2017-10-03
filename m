Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F0E20281
	for <e@80x24.org>; Tue,  3 Oct 2017 04:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750838AbdJCEHp (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 00:07:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63348 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750797AbdJCEHn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 00:07:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2348B5215;
        Tue,  3 Oct 2017 00:07:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=faAi
        ok4f1SxWioQgMv+XeDaHZVk=; b=CbtkLSAtKvKyMEcflJwPlneKCbDbiPW4D4M7
        L21xsAHEka86ZzwRjc9vnUu3rb0yRmXnwte3qL+G9ALbaQ0/bM67DFj0c5RPERqS
        5KZw2FK4Gpdbp4H6TjRKzTMCF28k+unX7UQajs8DR3nf/FWYqXxpkxM9mdLOI0BI
        iytYbuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        YpGANSlMBkFjqXVuXRgDqvtMV5/Km/WabgwKGAgRpSfEZlJ2CDs8Spi3gEtTYYYo
        ZZb9xUzQu0okSoVxFpcBeIG8Z1sJHMmIh3dXAMUbWK59JwCbqLN+6qJWTDiIjxUm
        vD3pHH8xIFJYyILtr/YfURf06prJ7p/xqiIn02dmlGg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9B33B5214;
        Tue,  3 Oct 2017 00:07:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 323FBB5213;
        Tue,  3 Oct 2017 00:07:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/2] colors: git_default_config() does not read color.ui
Date:   Tue,  3 Oct 2017 13:07:37 +0900
Message-Id: <20171003040737.2336-3-gitster@pobox.com>
X-Mailer: git-send-email 2.14.2-882-gfe33df219d
In-Reply-To: <20171003040737.2336-1-gitster@pobox.com>
References: <20171002230017.GT19555@aiede.mtv.corp.google.com>
 <20171003040737.2336-1-gitster@pobox.com>
X-Pobox-Relay-ID: 671F8D74-A7F0-11E7-B499-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we reverted 136c8c8b ("color: check color.ui in
git_default_config()", 2017-07-13), these need to be added back to
the codebase so that "git tag --list" and "git for-each-ref" would
still pay attention to color.ui setting.

A real fix to the problem introduced by 4c7f1819 ("make color.ui
default to 'auto'", 2013-06-10) must be found, to allow users to
override the default "auto" use of colors for any color-capable
plumbing commands, but let's leave that to a later round.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/for-each-ref.c | 3 ++-
 builtin/tag.c          | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 5d7c921a77..238eb00e09 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "parse-options.h"
 #include "ref-filter.h"
+#include "color.h"
 
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
@@ -54,7 +55,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	format.format = "%(objectname) %(objecttype)\t%(refname)";
 
-	git_config(git_default_config, NULL);
+	git_config(git_color_default_config, NULL);
 
 	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
 	if (maxcount < 0) {
diff --git a/builtin/tag.c b/builtin/tag.c
index 66e35b823b..46c3e78b55 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -158,7 +158,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "tag", &colopts);
-	return git_default_config(var, value, cb);
+	return git_color_default_config(var, value, cb);
 }
 
 static void write_tag_body(int fd, const struct object_id *oid)
-- 
2.14.2-882-gfe33df219d

