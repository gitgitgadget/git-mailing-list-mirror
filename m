Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F7E209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946840AbdEZDfs (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:48 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34449 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946778AbdEZDfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:32 -0400
Received: by mail-pf0-f182.google.com with SMTP id 9so184838397pfj.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=AXawnP1j5I7hkcjb3i48/JVG9zhivmfACejOXFI9WDI=;
        b=vNdeQOJaZtRclQa1OUul3cWfT76gUYVzjyZ3mRFSCD2uiK8NBUDgvm9MC9Zk16GugP
         jOQtrb14m7/YVt6R7/ktsaLEYybOzIO8Y2H1tZH83A4/J8nMQyUzKsUIqU5ZbunhnNoa
         xuyNXNhdapg7DDEVX2XsNFrqW0z8X4qxLGb4FnAdEk8sKeNuOM7DqiiAKu9ZBe54TfFx
         ojps1VtVJsyGinYqsddVy4P1bYFd6RLXYze1azmhEUzWPYERkjsu4QZpYTjrHBMiOPEd
         NQrSj5KZnGYRSXjULJNXt++giR1TQYYzNK+95VquR3xDXFYKrxTjFOP0xoUe72JIEd9x
         LTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=AXawnP1j5I7hkcjb3i48/JVG9zhivmfACejOXFI9WDI=;
        b=Se88Ge1j10471w07HEgy1xWyobsf0Rv/40BWk/SioEnlFPulRptQyu5Qu++GNLjznL
         PYMqMimcit6mN/4+UBKiK3HjvghXInrlu+8lUQbOLq02BvlnoI7TgwU3XUCtiAkRKigd
         ntW+IOI1lqzud72LcMKKP8ZNrbaC8bvBLhShIqnP/wLtXhqyg9/ndXPKzIL8k6RRyjiQ
         nuoue4QKJup3/PpoCEs2B/d8+KnA1uEd+7+vLV1OJC2VARDRxaN4DZVZbNaPHfmD6JYH
         DioDtCuWf6yJ7xh8Od1qwTVerKVsfq0I76Sf48AJqAiDThnIvSliZV15LyLeHM10amTC
         P8VQ==
X-Gm-Message-State: AODbwcDamWbQrTKWsIhKEB/a7qRvSXHhOACVAG3e92fyYpKy2GmGTI/P
        N3GepaMo2Ykd4ruD6/U=
X-Received: by 10.99.18.65 with SMTP id 1mr9014157pgs.40.1495769726994;
        Thu, 25 May 2017 20:35:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id f71sm16139444pfd.98.2017.05.25.20.35.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 12/13] wrapper: factor out is_missing_file_error()
Date:   Fri, 26 May 2017 12:35:09 +0900
Message-Id: <20170526033510.1793-13-gitster@pobox.com>
X-Mailer: git-send-email 2.13.0-491-g71cfeddc25
In-Reply-To: <20170526033510.1793-1-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our code often opens a path to an optional file, to work on its
contents when we can successfully open it.  We can ignore a failure
to open if such an optional file does not exist, but we do want to
report a failure in opening for other reasons (e.g. we got an I/O
error, or the file is there, but we lack the permission to open).

There is a logic to determine if an errno left by open/fopen
indicates such an ignorable error.  Split it out into a helper
function.  We may want to make it an extern in later steps, as many
hits from "git grep ENOENT" would instead want to be using the same
logic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wrapper.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/wrapper.c b/wrapper.c
index b117eb14a4..f1c87ec7ea 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -423,9 +423,23 @@ static void warn_on_inaccessible(const char *path)
 	warning_errno(_("unable to access '%s'"), path);
 }
 
+/*
+ * Our code often opens a path to an optional file, to work on its
+ * contents when we can successfully open it.  We can ignore a failure
+ * to open if such an optional file does not exist, but we do want to
+ * report a failure in opening for other reasons (e.g. we got an I/O
+ * error, or the file is there, but we lack the permission to open).
+ *
+ * Call this function after seeing an error from open() or fopen() to
+ * see if the errno indicates a missing file that we can safely ignore.
+ */
+static int is_missing_file_error(int errno_) {
+	return (errno_ == ENOENT || errno_ == ENOTDIR);
+}
+
 int warn_on_fopen_errors(const char *path)
 {
-	if (errno != ENOENT && errno != ENOTDIR) {
+	if (!is_missing_file_error(errno)) {
 		warn_on_inaccessible(path);
 		return -1;
 	}
-- 
2.13.0-491-g71cfeddc25

