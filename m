Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9514EC433FE
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 13:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378563AbiAaNa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 08:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbiAaNa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 08:30:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ECCC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 05:30:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c23so25438027wrb.5
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 05:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYNssGwgBPI/XgQH9YnGjO+JHSsExvfZ/0tMwYGpFX0=;
        b=KIXJZhQbZlnInRG3D0ATRDPctAmzA1e5I6nrBWwZr4AAy1hIcoKGd0rZ6+6R7Vl3ag
         6UoloqJCzamZiBVEMltdKNcm+QpvijAh54mb3RTv6dabo3NRda6LTvV7Qq3AtYbgoCR+
         00bwlOmeV+zv1RjtcWz2nPUgFV6y1HZfrkMxlmXcKw1sJ28zpzeU9i+UjBCc+EtAqLcN
         q0oZ7FCw2Q4TGgFFMtG5o0e28uRSn3Dnf7no+lAQobz5vvxT++apGsMzPu+FDggH146Z
         s02G0MpNaiUnrM94erOH+0bDTYrNeJ/nM3eHMIUGCERw6paM/snqiBv3k4XylwsJ/tr+
         nyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYNssGwgBPI/XgQH9YnGjO+JHSsExvfZ/0tMwYGpFX0=;
        b=JRNJTCPdVYRBwtI5xdZJ1nTj7ldij8THjWyOpOtbctgHpRc3z3Ez2hU1s/3BC9Uql8
         yP4cUTteq9Qbnh2OMPOokf+78NmEcnNncSFeYPpTcDBBcaHneCAtUGTIkYfMF/r71iH3
         qpw/G+RTgUr1kgaZEH6285NFWC7+fzJ6wr00jwL71ffqdYvJF0vLSQqSA6ZwlwIXurIk
         VdfOkQzbGq7XblIX4iJsM1gHkhhR65zhmRbs1iAqPFRpTzL1mfldRu8peDT6q1qFQcnG
         BoKgNjtCbgCm8bQiQFxAQkia2czAMBPWPD5ixBsEj+UkqrdOOXNdHW4VclfTS2D93lVd
         kEWA==
X-Gm-Message-State: AOAM532jjc8Pm6loV93fIpJKh+Ouw1qIwsIu2PutKReBH+PxVvdkC7in
        a70IQ2HkMjziwwf0GyphJq6r5BuYaBI=
X-Google-Smtp-Source: ABdhPJxlYleCOELCA+uq8BYYw0QVU1QRmY8C1S2AxqziAo1zsUs3yoHDc5jbbZTCbkh8sdrKosPdDw==
X-Received: by 2002:adf:f045:: with SMTP id t5mr17225311wro.387.1643635854944;
        Mon, 31 Jan 2022 05:30:54 -0800 (PST)
Received: from localhost ([77.75.179.5])
        by smtp.gmail.com with ESMTPSA id 11sm13954824wrb.30.2022.01.31.05.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 05:30:54 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2] fetch --prune: exit with error if pruning fails
Date:   Mon, 31 Jan 2022 13:30:47 +0000
Message-Id: <20220131133047.1885074-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.35.0.4.g4ff653b4ff.dirty
In-Reply-To: <20220127153714.1190894-1-t.gummerer@gmail.com>
References: <20220127153714.1190894-1-t.gummerer@gmail.com>
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

changes in v2:
- retcode will now always be 1 if we get an error from prune_refs,
  no matter what the original error code was.
- we will now continue the fetch, and only exit with a non-zero
  exit code after having finished the rest of the fetch operation
- added a comment in the test explaining why creating a packed-refs.new
  file will make the fetch --prune fail.

 builtin/fetch.c  | 10 ++++++----
 t/t5510-fetch.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06b21f8e..648f0694f2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1609,12 +1609,14 @@ static int do_fetch(struct transport *transport,
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
 		}
+		if (retcode != 0)
+			retcode = 1;
 	}
 	if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
 		free_refs(ref_map);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 20f7110ec1..ef0da0a63b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -164,6 +164,17 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
 	git rev-parse sometag
 '
 
+test_expect_success REFFILES 'fetch --prune fails to delete branches' '
+	cd "$D" &&
+	git clone . prune-fail &&
+	cd prune-fail &&
+	git update-ref refs/remotes/origin/extrabranch main &&
+	: this will prevent --prune from locking packed-refs for deleting refs, but adding loose refs still succeeds  &&
+	>.git/packed-refs.new &&
+
+	test_must_fail git fetch --prune origin
+'
+
 test_expect_success 'fetch --atomic works with a single branch' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
 
-- 
2.31.1

