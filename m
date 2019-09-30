Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643AD1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbfI3VKZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:10:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37897 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732486AbfI3VKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:10:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so8053994pgi.5
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXvlWDLlBYDCrkZHNlzFS2ZcuhsmhP0cLWtOEIhls4Y=;
        b=FL/ie33PkEbdx6mJON0YQxY4JRuiHrO1L3aN+Rx2Ibe3KfDMH467z+51WNbsWHGxvD
         xnaRMYWB+LZ0qkeq8IT7+lXrFSlgL+h1RkdQmCAEDX5kJFGOHriV+pm8BorXAgsKXrWQ
         VGsYOWsJx7YIebUJnKDkDc3EJua4DxZsORY+5invaoJu1pI7hxY7vfhnBmLk/EkmT1x1
         fbBer9jmb5b2ilOVKw8R+HjwOqzdtg6yDhaOXfTwJANc3PZJoImxZXD/WO4mS0+3hViw
         GccyH+rqFErRq7gs5wSP19JD503xrttZYGFkMo+eAdnCj4kirJfH32uL3LKQcjEnozub
         O/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXvlWDLlBYDCrkZHNlzFS2ZcuhsmhP0cLWtOEIhls4Y=;
        b=P+d0Oz9+N64/dxVsLMSRT6O05Ea7fR+yI5smOPRdvC2BRWdqydZsypJ6ddDqDyy9fX
         6yMBQ2amJyKfyZRdzggcb3/msgh48k1jIqxwq5/pT5QXZn4VwGFsrJ6XxF2MLat6H+H7
         weEXUYHbCOMp9baUHxfdMwqapFZgz05SFjSwuBEMnkzurtNZ+5EQMgo/Ob+fMI/CgHhv
         UOmQXNwRj9/8dnXzhJPcY4R92k0kcBVyUuccfYjy73bOaS47QmRPJH7hBCyaZPlVsUf6
         2jdG/fZrKjoAQ2JS7LEdJjEsQ2Ez4b/sMhLY9V+8nGMweyKtjzM7NaCAj194BPNFntoP
         0kig==
X-Gm-Message-State: APjAAAXDJq+vHncGS0j+c65vIXGh4TbUHkF+MD9uDozf8oKn9NdWUrMP
        RQWQSZdAFbzNCBlatOPfoWqQQdRr9pw=
X-Google-Smtp-Source: APXvYqyI7XLWlSA5vDSITknNda3/ynllrH5fRVWsHHFu+akTMzKxqe/9XisXdlnyTmt0YVQq6v0gVw==
X-Received: by 2002:a63:2406:: with SMTP id k6mr15495739pgk.420.1569877824074;
        Mon, 30 Sep 2019 14:10:24 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id w11sm13404609pfd.116.2019.09.30.14.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 14:10:23 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/8] fast-export: fix exporting a tag and nothing else
Date:   Mon, 30 Sep 2019 14:10:11 -0700
Message-Id: <20190930211018.23633-2-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.gac739dbb79
In-Reply-To: <20190930211018.23633-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
 <20190930211018.23633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fast-export allows specifying revision ranges, which can be used to
export a tag without exporting the commit it tags.  fast-export handled
this rather poorly: it would emit a "from :0" directive.  Since marks
start at 1 and increase, this means it refers to an unknown commit and
fast-import will choke on the input.

When we are unable to look up a mark for the object being tagged, use a
"from $HASH" directive instead to fix this problem.

Note that this is quite similar to the behavior fast-export exhibits
with commits and parents when --reference-excluded-parents is passed
along with an excluded commit range.  For tags of excluded commits we do
not require the --reference-excluded-parents flag because we always have
to tag something.  By contrast, when dealing with commits, pruning a
parent is always a viable option, so we need the flag to specify that
parent pruning is not wanted.  (It is slightly weird that
--reference-excluded-parents isn't the default with a separate
--prune-excluded-parents flag, but backward compatibility concerns
resulted in the current defaults.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  |  7 ++++++-
 t/t9350-fast-export.sh | 13 +++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index f541f55d33..5822271c6b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -860,7 +860,12 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	if (starts_with(name, "refs/tags/"))
 		name += 10;
-	printf("tag %s\nfrom :%d\n", name, tagged_mark);
+	printf("tag %s\n", name);
+	if (tagged_mark)
+		printf("from :%d\n", tagged_mark);
+	else
+		printf("from %s\n", oid_to_hex(&tagged->oid));
+
 	if (show_original_ids)
 		printf("original-oid %s\n", oid_to_hex(&tag->object.oid));
 	printf("%.*s%sdata %d\n%.*s\n",
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index b4004e05c2..d32ff41859 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -53,6 +53,19 @@ test_expect_success 'fast-export | fast-import' '
 
 '
 
+test_expect_success 'fast-export ^muss^{commit} muss' '
+	git fast-export --tag-of-filtered-object=rewrite ^muss^{commit} muss >actual &&
+	cat >expected <<-EOF &&
+	tag muss
+	from $(git rev-parse --verify muss^{commit})
+	$(git cat-file tag muss | grep tagger)
+	data 9
+	valentin
+
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'fast-export master~2..master' '
 
 	git fast-export master~2..master >actual &&
-- 
2.23.0.264.gac739dbb79

