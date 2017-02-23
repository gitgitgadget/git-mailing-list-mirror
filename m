Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C03B42022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdBWXFE (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:05:04 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34186 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdBWXFD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:05:03 -0500
Received: by mail-pg0-f47.google.com with SMTP id 1so2305198pgi.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gh9KnnWkXTk5gAYH3Ad4z+xQUIObfJnKEBk4Xxg8wE4=;
        b=oydnMT4OsST9QPBKA+iVl5SfUB2E6vz8633GMbaabPcPsUC6R91Sa92Y0xg9aEerwK
         d+DML6OhU3YyYHF+rmTES9ResSdvHN2NBKAV1z+M+GfzIPVZk8hoHBpIhHLaiQ4WJl9/
         a9e1Zud5LsVoAXxTBZollxt63hHeAyvKK8yUefJ78P8HVEvNxItHL9P5OtMm+pmZwcZi
         7zDP2lp5+5QHgyXnGbwXXmq8iqo16p2qJfUK7eATRlI27YwJ2dU8qQeP1gLmH3+tLOgB
         Zy4HZv+KuCdpf1NeLRXWjQGp0U/iE/fMpVaOwcQFuTJMrjkbiAZaGtl0+O0Q4cSPiJCy
         ez0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gh9KnnWkXTk5gAYH3Ad4z+xQUIObfJnKEBk4Xxg8wE4=;
        b=JosfHVvteV+Ybj16qlZtZioutsCbG4Ps8DGNNBdMb8b5Q116rrv48DkOEOmB6EO9nA
         XKx1aNRIQy48aNXfgSxbmva3DbqMASiV2BKeZUFH9ETgnD7eWppzdcfR037Ir+28mDAt
         YOwjlVzbgd/rUNTI33hUF3ao2yrA9+LLf1C8SQk/UK2kqfJqHUINwY8gV4tJEvhjrjTS
         159457j5FfEoME1saxBQs5Xj5r949icV1J/S8zgVEixYrjCKI2iGm4t0rCYTRwhyE1Ey
         ag/FCeXqcEmS/pazAnyOtitDXA9bqttOmMN8qHCHCKkQ3/T7LFU6JSW1GkmKA/mYXcV0
         s6eA==
X-Gm-Message-State: AMke39lfXm8+1cfmith53NeHjVrFXFqA9nIF/QLT2SP7HP69k5nuvBTrgOivDceESXCDoJeR
X-Received: by 10.98.133.202 with SMTP id m71mr49492003pfk.102.1487890674047;
        Thu, 23 Feb 2017 14:57:54 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id p14sm11596716pfl.75.2017.02.23.14.57.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:57:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
Subject: [PATCH 02/15] lib-submodule-update.sh: do not use ./. as submodule remote
Date:   Thu, 23 Feb 2017 14:57:22 -0800
Message-Id: <20170223225735.10994-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170223225735.10994-1-sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding the repository itself as a submodule does not make sense in the
real world. In our test suite we used to do that out of convenience in
some tests as the current repository has easiest access for setting up
'just a submodule'.

However this doesn't quite test the real world, so let's do not follow
this pattern any further and actually create an independent repository
that we can use as a submodule.

When using './.' as the remote the superproject and submodule share the
same objects, such that testing if a given sha1 is a valid commit works
in either repository.  As running commands in an unpopulated submodule
fall back to the superproject, this happens in `reset_work_tree_to`
to determine if we need to populate the submodule. Fix this bug by
checking in the actual remote now.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 5df528ea81..c0d6325133 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -37,6 +37,17 @@
 #
 
 create_lib_submodule_repo () {
+	git init submodule_update_sub1 &&
+	(
+		cd submodule_update_sub1 &&
+		echo "expect" >>.gitignore &&
+		echo "actual" >>.gitignore &&
+		echo "x" >file1 &&
+		echo "y" >file2 &&
+		git add .gitignore file1 file2 &&
+		git commit -m "Base inside first submodule" &&
+		git branch "no_submodule"
+	) &&
 	git init submodule_update_repo &&
 	(
 		cd submodule_update_repo &&
@@ -49,7 +60,7 @@ create_lib_submodule_repo () {
 		git branch "no_submodule" &&
 
 		git checkout -b "add_sub1" &&
-		git submodule add ./. sub1 &&
+		git submodule add ../submodule_update_sub1 sub1 &&
 		git config -f .gitmodules submodule.sub1.ignore all &&
 		git config submodule.sub1.ignore all &&
 		git add .gitmodules &&
@@ -162,7 +173,7 @@ reset_work_tree_to () {
 		test_must_be_empty actual &&
 		sha1=$(git rev-parse --revs-only HEAD:sub1) &&
 		if test -n "$sha1" &&
-		   test $(cd "sub1" && git rev-parse --verify "$sha1^{commit}")
+		   test $(cd "../submodule_update_sub1" && git rev-parse --verify "$sha1^{commit}")
 		then
 			git submodule update --init --recursive "sub1"
 		fi
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

