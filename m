From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 2/3] t7502-commit: add summary output tests for empty and merge commits
Date: Thu, 27 May 2010 23:34:51 +0800
Message-ID: <1274974492-4692-3-git-send-email-rctay89@gmail.com>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
 <1274974492-4692-1-git-send-email-rctay89@gmail.com>
 <1274974492-4692-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 27 17:41:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHfD7-0003tj-CD
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759151Ab0E0PlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 11:41:23 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49773 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757942Ab0E0PlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 11:41:22 -0400
Received: by pwi7 with SMTP id 7so79437pwi.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TBRv2M8oNTtbwse3oAz4ccZ+Scn+ouqB/nBy/ImOkZU=;
        b=io+j/0EwrtTxBRXnEFqiHFSdib8I1FbsoBvoFIaKUI0Qo4Zig7veBvzx0tof1KmMjx
         QQeWJ9qOY7TB9PxwhK3Vg0K/6POz87znKjPqXVzrIOmEhAI5AmiL9UaJzeAYJgwIngSu
         68HaiJZuaqJ/1Qt9CdqSQz3BVHSTXKM+9MiaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uirC87KIzEJL/hX48GxD5MmcJiwcB56OjcKJlbRpQ3uztMWrZjQ085E4Rmw2IuRRZF
         xDj5dfZ7yYI/RFOpCxm2UCQSqPQj+cr44ItE9GMdbVcuNtAbkwr7hMsSw3/CWipUvSPT
         jbSE2zbUkh7eldSAoQZibVtx+QD/LhmqicccM=
Received: by 10.115.39.24 with SMTP id r24mr9173104waj.166.1274974526263;
        Thu, 27 May 2010 08:35:26 -0700 (PDT)
Received: from localhost.localdomain (cm218.zeta152.maxonline.com.sg [116.87.152.218])
        by mx.google.com with ESMTPS id r20sm11007341wam.5.2010.05.27.08.35.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 08:35:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.352.g12d15
In-Reply-To: <1274974492-4692-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147882>

After c197702 (pretty: Respect --abbrev option), non-abbreviated hashes
began to appear, leading to failures for these tests.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changes from v1:
 - changed shell syntax in check_summary_oneline(), based on Junio's
   suggestion.

 t/t7502-commit.sh |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 478b637..b10541d 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -4,10 +4,10 @@ test_description='git commit porcelain-ish'

 . ./test-lib.sh

-# Arguments: [<prefix] [<commit message>]
+# Arguments: [<prefix] [<commit message>] [<commit options>]
 check_summary_oneline() {
 	test_tick &&
-	git commit -m "$2" | head -1 > act &&
+	git commit ${3+"$3"} -m "$2" | head -1 > act &&

 	# branch name
 	SUMMARY_PREFIX="$(git name-rev --name-only HEAD)" &&
@@ -36,6 +36,31 @@ test_expect_success 'output summary format' '
 	check_summary_oneline "" "a change"
 '

+test_expect_failure 'output summary format for commit with an empty diff' '
+
+	check_summary_oneline "" "empty" "--allow-empty"
+'
+
+test_expect_failure 'output summary format for merges' '
+
+	git checkout -b recursive-base &&
+	test_commit base file1 &&
+
+	git checkout -b recursive-a recursive-base &&
+	test_commit commit-a file1 &&
+
+	git checkout -b recursive-b recursive-base &&
+	test_commit commit-b file1 &&
+
+	# conflict
+	git checkout recursive-a &&
+	test_must_fail git merge recursive-b &&
+	# resolve the conflict
+	echo commit-a > file1 &&
+	git add file1 &&
+	check_summary_oneline "" "Merge"
+'
+
 output_tests_cleanup() {
 	# this is needed for "do not fire editor in the presence of conflicts"
 	git checkout master &&
--
1.7.1.189.g07419
