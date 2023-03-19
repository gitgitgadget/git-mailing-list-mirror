Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E191C7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCSGxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCSGxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:53:16 -0400
X-Greylist: delayed 546 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Mar 2023 23:53:14 PDT
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84ED206B3
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:53:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id C6EB316006A
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:44:16 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 02a5hMAfVb9T; Sat, 18 Mar 2023 23:44:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id E0E84160054;
        Sat, 18 Mar 2023 23:44:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.9.2 zimbra.cs.ucla.edu E0E84160054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=78364E5A-2AF3-11ED-87FA-8298ECA2D365; t=1679208255;
        bh=rzit9Do7A7WxrlLM+e6ILmwozG7oCg8MsY8OonRAJj8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=cvmq/wJUR7oNBkextWZ+5j8xul/Q032ZhbICAvU3RZeJGBd5FJd6yZhbBErO3b8Wz
         gWZksrWg3TGrjAnxU8tTZhSqbuW2rdsN4Dalb6GsMGB44uJLiX4QcJsK/EjRDXjF5y
         OZXEQmXcAnkCJ+6rox14/lEELHyRNKh/4QVPDuQA=
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O37ExH3DymmP; Sat, 18 Mar 2023 23:44:15 -0700 (PDT)
Received: from penguin.cs.ucla.edu (Penguin.CS.UCLA.EDU [131.179.64.200])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 9ECBD160045;
        Sat, 18 Mar 2023 23:44:15 -0700 (PDT)
From:   Paul Eggert <eggert@cs.ucla.edu>
To:     git@vger.kernel.org
Cc:     Paul Eggert <eggert@cs.ucla.edu>
Subject: [PATCH 2/2] git-compat-util: use gettimeofday for current time
Date:   Sat, 18 Mar 2023 23:43:53 -0700
Message-Id: <20230319064353.686226-3-eggert@cs.ucla.edu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230319064353.686226-1-eggert@cs.ucla.edu>
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use gettimeofday instead of time(NULL) to get current time.
This avoids clock skew on glibc 2.31+ on Linux, where in the
first 1 to 2.5 ms of every second, time(NULL) returns a
value that is one less than the tv_sec part of
higher-resolution timestamps such as those returned by
gettimeofday or timespec_get, or those in the file system.
There are similar clock skew problems on AIX and MS-Windows,
which have problems in the first 5 ms of every second.

Without this patch, users can observe Git issuing a
timestamp T+1 before it issues timestamp T, because Git
sometimes uses time(NULL) or time(&t) and sometimes uses
higher-res methods like gettimeofday.  Although strictly
speaking users should tolerate this behavuior because a
superuser can always change the clock back, this is a
quality of implementation issue and users naturally expect
Git to issue timestamps in increasing order unless the
superuser has fiddled with the system clock.

This patch always uses gettimeofday(...) instead of time(...),
and I have verified that the resulting .o files never refer
to the name 'time'.  A trickier patch would change only
those calls for which timestamp monotonicity is user-visible.
Such a patch would require more expertise about Git internals,
though, and would be harder to maintain later.

Another possibility would be to change Git's documentation
to warn users that Git does not always issue timestamps in
increasing order.  However, Git users would likely be either
dismayed by this possibility, or confused by the level of
detail that any such documentation would require.

Yet another possibility would be to fix the Linux kernel so
that the time syscall is consistent with the other timestamp
syscalls.  I suppose this has not been done due to
performance implications.  (Git's use of timestamps is rare
enough that performance is not a significant consideration
for git.)  However, this wouldn't fix Git's problem on older
Linux kernels, or on AIX or MS-Windows.

Signed-off-by: Paul Eggert <eggert@cs.ucla.edu>
---
 git-compat-util.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index d05f4bac22..dcd9e5ca65 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -341,7 +341,10 @@ int compat_mkdir_wo_trailing_slash(const char*, mode=
_t);
=20
 static inline time_t time_now(void)
 {
-	return time(NULL);
+	/* Avoid time(NULL), which can disagree with gettimeofday etc.  */
+	struct timeval tv;
+	gettimeofday(&tv, NULL);
+	return tv.tv_sec;
 }
=20
 #ifdef NO_STRUCT_ITIMERVAL
--=20
2.39.2

