Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C7820970
	for <e@80x24.org>; Tue, 11 Apr 2017 19:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbdDKTqi (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 15:46:38 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34057 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbdDKTqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 15:46:34 -0400
Received: by mail-pf0-f176.google.com with SMTP id c198so3116325pfc.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z5FCYavNdjRYTt/13o+TtBv1+oTnQZz9Wi3cWwO3Fys=;
        b=pzlYyI/wc6CF/ANyzPkgntB1Th7DdzhmEGKipwrxKw+lICvUBL1f+IIqzzmmfA5wwf
         khoZCCRUNMvG0JjwidENsBvBtnNFyUb0Gv+Hw5bNmVyKuTMpVxKERoi3CVIu7PKgUbam
         tzNZu2f1/KP2GQH02k+tBPJmJgpDqW0p1FsjYuzhhBNPGBQdGCJ/DEdCLdztbokR26mz
         NSTn710VrP6LJwnZbTz3ju5Ly/3x/fPAmQeKNw1UsE9ck1kPZLZJdi7ldi8Mq3n/KFDz
         Oae4D1hsWT6OACHbmmFk2KSrirTNRO0wTfOjzpGop8zJZyRr543bX9RYn7XJeGVLYpV8
         xKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z5FCYavNdjRYTt/13o+TtBv1+oTnQZz9Wi3cWwO3Fys=;
        b=NoysjINYqmg6MnSJtbnrOLGblnKZGXMXPhqcfdrCDxbCfdXjLkR+Y6c0A+hMK5+iGu
         ohRsqDO3yCE+RXMAz9IPI2daCKQZ8TdqdYauvmpUNE9WvYjGe5xjBdJ4Fs+I7QFGd+Gf
         7PmAanKzQfYXkpMnP/7JWheZo5MqOZAG4UPg0hkmtebbWeG1ZIoafaoWTNEgpta5/R/g
         PbbCA1TRijupOOGRtyuqV1AhLQJZOzTw8t3ho59oK+GdMCMx3tLiruhZdap7ao/f8eQH
         kbKdZypd5ZIjNCumxxSg/W9Zez3BzvvSXxY8ge5xVlwKbr4hEuqUTNPLwMPFcVfknjz+
         YZ5Q==
X-Gm-Message-State: AFeK/H0zq3bITw8ssM18faFomqyUk/47vAFkgVvbcBCTt01PVPexplovFj256Ad5poF2hync
X-Received: by 10.98.9.156 with SMTP id 28mr62310826pfj.199.1491939993909;
        Tue, 11 Apr 2017 12:46:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8428:a428:cb31:88df])
        by smtp.gmail.com with ESMTPSA id y29sm15751576pfj.90.2017.04.11.12.46.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 12:46:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, maxime.viargues@serato.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] clone: remember references for submodules even when not recursing
Date:   Tue, 11 Apr 2017 12:46:16 -0700
Message-Id: <20170411194616.4963-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170411194616.4963-1-sbeller@google.com>
References: <20170411194616.4963-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit 31224cbdc7 (clone: recursive and reference option triggers
submodule alternates, 2016-08-17) argued for any further `submodule update`
to respect the initial setup. This is not the case if you only pass
'--reference[-if-able]' to the initial clone without instructing to
recurse into submodules.

If there are submodules however the user is likely to later run
a 'submodule update --init' to obtain the submodules. In this case we
also want to have the references available.

Reported-by: Maxime Viargues <maxime.viargues@serato.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/clone.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index de85b85254..5f022e39e9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -24,6 +24,7 @@
 #include "remote.h"
 #include "run-command.h"
 #include "connected.h"
+#include "submodule.h"
 
 /*
  * Overall FIXMEs:
@@ -993,11 +994,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			string_list_append(&option_config,
 					   strbuf_detach(&sb, NULL));
 		}
+	}
 
+	if (option_recurse_submodules.nr ||
+	    has_submodules(SUBMODULE_CHECK_GITMODULES_IN_WT)) {
 		if (option_required_reference.nr &&
 		    option_optional_reference.nr)
-			die(_("clone --recursive is not compatible with "
-			      "both --reference and --reference-if-able"));
+			die(_("submodules are incompatible with both "
+			    "--reference and --reference-if-able"));
 		else if (option_required_reference.nr) {
 			string_list_append(&option_config,
 				"submodule.alternateLocation=superproject");
-- 
2.12.2.575.gb14f27f917

