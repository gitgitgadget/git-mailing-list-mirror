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
	by dcvr.yhbt.net (Postfix) with ESMTP id 292731F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbfHOVlV (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36940 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732317AbfHOVlU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so1278184pgp.4
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2nrw6eNFBwA1Z+TPyk3jHLcx07IPgqIcxNO6jAh5DpE=;
        b=L5IGpVT9X5JcNVfsNXqnjoV6inNR6s+QMVbdNJQ+nEYBfsnpZiIF0u+WnEdpeGqtRM
         7LhcbjpPCf0tSWxEBnMN3MqbQk6/vmF0rVvn4V1ABdnkYd8bAb8LfVQQkr4LOnMHfhLV
         gYF3X80ujnf1v7YtbNo5VnK/aMcqzhK/P7qz1/R4armDzl3baMmpEhpDRT4ZFDqcsqan
         dcddZEfADa1dc6PuwEevpklH5TRllbVW5ckhHLFkZIZkx77YLj90dYIbjKWJlPBtNHma
         EccQ4NxXeZ0G75FYBWCdHAxXjKzBRNtbaR+Pier0KJM875tpVq3kceoZlPnoBoN+oduU
         R4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nrw6eNFBwA1Z+TPyk3jHLcx07IPgqIcxNO6jAh5DpE=;
        b=p4z7BEJhCBPu6/ie2jnRXaNs9X3VjAYdUaUafmwpv2vGJ07r1ni068SVUff6CSZxVl
         X2+yxOaqYAugkdID28eRapSvIQ/jdvLbAqI+I7Ylj3UJGowG3TgPOZF/Cy8eTOyHP4Oe
         VJVevPvJj28PHhh30omMWY+fHJq8PG2d0P9FgE0fIC9UyzK8391RSObIyQe/dgS40RG4
         7ivOb9R+j2LQie/lcCYqdE5tW8pGVj5BnlTc7W4vty//Tm/oICvH1/o5UWSDpup4yJK+
         B4D8SmtEYX5+iODTObt921i5iIRsRTDjqcuik1gkVN4dM4mFzUrtqiP5JhXJ3V9Rzcrx
         ExWw==
X-Gm-Message-State: APjAAAWR/xd3R1t7LH+DbwoHjYcdE8fmSy/DPa4Hp+S52F62qzOwOe7w
        RqXcGIeEgR6Jtgxj8q4UxsrwXwJn
X-Google-Smtp-Source: APXvYqw21mrE5bPuVJjQSIgkNRL9vNIuyhqrkQffiCYBLMq7Wed6NHV4aW6VnQ0zI9FCiDcSvHzaRg==
X-Received: by 2002:aa7:9882:: with SMTP id r2mr7587767pfl.146.1565905279574;
        Thu, 15 Aug 2019 14:41:19 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 06/24] merge-recursive: future-proof update_file_flags() against memory leaks
Date:   Thu, 15 Aug 2019 14:40:35 -0700
Message-Id: <20190815214053.16594-7-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
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
index dd2ee5edee..eae3e4fbcc 100644
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
2.23.0.rc2.32.g2123e9e4e4

