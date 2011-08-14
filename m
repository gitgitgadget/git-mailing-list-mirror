From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH] rev-parse: Allow @{U} as a synonym for @{u}
Date: Sat, 13 Aug 2011 18:57:51 -0700
Message-ID: <1313287071-7851-1-git-send-email-conrad.irwin@gmail.com>
References: <CAMK1S_hZkdXiQb_UTB=snLAXPmo5yrCnFaQFHZqYq5AXqOgWng@mail.gmail.com>
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 03:58:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsPxy-0002jH-LK
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 03:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365Ab1HNB6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 21:58:12 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53995 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab1HNB6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 21:58:10 -0400
Received: by yie30 with SMTP id 30so2705095yie.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 18:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zZisnRo1OrPA040vqTXOueSM3FnBZ6N/FGug1sIStsI=;
        b=KFEqw77QYB5lO02c8WTtFNfTwoby7aZd5+oRi1i6fw09CMAuvszuCW9r6oi4/Truk2
         jE5SlF9FwzkrkHXJrTx95ePz43TOlKBQqrCowi0/8MvAZ02OcomxJpTQYagIvIYBsZJK
         zELB5fnYGy7D+LDCAM3jLNgSQQLBluzwgxkSQ=
Received: by 10.236.125.231 with SMTP id z67mr8443420yhh.109.1313287090269;
        Sat, 13 Aug 2011 18:58:10 -0700 (PDT)
Received: from localhost.localdomain (c-69-181-44-79.hsd1.ca.comcast.net [69.181.44.79])
        by mx.google.com with ESMTPS id s62sm1985288yhn.61.2011.08.13.18.58.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Aug 2011 18:58:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.448.gc83e3.dirty
In-Reply-To: <CAMK1S_hZkdXiQb_UTB=snLAXPmo5yrCnFaQFHZqYq5AXqOgWng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179300>

This facilitates specifying the upstream of a branch if you have
difficulty synchronising your shift-key and other characters, if you
just want to SHOUT at git, or if you're expecting consistency with
@{1DAY}.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 Documentation/revisions.txt   |    4 ++--
 sha1_name.c                   |    2 +-
 t/t1507-rev-parse-upstream.sh |    8 ++++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index b290b61..c89d74d 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -87,8 +87,8 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
   before the current one.
 
 '<refname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
-  The suffix '@\{upstream\}' to a ref (short form '<refname>@\{u\}') refers to
-  the branch the ref is set to build on top of.  A missing ref defaults
+  The suffix '@\{upstream\}' to a ref (short form '<refname>@\{u\}', or '@\{U\}')
+  refers to the branch the ref is set to build on top of.  A missing ref defaults
   to the current branch.
 
 '<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
diff --git a/sha1_name.c b/sha1_name.c
index ff5992a..ef4b77f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -334,7 +334,7 @@ static inline int upstream_mark(const char *string, int len)
 	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
 		int suffix_len = strlen(suffix[i]);
 		if (suffix_len <= len
-		    && !memcmp(string, suffix[i], suffix_len))
+		    && !strncasecmp(string, suffix[i], suffix_len))
 			return suffix_len;
 	}
 	return 0;
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index a455551..5be605f 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -37,6 +37,14 @@ test_expect_success '@{u} resolves to correct full name' '
 	test refs/remotes/origin/master = "$(full_name @{u})"
 '
 
+test_expect_success '@{U} resolves to correct full name' '
+	test refs/remotes/origin/master = "$(full_name @{U})"
+'
+
+test_expect_success '@{Upstream} resolves to correct full name' '
+	test refs/remotes/origin/master = "$(full_name @{Upstream})"
+'
+
 test_expect_success 'my-side@{upstream} resolves to correct full name' '
 	test refs/remotes/origin/side = "$(full_name my-side@{u})"
 '
-- 
1.7.6.448.gc83e3.dirty
