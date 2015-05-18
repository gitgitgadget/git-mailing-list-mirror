From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 1/2] pull: make pull.ff=true override merge.ff
Date: Mon, 18 May 2015 21:45:41 +0800
Message-ID: <1431956742-25992-2-git-send-email-pyokagan@gmail.com>
References: <1431956742-25992-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:46:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLMv-0006lK-8w
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbbERNqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:46:06 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33644 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbbERNqD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:46:03 -0400
Received: by pdbqa5 with SMTP id qa5so150464816pdb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Q1PAHotDVjUum3W3L/GODu2MCmthdyONXskrQ08CI8=;
        b=DBuel3WsCi0KmYdzN8Su8RsEoyHYEPuDVIeK2wxEHmpv/efamP4CMLOsn22kmYbuik
         QXo2VAzhHmvW+3Y1aVHcqPfoiRoPl3FmgOlayNxvUz0EKAVsUJdBRrTXDd2WO4hizy2J
         AlmFU52jlmW7nNYQvWUUo/+FTZnU6LSShZxp92xUN3WCE13eX7JZJUdPqvv9Vva9Ik74
         Y3b8Mtg2L8lWVmfl9tPgaBp0qWucDG3LA44NaA49pVm5yws+YHWn9gAe1dz90padoxoF
         u8+IyP+8krpgy0EsuN51FGlHUwdzjNRab3z0Z756DM2RKgHWa6fZq6bDcjRTA6VHALLQ
         JG2Q==
X-Received: by 10.66.222.161 with SMTP id qn1mr45041657pac.66.1431956763019;
        Mon, 18 May 2015 06:46:03 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id x4sm10175713pdl.55.2015.05.18.06.45.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:46:01 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431956742-25992-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269247>

Since b814da8 (pull: add pull.ff configuration, 2014-01-15), running
git-pull with the configuration pull.ff=false or pull.ff=only is
equivalent to passing --no-ff and --ff-only to git-merge. However, if
pull.ff=true, no switch is passed to git-merge. This leads to the
confusing behavior where pull.ff=false or pull.ff=only is able to
override merge.ff, while pull.ff=true is unable to.

Fix this by adding the --ff switch if pull.ff=true, and add a test to
catch future regressions.

Furthermore, clarify in the documentation that pull.ff overrides
merge.ff.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
* Removed use of "verbose".

 Documentation/config.txt     | 2 +-
 git-pull.sh                  | 3 +++
 t/t7601-merge-pull-config.sh | 8 ++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 948b8b0..ec0f9ef 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2042,7 +2042,7 @@ pull.ff::
 	a case (equivalent to giving the `--no-ff` option from the command
 	line). When set to `only`, only such fast-forward merges are
 	allowed (equivalent to giving the `--ff-only` option from the
-	command line).
+	command line). This setting overrides `merge.ff` when pulling.
 
 pull.rebase::
 	When true, rebase branches on top of the fetched branch, instead
diff --git a/git-pull.sh b/git-pull.sh
index 9ed01fd..e51dd37 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -56,6 +56,9 @@ fi
 # Setup default fast-forward options via `pull.ff`
 pull_ff=$(git config pull.ff)
 case "$pull_ff" in
+true)
+	no_ff=--ff
+	;;
 false)
 	no_ff=--no-ff
 	;;
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index f768c90..c6c44ec 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -45,6 +45,14 @@ test_expect_success 'fast-forward pull succeeds with "true" in pull.ff' '
 	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
 '
 
+test_expect_success 'pull.ff=true overrides merge.ff=false' '
+	git reset --hard c0 &&
+	test_config merge.ff false &&
+	test_config pull.ff true &&
+	git pull . c1 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
+'
+
 test_expect_success 'fast-forward pull creates merge with "false" in pull.ff' '
 	git reset --hard c0 &&
 	test_config pull.ff false &&
-- 
2.1.4
