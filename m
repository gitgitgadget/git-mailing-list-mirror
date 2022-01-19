Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47203C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 00:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350320AbiASABF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346735AbiASABF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 19:01:05 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F13C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:01:04 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y15-20020a62b50f000000b004be3069a65bso542775pfe.10
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4pTTKN6auvqykKv/btugSOe6WxV7925Gcj6jdW/Y6yA=;
        b=UHHso1MslQwjFDBrlrdr20RMMfnRvNxqTM2L6zrCL/G0NdjfXRlo5lGtCE8UslfDHL
         C+3SzcGLGvd35tYIvdfOPJLwO7v2pXoi4JLSS1DQHSfZ6kbK1Uf4e7HdXi+sn48stwpt
         JrbgbEkmcCtdrkQvtUvfhHWx2RjSgy9utzcFtXPhva2dVYJzOAI56jgrRCfGLSNDDtw7
         iFMh57xs/CX6tJ1txw6o3JqosP+5uyCA/vgsS1c6WRoKsprgf+QJ1Ds9Mg2LiQXWCZPW
         2L4vGQr0sBuuk2YBQDfAHvxhR42RQpvg9WYHQ3HoUW1BwRqbJg4dWHwZ+cpfJPyQd9G+
         WsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4pTTKN6auvqykKv/btugSOe6WxV7925Gcj6jdW/Y6yA=;
        b=BYDT5m+dZH2Pk7xDxFfFV+goKqi8uynQ6biDEieFKn2HJw12gs1MTuydkCSeEVkkrS
         hDaz84NeEWl+Mzp13LF58uWwzya0mgA+q9rtmPCBvkLW9vjiPgre8eHhJ3zWr6tr3DJ/
         B61x7TXAZB9R8GcRYTuo+si3bXWYal499aSw8/wR6Y4qO5jF5qFkW6oBCcSOVIrSg8X/
         5WxkQ7CzcMkhZ3Y3of6T7MueqigJUIeYrgWtAFJeRDTDDLyXRh/EG6qI11rWNQf91R5J
         cO5aMzWyk0MyVDJVQAvJiIZddRmdC55XK0My4qO6F5l7PZWGo3wDfTzGY4qbQ2Tc0PIu
         K2PQ==
X-Gm-Message-State: AOAM533juajtIMykNt+a/qf8LgUnyItnj7Hk1bTN/Ec+R31/8RMSKSJu
        Ol6DWmx1oTt+yE9dhb7dJcIb9fUVCsibv9oVHQ7NB6/UFsLWEhmYGhky4DL3MCD8Qw+uUR3hLVO
        ii0Jm6T2lrOsUJ7v415mwyzM5g9N8xwVwS5BEMZsR8tsAqfWsSDix+nirh/hPCXA=
X-Google-Smtp-Source: ABdhPJw2egcNY1KwSXqmjinlOGQ1rwlZPO1OdqY//nkDUvx0U5sXWrmNvJkaEXDi8/QylRU1Wdi/A+Zs8jyq/A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:750d:: with SMTP id
 q13mr24736708pgc.560.1642550464249; Tue, 18 Jan 2022 16:01:04 -0800 (PST)
Date:   Tue, 18 Jan 2022 16:00:53 -0800
In-Reply-To: <20220118185453.33710-1-chooglen@google.com>
Message-Id: <20220119000056.58503-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220118185453.33710-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v6 0/3] fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v5:
* revert v4
* drop the unnecessary block that Junio actually meant

Changes since v4:
* drop an unnecessary block (thanks Junio!)

Changes since v3:
* change commit message subject: builtin/fetch -> fetch --negotiate-only
* move the 'goto cleanup' to _after_ the submodule updating task because
  we may want to update submodules even if objects were not fetched (as
  pointed out by Junio, thanks!)
* disable submodule recursion in the patch that checks for
  --negotiate-only + --recurse-submodules, so we never silently ignore
  --recurse-submodules.
* incorporate some of Jonathan's suggestions (thanks!)

Changes since v2:
* added a prepatory patch that introduces a "goto cleanup"
* drop an unnecessary line move (as suggested by Junio)
* check for user-given --recurse-submodules and die() (as suggested by
  Jonathan and Junio)
* update --negotiate-only's documentation

Changes since v1:
* added more context to commit message
* added a NEEDSWORK comment

Glen Choo (3):
  fetch: use goto cleanup in cmd_fetch()
  fetch: skip tasks related to fetching objects
  fetch --negotiate-only: do not update submodules

 Documentation/fetch-options.txt |  1 +
 builtin/fetch.c                 | 40 ++++++++++++++++++++++++++++++---
 t/t5516-fetch-push.sh           | 12 ++++++++++
 t/t5702-protocol-v2.sh          | 12 ++++++++++
 4 files changed, 62 insertions(+), 3 deletions(-)

Range-diff against v5:
1:  ffa1a24109 = 1:  ffa1a24109 fetch: use goto cleanup in cmd_fetch()
2:  b0c73e8135 = 2:  b0c73e8135 fetch: skip tasks related to fetching objects
3:  f929297961 ! 3:  239101e752 fetch --negotiate-only: do not update submodules
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
     +	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
     +		recurse_submodules = recurse_submodules_cli;
     +
    -+	if (negotiate_only)
    ++	if (negotiate_only) {
     +		switch (recurse_submodules_cli) {
     +		case RECURSE_SUBMODULES_OFF:
    -+		case RECURSE_SUBMODULES_DEFAULT: {
    ++		case RECURSE_SUBMODULES_DEFAULT:
     +			/*
     +			 * --negotiate-only should never recurse into
     +			 * submodules. Skip it by setting recurse_submodules to
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
     +			 */
     +			recurse_submodules = RECURSE_SUBMODULES_OFF;
     +			break;
    -+		}
    ++
     +		default:
     +			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
     +		}
    -+
    ++	}
     +
      	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
      		int *sfjc = submodule_fetch_jobs_config == -1

base-commit: 90d242d36e248acfae0033274b524bfa55a947fd
-- 
2.33.GIT

