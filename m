From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 35/44] builtin-am: invoke pre-applypatch hook
Date: Sun, 28 Jun 2015 22:05:57 +0800
Message-ID: <1435500366-31700-36-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:09:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGb-0002vi-Lu
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbbF1OJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:09:02 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33666 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbbF1OId (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:33 -0400
Received: by pdjn11 with SMTP id n11so101609330pdj.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AMHqNIxG7LcWSRPd4FAVzTigH6ELMB18O2ycy3mExj8=;
        b=DSf2sj4llCFJMiGLokFigcTqIJ6Hsd3b/FKK29x3D2jbeijo/k2giNoPL9z+5X8rI7
         fsZ4qxxzEvepo1A0U53jCeqRT9FZM5o8Uy+MUQsVORMJsjXQbECEaf8JMHyvJ0qp+EEm
         5zV7aDSMZk2Wic4SSIhMker7SMtfTTq8txVsg6sZS6/ariivOHZpHrIMl/FXeA21hohV
         RyJblREu/z1jM0nrMxxCNHkyTmU8/dsPpIVtrVZF7nDQEIfYhK15jyPcT2wN7bW3sqiT
         InKEm1MMVWD7xjnfdXXTKZ1OMk7Hk1CDpEbuH45Kw4hxAwNjN+IDIr8tc5//tfPfzTyu
         1E1A==
X-Received: by 10.66.165.67 with SMTP id yw3mr22436705pab.95.1435500513051;
        Sun, 28 Jun 2015 07:08:33 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272910>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sg will invoke the pre-applypatch hook after applying the patch
to the index, but before a commit is made. Should the hook exit with a
non-zero status, git am will exit.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    No tests in master

 builtin/am.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 814a8b7..a2b0d63 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1379,6 +1379,9 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author;
 	struct strbuf sb = STRBUF_INIT;
 
+	if (run_hook_le(NULL, "pre-applypatch", NULL))
+		exit(1);
+
 	if (write_cache_as_tree(tree, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
 
-- 
2.5.0.rc0.76.gb2c6e93
