From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 3/8] t5520: test for failure if index has unresolved entries
Date: Mon, 18 May 2015 21:32:53 +0800
Message-ID: <1431955978-17890-4-git-send-email-pyokagan@gmail.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:34:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLBo-0001WL-DH
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbbERNec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:34:32 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34097 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbbERNd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:33:26 -0400
Received: by pdbnk13 with SMTP id nk13so54543645pdb.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qRiDTmVGg1ExAf9M4mTmmOCEQ8mToVS8aVmKv5hXOQ8=;
        b=oZ2Ym4JEaJ7cfCnGaXaQk3OF6GnFQc//gRY6de/R+9Wd0WNZNWmbcOEjYpgRRRcHdL
         e6hu7qvo6EKfJoRLzHwFqyVhDD3+xQ2goscP43s7aiS+N4konF/xyGkPXRbctMtdzoNB
         YSNF/8IP4yBBnFc0WQyWO2YJqGI5L+xGwD5ibFeOEebgauEtwT4Qav8Mmd7iUQwnzzUV
         ZVvgpSOe7/jr6+18j2CGFqaoZ+n7KLAXM30v1YoYERiVSVAtPZJcT6uut2jex4iJfANF
         zD3rY8YrlVBknk49OnjpmkJ24/fWmw2rr3pcP/olBeaapXYyLLPRM40UqZLhdf/qB45P
         555A==
X-Received: by 10.68.192.74 with SMTP id he10mr44088681pbc.30.1431956005485;
        Mon, 18 May 2015 06:33:25 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id da2sm10119540pbb.57.2015.05.18.06.33.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:33:23 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269242>

Commit d38a30d (Be more user-friendly when refusing to do something
because of conflict., 2010-01-12) introduced code paths to git-pull
which will error out with user-friendly advices if the user is in the
middle of a merge or has unmerged files.

Implement tests to ensure that git-pull will not run, and will print
these advices, if the user is in the middle of a merge or has unmerged
files in the index.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

* Use the stricter "Pull is not possible because you have unmerged files"
  instead of you have unmerged files" as git-merge will also raise a similar
  error "merge is not possible because you have unmerged files"

* Also, grep for "You have not concluded your merge" instead of "have not
  concluded your merge" as the latter reads weird to me personally.

 t/t5520-pull.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 4a2c0a1..3bc0594 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -164,6 +164,26 @@ test_expect_success 'fail if upstream branch does not exist' '
 	test "$(cat file)" = file
 '
 
+test_expect_success 'fail if the index has unresolved entries' '
+	git checkout -b third second^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	test "$(cat file)" = file &&
+	echo modified2 >file &&
+	git commit -a -m modified2 &&
+	test -z "$(git ls-files -u)" &&
+	test_must_fail git pull . second &&
+	test -n "$(git ls-files -u)" &&
+	cp file expected &&
+	test_must_fail git pull . second 2>err &&
+	test_i18ngrep "Pull is not possible because you have unmerged files" err &&
+	test_cmp expected file &&
+	git add file &&
+	test -z "$(git ls-files -u)" &&
+	test_must_fail git pull . second 2>err &&
+	test_i18ngrep "You have not concluded your merge" err &&
+	test_cmp expected file
+'
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
