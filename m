Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BB5C433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 03:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbhKVDi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 22:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbhKVDiY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 22:38:24 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4A5C06173E
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 19:35:18 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r5so14107895pgi.6
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 19:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eoJD98ActQCd6tZ193h7uST8rpSJE/3fPERzh6Kl9h8=;
        b=PpwbX6FId6HCaWnFI1NfXRmsuTVP/oasLwRJZFF/jeqFfFCd9ZVPmC0j/xdz+ywpjv
         ENiO0wF7rpzZ2GRU+fx+77R3Ovs+yWVPUdblOreFNCVMsvqhL35ptunZzJO505fDvisP
         knaMqOJH93t8iDV58LTeeTGYi4Ma2FOMNewu6egncZTbolG92qznjFb44NXLSaLzUw0z
         ASKN2bnZvPoVSKEmjFIpyxeyh/GDyF8dXQ+PGlyX8T+G/5Myh2m4RWmXxQ8+g7HTXBsZ
         AQJyIVcXtxV6J9n83vhIGakSohCyeuDDXVSNbTi0IVxBBghe1sZxZmeQ+Z7jtw3K1Izf
         RcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoJD98ActQCd6tZ193h7uST8rpSJE/3fPERzh6Kl9h8=;
        b=7nT+PGnR39QSavpa7YZ10tAbtvKlpdVWvOv4zo5IzScHgW09PTEIJTGN9lXFa1uA+Q
         MNlQOMnL6ETXhSCFLUB92l0T1Z01N5Ho/iDSqknQ+n4TQr9VGZxhXO8dGvwQKc1OHgo/
         IOiFhgax3Tw37V1ODerQcSPj6+0uZKfLpFq/pk8AzrReh1INz5uejC858SnUfPW9F5FZ
         8NNhYFFM9JvQHh/bcKZJSJMGrCp0N8Gwz4nAAdoJHqqgwxKUpBj7SjAj+O18Pw1ZypDl
         z7ehILgZ7yf7rAWR6YnQ2WL6ZH7CC5p+VcUW2fihYitDPpE+ny5BqYuppXP7LFCqfvaj
         i9gQ==
X-Gm-Message-State: AOAM532eIcPTr6UaxfhhFkhdmH0+VslFkfMfggECCBYlio3JesAPY0Sz
        EXUknlG+dUvvvzMitl7NZd8=
X-Google-Smtp-Source: ABdhPJyrGx7/Y/rMwi9MlrGWVV1VoJSuZRnLOAr9uV+J0TWimlYr+20ibJDqjnwPT6ctvNdobQ7yjQ==
X-Received: by 2002:a63:88c2:: with SMTP id l185mr30980737pgd.168.1637552118401;
        Sun, 21 Nov 2021 19:35:18 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id q11sm1235714pgt.54.2021.11.21.19.35.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Nov 2021 19:35:18 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v3 2/5] object-file.c: handle undetermined oid in write_loose_object()
Date:   Mon, 22 Nov 2021 11:32:17 +0800
Message-Id: <20211122033220.32883-3-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0.6.g676eedc724
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
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
index 227f53a0de..78fd2a5d39 100644
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
2.34.0.6.g676eedc724

