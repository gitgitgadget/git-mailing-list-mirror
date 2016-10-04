Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14BF420986
	for <e@80x24.org>; Tue,  4 Oct 2016 19:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbcJDT33 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 15:29:29 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35829 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbcJDT3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 15:29:16 -0400
Received: by mail-pa0-f48.google.com with SMTP id ik13so22766286pac.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gsdx1m3gktPuIsPQZ6VvNBcQ3eTcIipSNzh0eR5VwNs=;
        b=mB3BCcbxX2rKhElBEfOCWBP4VsYbmKkHG/kdtmf7FuhlT2wi1d5DMpwJTPNbfI/rKf
         Cv3m52wIXad4C6xZeLNGYQnqL4FkyPZdX9XOxLVBj/bKnXpcuzdPCrbJPfuq5RFdWAEV
         OhLif9+OBo/cjZTZfxxI/aOkoVSkFVwlt5zEum3s1njDztXOqs8jo6gHymoFNZf97tB+
         /tjdmzRM7BtWz0/vFpeNB6noW+JA0UZVcczkXMkScreyLLbcKbsYYfF4y9tgwblwr6re
         Uq50ZuUx+2W0V8uTpLa9ZxomR7cISUNYe8iSZGIXX06sAde/XPpNqCP2YpVmtetwy9MN
         RU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gsdx1m3gktPuIsPQZ6VvNBcQ3eTcIipSNzh0eR5VwNs=;
        b=Z1JOZnQhvxF2ghmfHzMAvegOrUD0gA3tn6qQG4soqFq/F8wXGGUPAOxs8IjO4+1Rf4
         9Ls0+7Fs8F/CYmgWUjZlDTS/EGw1Avd0jYm/3Lzb1a1Vu65XAIQdjwsH9WyDb1S8CjN8
         RKmEJYa5lBiDQw04UHc9MyxVhJQK64zrbABFflC9k5ZlZk2Pli4D3+oTlYyPZJWUbNOV
         zo2WNVotpO854vxFj7whxliiI30p2/1IOLjZVhel+k4bPS1XoLL13u1FjUrWp7kp6XM0
         YSiP9cJY4ERF3anJmTO1sdd2ZcFL22YN+Sp8fM8xufgQyNt4561Ht2+X8X7Td7b3Nskh
         /o/g==
X-Gm-Message-State: AA6/9Rna9Ua5clqPkpm7VfAA//Qk7DzapWYERIGj90gH9q5jcYfLqkvV5NWpiCS5uNps2iUM
X-Received: by 10.66.50.40 with SMTP id z8mr7510134pan.109.1475609355087;
        Tue, 04 Oct 2016 12:29:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d1d:42df:48d7:33a4])
        by smtp.gmail.com with ESMTPSA id p77sm20358155pfi.27.2016.10.04.12.29.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 12:29:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, peff@peff.net, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/2] push: change submodule default to check when submodules exist
Date:   Tue,  4 Oct 2016 12:29:09 -0700
Message-Id: <20161004192910.30649-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.129.g35f6318
In-Reply-To: <20161004182801.j3fdpewybatmibpo@sigill.intra.peff.net>
References: <20161004182801.j3fdpewybatmibpo@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working with submodules, it is easy to forget to push the submodules.
The setting 'check', which checks if any existing submodule is present on
at least one remote of the submodule remotes, is designed to prevent this
mistake.

Flipping the default to check for submodules is safer than the current
default of ignoring submodules while pushing.

However checking for submodules requires additional work[1], which annoys
users that do not use submodules, so we turn on the check for submodules
based on a cheap heuristic, the existence of the .git/modules directory.
That directory doesn't exist when no submodules are used and is only
created and populated when submodules are cloned/added.

When the submodule directory doesn't exist, a user may have changed the
gitlinks via plumbing commands. Currently the default is to not check.
RECURSE_SUBMODULES_DEFAULT is effectively RECURSE_SUBMODULES_OFF currently,
though it may change in the future. When no submodules exist such a check
is pointless as it would fail anyway, so let's just turn it off.

[1] https://public-inbox.org/git/CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com/

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Jeff wrote:
> Consulting .git/config is fine, I think. It's not like we don't read it
> (sometimes multiple times!) during the normal course of the program
> anyway. It's just a question of whether it makes more sense for the
> heuristic to kick in after "init", or only after "update". I don't know
> enough to have an opinion.

I think there is no difference in practice, however the "after update"
is way easier to implement and hence more maintainable (one lstat instead of
fiddeling with the config; that can go wrong easily). 

Thanks,
Stefan

 builtin/push.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 3bb9d6b..06fd3bd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "refs.h"
+#include "dir.h"
 #include "run-command.h"
 #include "builtin.h"
 #include "remote.h"
@@ -22,7 +23,7 @@ static int deleterefs;
 static const char *receivepack;
 static int verbosity;
 static int progress = -1;
-static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules;
 static enum transport_family family;
 
 static struct push_cas_option cas;
@@ -31,6 +32,19 @@ static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
 
+static void preset_submodule_default(void)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_addf(&sb, "%s/modules", get_git_dir());
+
+	if (file_exists(sb.buf))
+		recurse_submodules = RECURSE_SUBMODULES_CHECK;
+	else
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+
+	strbuf_release(&sb);
+}
+
 static void add_refspec(const char *ref)
 {
 	refspec_nr++;
@@ -552,6 +566,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	};
 
 	packet_trace_identity("push");
+	preset_submodule_default();
 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 	set_push_cert_flags(&flags, push_cert);
-- 
2.10.0.129.g35f6318

