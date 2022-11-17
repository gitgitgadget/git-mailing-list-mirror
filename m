Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C47C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 01:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiKQBpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 20:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbiKQBo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 20:44:56 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6256B213
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 17:44:53 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso3400917wme.5
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 17:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI/mjTy43VUwJvOzKs6jwOwPZ5BpinhNv4T/DyFFXds=;
        b=n2iDq1d4dHioUiVSaaYHACG/eUmak941rd0BWdT9beV/wgH58cIS2A6Dbe9kZl52Qp
         GSZFDMq90Bq8jDhcOKbpix7GXb/k68Is9qyo/8wntkMTMowsoDSrbRQy46/tG2MDoEvp
         X7OLrgegLychO+d895U/o5iNNcV5PWl5rFHeZXkoekx9UZCUK9vJ7WYfYbNuz+UBpNLA
         nQxh5JDwSfLUc7dX5z3pVtmlXNwZvrYIriHAzbMCnyi4eAut8m+BOwakGqhEuTHkw3ZG
         qgiVUvu0+4QavtOUMYkhC515/KGFPwdz2K6g4xJYnhnOWwSNB3Zh14AU1PG7Om6ghxq9
         dFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SI/mjTy43VUwJvOzKs6jwOwPZ5BpinhNv4T/DyFFXds=;
        b=VUv8iouivFTSinGkjitCCbmGkdeD4EoZwhEI7U9pB47rDOUj+QijCCwvwyTMoYG/eO
         n+W33B0TuqeFwQsYHH1n8A5vLiZfC8VtMBI1l3aCMBIxp4gByO1NSdNZSR3IZGBBY1yS
         QX5wBGd1pzuj0VGxi7fmzj9uzeu3JKGIiM2D3+XRF+OIxYILWUa6RDCNmwuVDaOAv7SF
         43+mX1A2OhVIncrZSiGdsx/cFV6wViEHEqipVifrnj8HkT5x2MSEC0PEOfwRvY4U+k8e
         ZcsPgUo/f0V/fIhG2+BdOPX4Alsz51YUT4bI/9GtOmvwJKCEJh9rzjtyD8M8+bbqwQuU
         5Hmw==
X-Gm-Message-State: ANoB5pmokfA7D67Q7ls4pQ0J/tBrUc+j/AFrWrrRivh7neiYWesNxe6L
        4hvE9oHTwCj0k9kppArl37L6ofDZgX0=
X-Google-Smtp-Source: AA0mqf7c6v+i26B21U47/l/KHiKVtE/2yGuOmemOext477+vX7iYVDmPe76aLUf27hfpu0W4D6KXyg==
X-Received: by 2002:a05:600c:688d:b0:3c3:77c2:cfff with SMTP id fn13-20020a05600c688d00b003c377c2cfffmr3638490wmb.171.1668649491719;
        Wed, 16 Nov 2022 17:44:51 -0800 (PST)
Received: from [192.168.2.52] (104.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.104])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b003cf37c5ddc0sm4106968wms.22.2022.11.16.17.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 17:44:51 -0800 (PST)
Subject: [PATCH 2/2] branch: clear target branch configuration before copying
 or renaming
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
Message-ID: <762c1e8f-fd0c-3b4b-94a0-709d8c9431e4@gmail.com>
Date:   Thu, 17 Nov 2022 02:44:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two problems with -m (rename) and -c (copy) branch operations.

 1. If we force-rename or force-copy a branch to overwrite another
 branch that already has configuration, the resultant branch ends up
 with the source configuration (if any) mixed with the configuration for
 the overwritten branch.

	$ git branch upstream
	$ git branch -t foo upstream  # foo has tracking configuration
	$ git branch bar              # bar has not
	$ git branch -M bar foo       # force-rename bar to foo
	$ git config branch.foo.merge # must return clear
	refs/heads/upstream

 2. If we repeatedly force-copy a branch to the same name, the branch
 configuration is repeatedly copied each time.

	$ git branch upstream
	$ git branch -t foo upstream  # foo has tracking configuration
	$ git branch -c foo bar       # bar is a copy of foo
	$ git branch -C foo bar       # again
	$ git branch -C foo bar       # ..
	$ git config --get-all branch.bar.merge # must return one value
	refs/heads/upstream
	refs/heads/upstream
	refs/heads/upstream

Whenever we copy or move (forced or not) we must make sure that there is
no residual configuration that will be, probably erroneously, inherited
by the new branch.  To avoid confusions, clear any branch configuration
before setting the configuration from the copied or moved branch.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c  | 17 +++++++++++------
 t/t3200-branch.sh | 19 +++++++++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a35e174aae..14664f0278 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -583,12 +583,17 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	strbuf_release(&logmsg);
 
-	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
-	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
-	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
-		die(_("Branch is renamed, but update of config-file failed"));
-	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
-		die(_("Branch is copied, but update of config-file failed"));
+	if (strcmp(interpreted_oldname, interpreted_newname)) {
+		strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
+		strbuf_addf(&newsection, "branch.%s", interpreted_newname);
+
+		delete_branch_config(interpreted_newname);
+
+		if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
+			die(_("Branch is renamed, but update of config-file failed"));
+		if (copy && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
+			die(_("Branch is copied, but update of config-file failed"));
+	}
 	strbuf_release(&oldref);
 	strbuf_release(&newref);
 	strbuf_release(&oldsection);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7f605f865b..c3b3d11c28 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -218,6 +218,25 @@ test_expect_success 'git branch -M should leave orphaned HEAD alone' '
 	)
 '
 
+test_expect_success 'git branch -M inherites clean tracking setup' '
+	test_when_finished git branch -D moved &&
+	git branch -t main-tracked main &&
+	git branch non-tracked &&
+	git branch -M main-tracked moved &&
+	git branch --unset-upstream moved &&
+	git branch -M non-tracked moved &&
+	test_must_fail git branch --unset-upstream moved
+'
+
+test_expect_success 'git branch -C inherites clean tracking setup' '
+	test_when_finished git branch -D copiable copied &&
+	git branch -t copiable main &&
+	git branch -C copiable copied &&
+	git branch --unset-upstream copied &&
+	git branch -C copied copiable &&
+	test_must_fail git branch --unset-upstream copiable
+'
+
 test_expect_success 'resulting reflog can be shown by log -g' '
 	oid=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-- 
2.36.1
