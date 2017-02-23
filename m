Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED59C2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbdBWXEE (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:04:04 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33989 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdBWXED (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:04:03 -0500
Received: by mail-pg0-f43.google.com with SMTP id 1so2294928pgi.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7+HkgYbVEURBuvkFlIM1NRo4raEaueIpZi375UgrJUY=;
        b=m2OHHLKG2Z/5f4KVEVddGIuku43XksKh50QjualGxxIyhOfhom5Dtq6gXQC8Z2ykaT
         B6OTaUYWoQjKiD0dhJdDo8xZOUeY7qdh/I/Rf73EZFHHU3z6QzZZGK+mUolD7Vu75OHb
         phSNGuHwGUWs4/OpcfRXdy2lL5viTf0zJvxQlunpyIAiUDbZHeg9JufQ6LkECv1KFPm6
         VD8QanufnqXcU8g833z7o3QjiH8pnbkv8W0n5JSrOoFsDEMuGflJxMiiU2s27+AEjLk6
         9TUhc+q2wmd1Sc9f8LsIdgCKlzRCk6xJLBPFQmcyuA+3ZMqGsX4RIJ5uwoit6f0xAIw6
         sszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7+HkgYbVEURBuvkFlIM1NRo4raEaueIpZi375UgrJUY=;
        b=nkatzmIVbHtiSFgVOwyn6dXDlyZK33/gqsSvIIb9aKhCxSBH486XCG4l/LZaONFFSn
         BSIbb1zDwTtlJ42BzfW9Gn0PnpYaPDyZVU5xi9ve4F5uHc2waU8FDEaFdfv1M3Y8kQfk
         YtkjMQrrurLdMHm+gLUXzh6Ss73wmeyQOSkL6leM9/XoXRKKpoT/F8QQSp0L8ETFWQ13
         VjRQiMzvS/x2C4F8OWeiaqD1djp1+IiF76Z6sLkJyXFAD1Ej0e02Wz2gpwvYdYZdXqFn
         Q3+wouOLGHw3y9+/HBljZmQbPRZOFjE0oOejHZhgnpd2O3geIh19rLGajfB8slHHKEVO
         DuIw==
X-Gm-Message-State: AMke39nGJXO5u4u9fbpdNKB3PtZdXO7dtEDNPIhChR/wPos9AouEJ785J48hoF9+cGXxVH3O
X-Received: by 10.99.103.133 with SMTP id b127mr50871464pgc.168.1487891042695;
        Thu, 23 Feb 2017 15:04:02 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id g28sm11698787pgn.3.2017.02.23.15.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:04:01 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        peartben@gmail.com, benpeart@microsoft.com
Subject: [BUG] allowtipsha1inwant serves unreachable blobs if you know its hash
Date:   Thu, 23 Feb 2017 15:03:58 -0800
Message-Id: <20170223230358.30050-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a server sets allowtipsha1inwant (or allowreachablesha1inwant), a
client can call "git fetch <server> <SHA-1>" where SHA-1 is the hash of
a blob (reachable or unreachable) to obtain it. The test below (which
passes) demonstrates that.

I have bisected this, and this bug occurs at least as early as the
introduction of allowreachablesha1inwant in commit 68ee628
("upload-pack: optionally allow fetching reachable sha1", 2015-05-21).
It may have occurred earlier, though - initially, I thought that this
was due to allowreachablesha1inwant, so I did not investigate
allowtipsha1inwant until later.

I found this out while investigating the feasibility of using the
existing fetch-pack/upload-pack protocol to support fetching of
arbitrary blobs.

This happens most likely because the "rev-list" call in
"do_reachable_revlist" (called through "has_unreachable") is invoked
without the "--objects" argument. "has_unreachable" determines that an
object is unreachable if nothing is printed to stdout, which normally
works, except that "rev-list" prints nothing when asked which commits
are reachable from a blob (which makes sense).

Adding "--objects" works, and all existing tests pass, except for the
potential performance issue and the side effect that even fetching a
reachable blob no longer works. This is due to a possible bug where a
call like "git rev-list --objects $tree ^master" (where $tree is the
tree object corresponding to master) prints out objects even though all
objects reachable from the tree are also reachable from master. (There
should be no issue with "get_reachable_list", the other invoker of
"do_reachable_revlist", because non-commits in the command's stdout are
skipped.)

The other option, of course, is to whitelist object types (that is, only
allow commits and tags - I haven't checked if this is sufficient,
though). This might be a sufficient temporary fix, although I expect
that we would still have to revisit this later (especially if we decide
that we want to allow downloading blobs through this interface).

I don't mind taking a look at either solution, but thought of putting
this out first in case people have any opinion or insight into this
problem and its possible solutions.

(CC-ing some people who might have an interest in downloading arbitrary
blobs.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t9999-mytests.sh | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 t/t9999-mytests.sh

diff --git a/t/t9999-mytests.sh b/t/t9999-mytests.sh
new file mode 100644
index 000000000..e71cfbf48
--- /dev/null
+++ b/t/t9999-mytests.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='my tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'setup' '
+	server="$HTTPD_DOCUMENT_ROOT_PATH/blobs" &&
+	git init "$server" &&
+	(
+		cd "$server" &&
+		test_commit myfile
+	) &&
+
+	# A reachable blob.
+	reachable=$(
+		git -C "$server" cat-file -p \
+		$(git -C "$server" cat-file -p HEAD | grep "^tree " | cut -c6-) | \
+		grep myfile | cut -c13-52) &&
+	test -n "$reachable" &&
+
+	# 2 unreachable blobs. Only one will be fetched. (2 are included here
+	# to demonstrate that there is no whole-repo copying or anything like
+	# that.)
+	unreachable=$(echo abc123 | git -C "$server" hash-object -w --stdin) &&
+	test -n "$unreachable" &&
+	another_unreachable=$(echo def456 | git -C "$server" hash-object -w --stdin) &&
+	test -n "$another_unreachable" &&
+
+	git init --bare client.git &&
+	git -C client.git remote add origin "$HTTPD_URL/smart/blobs" &&
+
+	# These fetches are supposed to fail (and do)
+	test_must_fail git -C client.git fetch origin $reachable &&
+	test_must_fail git -C client.git fetch origin $unreachable
+'
+
+test_expect_success 'allowtipsha1inwant suddenly allows blobs' '
+	test -n "$reachable" &&
+
+	git -C "$server" config uploadpack.allowtipsha1inwant 1 &&
+
+	# This fetch passes
+	git -C client.git fetch origin $reachable &&
+	test "myfile" = $(git -C client.git cat-file -p $reachable)
+'
+
+test_expect_success 'even unreachable ones' '
+	test -n "$unreachable" &&
+
+	# This fetch is supposed to fail (for multiple reasons), but passes.
+	# Only the wanted blob is fetched.
+	git -C client.git fetch origin $unreachable &&
+	git -C client.git cat-file -e $unreachable &&
+	test_must_fail git -C client.git cat-file -e $another_unreachable &&
+	test "abc123" = $(git -C client.git cat-file -p $unreachable)
+'
+
+stop_httpd
+test_done
-- 
2.11.0.483.g087da7b7c-goog

