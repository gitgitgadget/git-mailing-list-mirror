From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 14/19] pull: set reflog message
Date: Sun, 14 Jun 2015 16:42:01 +0800
Message-ID: <1434271326-11349-15-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:43:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43Vs-0006XL-JW
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbbFNIn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:43:28 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35737 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbbFNInJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:43:09 -0400
Received: by pacyx8 with SMTP id yx8so46697363pac.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DD+c7frvH5iHwUN3ZVZqErRXGvBhvbL5HdrwWwKYQ78=;
        b=BYLK3DEjZW3LbUfJ1M4OSIkaDXJ9qo4cpsBw+O16uN1SJL0WC1wCmOuRPhGWjaq6ba
         vKJUdq6vf9TplGtgth2Bta6T5rkbGHoxmFFSMQayDoYliRKA4Fleec6KhcJNsRlSu6NM
         GsQgLvrN8k6plHDxJcHfpfVY1UA4RXQoYvxOORoIoo6RH5X7jrl6SDd/Q++iiAtO/emU
         JYvagq07e9IB4//gohNbla432/Sr+TIcmnLGEVQJMSldUPDWTFjvQK8saZEfSs33ozRo
         NHTK6uP2DJWG3iNXbsV0zKI/+1v3G51/R3RnVDwpQ4eV3RDx1aLfSGUtkUFEO42DJmV0
         YXPw==
X-Received: by 10.67.4.201 with SMTP id cg9mr38206467pad.53.1434271389095;
        Sun, 14 Jun 2015 01:43:09 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.43.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:43:08 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271624>

f947413 (Use GIT_REFLOG_ACTION environment variable instead.,
2006-12-28) established git-pull's method for setting the reflog
message, which is to set the environment variable GIT_REFLOG_ACTION to
the evaluation of "pull${1+ $*}" if it has not already been set.

Re-implement this behavior.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index a2dd0ba..a2c900e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -169,6 +169,25 @@ static void argv_push_force(struct argv_array *arr)
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
+		if (i)
+			strbuf_addch(&msg, ' ');
+		strbuf_addstr(&msg, argv[i]);
+	}
+
+	setenv("GIT_REFLOG_ACTION", msg.buf, 0);
+
+	strbuf_release(&msg);
+}
+
+/**
  * If pull.ff is unset, returns NULL. If pull.ff is "true", returns "--ff". If
  * pull.ff is "false", returns "--no-ff". If pull.ff is "only", returns
  * "--ff-only". Otherwise, if pull.ff is set to an invalid value, die with an
@@ -443,6 +462,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die_errno("could not exec %s", path);
 	}
 
+	if (!getenv("GIT_REFLOG_ACTION"))
+		set_reflog_message(argc, argv);
+
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
-- 
2.1.4
