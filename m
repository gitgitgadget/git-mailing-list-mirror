Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCDF61FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 08:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbcHPIRj (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 04:17:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35754 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbcHPIRh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 04:17:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so15053297wmg.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 01:17:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=P+EejKwFuzA2G1obh7OL2N5eVl0BwPLGJUgQCeccbbc=;
        b=khyeBP+ERTQ2Q4hYJEsjC/cHYoj1aafeC8zZU0DmzbUMcqrvLoVeHUzsyk09pfT9jX
         MFGyXhGMzcwh/MvonnaoKmOgOlVvtx1Rt5f0oukPLYOyJW7fR47Oby0lOVFWHlKOWxF2
         8/qFwr5Py3XZXsiA2tklhUaWYi3Tb0mgW7M3OEXLO9B/Sa9fcs9dYm7exqtYtmncdocN
         4yJElStdngSjtHkfPzCTDNQyma62YQuXRie8R7Utc7B1HXxoVJ9kkpkgk7B44zEZwyp/
         e3Nj6Lg05WAmDEDtxj2h/cBLG0QjyqUYEZiG2ODB0os1C52MY30Ft497HEUvDkXzHKbn
         Yl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P+EejKwFuzA2G1obh7OL2N5eVl0BwPLGJUgQCeccbbc=;
        b=Sw9oLgcBFh4nGE79KuLr0kDsBNF8jDu9J32JzHNERwKbGWJrHgS77QDSJN58gv6flt
         HGbWAE8QpCzDnazKxV9d/Fct8A1gFhDeeZAQzoSD1r8bjMxYrnwDZY+cBIDorrB3xGdZ
         +fZjt6hKeQ5T+j61nPma5fq20B1mskab0je+eL0WHsmdcBgmAmySD+4BmT0y7rrGIh1z
         5Zam2o9b7WGBzerF2JYWjKWmOsNmRZok2gGNhAFNR1oCTBFESndE/qZ96gZ4Pn+qLC33
         +4hLxcS+mooVHtKsSDrUhIQyvjQXRb1lHKiWYXRZ7tz0/7IaljW1qWSuJ+nfhvNuciD+
         EGbA==
X-Gm-Message-State: AEkooutQigHpjzFEIsBp9+sxzvU6uWRbCx2d3SlZtx9LAGWbsiP17IK3LfxBT6zr3dB5uw==
X-Received: by 10.28.164.130 with SMTP id n124mr5147748wme.105.1471335455580;
        Tue, 16 Aug 2016 01:17:35 -0700 (PDT)
Received: from localhost.localdomain ([80.215.5.33])
        by smtp.gmail.com with ESMTPSA id 142sm20461121wmh.12.2016.08.16.01.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Aug 2016 01:17:34 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/3] limit the size of the packs we receive
Date:	Tue, 16 Aug 2016 10:16:58 +0200
Message-Id: <20160816081701.29949-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc0.3.g8535b4c
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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

Changes from previous RFC version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - added documentation to all the 3 patches,

  - changed strtoul() to strtoumax() in the first 2 patches, as
    suggested by Peff,

  - changed git_config_ulong() to git_config_int64() and used PRIuMAX
    and uintmax_t in the last patch, as suggested by Peff,

  - reorganized the tests in the last patch, as suggested by Peff

  - improved commit message of the last patch with information from
    Peff

Links
~~~~~

This patch series is available here:

https://github.com/chriscool/git/commits/max-receive

The previous RFC version is here on GitHub:

https://github.com/chriscool/git/commits/max-receive2

and here on the list:

https://public-inbox.org/git/20160815195729.16826-1-chriscool@tuxfamily.org/

Peff's initial patch is:

https://public-inbox.org/git/20150612182045.GA23698%40peff.net/

Diff with previous RFC version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcb679..f5b6061 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2517,6 +2517,11 @@ receive.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+receive.maxsize::
+	If the size of a pack file is larger than this limit, then
+	git-receive-pack will error out, instead of accepting the pack
+	file. If not set or set to 0, then the size is unlimited.
+
 receive.denyDeletes::
 	If set to true, git-receive-pack will deny a ref update that deletes
 	the ref. Use this to prevent such a ref deletion via a push.
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 7a4e055..1b4b65d 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -87,6 +87,8 @@ OPTIONS
 	Specifying 0 will cause Git to auto-detect the number of CPU's
 	and use maximum 3 threads.
 
+--max-input-size=<size>::
+	Die, if the pack is larger than <size>.
 
 Note
 ----
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 000ee8d..0ccd5fb 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -33,6 +33,9 @@ post-update hooks found in the Documentation/howto directory.
 option, which tells it if updates to a ref should be denied if they
 are not fast-forwards.
 
+A number of other receive.* config options are available to tweak
+its behavior, see linkgit:git-config[1].
+
 OPTIONS
 -------
 <directory>::
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 3e887d1..b3de50d 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -44,6 +44,9 @@ OPTIONS
 --strict::
 	Don't write objects with broken content or links.
 
