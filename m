Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD52C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 17:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJJRlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJJRlj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 13:41:39 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F62B6AA3E
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 10:41:34 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id q18so3209548ils.12
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 10:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+iQOa+H2UQieBO/ih0IN1BGbprL6801CQJjhC1IpcI4=;
        b=eIMFTpl7RPSUespf3qxUYEYISsSPPy5+A5/gij2rAQpn+Xcikcqgc59wzzLLZgWYUT
         ZywlT8FKgFd8y8W7dxqdIuq2ydo2FfmUAgKL0+9Fzmo7yp61ANt2RBIiFgrv3rTtwt8t
         rZXjgDDMWeqlKqDXL35pLjgWFr5ObvRmNk2RnULAoPFjv7TZIxNWBX7+HWPMIC4J2fY8
         5U5Gh8tMPMo132F8jgpfCrtTxrMZvk3plgsHEeJMimJB/ghVa0cYVSWEHM9+yv/7hUl+
         WN3aF7yryEOhc5wzNZw6L/rFWV0dORhQ460kjDjEEV02toK95La3qcvIJrq2wnd9uhNP
         c3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iQOa+H2UQieBO/ih0IN1BGbprL6801CQJjhC1IpcI4=;
        b=T3GEu5rHl5aFddWyFfB7RFErhiDmo42MxIk5ODWt1sWYnWL6GWsuyFhLT4CgbVJ5y/
         CR3eh9gh+DLer1+4C0QMvbxqNYYnawH+8LFFtd1moRQslvlagx/yDaDmgcbx3KceCnpx
         mF6VBd24zwKLPCzVdOfZ+aT6e50VZljStuR2iwsEvt4PdygD+aUH9W3BEc3ZomdU05zr
         +TwK+t0reL90JdK3TB8DnDEEw2z3kDL/unztfkqVjFwodNM/WjKNn8b+DvHYB1Nk2A0F
         o9gQgXPu1kDRUzIweNqSpaw64g7BFcwCK4cuwdi2MRTD7fzKtarGaepY5YRlWZCvleKW
         uhFw==
X-Gm-Message-State: ACrzQf0lEhW4M2WWW9ktE8C3KtdSBkmTfhBTRIVxo0Rma4Kf9IirJjgU
        bpSWCr88bq0oA7gpyrHKWmg/5zwOwKWZAfeu
X-Google-Smtp-Source: AMsMyM5x6/kKnf1oPqL4hS2O4JzlnGYN2A76Wpn4s9gYKxBzIJ2UADEVI7lwf+lJ4x7dPCDUVRpHCg==
X-Received: by 2002:a92:ca0d:0:b0:2fc:24a6:9115 with SMTP id j13-20020a92ca0d000000b002fc24a69115mr4251796ils.70.1665423693805;
        Mon, 10 Oct 2022 10:41:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bq8-20020a056638468800b00363b0517662sm1897185jab.12.2022.10.10.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:41:33 -0700 (PDT)
Date:   Mon, 10 Oct 2022 13:41:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     orygaw@protonmail.com, rsbecker@nexbridge.com, gitster@pobox.com
Subject: [PATCH 2/2] grep.c: tolerate NULL grep_expr in free_pattern_expr()
Message-ID: <7e094882c2a71894416089f894557a9eae07e8f8.1665423686.git.me@ttaylorr.com>
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
 <cover.1665423686.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665423686.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As demonstrated in the previous commit, `git log --invert-grep` without
a `--grep` argument causes a segfault after f41fb662f5 (revisions API:
have release_revisions() release "grep_filter", 2022-04-13).

The segfault occurs in `free_pattern_expr()`, which crashes on trying to
switch on `x->node` when given a NULL pointer. Usually we avoid calling
`free_pattern_expr()` without a pattern as indicated by the `extended`
bit being zero.

But it is possible to get into a state where the `extended` bit is
non-zero, but the `pattern_expression` is still NULL. This happens
because the `--invert-grep` option sets the `no_body_match` bit. When we
call `compile_grep_patterns()`, we set `opt->extended = 1`. But the
`pattern_expression` is left as NULL, since we return with a NULL
`header_expr`.

So when we try to call `free_pattern_expr()`, things go awry, since
`free_grep_patterns()` expects a non-NULL argument.

Instead, teach `free_grep_patterns()` to tolerate a NULL argument
(treating it as a noop), and avoid checking whether or not the
`extended` bit is set, since `free_pattern_expr()` will handle its
argument regardless.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c         | 5 +++--
 t/t4202-log.sh | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 52a894c989..bcc6e63365 100644
--- a/grep.c
+++ b/grep.c
@@ -752,6 +752,9 @@ void compile_grep_patterns(struct grep_opt *opt)
 
 static void free_pattern_expr(struct grep_expr *x)
 {
+	if (!x)
+		return;
+
 	switch (x->node) {
 	case GREP_NODE_TRUE:
 	case GREP_NODE_ATOM:
@@ -790,8 +793,6 @@ void free_grep_patterns(struct grep_opt *opt)
 		free(p);
 	}
 
-	if (!opt->extended)
-		return;
 	free_pattern_expr(opt->pattern_expression);
 }
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e3ec5f5661..44f7ef0ea2 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -297,7 +297,7 @@ test_expect_success 'log --invert-grep --grep -i' '
 	fi
 '
 
-test_expect_failure 'log --invert-grep (no --grep)' '
+test_expect_success 'log --invert-grep (no --grep)' '
 	git log --pretty="tformat:%s" >expect &&
 	git log --invert-grep --pretty="tformat:%s" >actual &&
 	test_cmp expect actual
-- 
2.37.0.1.g1379af2e9d
