From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/2] t3310: Add testcase demonstrating failure to --commit from within another dir
Date: Mon, 12 Mar 2012 15:47:26 +0100
Message-ID: <1331563647-1909-1-git-send-email-johan@herland.net>
References: <1319438176-7304-3-git-send-email-pclouds@gmail.com>
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	david@tethera.net, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 15:48:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76Xd-0005e7-Vq
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 15:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab2CLOsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 10:48:00 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42750 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab2CLOr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 10:47:59 -0400
Received: by wibhj6 with SMTP id hj6so3829283wib.1
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 07:47:58 -0700 (PDT)
Received: by 10.180.95.129 with SMTP id dk1mr14458052wib.3.1331563678307;
        Mon, 12 Mar 2012 07:47:58 -0700 (PDT)
Received: from gamma.cisco.com (64-103-25-233.cisco.com. [64.103.25.233])
        by mx.google.com with ESMTPS id o2sm36130055wiv.11.2012.03.12.07.47.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 07:47:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.2
In-Reply-To: <1319438176-7304-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192868>

Found-by: David Bremner <david@tethera.net>
Signed-off-by: Johan Herland <johan@herland.net>
---

This is a transcription of David's test script into a git test case.

Thanks to David for finding this issue.


Have fun! :)

...Johan

 t/t3310-notes-merge-manual-resolve.sh |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 4367197..0c531c3 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -553,4 +553,23 @@ test_expect_success 'resolve situation by aborting the notes merge' '
 	verify_notes z
 '

+cat >expect_notes <<EOF
+foo
+bar
+EOF
+
+test_expect_failure 'switch cwd before committing notes merge' '
+	git notes add -m foo HEAD &&
+	git notes --ref=other add -m bar HEAD &&
+	test_must_fail git notes merge refs/notes/other &&
+	(
+		cd .git/NOTES_MERGE_WORKTREE &&
+		echo "foo" > $(git rev-parse HEAD) &&
+		echo "bar" >> $(git rev-parse HEAD) &&
+		git notes merge --commit
+	) &&
+	git notes show HEAD > actual_notes &&
+	test_cmp expect_notes actual_notes
+'
+
 test_done
--
1.7.9.2
