Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8E420A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 22:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbeLLWcp (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 17:32:45 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38655 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLWco (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 17:32:44 -0500
Received: by mail-qk1-f196.google.com with SMTP id d19so28178qkg.5
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 14:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ycOQExb3U1Uq5H/4SWGMM2lCztQe8TGXUknBXPTp7YY=;
        b=nDJDfpNO8Wnvw70LBlU0kcVE344jppjTQe07YO6gjhseEC4qJqBeCHTE9FVJq5SEc8
         qqYRVCjxsDWTfM6Ep7Gmg27KSnXsD+u6zHJQY0uHSPE6PkRFIcHd0kib3C9LBlvlLr9c
         LUXn162MhOIp6/apzx6nPehxFdad1gUwH3ObyhG1cmN6RaV6/HDYrTrOPfylSikL42If
         MHgDEqY9xIso1K60muJ9cKCiOkvECwzkxUOQzwGh4NOeQLW8Bgc7lQU/GDCHQsFU4eBR
         D7JOe2tTlMNqPcRqm11nnd3gIOpi+968N+AG/UZyworF3kWLH7aB9qvQtURSLnbnKw2o
         2qBw==
X-Gm-Message-State: AA+aEWZIv63RGDKQy9DmSLjG+1TZmNRp3J15l85izRZstQYAX6eLlKWp
        aXtlwHDCnuFyg3L9IrJMdbBmDibScyw=
X-Google-Smtp-Source: AFSGD/Xd0I78QGS1a+yqJaSIW44TuNHAvxj6WAI+7Yvqv+fHQE6Y8YZ2Ko6LG4vjAYkInYY0eorZbA==
X-Received: by 2002:a37:4cd7:: with SMTP id z206mr20690019qka.233.1544653963751;
        Wed, 12 Dec 2018 14:32:43 -0800 (PST)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id r67sm65862qkr.28.2018.12.12.14.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:32:43 -0800 (PST)
From:   Laura Abbott <labbott@redhat.com>
To:     git@vger.kernel.org
Cc:     Laura Abbott <labbott@redhat.com>
Subject: [PATCH] git-quiltimport: Add --keep-non-patch option
Date:   Wed, 12 Dec 2018 14:32:27 -0800
Message-Id: <20181212223227.4024-1-labbott@redhat.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-am has the --keep-non-patch option to pass -b to
git-mailinfo for keeping subject prefixes intact. Allow
this option to be used with quiltimport as well.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 Documentation/git-quiltimport.txt | 5 ++++-
 git-quiltimport.sh                | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index 8cf952b4d..70562dc4c 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git quiltimport' [--dry-run | -n] [--author <author>] [--patches <dir>]
-		[--series <file>]
+		[--series <file>] [--keep-non-patch]
 
 
 DESCRIPTION
@@ -56,6 +56,9 @@ The default for the series file is <patches>/series
 or the value of the `$QUILT_SERIES` environment
 variable.
 
+--keep-non-patch::
+	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 6d3a88dec..e3d390974 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -8,6 +8,7 @@ n,dry-run     dry run
 author=       author name and email address for patches without any
 patches=      path to the quilt patches
 series=       path to the quilt series file
+keep-non-patch Pass -b to git mailinfo
 "
 SUBDIRECTORY_ON=Yes
 . git-sh-setup
@@ -32,6 +33,9 @@ do
 		shift
 		QUILT_SERIES="$1"
 		;;
+	--keep-non-patch)
+		MAILINFO_OPT="-b"
+		;;
 	--)
 		shift
 		break;;
@@ -98,7 +102,7 @@ do
 		continue
 	fi
 	echo $patch_name
-	git mailinfo "$tmp_msg" "$tmp_patch" \
+	git mailinfo $MAILINFO_OPT "$tmp_msg" "$tmp_patch" \
 		<"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
 	test -s "$tmp_patch" || {
 		echo "Patch is empty.  Was it split wrong?"
-- 
2.19.1

