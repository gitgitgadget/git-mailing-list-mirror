From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 06/12] t4150: am --resolved fails if index has unmerged entries
Date: Tue,  7 Jul 2015 22:08:28 +0800
Message-ID: <1436278114-28057-7-git-send-email-pyokagan@gmail.com>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:09:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTYm-0005gv-Em
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757420AbbGGOJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:09:10 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33052 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757573AbbGGOJF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:09:05 -0400
Received: by pdbdz6 with SMTP id dz6so31801047pdb.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e8iomrk8M7FdKUKmO0Fta3O+jl4blLuRRYxOwWiBvnw=;
        b=IPVAb9zsOhSc+b+D+zHVqNwDLmUOyZCp8kO5HH5MHdlAyQrumZU5H5Zc86hbErQ82j
         CM6m6N6SIuZydCMeJLympe2Qx8fBWmbvLVjOKYe544T2m4/+G0chlOqcb6vrXji7LxoZ
         ltNywinSDlyfhdbtFcvqUDn2vXBeq1PGHMbz9+hRQAmU/13uB0FFnKZSO5fKu9+A3Pcf
         eQnsp4fvcI29oNykjlLnDkMwh6BXyLxSa790UXfze2kHzcP8a1vsIj7liu7yRIYGHXup
         Twc4YcfNnL+5E4WKAKOD4eZSYijKz+m9oTW6j6Sv10XrfOz4/oPGuJbCff/5ZdnuRVKH
         vFLw==
X-Received: by 10.66.141.109 with SMTP id rn13mr9136277pab.127.1436278145338;
        Tue, 07 Jul 2015 07:09:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.09.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:09:04 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273513>

Since c1d1128 (git-am --resolved: more usable error message.,
2006-04-28), git-am --resolved will check to see if there are any
unmerged entries, and will error out with a user-friendly error message
if there are.

Add a test for this.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 430ae71..c1ec4d5 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -437,6 +437,19 @@ test_expect_success 'am --resolved fails if index has no changes' '
 	test_cmp_rev lorem2^^ HEAD
 '
 
+test_expect_success 'am --resolved fails if index has unmerged entries' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout second &&
+	test_must_fail git am -3 lorem-move.patch &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev second HEAD &&
+	test_must_fail git am --resolved >err &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev second HEAD &&
+	test_i18ngrep "still have unmerged paths" err
+'
+
 test_expect_success 'am takes patches from a Pine mailbox' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.5.0.rc1.76.gf60a929
