Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0471C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 03:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbhKVDi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 22:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbhKVDi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 22:38:26 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ADFC061574
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 19:35:21 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q12so14102713pgh.5
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 19:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jbv7rq8AYOEcNHJBMDFPy3O+45YJrv6NMu0msSjf3yM=;
        b=Im4grLdwPvjXTb01ZYP064xrUspuqS2EnXXccQKkDmcIEhzmgNyFBmotzLw9phkkWn
         FjVJqWgM8+IgZV0wAAPwZRFn5SdtEB10DMnJ6Vok9d3aocdgKaUx5NZYkiN1J3EFkeZo
         2bGhHe6A7O4zFhpj20Mqo4YSYpQq03vt9OQr7Zs6FG3+1qotCJPR81I+bfN7XBIW3aWA
         dBqm+wmcxCj++rJaNKPMOFPDNDlGJgonQdGZMk36lIbNG7N+1ZsYGp1KdxNgMFHFWfXw
         Ksn1btiJanhtU1LZW/CmQ0Vy30KR4417GVKcsToZUO4NdoaNxIxPBdc1ogdHqrBjh3i1
         CT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jbv7rq8AYOEcNHJBMDFPy3O+45YJrv6NMu0msSjf3yM=;
        b=khdVJmg70Wbd9VCCIOacLNUi84SrqcJ6AOsLUK46AUIVa7Bg+eDlPL1FysYW6m37tJ
         IJwEYvuuICeWNPQ3Jbe6zxUCu7nNRMWmErmTXAR3hXdeWzEH/mEvgUChVILy2ti1lf01
         65MVonuTOChQ9zae2mPafkmr25DSofUFLO51mO6aAn+LdsYieHRjpOWYSB/Oubyo6+Fy
         h3amutfNyzAJbCYSVXmvKuecvJWS70pE8YHcaPhKUW/brIYNDglrrl4m7cKPLOZR/sUA
         uEy5M34QkoqJ/opQR2nKtpVM2fuh6iP9SJ4l/jNZ3xi9ErRnDzG3I78p+TdW0zlSGj7f
         Nd8w==
X-Gm-Message-State: AOAM531hLSaQS+f1s1DH6Nw4BacKZTj1DvO+qZay5mjatAJL3pTJh2nr
        gfZ3lsVrAyvavTETBnMtTrc=
X-Google-Smtp-Source: ABdhPJx+NicnH4342Hw9nwR6KSzan1o9NmtZgzgqoDwWyN6w2bloAGKcpoQSIKeUAt2DUboWNd5hVw==
X-Received: by 2002:a63:2020:: with SMTP id g32mr30718162pgg.208.1637552120652;
        Sun, 21 Nov 2021 19:35:20 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id q11sm1235714pgt.54.2021.11.21.19.35.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Nov 2021 19:35:20 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v3 3/5] object-file.c: read stream in a loop in write_loose_object()
Date:   Mon, 22 Nov 2021 11:32:18 +0800
Message-Id: <20211122033220.32883-4-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0.6.g676eedc724
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

In order to prepare the stream version of "write_loose_object()", read
the input stream in a loop in "write_loose_object()", so that we can
feed the contents of large blob object to "write_loose_object()" using
a small fixed buffer.

Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/object-file.c b/object-file.c
index 78fd2a5d39..93bcfaca50 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1890,7 +1890,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
 	const void *buf;
-	unsigned long len;
+	int flush = 0;
 
 	if (is_null_oid(oid)) {
 		/* When oid is not determined, save tmp file to odb path. */
@@ -1925,12 +1925,18 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	the_hash_algo->update_fn(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
-	buf = in_stream->read(in_stream, &len);
-	stream.next_in = (void *)buf;
-	stream.avail_in = len;
 	do {
 		unsigned char *in0 = stream.next_in;
-		ret = git_deflate(&stream, Z_FINISH);
+		if (!stream.avail_in) {
+			buf = in_stream->read(in_stream, &stream.avail_in);
+			if (buf) {
+				stream.next_in = (void *)buf;
+				in0 = (unsigned char *)buf;
+			} else {
+				flush = Z_FINISH;
+			}
+		}
+		ret = git_deflate(&stream, flush);
 		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
 			die(_("unable to write loose object file"));
-- 
2.34.0.6.g676eedc724

