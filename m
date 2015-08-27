From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH v2.1] stash: Add stash.showFlag config variable
Date: Fri, 28 Aug 2015 00:55:37 +0900
Message-ID: <1440690937-11424-1-git-send-email-namhyung@gmail.com>
References: <1440690553-28582-1-git-send-email-namhyung@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 17:58:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUzZa-0006Ud-4X
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 17:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbbH0P6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 11:58:37 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35806 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbbH0P6h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 11:58:37 -0400
Received: by pacdd16 with SMTP id dd16so29829089pac.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=BDL5n3gtnmn0b6t8JvgPloXPoPV66Be+db23iLSsahM=;
        b=w/ZupjShWHKgQQsSzrHygbkHD+ciDqPOl338HkKTW0djkVTlyLV8N9Yqez7Le+iB6O
         iESVK3DNW7QDly2sz/Oaw762AOVN89ycSZVUVXawv3zSLPPr3aS6wHC1fw7blVlIKEua
         nQtikDEikXKkmh9wib0fNVVON75dyj9VwcEJZ56ukl/Mc7u/YJxQxMbwz+tucJK4wt1T
         U2fjRvYe4muOBo62DI13cZIHiXbc2mnpeHWmA4T5T6jQhU5+e3GiPkvTC4+lFpCyDJD6
         aEHgpc29E5HR5fFLDP1+DrgtE2zZ6lZCtm3ehKVtlg+U5EhJvcxhhkhNAAWFRsutAfjX
         bfCQ==
X-Received: by 10.66.65.234 with SMTP id a10mr14585221pat.2.1440691116803;
        Thu, 27 Aug 2015 08:58:36 -0700 (PDT)
Received: from localhost.localdomain ([220.120.166.123])
        by smtp.gmail.com with ESMTPSA id qp5sm2873430pbc.0.2015.08.27.08.58.35
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Aug 2015 08:58:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440690553-28582-1-git-send-email-namhyung@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276680>

Some users might want to see diff (patch) output always rather than
diffstat when [s]he runs 'git stash show'.  Although this can be done
with adding -p option, it'd be better to provide a config option to
control this behavior IMHO.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 Documentation/config.txt    | 5 +++++
 Documentation/git-stash.txt | 1 +
 git-stash.sh                | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f5d15ff..bbadae6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2567,6 +2567,11 @@ status.submoduleSummary::
 	submodule summary' command, which shows a similar output but does
 	not honor these settings.
 
+stash.showFlag::
+	The default option to pass to `git stash show` when no option is
+	given. The default is '--stat'.  See description of 'show' command
+	in linkgit:git-stash[1].
+
 submodule.<name>.path::
 submodule.<name>.url::
 	The path within this project and URL for a submodule. These
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 375213f..e00f67e 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -95,6 +95,7 @@ show [<stash>]::
 	shows the latest one. By default, the command shows the diffstat, but
 	it will accept any format known to 'git diff' (e.g., `git stash show
 	-p stash@{1}` to view the second most recent stash in patch form).
+	You can use stash.showflag config variable to change this behavior.
 
 pop [--index] [-q|--quiet] [<stash>]::
 
diff --git a/git-stash.sh b/git-stash.sh
index 1d5ba7a..992fb02 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -305,7 +305,12 @@ show_stash () {
 	ALLOW_UNKNOWN_FLAGS=t
 	assert_stash_like "$@"
 
-	git diff ${FLAGS:---stat} $b_commit $w_commit
+	if test -z "$FLAGS"
+	then
+		FLAGS=$(git config --get stash.showFlag || echo "--stat")
+	fi
+
+	git diff ${FLAGS} $b_commit $w_commit
 }
 
 show_help () {
-- 
2.5.0
