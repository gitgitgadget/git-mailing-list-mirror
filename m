Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD7D207EC
	for <e@80x24.org>; Sat,  1 Oct 2016 00:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbcJAATs (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 20:19:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53050 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752596AbcJAATq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 20:19:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 287E543AC1;
        Fri, 30 Sep 2016 20:19:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=IgF5
        exdcuoY1jKjfsQGAxI3uwLs=; b=P5wXcvKimHdxd86MCZ+Lq/dw+jDSlgoZEw+8
        4lhVzQ9mU6cwPOsoSibyOMesxW8sX+U7Mju9OGJvTGWTS/QZNf/36p5JR4RY7a6T
        CGbV/p0RFES+hSv98lb6Xe46W11mZj0Xu+Cl3d6VsB9S2242v4e403T5+UexTCFX
        KFVW2Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=QXIFTm
        j8nNqZLd6xnFotAZBJ60HntV3et4neuEHZRhmPeRaHLuhpJvLln/EJot0a758Irg
        zP6DQHuCSS2FqicaSIJ8XRSEJ7tMFXN7PcfpxiY38Aavk2vvVKv+0jaJlgUdv+zU
        jwMtnQJln1uZg4LbBcbgI5IEUx3z10qBcQ3gU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2012A43AC0;
        Fri, 30 Sep 2016 20:19:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C1F143ABD;
        Fri, 30 Sep 2016 20:19:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] abbrev: prepare for new world order
Date:   Fri, 30 Sep 2016 17:19:36 -0700
Message-Id: <20161001001937.10884-3-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-622-g05f606bbb0
In-Reply-To: <20161001001937.10884-1-gitster@pobox.com>
References: <20161001001937.10884-1-gitster@pobox.com>
X-Pobox-Relay-ID: C10DE3F8-876C-11E6-A087-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code that sets custom abbreviation length, in response to
command line argument, often does something like this:

	if (skip_prefix(arg, "--abbrev=", &arg))
		abbrev = atoi(arg);
	else if (!strcmp("--abbrev", &arg))
		abbrev = DEFAULT_ABBREV;
	/* make the value sane */
	if (abbrev < 0 || 40 < abbrev)
		abbrev = ... some sane value ...

However, it is pointless to sanity-check and tweak the value
obtained from DEFAULT_ABBREV.  We are going to allow it to be
initially set to -1 to signal that the default abbreviation length
must be auto sized upon the first request to abbreviate, based on
the number of objects in the repository, and when that happens,
rejecting or tweaking a negative value to a "saner" one will
negatively interfere with the auto sizing.  The codepaths for

    git rev-parse --short <object>
    git diff --raw --abbrev

do exactly that; allow them to pass possibly negative abbrevs
intact, that will come from DEFAULT_ABBREV in the future.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rev-parse.c | 5 +++--
 diff.c              | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 76cf05e2ad..17cbfabdde 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -643,8 +643,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				filter &= ~(DO_FLAGS|DO_NOREV);
 				verify = 1;
 				abbrev = DEFAULT_ABBREV;
-				if (arg[7] == '=')
-					abbrev = strtoul(arg + 8, NULL, 10);
+				if (!arg[7])
+					continue;
+				abbrev = strtoul(arg + 8, NULL, 10);
 				if (abbrev < MINIMUM_ABBREV)
 					abbrev = MINIMUM_ABBREV;
 				else if (40 <= abbrev)
diff --git a/diff.c b/diff.c
index c6da383c56..cefc13eb8e 100644
--- a/diff.c
+++ b/diff.c
@@ -3399,7 +3399,7 @@ void diff_setup_done(struct diff_options *options)
 			 */
 			read_cache();
 	}
-	if (options->abbrev <= 0 || 40 < options->abbrev)
+	if (40 < options->abbrev)
 		options->abbrev = 40; /* full */
 
 	/*
-- 
2.10.0-622-g05f606bbb0

