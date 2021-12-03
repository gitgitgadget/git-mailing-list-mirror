Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EC2C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 09:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351418AbhLCJjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 04:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhLCJje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 04:39:34 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510E1C06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 01:36:11 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 200so2503837pga.1
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 01:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skIAiRKZ183CeUNhWtFnoaHlnkxLZyLefNCqVeWgZjE=;
        b=XBTCfJdjyg0dWAhSPgaWc84ofhpsQka5iMNQMmwA7L8GM9iifjudAm1AKLeIkXlsJ0
         hKYLG2y1cUfGq+Mg6OzWq8wV1TbDdEldnndVJnlfwvLU/tZfcrmvUkrywV3XGpcREZ1Q
         kccu8rgVhONqpVcmrnNaegIh/aOSv4FLyTv/NsE04RuNg1TPnP9w1glMOK/LgQUNI1AA
         FIW1IjHXZeBdoTdw+X0Sf/DKO07aUCEt6p5t5daezeVfnFkzXlsDEYcSodgqdSgJ+Jk1
         F7wquw1QX+GyiJUyqDUglN8A2YJqabEZgCDdDxps6EIccdpfNszkCPTsJBsRSoHvlQzK
         2OiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skIAiRKZ183CeUNhWtFnoaHlnkxLZyLefNCqVeWgZjE=;
        b=1RtcWT/E4JLKvp5hYtV7c/MOVkxioDcvXYesylblWPbDdeFkoGV1FYoUEPnL4FJsAu
         /n8AVWUX0cNosc7cU6pi99WkdO9p3c4xUwNtWdLEP8bpZwv2gaXcCwYr4tZZ3ug/fijI
         tyUM7Y1NvdQFtU7fqPzzyJdAXMy7sHVmLdZHeEdAx738zWxQ6vF/zD18zESJlp+WdG/h
         zTG3T/wcjHIAOKovMYmHiOE4sJm2Gk0ybyBB8s+xOPGxVZ6M0kBERhMjBvI0HJF6kxZ8
         cnFS9O+/mT6LTufxAOWQZ55+OKeFEPvsIeTNjLNIg1Wa1Lei4ylY7Uk/Ryb2jQIdiF5Y
         5nXA==
X-Gm-Message-State: AOAM530/iQG1Aw2SMGj3/HIhnAcvGWR54xP2VfBM10RyYOiBYpuWkGeS
        ULWCxUpjC603xtbzzncGRsA=
X-Google-Smtp-Source: ABdhPJwf53+22Oa1t3i4ORq2d4vb3rJSXHxQ1nTsUFEeCJ1VxIvQIdV1k/HhwMmaR0VwABZrUIHQjw==
X-Received: by 2002:a63:8c0a:: with SMTP id m10mr3756358pgd.142.1638524170765;
        Fri, 03 Dec 2021 01:36:10 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id g9sm2708142pfj.160.2021.12.03.01.36.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Dec 2021 01:36:10 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v4 2/5] object-file.c: handle undetermined oid in write_loose_object()
Date:   Fri,  3 Dec 2021 17:35:27 +0800
Message-Id: <20211203093530.93589-3-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122033220.32883-1-chiyutianyi@gmail.com>
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

When streaming a large blob object to "write_loose_object()", we have no
chance to run "write_object_file_prepare()" to calculate the oid in
advance. So we need to handle undetermined oid in function
"write_loose_object()".

In the original implementation, we know the oid and we can write the
temporary file in the same directory as the final object, but for an
object with an undetermined oid, we don't know the exact directory for
the object, so we have to save the temporary file in ".git/objects/"
directory instead.

Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 82656f7428..1c41587bfb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1892,7 +1892,14 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	const void *buf;
 	unsigned long len;
 
-	loose_object_path(the_repository, &filename, oid);
+	if (is_null_oid(oid)) {
+		/* When oid is not determined, save tmp file to odb path. */
+		strbuf_reset(&filename);
+		strbuf_addstr(&filename, the_repository->objects->odb->path);
+		strbuf_addch(&filename, '/');
+	} else {
+		loose_object_path(the_repository, &filename, oid);
+	}
 
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
@@ -1939,12 +1946,31 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
 	the_hash_algo->final_oid_fn(&parano_oid, &c);
-	if (!oideq(oid, &parano_oid))
+	if (!is_null_oid(oid) && !oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
 	close_loose_object(fd);
 
+	if (is_null_oid(oid)) {
+		int dirlen;
+
+		oidcpy((struct object_id *)oid, &parano_oid);
+		loose_object_path(the_repository, &filename, oid);
+
+		/* We finally know the object path, and create the missing dir. */
+		dirlen = directory_size(filename.buf);
+		if (dirlen) {
+			struct strbuf dir = STRBUF_INIT;
+			strbuf_add(&dir, filename.buf, dirlen - 1);
+			if (mkdir(dir.buf, 0777) && errno != EEXIST)
+				return -1;
+			if (adjust_shared_perm(dir.buf))
+				return -1;
+			strbuf_release(&dir);
+		}
+	}
+
 	if (mtime) {
 		struct utimbuf utb;
 		utb.actime = mtime;
-- 
2.34.0

