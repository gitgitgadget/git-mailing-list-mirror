Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76FBD1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 22:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758591AbcJQWRU (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 18:17:20 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33722 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758713AbcJQWQa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 18:16:30 -0400
Received: by mail-pa0-f50.google.com with SMTP id vu5so65433951pab.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEPESgWG9m6kay61XaCZSHzLebV5VKI6FpvthTI33Ds=;
        b=dZHdvsAEQ7MDz6aXnQ6pL6f9FG/Ahuyh5gbCcBtBjPUO865VtBGbZ8U2TEoX/Z2aZr
         jnPmABIRPcWTRd9+i1IqGWSYegLcc+ZwJ98kqS7ecjNx2qaBJv2CwyPW9aCs8VbreXu2
         33qAq2T7amN4ZY2QTLkrDjpDsKJMtpbHMrQI63sKjkIhwf58hJ2AQXfrbeKB1plVUpF5
         28rpIoIrY4fu4eAN+TkvpR+cn6/ZoLi+N7c65OiQxUxOoA5d6SD1+yPctwSkxRAeRMt0
         byMA+GpYXZg7tKdvqxO62ZtINbIgpygI3GEt2Jnr16OBR+W+q6W0qd2HeW9Xiw2xk5YT
         5dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEPESgWG9m6kay61XaCZSHzLebV5VKI6FpvthTI33Ds=;
        b=gg1e/adid2UNiXBaxonAyDilEgKH2FD6PK3s9va+kRV3OgmndCKAidkc1szE5an0hA
         jM3xZ5RciQDrSY3K69PHoSnI9WwYEyopv3+xm+VSi5tSaPQ1AHqemQnROAEk1ZuBPQnM
         kGDqUzShuDO4y2VpLDyjk9bPzga/bTWR66VF83tFn7LQm+usbFceSZfXh4VVtQbi9Qfr
         BPUBcBO1c3G8eepoNXS285YBF99Q2Ltl0M4Ui7M8a+gWsUhNJIIjoLM6bRLIiQVG2AFI
         3GGFVheB59t+zgKCFc6GnhB3oAgmq18ZqUTwjYU20bOdm3SQHo6zUHrzNy238wo0MG1N
         ffAA==
X-Gm-Message-State: AA6/9RnXxy2rgrcyN4uqguhAzGXdPMATT0DwkjZncR/TGR0jcmGS9Lg235oADrIO0WBa1HTn
X-Received: by 10.66.21.162 with SMTP id w2mr33682911pae.160.1476742588912;
        Mon, 17 Oct 2016 15:16:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c108:d919:372b:e4cb])
        by smtp.gmail.com with ESMTPSA id g67sm7906914pfd.82.2016.10.17.15.16.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Oct 2016 15:16:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, j6t@kdbg.org, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, venv21@gmail.com, dennis@kaarsemaker.net,
        jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule--helper: normalize funny urls
Date:   Mon, 17 Oct 2016 15:16:23 -0700
Message-Id: <20161017221623.7299-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.480.g573bd76
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently a URL for the superproject ending in

(A)    .../path/to/dir
(B)    .../path/to/dir/
(C)    .../path/to/dir/.
(D)    .../path/to/dir/./.
(E)    .../path/to/dir/.///.//.

is treated the same in (A) and (B), but (C, D, E) are different.

We never produce the URLs in (C,D,E) ourselves, they come to use, because
the user used it as the URL for cloning a superproject.
Normalize these paths.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 By being strict in Git, I think we also fix the Git for Windows painpoints.
 
 This goes on top of origin/sb/submodule-ignore-trailing-slash.
 
 Thanks,
 Stefan

 builtin/submodule--helper.c | 49 ++++++++++++++++++++++++++++++++++-----------
 t/t0060-path-utils.sh       | 11 ++++++----
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 260f46f..ca90763 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -76,6 +76,30 @@ static int chop_last_dir(char **remoteurl, int is_relative)
 	return 0;
 }
 
