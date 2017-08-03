Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D241F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbdHCSUW (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:22 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36012 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbdHCSUS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:18 -0400
Received: by mail-pg0-f53.google.com with SMTP id v77so9279795pgb.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kHUoRy/XVwtgRXIsj+k4a0KSgLGrrGIw0sTd5mibnuc=;
        b=vS+lbtCjRY5Hn5YKxxNrvJR/QMtYfTl9mW438uj/QO7iCopkvC145nF2htZWkRqbtu
         e1LmrNMX9HhG5pig0siV36Aj4j+ocdl2Ho4NmVqAovyCHSHkvnDe1A/9qq2Jss/j3ipu
         yxA9r3IC6fqRlTI67og+DPiRdQV/XPm2Q0bo1aYYCYls+SUuGBa+1dfOmUv6VGxvbmPu
         tPTGe0zaTZ799eKoveJbJjQ6lQ2757vPCMWrLPw1TPbBns5aXz8sY/x0ovlsWX0GQyPp
         EUcd+yLPBCD6+M8JSa+h68TYVpwWNAA0JCn+GDr0S7jwlTFFXyKjw0/4aU79AFHRKYp6
         h7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kHUoRy/XVwtgRXIsj+k4a0KSgLGrrGIw0sTd5mibnuc=;
        b=JIrquYvZKYs4F4zzgy6QdA92xcnzthdsJ+TvAETzQrD5qAZelaIuVQ3cQiHB9toBaf
         C/I7osnRBUbBYgOR3o3uC92TQPnh/Wv0DVHHmOGEnREM2EjuevJSSdIjr9Iw2YYnXXIf
         jCZAnvI/nQUt+E0B7SYe2QycCXM60C/AHZ24QkWCX85QxUxp5B7XzCs1keqUZozmBKd9
         j4cv9SHha6T1wEOm8ItWHL0WLlpHTB+mL5EwhrH/uTsRku7FwZ19lQxyNisxQNGzotB0
         hbIyghpCc68im+0PWbbcZyzXqHCz8NfAeKDI9ZmCPm/poi9Aditp66uBH0SF9oMHaD4B
         G0EQ==
X-Gm-Message-State: AIVw112tYSY+eRKqnkOZY1+bDIgCDCH33Re4p2xK7iI/dJa55uxbu04X
        2ey+Jkq2wPNrQ1u1hWR/9g==
X-Received: by 10.98.245.6 with SMTP id n6mr2475379pfh.113.1501784417844;
        Thu, 03 Aug 2017 11:20:17 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:16 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 07/15] submodule: don't rely on overlayed config when setting diffopts
Date:   Thu,  3 Aug 2017 11:19:52 -0700
Message-Id: <20170803182000.179328-8-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't rely on overlaying the repository's config on top of the
submodule-config, instead query the repository's config directory for
the ignore field.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 59e3d0828..a32043893 100644
--- a/submodule.c
+++ b/submodule.c
@@ -165,8 +165,16 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 {
 	const struct submodule *submodule = submodule_from_path(&null_oid, path);
 	if (submodule) {
-		if (submodule->ignore)
-			handle_ignore_submodules_arg(diffopt, submodule->ignore);
+		const char *ignore;
+		char *key;
+
+		key = xstrfmt("submodule.%s.ignore", submodule->name);
+		if (repo_config_get_string_const(the_repository, key, &ignore))
+			ignore = submodule->ignore;
+		free(key);
+
+		if (ignore)
+			handle_ignore_submodules_arg(diffopt, ignore);
 		else if (is_gitmodules_unmerged(&the_index))
 			DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
 	}
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

