From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 4/4] rebase -i: Add tests for "--edit-todo"
Date: Mon, 17 Sep 2012 21:28:10 -0400
Message-ID: <1347931690-20625-5-git-send-email-andrew.kw.w@gmail.com>
References: <CANiSa6j2zA5P6yDaR7VU416Bzes6xbWuHbU83=BGN67Wo9j_Cw@mail.gmail.com>
 <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 04:29:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDnZT-0002lx-LS
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 04:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390Ab2IRC3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 22:29:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35308 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab2IRC3i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 22:29:38 -0400
Received: by mail-yw0-f46.google.com with SMTP id m54so1696069yhm.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 19:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6je5CREpRh3Jz6vNs6x7F4KvpAsHYoAVF/rqPAP0Jus=;
        b=fPFIj2LL8TsJSN14zrmeZt7rBY8esPCyKXwieprabf2UixGSbpN8BDqI66MIhGMYll
         iaNZX2JmurWTLiUfkCdNWcl0I/zjI9FKMWkMzgkX1HbTd+kEJif7o83mVYCbM5Y25OXt
         6EsqCAY8fJEFPFi789R6CaebTiNcWD/C9qJSKGe9ovbnYU3AaIg21OPlUHcbpscwlRIA
         MS/9iKnzUAW0FEnFGsZ2QcKeYCkPkwhrNkdUklyjGYSVrasA/8pxY1ULtrpUXp10xgmP
         USJP87yCqHavwaILgBt+oaqtj8T8HTySovcAOmuvQoFuUfN/MGFhpDPnLltgFkmjKkaI
         zFjg==
Received: by 10.236.153.39 with SMTP id e27mr13800960yhk.130.1347935378409;
        Mon, 17 Sep 2012 19:29:38 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id s12sm11226868anh.2.2012.09.17.19.29.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 19:29:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.318.g79683ba.dirty
In-Reply-To: <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205782>

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7304b66..6eafb63 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -911,4 +911,22 @@ test_expect_success 'rebase -i --root fixup root commit' '
 	test 0 = $(git cat-file commit HEAD | grep -c ^parent\ )
 '
 
+test_expect_success 'rebase --edit-todo does not works on non-interactive rebase' '
+	git reset --hard &&
+	git checkout conflict-branch &&
+	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
+	test_must_fail git rebase --edit-todo &&
+	git rebase --abort
+'
+
+test_expect_success 'rebase --edit-todo can be used to modify todo' '
+	git reset --hard &&
+	git checkout no-conflict-branch^0 &&
+	FAKE_LINES="edit 1 2 3" git rebase -i HEAD~3 &&
+	FAKE_LINES="2 1" git rebase --edit-todo &&
+	git rebase --continue
+	test M = $(git cat-file commit HEAD^ | sed -ne \$p) &&
+	test L = $(git cat-file commit HEAD | sed -ne \$p)
+'
+
 test_done
-- 
1.7.12.318.g79683ba.dirty
