From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 5/8] t5520: test --rebase with multiple branches
Date: Mon, 18 May 2015 21:32:55 +0800
Message-ID: <1431955978-17890-6-git-send-email-pyokagan@gmail.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:33:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLAz-0001A5-FH
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbbERNdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:33:41 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34347 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbbERNdc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:33:32 -0400
Received: by pdbnk13 with SMTP id nk13so54547839pdb.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hRU2+Of5nEXpa+WmNwG33HavhCmZDJsnldD3ZUe5kWM=;
        b=J5wt29Mp3BUaEwTcVnIjhjEPqQjOKegdfjndyGE9uj1/sl+UrpVUChjC20kdty6hIk
         AiUdOhoZ4RFv0AL0eR0XxBdx8MRXjkxW0felEmGGjsV3+lyamt5ANNSN6HGKyb5rdX6k
         HYuW9hKPKCYvOvQbtT7Ay4riszhVtJeQb93EBiWElaNKq+NcLRR6vCvgfnIOMJYMCAYm
         P1hFSP7KAyRYjHYvD2edRCdkb0j6C0KZoNV913flQvWod6Gz9S3BL368qVwKwXVd0JWz
         tT/tKPOwPi4Nd/M1T+h1u+naAzqQH5vh+TX3eCYF3qzHR5/sphJk7cOKoKF/A136Y5Vt
         m/nQ==
X-Received: by 10.70.118.5 with SMTP id ki5mr44802871pdb.6.1431956012011;
        Mon, 18 May 2015 06:33:32 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id da2sm10119540pbb.57.2015.05.18.06.33.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:33:30 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269241>

Since rebasing on top of multiple upstream branches does not make sense,
since 51b2ead (disallow providing multiple upstream branches to rebase,
pull --rebase, 2009-02-18), git-pull explicitly disallowed specifying
multiple branches in the rebase case.

Implement tests to ensure that git-pull fails and prints out the
user-friendly error message in such a case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
* Removed use of "verbose".

 t/t5520-pull.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 3a53a5e..f991439 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -218,6 +218,15 @@ test_expect_success '--rebase' '
 	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
 	test new = "$(git show HEAD:file2)"
 '
+
+test_expect_success '--rebase fails with multiple branches' '
+	git reset --hard before-rebase &&
+	test_must_fail git pull --rebase . copy master 2>err &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
+	test_i18ngrep "Cannot rebase onto multiple branches" err &&
+	test modified = "$(git show HEAD:file)"
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.1.4
