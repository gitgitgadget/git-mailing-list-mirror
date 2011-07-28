From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/5] fast-import: don't fail on omitted committer name
Date: Thu, 28 Jul 2011 11:44:01 +0600
Message-ID: <1311831844-13123-3-git-send-email-divanorama@gmail.com>
References: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
Cc: SASAKI Suguru <sss.sonik@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 07:41:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmJLh-0004L5-8f
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 07:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab1G1FlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 01:41:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61460 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab1G1FlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 01:41:18 -0400
Received: by fxh19 with SMTP id 19so916401fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 22:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UsTcyKiub7DdPwQaOvMrI7gLGf9xs+7ttyvSaIM9+1k=;
        b=oXsXIzy861Irwq68tQ8R1nn7L0D8N6ivUhG9waYr6t7NXETfJXA8zQFUluuFj8veBC
         2nd8k0xldGwwRGkP72VrGmzb5JSHcHe+6juJoDHWtiMgUpY2RIiLhyd/xQ0tUCFY4t8Z
         a9X6boRZpMOk+g39GDo/QLPpI3fNhfdv1/7Q0=
Received: by 10.204.157.10 with SMTP id z10mr174427bkw.347.1311831676919;
        Wed, 27 Jul 2011 22:41:16 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id g11sm154133bku.49.2011.07.27.22.41.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 22:41:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178037>

fast-import format declares 'committer_name SP' to be optional. But SP
between empty or not name and a email is obligatory and checked by
git-fsck, so fast-import must prepend the SP if the name is omitted.
Currently it doesn't.

Name cannot contain LT or GT and ident always comes after SP in
fast-import. So reuse that SP as if a valid 'SP <email>' ident was passed.

This fixes a ident parsing bug for a well-formed fast-import input.
Though the parsing is still loose and can accept a ill-formed input.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |    4 ++++
 t/t9300-fast-import.sh |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 9e8d186..3194f4e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1972,6 +1972,10 @@ static char *parse_ident(const char *buf)
 	size_t name_len;
 	char *ident;
 
+	/* ensure there is a space delimiter even if there is no name */
+	if (*buf == '<')
+		--buf;
+
 	gt = strrchr(buf, '>');
 	if (!gt)
 		die("Missing > in ident string: %s", buf);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index a659dd4..09ef6ba 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -352,7 +352,7 @@ data <<COMMIT
 empty commit
 COMMIT
 INPUT_END
-test_expect_failure 'B: accept and fixup committer with no name' '
+test_expect_success 'B: accept and fixup committer with no name' '
 	git fast-import <input &&
 	out=$(git fsck) &&
 	echo "$out" &&
-- 
1.7.3.4
