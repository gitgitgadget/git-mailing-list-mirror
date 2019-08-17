Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73CBD1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfHQSmH (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44514 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfHQSmG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so4577633pgl.11
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DbKESkiGpf9yu8BtF3RE9rIrceYn5i9Y2JdbozNrRyE=;
        b=tluUkgl+dyVmI/5BAX18tLsvSLPCuQq367OEB7KhBHhgVrSlwRoCr1gY+yLmSh2vcP
         ecyaIsuytmUkXKvqJ1kGunY241mUFcni8ngCivcyd7JKYsFiceFzAU4+ZLyLhRw0s0X+
         KcIzpiKmHN6MJER5sckowNQ5bnjIfGK5u3XvZw94KT2nP/7oj7mvicP9pthqRfUFcE/s
         rAEdXGXhUWdUZwKnA0xpictz+/xOLy6AwYlHzz7J8QXHfR+SSJE/JNOmqi8SUadEwDrd
         riB+5ryDXBDg/chSZinTQ1nMMgrxfMK5BOO+IRVqEc0GZhS17ouzJesKKqCXQk0Vz77S
         C+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbKESkiGpf9yu8BtF3RE9rIrceYn5i9Y2JdbozNrRyE=;
        b=HnkGLQwgxgo+dZzJ40X5V6zCQ3jf9vGWUcQbX9lYOreogtbhFYQCg72jiGt5RZ0ieF
         62Ug8poYYJAlxrrUiDPoyTWmvvyJldVdggMF+BFpqYrMofm+zWym+xjHarsA4EGgS9+D
         yw22lRlvcC/NF9ce7Ukip2FnidwSq9kW6hhKxaegdLENWYf1eycIShrcPRXVYwsbQxOu
         6U18jC55oW/hNjrD4bhNX91VsBUqzWX4HfuWU1oB1Ef66cROYxlO+vSTVIaahK8347Q3
         /OwvCtPf4WCE+NbKHfXjuLz5asUrmFNgwh6eSZb6VcpT7K5KKtJQz1848dn8Gr4Fy2sX
         j8tw==
X-Gm-Message-State: APjAAAW834Ly/RzzHOPxWOBR8gzYx+ifktAuOoNRyhwoCY1Uo3lSwiQn
        +gjgh9OrpoiVtzvTcXMvTRstrywp
X-Google-Smtp-Source: APXvYqxZvmbyHmhFmN5kJ3X6ca8MfSLY5e5aFe09+MBxzPGdWpU+u6qhe/8pURtA6+ClPkAle+KRwQ==
X-Received: by 2002:a65:6458:: with SMTP id s24mr12820482pgv.158.1566067325438;
        Sat, 17 Aug 2019 11:42:05 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:04 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 06/24] merge-recursive: future-proof update_file_flags() against memory leaks
Date:   Sat, 17 Aug 2019 11:41:26 -0700
Message-Id: <20190817184144.32179-7-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a 'free_buf' label to which all but one of the error paths in
update_file_flags() jump; that error case involves a NULL buf and is
thus not a memory leak.  However, make that error case execute the same
deallocation code anyway so that if anyone adds any additional memory
allocations or deallocations, then all error paths correctly deallocate
resources.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9622781612..1d4df952e5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -934,9 +934,11 @@ static int update_file_flags(struct merge_options *opt,
 		}
 
 		buf = read_object_file(&contents->oid, &type, &size);
-		if (!buf)
-			return err(opt, _("cannot read object %s '%s'"),
-				   oid_to_hex(&contents->oid), path);
+		if (!buf) {
+			ret = err(opt, _("cannot read object %s '%s'"),
+				  oid_to_hex(&contents->oid), path);
+			goto free_buf;
+		}
 		if (type != OBJ_BLOB) {
 			ret = err(opt, _("blob expected for %s '%s'"),
 				  oid_to_hex(&contents->oid), path);
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

