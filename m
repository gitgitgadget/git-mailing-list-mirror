From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetools/meld: do not rely on the output of `meld --help`
Date: Wed, 15 Oct 2014 01:30:48 -0700
Message-ID: <1413361848-16923-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Andrey Novoseltsev <novoselt@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 10:31:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeJyz-00028Q-Dr
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 10:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbaJOIam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 04:30:42 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:47521 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbaJOIa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 04:30:27 -0400
Received: by mail-pd0-f178.google.com with SMTP id y10so846703pdj.37
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wj7K7w4P3IUZDY7o7uk3XPMO/HMEWV7CRUHbq+SfKHM=;
        b=xiKXlAgIUA5Fuw5NNG9Or9Zx67U2s1wuNagTyv3wzqIG/ylvKRwKB2GEXdrTf0gzB/
         gjcAPu+cpW5KyIZM0fJ96Pm4mPxpBSx/RRjWZZZdAJIOwgnDb6udF5fsbCdKQtrNqzYu
         iXDkHLPgXOvQMEhpy8gaGK0hFRWXlxzBX2KSTvK+pyO+ISkWeJC8If5kXC0IOzhUQaUX
         w+7veDJxntL1h8QQoMeD6FaqX/q6S0dOkkAHkcOTFQXwReoCWM9BSzlHDqTOd1LB+Ol5
         k/a+wPCRsiTqWfxIvq425uQ7+Ofi37OTAQdRLXrXSbTEXU8wORGNRtWNd9S9bKWJKmZ1
         D9jg==
X-Received: by 10.68.140.203 with SMTP id ri11mr90290pbb.169.1413361826341;
        Wed, 15 Oct 2014 01:30:26 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id yt3sm16333695pbc.34.2014.10.15.01.30.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Oct 2014 01:30:25 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.453.g1b015e3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We cannot rely on the output of `meld --help` when determining
whether or not meld understands the --output option.

Newer versions of meld print a generic help message that does not
mention --output even though it is supported.

Add a mergetool.meld.compat variable to enable the historical
behavior and make the --output mode the default.

Reported-by: Andrey Novoseltsev <novoselt@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/config.txt | 7 +++++++
 mergetools/meld          | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 04a1e2f..a942bfe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1755,6 +1755,13 @@ mergetool.<tool>.trustExitCode::
 	if the file has been updated, otherwise the user is prompted to
 	indicate the success of the merge.
 
+mergetool.meld.compat::
+	Git passes the `--output` option to `meld` by default when
+	using the `meld` merge tool.  Older versions of `meld` do not
+	understand the `--output` option.  Set `mergetool.meld.compat`
+	to `true` if your version of `meld` is older and does not
+	understand the `--output` option.  Defaults to false.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
diff --git a/mergetools/meld b/mergetools/meld
index cb672a5..9e2b8d2 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -18,12 +18,12 @@ merge_cmd () {
 	check_unchanged
 }
 
-# Check whether 'meld --output <file>' is supported
+# Use 'meld --output <file>' unless mergetool.meld.compat is true.
 check_meld_for_output_version () {
 	meld_path="$(git config mergetool.meld.path)"
 	meld_path="${meld_path:-meld}"
 
-	if "$meld_path" --help 2>&1 | grep -e --output >/dev/null
+	if test "$(git config --bool mergetool.meld.compat)" != true
 	then
 		meld_has_output_option=true
 	else
-- 
2.1.2.453.g1b015e3
