Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20142018E
	for <e@80x24.org>; Wed, 24 Aug 2016 18:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933028AbcHXSmZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 14:42:25 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36158 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754808AbcHXSmS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 14:42:18 -0400
Received: by mail-qt0-f193.google.com with SMTP id u25so903930qtb.3
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wZyEz6aPQormjH0PK21a9MsAucovaWiaesKwQ1OX7P8=;
        b=xAnGGuU6HbqByNcT1DLTrRo45XGgZNcaNtyDWjHvUBS8fLy17ydLEdgFss3+SuLNOW
         bsA7q058Z8ut7ShXOFOBKmsALGtbyvl3nNA59dqLyrdXlgrRLW/RRPJDNAKMQzgFP/Io
         cHHMUbAXA2LUEy7OoreVv5i2ZRDU/akm12QXFKUbzZ6cK5TcY0POHkiUWe/rvKGA+iQm
         lHIE1Df46jHL5Ndk2sxUR+5uUjXSJ4LsMs4WJs9LbJO4vkPCoA5TdS+dbhnF4/TAPGCP
         RetjyVMLHHhrvsR9+PpgoBEmqtzrMwP+XeqxlZqO5utVIuYnDHpKk8LbxYsY5nGc2ot2
         R0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wZyEz6aPQormjH0PK21a9MsAucovaWiaesKwQ1OX7P8=;
        b=Hk3BIw9Fz5JQLmu9xeERP+1MCiUDstAWc7MxuiLfiaOMb7vDJEPjcgp5hVuBnYjl0J
         VMcdnGvbUSyZAMPYY3NvwB3hhjgsyaUqN514dlgTwkhfww4kUIfJp3grGE+6fL6RDDYX
         y7LBsmQL/M6ytZJ1O8ykpssNcIYLQXY/bHcim5t7ZE+tzXrCUWsB5+4lL/eeZdKtHZ5U
         zIcVQWEDpCAIAN8WOtJc1KbCflAvFiHGfGn40Li+Zcq+RV8f5kHmjlkCbLEDTnusj2IC
         canDW37thmVzh2nIEuSsFRiUDmLtWK8l0Aqq8TEDeQjYIKL9dScokDMvwA8BLyjq1/EA
         LDXg==
X-Gm-Message-State: AE9vXwMTuuSmrYYHZe57KQn8HYkfk2saWLKI9qAZ0ZwwzOg3+jSjnrnCS5kRilMWnnxrlw==
X-Received: by 10.237.41.225 with SMTP id o88mr5462094qtd.18.1472064131560;
        Wed, 24 Aug 2016 11:42:11 -0700 (PDT)
Received: from christian-Latitude-E6330.event.rightround.com ([75.98.193.200])
        by smtp.gmail.com with ESMTPSA id k20sm5412874qkl.2.2016.08.24.11.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Aug 2016 11:42:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 0/3] limit the size of the packs we receive
Date:   Wed, 24 Aug 2016 20:41:54 +0200
Message-Id: <20160824184157.19264-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc1.3.g93be2b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal
~~~~

In https://public-inbox.org/git/20150612182045.GA23698%40peff.net/,
Peff sent a patch that is used by GitHub to abort `git receive-pack`
when the size of the pack we receive is bigger than a configured
limit.

GitLab is interested in using the same approach and in standardizing
the error messages the user could get back.

Comments
~~~~~~~~

I kept Peff as the author of the patches that are made mostly from his
patch, but I added my Signed-off-by to them.

Changes from previous v2 version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All these changes have been suggested by Junio and are in patch 3/3,
the other 2 patches are the same as v2:

  - renamed "receive.maxsize" to "receive.maxInputSize",
  - improved commit message,
  - renamed test script from "t5546-push-limits.sh" to
    "t5546-receive-limits.sh",
  - improved the tests in the last patch by adding a
    test_pack_input_limit() function and deleting the destination repo
    at the beginning of this function.

Links
~~~~~

This patch series is available here:

https://github.com/chriscool/git/commits/max-receive

The previous versions are here on GitHub:

RFC: https://github.com/chriscool/git/commits/max-receive2
v1: https://github.com/chriscool/git/commits/max-receive6
v2: https://github.com/chriscool/git/commits/max-receive7

and here on the list:

RFC: https://public-inbox.org/git/20160815195729.16826-1-chriscool@tuxfamily.org/
v1: https://public-inbox.org/git/20160816081701.29949-1-chriscool@tuxfamily.org/
v2: https://public-inbox.org/git/20160818131553.22580-1-chriscool@tuxfamily.org/

Peff's initial patch is:

https://public-inbox.org/git/20150612182045.GA23698%40peff.net/

