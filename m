Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF49C77B7C
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 00:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbjDZAtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 20:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238520AbjDZAtS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 20:49:18 -0400
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D4B19A6E
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 17:49:11 -0700 (PDT)
Received: from [2400:4160:1877:2b00:19b6:5a5d:912f:bb56] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <glandium@glandium.org>)
        id 1prTLG-002l10-2k;
        Wed, 26 Apr 2023 00:49:07 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <glandium@goemon>)
        id 1prTLA-00EENX-FM; Wed, 26 Apr 2023 09:49:00 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Mike Hommey <mh@glandium.org>
Subject: [PATCH] Handle some compiler versions containing a dash
Date:   Wed, 26 Apr 2023 09:48:43 +0900
Message-Id: <20230426004843.3391826-1-mh@glandium.org>
X-Mailer: git-send-email 2.40.0.1.gc689dad23e
In-Reply-To: <xmqqo7nd9cy7.fsf@gitster.g>
References: <xmqqo7nd9cy7.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The version reported by e.g. x86_64-w64-mingw32-gcc on Debian bullseye
looks like:
  gcc version 10-win32 20210110 (GCC)

This ends up with detect-compiler failing with:
  ./detect-compiler: 30: test: Illegal number: 10-win32

This change removes the two known suffixes known to exist in GCC versions
in Debian: -win32 and -posix.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 detect-compiler | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/detect-compiler b/detect-compiler
index 50087f5670..a87650b71b 100755
--- a/detect-compiler
+++ b/detect-compiler
@@ -17,7 +17,15 @@ get_family() {
 }
 
 get_version() {
-	get_version_line | sed 's/^.* version \([0-9][^ ]*\).*/\1/'
+	# A string that begins with a digit up to the next SP
+	ver=$(get_version_line | sed 's/^.* version \([0-9][^ ]*\).*/\1/')
+
+	# There are known -variant suffixes that do not affect the
+	# meaning of the main version number.  Strip them.
+	ver=${ver%-win32}
+	ver=${ver%-posix}
+
+	echo "$ver"
 }
 
 print_flags() {
-- 
2.40.0.1.gc689dad23e

