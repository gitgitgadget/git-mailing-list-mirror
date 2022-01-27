Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9922CC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 15:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbiA0PhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 10:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiA0PhU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 10:37:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10561C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:37:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a13so5480879wrh.9
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZulHkrV+VcHGGL0YADbUZOtQHQgcNHvVOCZmYrkI3kE=;
        b=nSWJmWpd6QmZ3uyZDOLWEi1jc4v/9b+vBScRABdmvD5qlRCsRK6Nc5N+qiZKn6fiE6
         yFW8KMaOY2bhAF1O90gOmxh7fgeXG7Lel8YY/oNEGs3yCIaamXm3qHcZI/8PYcNAHZRl
         VT5eamHKJGjMFqhBrQgkDMW/DEVCGUjjkWarhsGGHQXy8ECmnU8IkQszZhzW25cXaFXY
         3Lxi+sanACD/mHQ1bftLDH+dUZl14JQQscLlIOmk9MgFZzippscT2UzwXOrTXuos3hU/
         wVD/MUyzW1O587SrQMnmcTO93C/QvWl9QIcm3Y7bWArOr3Ch3XH+KOynvKLUI82YmZRm
         347g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZulHkrV+VcHGGL0YADbUZOtQHQgcNHvVOCZmYrkI3kE=;
        b=HORIYDxah+bbmI/AEOPRVJBFz9vXv6XIPDUr4XyunXMoVkoOJOWG2Uz+UcMtEJ2Non
         VjXBQh25F7En6PrqWiibvRMyBmjmNOWd0cpyAt1rZltZkVD/zlUq3HYK0vkVz3RluFhd
         TxMeHxrkkIDWi3HxrtDki3Z7GMV3eohE1KdQBqpp0bPkwwFtv8W27X1dDLLLa5n0tfs7
         r87SxKD8HyrSLOWEyqzNwS1iD4mx7xdti+RXVVDJzLjF77ZdUdHJIhhYZ9aJAk0+Qx/2
         wEDm5JAyB/VY9+9I8l0idgls1Na/CnVVAX9vcw7+9bH6B5TGnOGinRAujPVuGXrWfSA0
         7Sng==
X-Gm-Message-State: AOAM533FQQyG4afhTW4Zl8teahLKK5pxv9IK9A+9BO2pTlQGYf0ei0wY
        9jyRIwPHPu0YvKff6CNxDL7G7OrZ9hk=
X-Google-Smtp-Source: ABdhPJy1/LpzAMysH+U2q/OAtrocVg6zd9h7cthFcSLXLpd8vUmxGuO+UYPVPjhDRcjqbzy20zSbyg==
X-Received: by 2002:a5d:604a:: with SMTP id j10mr3396799wrt.547.1643297838465;
        Thu, 27 Jan 2022 07:37:18 -0800 (PST)
Received: from localhost ([77.75.179.5])
        by smtp.gmail.com with ESMTPSA id t14sm4781198wmq.43.2022.01.27.07.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 07:37:17 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] fetch --prune: exit with error if pruning fails
Date:   Thu, 27 Jan 2022 15:37:14 +0000
Message-Id: <20220127153714.1190894-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.35.0.4.g4ff653b4ff
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pruning refs fails, we currently print an error to stderr, but
still exit 0 from 'git fetch'.  Since this is a genuine error fetch
should be exiting with some non-zero exit code.  Make it so.

The --prune option was introduced in f360d844de ("builtin-fetch: add
--prune option", 2009-11-10).  Unfortunately it's unclear from that
commit whether ignoring the exit code was an oversight or
intentional, but it feels like an oversight.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/fetch.c  | 12 ++++++++----
 t/t5510-fetch.sh | 10 ++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06b21f8e..54545efedd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1609,11 +1609,15 @@ static int do_fetch(struct transport *transport,
 		 * don't care whether --tags was specified.
 		 */
 		if (rs->nr) {
-			prune_refs(rs, ref_map, transport->url);
+			retcode = prune_refs(rs, ref_map, transport->url);
 		} else {
-			prune_refs(&transport->remote->fetch,
-				   ref_map,
-				   transport->url);
+			retcode = prune_refs(&transport->remote->fetch,
+					     ref_map,
+					     transport->url);
+		}
+		if (retcode) {
+			free_refs(ref_map);
+			goto cleanup;
 		}
 	}
 	if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 20f7110ec1..df824cc3d0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -164,6 +164,16 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
 	git rev-parse sometag
 '
 
+test_expect_success REFFILES 'fetch --prune fails to delete branches' '
+	cd "$D" &&
+	git clone . prune-fail &&
+	cd prune-fail &&
+	git update-ref refs/remotes/origin/extrabranch main &&
+	>.git/packed-refs.new &&
+
+	test_must_fail git fetch --prune origin
+'
+
 test_expect_success 'fetch --atomic works with a single branch' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
 
-- 
2.31.1