+static void strip_url_ending(char *url, size_t *_len)
+{
+	int check_url_stripping = 1;
+	size_t len = _len ? *_len : strlen(url);
+
+	while (check_url_stripping) {
+		check_url_stripping = 0;
+		if (is_dir_sep(url[len-2]) && url[len-1] == '.') {
+			url[len-2] = '\0';
+			len -= 2;
+			check_url_stripping = 1;
+		}
+
+		if (is_dir_sep(url[len-1])) {
+			url[len-1] = '\0';
+			len --;
+			check_url_stripping = 1;
+		}
+	}
+
+	if (_len)
+		*_len = len;
+}
+
 /*
  * The `url` argument is the URL that navigates to the submodule origin
  * repo. When relative, this URL is relative to the superproject origin
@@ -93,14 +117,16 @@ static int chop_last_dir(char **remoteurl, int is_relative)
  * the superproject working tree otherwise.
  *
  * NEEDSWORK: This works incorrectly on the domain and protocol part.
- * remote_url      url              outcome          expectation
- * http://a.com/b  ../c             http://a.com/c   as is
- * http://a.com/b/ ../c             http://a.com/c   same as previous line, but
- *                                                   ignore trailing slash in url
- * http://a.com/b  ../../c          http://c         error out
- * http://a.com/b  ../../../c       http:/c          error out
- * http://a.com/b  ../../../../c    http:c           error out
- * http://a.com/b  ../../../../../c    .:c           error out
+ * remote_url       url              outcome          expectation
+ * http://a.com/b   ../c             http://a.com/c   as is
+ * http://a.com/b/  ../c             http://a.com/c   same as previous line, but
+ *                                                    ignore trailing '/' in url
+ * http://a.com/b/. ../c             http://a.com/c   same as previous line, but
+ *                                                    ignore trailing '/.' in url
+ * http://a.com/b   ../../c          http://c         error out
+ * http://a.com/b   ../../../c       http:/c          error out
+ * http://a.com/b   ../../../../c    http:c           error out
+ * http://a.com/b   ../../../../../c    .:c           error out
  * NEEDSWORK: Given how chop_last_dir() works, this function is broken
  * when a local part has a colon in its path component, too.
  */
@@ -115,8 +141,7 @@ static char *relative_url(const char *remote_url,
 	struct strbuf sb = STRBUF_INIT;
 	size_t len = strlen(remoteurl);
 
-	if (is_dir_sep(remoteurl[len-1]))
-		remoteurl[len-1] = '\0';
+	strip_url_ending(remoteurl, &len);
 
 	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
 		is_relative = 0;
@@ -149,10 +174,10 @@ static char *relative_url(const char *remote_url,
 	}
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
-	if (ends_with(url, "/"))
-		strbuf_setlen(&sb, sb.len - 1);
 	free(remoteurl);
 
+	strip_url_ending(sb.buf, &sb.len);
+
 	if (starts_with_dot_slash(sb.buf))
 		out = xstrdup(sb.buf + 2);
 	else
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 25b48e5..e154e5f 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -329,14 +329,17 @@ test_submodule_relative_url "(null)" "./foo" "../submodule" "submodule"
 test_submodule_relative_url "(null)" "//somewhere else/repo" "../subrepo" "//somewhere else/subrepo"
 test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
 test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
-test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
-test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)/."
+test_submodule_relative_url "(null)" "$PWD/sub/." "../." "$(pwd)"
+test_submodule_relative_url "(null)" "$PWD/sub/./." "../." "$(pwd)"
+test_submodule_relative_url "(null)" "$PWD/sub/.////././/./." "../." "$(pwd)"
+test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)"
 test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd)/repo"
 test_submodule_relative_url "(null)" "$PWD" "./å äö" "$(pwd)/å äö"
-test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$(pwd)/submodule"
+test_submodule_relative_url "(null)" "$PWD/sub" "../submodule" "$(pwd)/submodule"
+test_submodule_relative_url "(null)" "$PWD/sub/." "../submodule" "$(pwd)/submodule"
 test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule" "$(pwd)/submodule"
 test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle1" "$(pwd)/home2/../bundle1"
-test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./." "$(pwd)/submodule_update_repo/."
+test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./." "$(pwd)/submodule_update_repo"
 test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo" "file:///tmp/subrepo"
 test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/submodule"
 test_submodule_relative_url "(null)" "foo" "../submodule" "submodule"
-- 
2.10.1.480.g573bd76

