From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 10/14] pull: set reflog message
Date: Mon, 18 May 2015 23:06:07 +0800
Message-ID: <1431961571-20370-11-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:08:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMeL-0004bU-II
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbbERPIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:08:04 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35485 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbbERPH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:07:59 -0400
Received: by pacwv17 with SMTP id wv17so155742538pac.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tx5sXoCTT8J6xyOFXjgT5oMpG0EdMpcurB+gLjlgv+E=;
        b=rcqaa0haWsp6wXxubMvHWs2y5E7pULcdUn1NDRoikHUPHtwx/XzpnItn3138gtnNC6
         T0cEGbqtUS6HtBaLlnY1oqlLyLguF7Sux/QSsMCGQaMpGF1xpRmgK3tb/VqaC7bt1ABO
         jYSPGviIDwiVCbzNZ1zVlMUHi3WwpIThdl0F24IXPM+AovwaKs4jqyYQ+t3Busmvq495
         /RCDmNK83JuQC+cNpTGJNuWjs8eKzBMpvu+ZvReqR7knipvrdm/913iAFLCiu3cGatwn
         zhGhYCxIRhYkqriRZ7RAvrsb5T/4mkej7chaX18hVAXbCImWXnxtgLVoD9ZB1KZcu7zK
         0OIQ==
X-Received: by 10.68.191.167 with SMTP id gz7mr39257279pbc.43.1431961678291;
        Mon, 18 May 2015 08:07:58 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.07.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:07:56 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269269>

f947413 (Use GIT_REFLOG_ACTION environment variable instead.,
2006-12-28) established git-pull's method for setting the reflog
message, which is to set the environment variable GIT_REFLOG_ACTION to
the evaluation of "pull${1+ $*}" if it has not already been set.

Re-implement this behavior.

Signed-off-by: Stephen Robin <stephen.robin@gmail.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c  | 23 +++++++++++++++++++++++
 t/t5520-pull.sh |  4 ++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index ba2ff01..81e31a1 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -212,6 +212,26 @@ static void argv_push_force(struct argv_array *arr)
 }
 
 /**
+ * Sets the GIT_REFLOG_ACTION environment variable to the concatenation of argv
+ */
+static void set_reflog_message(int argc, const char **argv)
+{
+	int i;
+	struct strbuf msg = STRBUF_INIT;
+
+	for (i = 0; i < argc; i++) {
+		strbuf_addstr(&msg, argv[i]);
+		strbuf_addch(&msg, ' ');
+	}
+
+	strbuf_rtrim(&msg);
+
+	setenv("GIT_REFLOG_ACTION", msg.buf, 0);
+
+	strbuf_release(&msg);
+}
+
+/**
  * If pull.ff is "true", returns "--ff". If pull.ff is "false", returns
  * "--no-ff". If pull.ff is "only", returns "--ff-only". Otherwise, returns
  * NULL.
@@ -492,6 +512,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
 	unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
 
+	if (!getenv("GIT_REFLOG_ACTION"))
+		set_reflog_message(argc, argv);
+
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 2131749..9414cc1 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -85,7 +85,7 @@ test_expect_success 'pulling into void must not create an octopus' '
 	)
 '
 
-test_expect_failure 'test . as a remote' '
+test_expect_success 'test . as a remote' '
 	git branch copy master &&
 	git config branch.copy.remote . &&
 	git config branch.copy.merge refs/heads/master &&
@@ -101,7 +101,7 @@ test_expect_failure 'test . as a remote' '
 	test_cmp reflog.expected reflog.fuzzy
 '
 
-test_expect_failure 'the default remote . should not break explicit pull' '
+test_expect_success 'the default remote . should not break explicit pull' '
 	git checkout -b second master^ &&
 	echo modified >file &&
 	git commit -a -m modified &&
-- 
2.1.4