+--max-input-size=<size>::
+	Die, if the pack is larger than <size>.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1fd60bd..4a8b4ae 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1718,7 +1718,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				if (*c || opts.off32_limit & 0x80000000)
 					die(_("bad %s"), arg);
 			} else if (skip_prefix(arg, "--max-input-size=", &arg)) {
-				max_input_size = strtoul(arg, NULL, 10);
+				max_input_size = strtoumax(arg, NULL, 10);
 			} else
 				usage(index_pack_usage);
 			continue;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7627f7f..8c2943d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -214,7 +214,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	}
 
 	if (strcmp(var, "receive.maxsize") == 0) {
-		max_input_size = git_config_ulong(var, value);
+		max_input_size = git_config_int64(var, value);
 		return 0;
 	}
 
@@ -1657,8 +1657,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 			argv_array_pushf(&child.args, "--strict%s",
 				fsck_msg_types.buf);
 		if (max_input_size)
-			argv_array_pushf(&child.args, "--max-input-size=%lu",
-				max_input_size);
+			argv_array_pushf(&child.args, "--max-input-size=%"PRIuMAX,
+				(uintmax_t)max_input_size);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1688,8 +1688,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (!reject_thin)
 			argv_array_push(&child.args, "--fix-thin");
 		if (max_input_size)
-			argv_array_pushf(&child.args, "--max-input-size=%lu",
-				max_input_size);
+			argv_array_pushf(&child.args, "--max-input-size=%"PRIuMAX,
+				(uintmax_t)max_input_size);
 		child.out = -1;
 		child.err = err_fd;
 		child.git_cmd = 1;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 59b1f39..4532aa0 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -554,7 +554,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (skip_prefix(arg, "--max-input-size=", &arg)) {
-				max_input_size = strtoul(arg, NULL, 10);
+				max_input_size = strtoumax(arg, NULL, 10);
 				continue;
 			}
 			usage(unpack_usage);
diff --git a/t/t5546-push-limits.sh b/t/t5546-push-limits.sh
index d3a4d1a..b38d508 100755
--- a/t/t5546-push-limits.sh
+++ b/t/t5546-push-limits.sh
@@ -3,45 +3,40 @@
 test_description='check input limits for pushing'
 . ./test-lib.sh
 
-test_expect_success 'create known-size commit' '
-	test-genrandom foo 1024 >file &&
-	git add file &&
-	test_commit one-k
-'
-
 test_expect_success 'create remote repository' '
-	git init --bare dest &&
-	git --git-dir=dest config receive.unpacklimit 1
+	git init --bare dest
 '
 
-test_expect_success 'receive.maxsize rejects push' '
-	git --git-dir=dest config receive.maxsize 512 &&
-	test_must_fail git push dest HEAD
-'
+# Let's run tests with different unpack limits: 1 and 10
+# When the limit is 1, `git receive-pack` will call `git index-pack`.
+# When the limit is 10, `git receive-pack` will call `git unpack-objects`.
 
-test_expect_success 'bumping limit allows push' '
-	git --git-dir=dest config receive.maxsize 4k &&
-	git push dest HEAD
-'
+while read unpacklimit filesize filename
+do
 
-test_expect_success 'create another known-size commit' '
-	test-genrandom bar 2048 >file2 &&
-	git add file2 &&
-	test_commit two-k
-'
+	test_expect_success "create known-size ($filesize bytes) commit '$filename'" '
+		test-genrandom foo "$filesize" >"$filename" &&
+		git add "$filename" &&
+		test_commit "$filename"
+	'
 
-test_expect_success 'change unpacklimit' '
-	git --git-dir=dest config receive.unpacklimit 10
-'
+	test_expect_success "set unpacklimit to $unpacklimit" '
+		git --git-dir=dest config receive.unpacklimit "$unpacklimit"
+	'
 
-test_expect_success 'receive.maxsize rejects push' '
-	git --git-dir=dest config receive.maxsize 512 &&
-	test_must_fail git push dest HEAD
-'
+	test_expect_success 'setting receive.maxsize to 512 rejects push' '
+		git --git-dir=dest config receive.maxsize 512 &&
+		test_must_fail git push dest HEAD
+	'
 
-test_expect_success 'bumping limit allows push' '
-	git --git-dir=dest config receive.maxsize 4k &&
-	git push dest HEAD
-'
+	test_expect_success 'bumping limit to 4k allows push' '
+		git --git-dir=dest config receive.maxsize 4k &&
+		git push dest HEAD
+	'
+
+done <<\EOF
+1 1024 one-k-file
+10 2048 two-k-file
+EOF
 
 test_done


Christian Couder (1):
  unpack-objects: add --max-input-size=<size> option

Jeff King (2):
  index-pack: add --max-input-size=<size> option
  receive-pack: allow a maximum input size to be specified

 Documentation/config.txt             |  5 +++++
 Documentation/git-index-pack.txt     |  2 ++
 Documentation/git-receive-pack.txt   |  3 +++
 Documentation/git-unpack-objects.txt |  3 +++
 builtin/index-pack.c                 |  5 +++++
 builtin/receive-pack.c               | 12 +++++++++++
 builtin/unpack-objects.c             |  7 ++++++
 t/t5546-push-limits.sh               | 42 ++++++++++++++++++++++++++++++++++++
 8 files changed, 79 insertions(+)
 create mode 100755 t/t5546-push-limits.sh

-- 
2.10.0.rc0.3.g8535b4c

