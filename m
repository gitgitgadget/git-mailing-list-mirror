Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7786C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbhKVQHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240061AbhKVQHX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:07:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D4EC06173E
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:04:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d5so33676936wrc.1
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/uNjImpgCBG6yE7nLwY1dKecRXjcFjah73romBbnIM=;
        b=FPgZ9G1+zYoFySL8XOvH2yC9cv+7Q2SpYQ4m0G4SXzuOvEVO72WZCiXdoT7+gSORfD
         vkhC30GQVziLE1v8UauHFgLU68j0pOSbS8GzajynsnzNlCc9sM/737GpsGEeOH/bfmva
         4N7eSeX0KCJXLZBsVD0WUdvjVJjVE7USotao1JIA0D/5+kvLPfSwzkNDVTrvXlVOTUAh
         V3JcDLqCOasFbTuzkvW+/u+AwKoPloAsj0fz9gDfrYyy6EVQp/UPzn7MIy1o9FJjDJOQ
         8MhmUw/QyD7IIL27sfE/kxaPNYF4bl4X39eNMFqXi+lmU6xmLmdWO0V0vw/I55smXPec
         T2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/uNjImpgCBG6yE7nLwY1dKecRXjcFjah73romBbnIM=;
        b=7UG9GMtaw7fC3vixP+TRaHLmoFHRv1Bx9/Dn+XlG9xMjmEZUFNMrv/dVmD8idHYCWu
         r3YVWpR4O45zlCfGhDOngfoa4CiyHaRRqDA3PZPNv0ZEeaH4HXkAotnrlqX50DQdHJB5
         lYlIXYw9ndRDOqWtgelgA06e16tAontNl/duHeTsDG0S4UQTTXchoutEbRVhaGeZiFNW
         Vn0TXqhm1bOu/+GqwJ3Rw/uDRA1bogkfit3hAgc5H3+hVqOPGm7SZgeqm1x9JsJqDHaG
         UZWZ9rVSfDRxnnuQy+GYZ3nhXTwUEjFg8xbgqJOo9vWOCZNIUk5ZMihw51VYguhbRS6F
         d/pA==
X-Gm-Message-State: AOAM533KCUOTTHYnxh9YMBmKbgjIK5sz15yc6C1FJhGXi01GrNPDP88K
        nUJ9EhOTa5MT38D67FcstV5c81KJdYzfaw==
X-Google-Smtp-Source: ABdhPJwerHY4Y1GG8CFNp7fxaajP0OnkUqUn73VybHn0y5JWSbSegPUxpRzSWSDHVpnpzVtJc2Z1YQ==
X-Received: by 2002:adf:d082:: with SMTP id y2mr38679240wrh.214.1637597055170;
        Mon, 22 Nov 2021 08:04:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm24005953wmc.43.2021.11.22.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 08:04:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] upload-archive: use regular "struct child_process" pattern
Date:   Mon, 22 Nov 2021 17:04:04 +0100
Message-Id: <patch-2.5-a411098699d-20211122T153605Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.822.gf3f912c366d
In-Reply-To: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net> <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This pattern added [1] in seems to have been intentional, but since
[2] and [3] we've wanted do initialization of what's now the "struct
strvec" "args" and "env_array" members. Let's not trample on that
initialization here.

1. 1bc01efed17 (upload-archive: use start_command instead of fork,
   2011-11-19)
2. c460c0ecdca (run-command: store an optional argv_array, 2014-05-15)
3. 9a583dc39e (run-command: add env_array, an optional argv_array for
   env, 2014-10-19)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/upload-archive.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 24654b4c9bf..b4b9b3a6262 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -77,7 +77,7 @@ static ssize_t process_input(int child_fd, int band)
 
 int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
-	struct child_process writer = { argv };
+	struct child_process writer = CHILD_PROCESS_INIT;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(upload_archive_usage);
@@ -92,6 +92,9 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 	argv[0] = "upload-archive--writer";
 	writer.out = writer.err = -1;
 	writer.git_cmd = 1;
+	strvec_push(&writer.args, "upload-archive--writer");
+	if (argc > 1)
+		strvec_pushv(&writer.args, &argv[1]);
 	if (start_command(&writer)) {
 		int err = errno;
 		packet_write_fmt(1, "NACK unable to spawn subprocess\n");
-- 
2.34.0.822.gb876f875f1b

