From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 14/19] pull: set reflog message
Date: Thu, 18 Jun 2015 18:54:07 +0800
Message-ID: <1434624852-6869-15-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:06:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xeh-0003em-CU
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbbFRKzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:55:45 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33536 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbbFRKzY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:55:24 -0400
Received: by pdjn11 with SMTP id n11so64303252pdj.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rWciEICX7RcKKkPRYqGE9L1CYY0jfzWOdAX3WCvFP5c=;
        b=GVCqS+uUd1v3f53OZnfSxq8+/hHR2KfaEElqQADXljMmq4u1M/l0Y/ZiYWcF9BW4Hm
         fYIDv1RprWmWI0UeTS1iZ9uCx47SwVIfD+VZ42TjmTYV95KAOYRCIzy5X1GhjhzDzJ9s
         uaiSU4edKMEMIkVE8RqxgZH4625uFHjBq6OI31aBgHuwORIpSkhm8cbspxegThxQab/n
         JPS8GtjBcFxn7DguL0B6DRHDEcCHL/hw3Uya7TcgN6m5N8l2hbW5rTxzL86e0VEXwuKZ
         E1a25kbN0u76UhYNU2n82pLQGp4db1S+JXj4qaVTW8F6Jy77rz8ZctR/qbFDnoHBPtB1
         zBrA==
X-Received: by 10.68.219.201 with SMTP id pq9mr20238784pbc.97.1434624923670;
        Thu, 18 Jun 2015 03:55:23 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.55.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:55:22 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271957>

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
index 492bb0e..98caffe 100644
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
