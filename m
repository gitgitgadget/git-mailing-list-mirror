Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C9AC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 06:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD706138F
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 06:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhJEG4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 02:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhJEG4v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 02:56:51 -0400
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233DCC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 23:55:01 -0700 (PDT)
Received: from [2400:4160:1877:2b00:410a:fd15:2718:8b5d] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1mXeLo-0004bz-9O; Tue, 05 Oct 2021 06:54:57 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <glandium@goemon>)
        id 1mXe78-002TCA-Fx; Tue, 05 Oct 2021 15:39:46 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Mike Hommey <mh@glandium.org>
Subject: [PATCH] Use mingw.h declarations for gmtime_r/localtime_r on msys2
Date:   Tue,  5 Oct 2021 15:39:36 +0900
Message-Id: <20211005063936.588874-1-mh@glandium.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Older versions of msys2 had _POSIX_THREAD_SAFE_FUNCTIONS set in
pthread_unistd.h, included from unistd.h. That would enable the
declarations for gmtime_r and localtime_r in time.h.

That's not the case anymore, and gmtime_r and localtime_r end up
being undeclared, which subsequently leads to "miscompilations", for
example, in datestamp(), where the result of localtime_r would be
truncated and sign-extended before being passed to tm_to_time_t, leading
to segfaults at runtime.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 compat/mingw.h | 2 --
 1 file changed, 2 deletions(-)

A possible alternative fix would be to e.g. add `#define _POSIX_C_SOURCE
200112L` to git-compat-util.h and add `ifndef __MINGW64_VERSION_MAJOR`
around the definitions of `gmtime_r` and `localtime_r` in
compat/mingw.c, since, after all, they are available there.

diff --git a/compat/mingw.h b/compat/mingw.h
index c9a52ad64a..4fd989980c 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -204,10 +204,8 @@ int pipe(int filedes[2]);
 unsigned int sleep (unsigned int seconds);
 int mkstemp(char *template);
 int gettimeofday(struct timeval *tv, void *tz);
-#ifndef __MINGW64_VERSION_MAJOR
 struct tm *gmtime_r(const time_t *timep, struct tm *result);
 struct tm *localtime_r(const time_t *timep, struct tm *result);
-#endif
 int getpagesize(void);	/* defined in MinGW's libgcc.a */
 struct passwd *getpwuid(uid_t uid);
 int setitimer(int type, struct itimerval *in, struct itimerval *out);
-- 
2.33.0

