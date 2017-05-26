Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2EB1FA14
	for <e@80x24.org>; Fri, 26 May 2017 19:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944585AbdEZTKr (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:10:47 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:32841 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941507AbdEZTKb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:10:31 -0400
Received: by mail-pf0-f180.google.com with SMTP id e193so19466587pfh.0
        for <git@vger.kernel.org>; Fri, 26 May 2017 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j+aDT6osivI+iXhTOKtBCZcpquIkV0yxFqOmE7C3Jwc=;
        b=NbhcwmtazXj57OoV4Gi2Kn9Uj7qJev6nkdujiy772ZKKZfRZoaFXPm90X01cHQBGqs
         5vO/ENG+3e1FOxZiV2AbEsCQvBV7GXagE4saRKYH1Dzwk+qWMbCBi8JA4WrdIDhctAQj
         jLeOm3vY0NUX40FmaVF4n4QO5b8PQEBtJhO1r3NFWGoN2MEUlXOJp3DMxi4kGagqwqXa
         xWv8qUwCNEJJuOrpa7J92QcjXBi+i6wzLtXt8q8fdccMRiaWmcyjyTs5nC8pXAzJVmLA
         RBrv4nKG4gVlhG8HdNnYNZ5GEjxxuMGvtp9VvcX5a1ovgc/97TJgarZzPBBXeK4uXwRG
         dV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j+aDT6osivI+iXhTOKtBCZcpquIkV0yxFqOmE7C3Jwc=;
        b=mTMIEws2vC5mcQ7s4LonS/JOR3Bt8nTDuuSadcI8H5MR87iSTpMapec4XCkCtOho2D
         2AxUOVGSln34h1AO6KgLDCC3PRHqne0xUwdO0sjP28i6oqBJOhV0YlQQEgWJoUXXfRXg
         5FUi2X5k+a1pqhBvwZIRuHROjxJA+U70ARGBQSJhy9UtRttBJmoSh7vhlx5siID/ocMr
         MV6FGclwdxa63iQA3nufITHN7OQT9dA72awGkbQ/y53UDiAi1iHjVl5trZmxfpcoJTQl
         ShzZmdaYk9bspOJjQU5bk0xSUuIru0Z9jbz4PWATX6N4OcpGMwroYxP5aiYjk7V0AVaa
         Nw2g==
X-Gm-Message-State: AODbwcCB5XlGgaZOgepogzUphfLXDqwd+qhX81NOKBs06QIGXInNREL1
        eZNGTEOnZ0NULQfv
X-Received: by 10.84.142.131 with SMTP id 3mr59336435plx.183.1495825825831;
        Fri, 26 May 2017 12:10:25 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:818a:1f3a:57c6:8d29])
        by smtp.gmail.com with ESMTPSA id 67sm2990195pfn.84.2017.05.26.12.10.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 12:10:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/8] submodule loading: separate code path for .gitmodules and config overlay
Date:   Fri, 26 May 2017 12:10:13 -0700
Message-Id: <20170526191017.19155-5-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.g582985b1e4
In-Reply-To: <20170526191017.19155-1-sbeller@google.com>
References: <20170526191017.19155-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The .gitmodules file is not supposed to have all the options available,
that are available in the configuration so separate it out.

A configuration option such as the hypothetical submodule.color.diff
that determines in which color a submodule change is printed,
is a very user specific thing, that the .gitmodules file should
not tamper with.

The .gitmodules file should only be used for settings that required
to setup the project in which the .gitmodules file is tracked. As the
minimum this would only include the name<->path mapping of the
submodule and its URL and branch.

Any further setting (such as 'fetch.recursesubmodules' or
'submodule.<name>.{update, ignore, shallow}') is not specific
to the project setup requirements, but rather is a distribution
of suggested developer configurations.  In other areas of Git
a suggested developer configuration is not transported in-tree
but via other means.  In an organisation this could be done
by deploying an opinionated system wide config (/etc/gitconfig)
or by putting the settings in the users home directory when
they start at the organisation. In open source projects this
is often accomplished via extensive READMEs (cf. our
SubmittingPatches/CodingGuidlines).

As a later patch in this series wants to introduce
a generic submodule recursion option, we want to make
sure that switch is not exposed via the gitmodules file.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index c9e764b519..78cccb7563 100644
--- a/submodule.c
+++ b/submodule.c
@@ -153,7 +153,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 	}
 }
 
-int submodule_config(const char *var, const char *value, void *cb)
+/* For loading from the .gitmodules file. */
+static int git_modules_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "submodule.fetchjobs")) {
 		parallel_jobs = git_config_int(var, value);
@@ -169,6 +170,12 @@ int submodule_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+/* Loads all submodule settings from the config */
+int submodule_config(const char *var, const char *value, void *cb)
+{
+	return git_modules_config(var, value, cb);
+}
+
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 						     const char *arg, int unset)
 {
@@ -222,7 +229,8 @@ void gitmodules_config(void)
 		}
 
 		if (!gitmodules_is_unmerged)
-			git_config_from_file(submodule_config, gitmodules_path.buf, NULL);
+			git_config_from_file(git_modules_config,
+				gitmodules_path.buf, NULL);
 		strbuf_release(&gitmodules_path);
 	}
 }
@@ -233,7 +241,7 @@ void gitmodules_config_sha1(const unsigned char *commit_sha1)
 	unsigned char sha1[20];
 
 	if (gitmodule_sha1_from_commit(commit_sha1, sha1, &rev)) {
-		git_config_from_blob_sha1(submodule_config, rev.buf,
+		git_config_from_blob_sha1(git_modules_config, rev.buf,
 					  sha1, NULL);
 	}
 	strbuf_release(&rev);
-- 
2.13.0.17.g582985b1e4