Diff with previous v2 version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f5b6061..8a115b3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2517,10 +2517,11 @@ receive.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
-receive.maxsize::
-	If the size of a pack file is larger than this limit, then
-	git-receive-pack will error out, instead of accepting the pack
-	file. If not set or set to 0, then the size is unlimited.
+receive.maxInputSize::
+	If the size of the incoming pack stream is larger than this
+	limit, then git-receive-pack will error out, instead of
+	accepting the pack file. If not set or set to 0, then the size
+	is unlimited.
 
 receive.denyDeletes::
 	If set to true, git-receive-pack will deny a ref update that deletes
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4b0379b..f1ce05c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -213,7 +213,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (strcmp(var, "receive.maxsize") == 0) {
+	if (strcmp(var, "receive.maxinputsize") == 0) {
 		max_input_size = git_config_int64(var, value);
 		return 0;
 	}
diff --git a/t/t5546-push-limits.sh b/t/t5546-push-limits.sh
deleted file mode 100755
index 09e958f..0000000
--- a/t/t5546-push-limits.sh
+++ /dev/null
@@ -1,42 +0,0 @@
-#!/bin/sh
-
-test_description='check input limits for pushing'
-. ./test-lib.sh
-
-test_expect_success 'create remote repository' '
-	git init --bare dest
-'
-
-# Let's run tests with different unpack limits: 1 and 10
-# When the limit is 1, `git receive-pack` will call `git index-pack`.
-# When the limit is 10, `git receive-pack` will call `git unpack-objects`.
-
-while read unpacklimit filesize filename seed
-do
-
-	test_expect_success "create known-size ($filesize bytes) commit '$filename'" '
-		test-genrandom "$seed" "$filesize" >"$filename" &&
-		git add "$filename" &&
-		test_commit "$filename"
-	'
-
-	test_expect_success "set unpacklimit to $unpacklimit" '
-		git --git-dir=dest config receive.unpacklimit "$unpacklimit"
-	'
-
-	test_expect_success 'setting receive.maxsize to 512 rejects push' '
-		git --git-dir=dest config receive.maxsize 512 &&
-		test_must_fail git push dest HEAD
-	'
-
-	test_expect_success 'bumping limit to 4k allows push' '
-		git --git-dir=dest config receive.maxsize 4k &&
-		git push dest HEAD
-	'
-
-done <<\EOF
-1 1024 one-k-file foo
-10 1024 other-one-k-file bar
-EOF
-
-test_done
diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
new file mode 100755
index 0000000..10cb0be
--- /dev/null
+++ b/t/t5546-receive-limits.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='check receive input limits'
+. ./test-lib.sh
+
+# Let's run tests with different unpack limits: 1 and 10000
+# When the limit is 1, `git receive-pack` will call `git index-pack`.
+# When the limit is 10000, `git receive-pack` will call `git unpack-objects`.
+
+test_pack_input_limit () {
+	case "$1" in
+	index) unpack_limit=1 ;;
+	unpack) unpack_limit=10000 ;;
+	esac
+
+	test_expect_success 'prepare destination repository' '
+		rm -fr dest &&
+		git --bare init dest
+	'
+
+	test_expect_success "set unpacklimit to $unpack_limit" '
+		git --git-dir=dest config receive.unpacklimit "$unpack_limit"
+	'
+
+	test_expect_success 'setting receive.maxInputSize to 512 rejects push' '
+		git --git-dir=dest config receive.maxInputSize 512 &&
+		test_must_fail git push dest HEAD
+	'
+
+	test_expect_success 'bumping limit to 4k allows push' '
+		git --git-dir=dest config receive.maxInputSize 4k &&
+		git push dest HEAD
+	'
+
+	test_expect_success 'prepare destination repository (again)' '
+		rm -fr dest &&
+		git --bare init dest
+	'
+
+	test_expect_success 'lifting the limit allows push' '
+		git --git-dir=dest config receive.maxInputSize 0 &&
+		git push dest HEAD
+	'
+}
+
+test_expect_success "create known-size (1024 bytes) commit" '
+	test-genrandom foo 1024 >one-k &&
+	git add one-k &&
+	test_commit one-k
+'
+
+test_pack_input_limit index
+test_pack_input_limit unpack
+
+test_done
---

Christian Couder (1):
  unpack-objects: add --max-input-size=<size> option

Jeff King (2):
  index-pack: add --max-input-size=<size> option
  receive-pack: allow a maximum input size to be specified

 Documentation/config.txt             |  6 ++++
 Documentation/git-index-pack.txt     |  2 ++
 Documentation/git-receive-pack.txt   |  3 ++
 Documentation/git-unpack-objects.txt |  3 ++
 builtin/index-pack.c                 |  5 ++++
 builtin/receive-pack.c               | 12 ++++++++
 builtin/unpack-objects.c             |  7 +++++
 t/t5546-receive-limits.sh            | 55 ++++++++++++++++++++++++++++++++++++
 8 files changed, 93 insertions(+)
 create mode 100755 t/t5546-receive-limits.sh

-- 
2.10.0.rc1.3.g93be2b9

