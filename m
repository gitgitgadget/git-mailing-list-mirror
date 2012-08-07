From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 2/2] prune.c: only print informational message in show_only or verbose mode
Date: Mon,  6 Aug 2012 22:01:49 -0700
Message-ID: <1344315709-15897-2-git-send-email-drafnel@gmail.com>
References: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
 <1344315709-15897-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 07 07:02:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SybwS-000708-FH
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 07:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274Ab2HGFCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 01:02:49 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51899 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab2HGFCN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 01:02:13 -0400
Received: by pbbrr13 with SMTP id rr13so3707051pbb.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 22:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lr6WpTxoXfDmJFg/yeBPIvAhfBtdbTnnUF6hLDNYUbk=;
        b=IdEh1FYH6ZxLZqf6sMwpBjrfdznEyxrsS3qXmVRUNmMBQ49nE7nRE8jrPCXuRdNge9
         LONM1OCDaaEPrhdFED7XAuFeanGF+k/k13r0Le4O0P3pZhH+3B5cnZHqqbXB68WtEmY4
         rTCUWtB+3T7SxcMVoeZx6/d0PHdhjw5k+zXWHnPRtF7GSepPvsO3G00Yz5SpyOy2Dmhc
         m0mqTdmKYgCv5zp57zHDu0Y/5upj81znBxSXqc4TBwSU1YzDvXmnUMj4Jh/cmltHAy1i
         5AqbM/d839WNttFUz/juIDHHJcdsumXUYHsUXCQQ6NHuDYIp+o/RqOLGyXnWh7xwUGQx
         XJYQ==
Received: by 10.68.231.67 with SMTP id te3mr3487490pbc.134.1344315733078;
        Mon, 06 Aug 2012 22:02:13 -0700 (PDT)
Received: from charliebrown.gateway.2wire.net (adsl-108-91-67-189.dsl.pltn13.sbcglobal.net. [108.91.67.189])
        by mx.google.com with ESMTPS id px1sm10375777pbb.49.2012.08.06.22.02.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Aug 2012 22:02:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1.17.g9a7365c
In-Reply-To: <1344315709-15897-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203013>

This informational message can cause a problem if 'git prune' is spawned
from an auto-gc during receive-pack.  In this case, the informational
message will be sent back over the wire to the git client and the client
will try to interpret it as part of the pack protocol and will produce an
error.

So let's refrain from producing this message unless show_only or verbose
is enabled.

This fixes the test in t5400.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin/prune.c      | 3 ++-
 t/t5400-send-pack.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index b99b635..6cb9944 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -25,7 +25,8 @@ static int prune_tmp_object(const char *path, const char *filename)
 		return error("Could not stat '%s'", fullpath);
 	if (st.st_mtime > expire)
 		return 0;
-	printf("Removing stale temporary file %s\n", fullpath);
+	if (show_only || verbose)
+		printf("Removing stale temporary file %s\n", fullpath);
 	if (!show_only)
 		unlink_or_warn(fullpath);
 	return 0;
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 04a8791..250c720 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -145,7 +145,7 @@ test_expect_success 'push --all excludes remote-tracking hierarchy' '
 	)
 '
 
-test_expect_failure 'receive-pack runs auto-gc in remote repo' '
+test_expect_success 'receive-pack runs auto-gc in remote repo' '
 	rm -rf parent child &&
 	git init parent &&
 	(
-- 
1.7.12.rc1.17.g9a7365c
