Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507C5C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbiHQGF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiHQGF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:05:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E326C75C
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:05:26 -0700 (PDT)
Received: (qmail 6592 invoked by uid 109); 17 Aug 2022 06:05:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Aug 2022 06:05:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13702 invoked by uid 111); 17 Aug 2022 06:05:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Aug 2022 02:05:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Aug 2022 02:05:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 2/6] nonblock: support Windows
Message-ID: <YvyFJcqyBGXMtoxZ@coredump.intra.peff.net>
References: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

Implement enable_pipe_nonblock() using the Windows API. This works only
for pipes, but that is sufficient for this limited interface. Despite
the API calls used, it handles both "named" and anonymous pipes from our
pipe() emulation.

Signed-off-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 compat/nonblock.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/compat/nonblock.c b/compat/nonblock.c
index b08105a21d..9694ebdb1d 100644
--- a/compat/nonblock.c
+++ b/compat/nonblock.c
@@ -12,6 +12,33 @@ int enable_pipe_nonblock(int fd)
 	return fcntl(fd, F_SETFL, flags);
 }
 
+#elif defined(GIT_WINDOWS_NATIVE)
+
+#include "win32.h"
+
+int enable_pipe_nonblock(int fd)
+{
+	HANDLE h = (HANDLE)_get_osfhandle(fd);
+	DWORD mode;
+	DWORD type = GetFileType(h);
+	if (type == FILE_TYPE_UNKNOWN && GetLastError() != NO_ERROR) {
+		errno = EBADF;
+		return -1;
+	}
+	if (type != FILE_TYPE_PIPE)
+		BUG("unsupported file type: %lu", type);
+	if (!GetNamedPipeHandleState(h, &mode, NULL, NULL, NULL, NULL, 0)) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+	mode |= PIPE_NOWAIT;
+	if (!SetNamedPipeHandleState(h, &mode, NULL, NULL)) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+	return 0;
+}
+
 #else
 
 int enable_pipe_nonblock(int fd)
-- 
2.37.2.881.gb57357660c

