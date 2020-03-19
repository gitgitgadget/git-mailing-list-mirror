Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD14C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 01:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BEF20767
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 01:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgCSBJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:09:53 -0400
Received: from sunset.tt-solutions.com ([82.240.17.225]:57731 "EHLO
        smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSBJx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 21:09:53 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2020 21:09:52 EDT
Received: from zeitlin by smtp.tt-solutions.com with local (Exim 4.92)
        (envelope-from <zeitlin@tt-solutions.com>)
        id 1jEjbw-00051D-M1; Thu, 19 Mar 2020 02:04:36 +0100
From:   Vadim Zeitlin <vz-git@zeitlins.org>
To:     git@vger.kernel.org
Cc:     Vadim Zeitlin <vz-git@zeitlins.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fetch: allow running as different users in shared repositories
Date:   Thu, 19 Mar 2020 02:03:22 +0100
Message-Id: <20200319010321.18614-1-vz-git@zeitlins.org>
X-Mailer: git-send-email 2.26.0.rc2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function fopen_for_writing(), which was added in 79d7582e32 (commit:
allow editing the commit message even in shared repos, 2016-01-06) and
used for overwriting FETCH_HEAD since ea56518dfe (Handle more file
writes correctly in shared repos, 2016-01-11), didn't do it correctly in
shared repositories under Linux.

This happened because in this situation the file FETCH_HEAD has mode 644
and attempting to overwrite it when running git-fetch under an account
different from the one that was had originally created it, failed with
EACCES, and not EPERM. However fopen_for_writing() only checked for the
latter, and not the former, so it didn't even try removing the existing
file and recreating it, as it was supposed to do.

Fix this by checking for either EACCES or EPERM. The latter doesn't seem
to be ever returned in a typical situation by open(2) under Linux, but
keep checking for it as it is presumably returned under some other
platform, although it's not really clear where does this happen.

Signed-off-by: Vadim Zeitlin <vz-git@zeitlins.org>
---
I couldn't find any system that would return EPERM for a "normal"
permissions denied error, so maybe it's not worth checking for it, but I
wanted to minimize the number of changes to the existing behaviour. At the
very least, testing for EACCES is definitely necessary under Linux, where
openat(2) returns it, and not EPERM, in the situation described above, i.e.
non-writable file (even if it's in a writable directory, allowing to unlink
it without problems).
---
 wrapper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index e1eaef2e16..f5607241da 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -373,11 +373,12 @@ FILE *fopen_for_writing(const char *path)
 {
 	FILE *ret = fopen(path, "w");
 
-	if (!ret && errno == EPERM) {
+	if (!ret && (errno == EACCES || errno == EPERM)) {
+		int open_error = errno;
 		if (!unlink(path))
 			ret = fopen(path, "w");
 		else
-			errno = EPERM;
+			errno = open_error;
 	}
 	return ret;
 }
-- 
2.26.0.rc2
