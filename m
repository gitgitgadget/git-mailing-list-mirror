Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32BE420989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbcJJR5S (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:57:18 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35767 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbcJJR5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:57:17 -0400
Received: by mail-pa0-f50.google.com with SMTP id qn10so54591500pac.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QJEM5yhcCZ/9zQtBYAFfFfpWdn8bylBF9I7hFQubGEw=;
        b=RAAKKhmxs1bJ5r3RAGqMRe33AzMcNsG5awawYjgE9c33fd6zXip+i9nzmh+XX2DfgO
         c6Qx3ZnQ9I7bXSulRHETQOEt3jNy4mKaxxOlMMkenYOa1APqKdnjVOupfoG9uQGuV52u
         RnSxWHaED2ZmPw9bDhXuk1bTpHcwwHNwD4H3IRvEvEQx3QJPQCCdg39afME7sWdRSwl9
         lrP6AbjzA11cn7Cm8PURTaOeubLuxAjtC1u1fklnp9QvgercAYHNScqRBu4byuLFLKhn
         CZvzvpVmfnBroIchWiUaYbrPVRzd40iBgoElBDX+0lrphC6SfYk6lDKuEEBnL9xoOX3y
         ErbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QJEM5yhcCZ/9zQtBYAFfFfpWdn8bylBF9I7hFQubGEw=;
        b=JwfZkGInJ7gQ8LCmYEZZKs/b+aQ6d44OpuuWZ3GskZ0L5tHA9s7mrrEJB6ssOaBL3K
         wR9SN7EXXBpEKAvmG213/121ACC2sH/ZhOvQykXDCm4wnGYHeTUfV4Ii5e5ShStvOLTf
         gnUHY1ZggelJ7+5Bk2k/REhTjM7kM/oVkk0gVRop4EOYqPdCFydOLiuVE8qQClVANUl0
         O3mzihg+y8vG4xduTB+Fp2rVfR/Y/UkRBZKxm3M/RSnwNSDlJEg2NJgrA9j0gduLW0F9
         Pz7RIv7sNvllqaN/0UA75OC1g8zqWTqGNXKKHz1mf4dcjUljmRvIpon/jYHlbIbPwhzu
         MGAA==
X-Gm-Message-State: AA6/9RnhQEY0lixDiJoEq/syaaQa5pXVAL7bku+PQPqMgM00CPNgTS3A64Rh8nRa5Y8jnG61
X-Received: by 10.66.10.102 with SMTP id h6mr57916809pab.112.1476122177160;
        Mon, 10 Oct 2016 10:56:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id tj8sm58318094pab.16.2016.10.10.10.56.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 10:56:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, venv21@gmail.com, dennis@kaarsemaker.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] submodule: ignore trailing slash on superproject URL
Date:   Mon, 10 Oct 2016 10:56:10 -0700
Message-Id: <20161010175611.1058-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before 63e95beb0 (2016-04-15, submodule: port resolve_relative_url from
shell to C), it did not matter if the superprojects URL had a trailing
slash or not. It was just chopped off as one of the first steps
(The "remoteurl=${remoteurl%/}" near the beginning of
resolve_relative_url(), which was removed in said commit).

When porting this to the C version, an off-by-one error was introduced
and we did not check the actual last character to be a slash, but the
NULL delimiter.

Reintroduce the behavior from before 63e95beb0, to ignore the trailing
slash.

Reported-by: <venv21@gmail.com>
Helped-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 6 ++++--
 t/t0060-path-utils.sh       | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 444ec06..a7841a5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -95,6 +95,8 @@ static int chop_last_dir(char **remoteurl, int is_relative)
  * NEEDSWORK: This works incorrectly on the domain and protocol part.
  * remote_url      url              outcome          expectation
  * http://a.com/b  ../c             http://a.com/c   as is
+ * http://a.com/b/ ../c             http://a.com/c   same as previous line, but
+ *                                                   ignore trailing slash in url
  * http://a.com/b  ../../c          http://c         error out
  * http://a.com/b  ../../../c       http:/c          error out
  * http://a.com/b  ../../../../c    http:c           error out
@@ -113,8 +115,8 @@ static char *relative_url(const char *remote_url,
 	struct strbuf sb = STRBUF_INIT;
 	size_t len = strlen(remoteurl);
 
-	if (is_dir_sep(remoteurl[len]))
-		remoteurl[len] = '\0';
+	if (is_dir_sep(remoteurl[len-1]))
+		remoteurl[len-1] = '\0';
 
 	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
 		is_relative = 0;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index bf2deee..82b98f8 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -319,6 +319,7 @@ test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/submodule"
 test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
 
 test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../foo/sub/a/b/c"
+test_submodule_relative_url "(null)" "../foo/bar/" "../sub/a/b/c" "../foo/sub/a/b/c"
 test_submodule_relative_url "(null)" "../foo/bar" "../submodule" "../foo/submodule"
 test_submodule_relative_url "(null)" "../foo/submodule" "../submodule" "../foo/submodule"
 test_submodule_relative_url "(null)" "../foo" "../submodule" "../submodule"
-- 
2.10.1.382.ga23ca1b.dirty

