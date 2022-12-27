Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF263C4332F
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 14:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiL0OcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 09:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0OcL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 09:32:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA4281
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 06:32:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id x22so32257854ejs.11
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 06:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qe7oFgpCmwjeG9MnvH4DLB/rRTHeE65dFFxF0EgJipQ=;
        b=eDjLp01QxDzBcX/sCCw0+dWltvCbUT2F8qsilow50v2pV8OF6P1OEfR5pQ4TKjCpov
         EEjIICjH4ARLsBW/pz3+iVCu341gmhu3mRQd4oTej7B3JBkvS6GdFgUpUwbUMiEtNwlF
         v2lmGePjkS493dV+vEclv6GKFhPQl42ac+J2Fd3gsdposHhTZUMR+h/bDVBQ31MCWXtk
         yo+1tq1hnaxUaQPvVqyubwvqz/2EixTfbLzIf0MuzkIKE94dncb8SXqMlm+ySWOtGofw
         x1/OU+tueo2n/1HjSVpndG7AdPV42KyZNNzmge4xZEzplSybajl53U5uxLwIdivjZXhi
         EuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qe7oFgpCmwjeG9MnvH4DLB/rRTHeE65dFFxF0EgJipQ=;
        b=q8yL8TEmPJW0UyJTfVZjP0d4fnPW5/tAvWlZKeYNFCKnJjPAOwbUuf3DjIcx07JIce
         ytY/St969eheD62pGkwAv72UgiHLkRdWOVkIJht1Vb3KXCDoNgkFi9GtcfbUXSWIMzvK
         4GQ22G4eZP4H5myjHrNKGaWWpRrlW9vmVlgnj0ZNmrpTz67wya9YhMhdVXrA1Ow6fliL
         wKj0QGW/IjrmKT0Z5pO/8a+hGC1wUmdvG5WQPbSyGtKK8ptLaJPipTlZtxMbHrK0Zzl7
         VUU8dcA0jaCtiPilJWm4+zAjjxt70Hg5rHG/prZNJkeAONvkYE+iIZleHpJ3ACgTGGOu
         OlCA==
X-Gm-Message-State: AFqh2kqFNdUDRDVlyVbkCQVNae9sXZjm79PXdZMFPvxRddCTG9ubssCY
        7d6UvVBOVnhLdBdrIwbi5GD2wuDnYP8/RQ==
X-Google-Smtp-Source: AMrXdXtSNg2wf/FKsqSvCN5rcvcCSMBrU0Hoo3dcaGg83ziW7zIoVwcqzabDHD2g/oOfFsUW5O4N9g==
X-Received: by 2002:a17:907:d311:b0:829:5e3f:3c92 with SMTP id vg17-20020a170907d31100b008295e3f3c92mr26037018ejc.73.1672151528849;
        Tue, 27 Dec 2022 06:32:08 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-119-040-067.95.119.pool.telefonica.de. [95.119.40.67])
        by smtp.gmail.com with ESMTPSA id t19-20020a170906609300b007bf71053d97sm6118967ejj.40.2022.12.27.06.32.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:32:08 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH v2] setup: avoid unconditional open syscall with write flags
Date:   Tue, 27 Dec 2022 15:32:00 +0100
Message-Id: <20221227143200.1182341-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 57f5d52a942 ("common-main: call sanitize_stdfds()") added the
sanitization for standard file descriptors (stdin, stdout, stderr) to
all binaries.  The lead to all binaries unconditionally opening
/dev/null with the flag O_RDWR (read and write).  Most of the time the
standard file descriptors should be set up properly and the sanitization
ends up doing nothing.

There are many git operations, like `git status` or `git stash list`,
which might be called by a parent to gather information about the
repository and should work on a read-only repository.  That parent might
run under a seccomp filter to avoid accidental modification or unwanted
command execution on memory corruptions.  As part of that seccomp filter
open(2) and openat(2) might be only allowed in read-only mode
(O_RDONLY), thus preventing git's sanitation and stopping the
application.

Check the need of sanitization with a file descriptor in read-only mode,
keep it as replacement for stdin and open replacement file descriptors
for stdout and stderr in write-only mode.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---

v2:
  - switch to xopen("/dev/null", O_RDONLY) to stay at 2 syscalls in the
    common case and use O_WRONLY for stdout and stderr, as suggested
    by René Scharfe
---
 setup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index cefd5f6..c57582b 100644
--- a/setup.c
+++ b/setup.c
@@ -1669,7 +1669,15 @@ const char *resolve_gitdir_gently(const char *suspect, int *return_error_code)
 /* if any standard file descriptor is missing open it to /dev/null */
 void sanitize_stdfds(void)
 {
-	int fd = xopen("/dev/null", O_RDWR);
+	int fd;
+
+	fd = xopen("/dev/null", O_RDONLY);
+	if (fd > 0)
+		close(fd);
+	if (fd > 2)
+		return;
+
+	fd = xopen("/dev/null", O_WRONLY);
 	while (fd < 2)
 		fd = xdup(fd);
 	if (fd > 2)
-- 
2.39.0

